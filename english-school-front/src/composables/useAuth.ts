import { computed, reactive, ref } from 'vue'
import { loginUser } from '@/api/userAccountController'
import { useUserStore } from '@/store/user'
import type { PendingRegisterAuth, UserInfo, UserRole, UserStatus } from '@/types/user'
import { getWxLoginCode } from '@/utils/wxLogin'

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

      if (result.message === '请注册用户') {
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

      if (user.role === 'teacher' && user.status === 'pending') {
        uni.showToast({ title: '登录成功，账号审核中', icon: 'none' })
        return
      }

      uni.showToast({ title: '微信登录成功', icon: 'success' })
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
    if (store.state.pendingRegisterAuth?.role !== 'student') {
      uni.showToast({ title: '请先完成微信授权', icon: 'none' })
      return
    }

    void name
    void studentId
    uni.showToast({ title: '注册接口暂未实现', icon: 'none' })
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
    role: (userAccount.role as UserRole) || fallbackRole,
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

function normalizeStatus(status?: string): UserStatus {
  if (status === 'pending' || status === 'approved' || status === 'rejected') {
    return status
  }
  return 'approved'
}
