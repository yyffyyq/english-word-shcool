import { computed, reactive, ref } from 'vue'
import { loginUser, registerStudent } from '@/api/userAccountController'
import { useUserStore } from '@/store/user'
import type { PendingRegisterAuth, UserInfo, UserRole, UserStatus } from '@/types/user'
import { normalizeRole } from '@/types/user'
import { getWxLoginCode } from '@/utils/wxLogin'
import { syncCustomTabBar } from '@/utils/tabBar'

const authState = reactive({
  showRoleModal: false,
  showWxLoginModal: false,
})

const loading = ref(false)
const pendingRole = ref<UserRole | null>(null)
const isMockEnv = ref(false)

type LoginUserVO = API.UserAccountVO & {
  openid?: string
  openId?: string
  token?: string
}

// #ifndef MP-WEIXIN
isMockEnv.value = true
// #endif

export function useAuth() {
  const store = useUserStore()

  function openRoleSelect() {
    authState.showRoleModal = true
  }

  function closeRoleSelect() {
    authState.showRoleModal = false
  }

  function openWxLogin() {
    authState.showWxLoginModal = true
  }

  function closeWxLogin() {
    authState.showWxLoginModal = false
    pendingRole.value = null
  }

  function selectRole(role: UserRole) {
    closeRoleSelect()
    pendingRole.value = role
    openWxLogin()
  }

  function loginWithRole(role: UserRole) {
    selectRole(role)
  }

  function loginFromModal(role: UserRole) {
    selectRole(role)
  }

  async function confirmWxLogin() {
    if (!pendingRole.value || loading.value) return
    await performWxLogin(pendingRole.value)
  }

  async function performWxLogin(role: UserRole) {
    loading.value = true
    try {
      const { code, isMock } = await getWxLoginCode()
      isMockEnv.value = isMock

      const response = await loginUser({
        code,
        loginRole: role,
      })
      const result = response.data
      const userAccount = result.data as LoginUserVO | undefined
      const openid = userAccount?.openid || userAccount?.openId || ''

      if (isUnregisteredUser(result, userAccount, openid)) {
        uni.showToast({ title: '请先注册用户', icon: 'none' })
        store.setPendingAuth(buildPendingRegisterAuth(userAccount, role, code, openid))
        closeWxLogin()
        const url =
          role === 'student'
            ? '/pages/auth/register-student'
            : '/pages/auth/register-teacher'
        setTimeout(() => {
          uni.navigateTo({ url })
        }, 800)
        return
      }

      if (result.code !== 0 || !userAccount?.id) {
        throw new Error(result.message || '登录失败，请重试')
      }

      const user = mapUserAccountToUserInfo(userAccount, role, openid)
      store.setUser(user, userAccount.token || `token_${user.id}`)
      closeWxLogin()

      if (user.role === 'teacher') {
        if (user.status === 'pending') {
          uni.showToast({ title: '登录成功，账号审核中', icon: 'none' })
        } else {
          uni.showToast({ title: '微信登录成功', icon: 'success' })
        }
        syncCustomTabBar('pages/index/index')
        return
      }

      uni.showToast({ title: '微信登录成功', icon: 'success' })
      syncCustomTabBar('pages/index/index')
    } catch (error) {
      const message = error instanceof Error ? error.message : '登录失败，请重试'
      uni.showToast({ title: message, icon: 'none' })
    } finally {
      loading.value = false
    }
  }

  function guardPageAccess(): boolean {
    if (!store.isLoggedIn.value) {
      openRoleSelect()
      return false
    }

    if (store.isTeacherPending.value) {
      uni.showToast({ title: '账号审核中，请耐心等待', icon: 'none' })
      return false
    }

    return true
  }

  function handleMineTabAccess(): boolean {
    if (!store.isLoggedIn.value) {
      openRoleSelect()
      return false
    }
    return true
  }

  async function submitStudentRegister(name: string, studentId: string) {
    const pendingAuth = store.state.pendingRegisterAuth
    if (pendingAuth?.role !== 'student') {
      uni.showToast({ title: '请先完成微信授权', icon: 'none' })
      return
    }

    if (!pendingAuth.openid) {
      uni.showToast({ title: '微信身份信息缺失，请重新授权', icon: 'none' })
      return
    }

    loading.value = true
    try {
      const response = await registerStudent({
        openid: pendingAuth.openid,
        realName: name.trim(),
        studentNo: studentId.trim(),
      })
      const result = response.data
      const userAccount = result.data as LoginUserVO | undefined

      if (result.code !== 0 || !userAccount?.id) {
        throw new Error(result.message || '注册失败，请重试')
      }

      const user = mapUserAccountToUserInfo(userAccount, 'student', pendingAuth.openid)
      store.setUser(user, userAccount.token || `token_${user.id}`)
      store.clearPendingAuth()
      uni.showToast({ title: '注册成功', icon: 'success' })
      setTimeout(() => {
        uni.switchTab({ url: '/pages/index/index' })
        syncCustomTabBar('pages/index/index')
      }, 800)
    } catch (error) {
      const message = error instanceof Error ? error.message : '注册失败，请重试'
      uni.showToast({ title: message, icon: 'none' })
    } finally {
      loading.value = false
    }
  }

  async function submitTeacherRegister(name: string, school: string) {
    if (store.state.pendingRegisterAuth?.role !== 'teacher') {
      uni.showToast({ title: '请先完成微信授权', icon: 'none' })
      return
    }

    void name
    void school
    uni.showToast({ title: '注册接口暂未实现', icon: 'none' })
  }

  function logout() {
    store.logout()
    uni.showToast({ title: '已退出登录', icon: 'none' })
    uni.switchTab({ url: '/pages/index/index' })
    setTimeout(() => {
      syncCustomTabBar('pages/index/index')
    }, 300)
  }

  return {
    loading,
    pendingRole,
    isMockEnv,
    showRoleModal: computed(() => authState.showRoleModal),
    showWxLoginModal: computed(() => authState.showWxLoginModal),
    openRoleSelect,
    closeRoleSelect,
    openWxLogin,
    closeWxLogin,
    selectRole,
    loginWithRole,
    loginFromModal,
    confirmWxLogin,
    guardPageAccess,
    handleMineTabAccess,
    submitStudentRegister,
    submitTeacherRegister,
    logout,
  }
}

