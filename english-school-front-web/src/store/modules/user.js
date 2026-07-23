import cache from '@/plugins/cache'
import { login, logout } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { isHttp, isEmpty } from "@/utils/validate"
import useLockStore from '@/store/modules/lock'
import defAva from '@/assets/images/profile.jpg'

const LOGIN_USER_KEY = 'loginUser'

function buildLocalToken(user) {
  return `system_${user.id}`
}

function normalizeRole(role) {
  if (!role) return 'ADMIN'
  return String(role).toUpperCase()
}

const useUserStore = defineStore(
  'user',
  {
    state: () => ({
      token: getToken(),
      id: '',
      name: '',
      nickName: '',
      avatar: '',
      roles: [],
      permissions: [],
      schoolName: '',
      status: ''
    }),
    actions: {
      // 登录
      login(userInfo) {
        const username = userInfo.username.trim()
        const password = userInfo.password
        return new Promise((resolve, reject) => {
          login(username, password).then(res => {
            const user = res.data
            if (!user || !user.id) {
              reject(new Error(res.message || '登录失败'))
              return
            }
            const token = buildLocalToken(user)
            setToken(token)
            this.token = token
            cache.session.setJSON(LOGIN_USER_KEY, user)
            useLockStore().unlockScreen()
            resolve(user)
          }).catch(error => {
            reject(error)
          })
        })
      },
      // 获取用户信息（使用登录缓存）
      getInfo() {
        return new Promise((resolve, reject) => {
          const user = cache.session.getJSON(LOGIN_USER_KEY)
          if (!user || !user.id) {
            reject('登录状态已失效，请重新登录')
            return
          }

          let avatar = user.avatarUrl || ''
          if (!isHttp(avatar)) {
            avatar = isEmpty(avatar) ? defAva : import.meta.env.VITE_APP_BASE_API + avatar
          }

          const role = normalizeRole(user.role)
          this.roles = [role]
          // 管理端先放开全部权限，后续可按角色细化
          this.permissions = role === 'ADMIN' ? ['*:*:*'] : ['*:*:*']
          this.id = user.id
          this.name = user.realName || String(user.id)
          this.nickName = user.realName || String(user.id)
          this.avatar = avatar
          this.schoolName = user.schoolName || ''
          this.status = user.status || ''
          resolve({ user, roles: this.roles, permissions: this.permissions })
        })
      },
      // 退出系统
      logOut() {
        return new Promise((resolve) => {
          logout().finally(() => {
            this.token = ''
            this.id = ''
            this.name = ''
            this.nickName = ''
            this.avatar = ''
            this.roles = []
            this.permissions = []
            this.schoolName = ''
            this.status = ''
            cache.session.remove(LOGIN_USER_KEY)
            removeToken()
            resolve()
          })
        })
      }
    }
  })

export default useUserStore
