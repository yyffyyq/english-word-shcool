import { computed, reactive } from 'vue'
import type { PendingRegisterAuth, UserInfo, UserRole } from '@/types/user'
import {
  clearPendingRegisterAuthStorage,
  clearUserStorage,
  getPendingRegisterAuthStorage,
  getToken,
  getUserStorage,
  setPendingRegisterAuthStorage,
  setToken,
  setUserStorage,
} from '@/utils/storage'

interface UserState {
  user: UserInfo | null
  token: string | null
  pendingOpenid: string | null
  pendingRole: UserRole | null
  pendingRegisterAuth: PendingRegisterAuth | null
}

const state = reactive<UserState>({
  user: null,
  token: null,
  pendingOpenid: null,
  pendingRole: null,
  pendingRegisterAuth: null,
})

export function initUserStore() {
  state.user = getUserStorage()
  state.token = getToken()
  state.pendingRegisterAuth = getPendingRegisterAuthStorage()
  state.pendingOpenid = state.pendingRegisterAuth?.openid || null
  state.pendingRole = state.pendingRegisterAuth?.role || null
}

export function useUserStore() {
  const isLoggedIn = computed(() => !!state.user && !!state.token)
  const isStudent = computed(() => state.user?.role === 'student')
  const isTeacher = computed(() => state.user?.role === 'teacher')
  const isApproved = computed(() => state.user?.status === 'approved')
  const isPending = computed(() => state.user?.status === 'pending')
  const isTeacherPending = computed(
    () => state.user?.role === 'teacher' && state.user?.status === 'pending',
  )

  function setUser(user: UserInfo, token: string) {
    state.user = user
    state.token = token
    setUserStorage(user)
    setToken(token)
  }

  function setPendingAuth(auth: PendingRegisterAuth): void
  function setPendingAuth(openid: string, role: UserRole): void
  function setPendingAuth(authOrOpenid: PendingRegisterAuth | string, role?: UserRole) {
    const auth =
      typeof authOrOpenid === 'string'
        ? {
            openid: authOrOpenid,
            role: role as UserRole,
            wxCode: '',
            createdAt: Date.now(),
          }
        : authOrOpenid

    state.pendingOpenid = auth.openid
    state.pendingRole = auth.role
    state.pendingRegisterAuth = auth
    setPendingRegisterAuthStorage(auth)
  }

  function clearPendingAuth() {
    state.pendingOpenid = null
    state.pendingRole = null
    state.pendingRegisterAuth = null
    clearPendingRegisterAuthStorage()
  }

  function logout() {
    state.user = null
    state.token = null
    clearPendingAuth()
    clearUserStorage()
  }

  return {
    state,
    isLoggedIn,
    isStudent,
    isTeacher,
    isApproved,
    isPending,
    isTeacherPending,
    setUser,
    setPendingAuth,
    clearPendingAuth,
    logout,
  }
}
