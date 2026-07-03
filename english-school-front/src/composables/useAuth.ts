import { computed, reactive, ref } from 'vue'
import { registerStudent, registerTeacher, wxLogin } from '@/api/auth'
import { useUserStore } from '@/store/user'
import type { UserRole } from '@/types/user'
import { getWxLoginCode } from '@/utils/wxLogin'

const authState = reactive({
  showRoleModal: false,
  showWxLoginModal: false,
})

const loading = ref(false)
const pendingRole = ref<UserRole | null>(null)
const isMockEnv = ref(false)

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

      const result = await wxLogin(code, role)
      const openid = `mock_openid_${code.slice(-8)}`

      if (result.isNewUser || !result.user) {
        store.setPendingAuth(openid, role)
        closeWxLogin()
        const url =
          role === 'student'
            ? '/pages/auth/register-student'
            : '/pages/auth/register-teacher'
        uni.navigateTo({ url })
        return
      }

      store.setUser(result.user, result.token)
      closeWxLogin()

      if (result.user.role === 'teacher' && result.user.status === 'pending') {
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
    if (!store.state.pendingOpenid || store.state.pendingRole !== 'student') {
      uni.showToast({ title: '请先完成微信授权', icon: 'none' })
      return
    }

    loading.value = true
    try {
      const user = await registerStudent({
        name: name.trim(),
        studentId: studentId.trim(),
        openid: store.state.pendingOpenid,
      })
      store.setUser(user, `token_${user.id}`)
      store.clearPendingAuth()
      uni.showToast({ title: '注册成功', icon: 'success' })
      setTimeout(() => {
        uni.switchTab({ url: '/pages/study/index' })
      }, 800)
    } catch {
      uni.showToast({ title: '注册失败', icon: 'none' })
    } finally {
      loading.value = false
    }
  }

  async function submitTeacherRegister(name: string, school: string) {
    if (!store.state.pendingOpenid || store.state.pendingRole !== 'teacher') {
      uni.showToast({ title: '请先完成微信授权', icon: 'none' })
      return
    }

    loading.value = true
    try {
      const user = await registerTeacher({
        name: name.trim(),
        school: school.trim(),
        openid: store.state.pendingOpenid,
      })
      store.setUser(user, `token_${user.id}`)
      store.clearPendingAuth()
      uni.showToast({ title: '提交成功，等待审核', icon: 'none' })
      setTimeout(() => {
        uni.switchTab({ url: '/pages/index/index' })
      }, 800)
    } catch {
      uni.showToast({ title: '提交失败', icon: 'none' })
    } finally {
      loading.value = false
    }
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