function mapUserAccountToUserInfo(
  userAccount: LoginUserVO,
  fallbackRole: UserRole,
  openid: string,
): UserInfo {
  return {
    id: String(userAccount.id),
    openid,
    role: normalizeRole(userAccount.role, fallbackRole),
    name: userAccount.realName || '微信用户',
    studentId: userAccount.studentNo,
    school: userAccount.schoolName,
    status: normalizeStatus(userAccount.status),
    avatar: userAccount.avatarUrl,
  }
}

function buildPendingRegisterAuth(
  userAccount: LoginUserVO | undefined,
  role: UserRole,
  wxCode: string,
  openid: string,
): PendingRegisterAuth {
  return {
    openid,
    role,
    wxCode,
    userAccountId: userAccount?.id ? String(userAccount.id) : undefined,
    realName: userAccount?.realName,
    schoolName: userAccount?.schoolName,
    studentNo: userAccount?.studentNo,
    avatarUrl: userAccount?.avatarUrl,
    status: userAccount?.status,
    createdAt: Date.now(),
  }
}

function isUnregisteredUser(
  result: API.BaseResponseUserAccountVO,
  userAccount: LoginUserVO | undefined,
  openid: string,
) {
  return result.message === '请注册用户' || (Boolean(openid) && !userAccount?.id)
}

function normalizeStatus(status?: string): UserStatus {
  if (status === 'pending' || status === 'approved' || status === 'rejected') {
    return status
  }
  return 'approved'
}
