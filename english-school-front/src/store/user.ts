import { computed, reactive } from 'vue'
import type { UserInfo, UserRole } from '@/types/user'
import {
  clearUserStorage,
  getToken,
  getUserStorage,
  setToken,
  setUserStorage,
} from '@/utils/storage'

interface UserState {
  user: UserInfo | null
  token: string | null
  pendingOpenid: string | null
  pendingRole: UserRole | null
}

const state = reactive<UserState>({
  user: null,
  token: null,
  pendingOpenid: null,
  pendingRole: null,
})

export function initUserStore() {
  state.user = getUserStorage()
  state.token = getToken()
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

  function setPendingAuth(openid: string, role: UserRole) {
    state.pendingOpenid = openid
    state.pendingRole = role
  }

  function clearPendingAuth() {
    state.pendingOpenid = null
    state.pendingRole = null
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
