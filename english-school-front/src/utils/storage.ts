const USER_KEY = 'english_school_user'
const TOKEN_KEY = 'english_school_token'
const PENDING_REGISTER_AUTH_KEY = 'english_school_pending_register_auth'

export function getStorage<T>(key: string): T | null {
  try {
    const value = uni.getStorageSync(key)
    return value ? (value as T) : null
  } catch {
    return null
  }
}

export function setStorage(key: string, value: unknown) {
  uni.setStorageSync(key, value)
}

export function removeStorage(key: string) {
  uni.removeStorageSync(key)
}

export function getUserStorage() {
  return getStorage<import('@/types/user').UserInfo>(USER_KEY)
}

export function setUserStorage(user: import('@/types/user').UserInfo) {
  setStorage(USER_KEY, user)
}

export function clearUserStorage() {
  removeStorage(USER_KEY)
  removeStorage(TOKEN_KEY)
}

export function getPendingRegisterAuthStorage() {
  return getStorage<import('@/types/user').PendingRegisterAuth>(PENDING_REGISTER_AUTH_KEY)
}

export function setPendingRegisterAuthStorage(
  auth: import('@/types/user').PendingRegisterAuth,
) {
  setStorage(PENDING_REGISTER_AUTH_KEY, auth)
}

export function clearPendingRegisterAuthStorage() {
  removeStorage(PENDING_REGISTER_AUTH_KEY)
}

export function getToken() {
  return getStorage<string>(TOKEN_KEY)
}

export function setToken(token: string) {
  setStorage(TOKEN_KEY, token)
}
