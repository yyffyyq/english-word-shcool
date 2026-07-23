import cache from '@/plugins/cache'
import { login, logout } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { isHttp, isEmpty } from '@/utils/validate'
import useLockStore from '@/store/modules/lock'
import defAva from '@/assets/images/profile.jpg'

const LOGIN_USER_KEY = 'loginUser'

function buildLocalToken(user) {
  return `system_${user.id}`
}

function normalizeRole(role) {
  if (!role) return ''
  return String(role).toUpperCase()
}

function createEmptyLoginUser() {
  return {
    id: undefined,
    role: '',
    realName: '未登录',
    schoolName: '',
    studentNo: '',
    avatarUrl: '',
    status: '',
    openid: ''
  }
}

const useUserStore = defineStore('user', {
  state: () => ({
    token: getToken(),
    id: '',
    name: '',
    nickName: '',
    avatar: '',
    roles: [],
    permissions: [],
    schoolName: '',
    status: '',
    openid: '',
    // 当前登录用户
    loginUser: createEmptyLoginUser()
  }),
  getters: {
    isLoggedIn: (state) => Boolean(state.token && state.loginUser && state.loginUser.id),
    userRole: (state) => normalizeRole(state.loginUser?.role || (state.roles[0] || ''))
  },
  actions: {
    /**
     * 写入登录用户到本地缓存（sessionStorage）
     * 管理端后续请求通过请求头 userId 与后端 Redis 会话对齐
     */
    setLoginUser(user) {
      const nextUser = user && user.id ? { ...createEmptyLoginUser(), ...user } : createEmptyLoginUser()
      // 管理端登录通常没有微信 openid，保持为空，避免误走微信会话校验
      if (!nextUser.openid) {
        nextUser.openid = ''
      }
      this.loginUser = nextUser
      this.id = nextUser.id || ''
      if (nextUser.id) {
        cache.session.setJSON(LOGIN_USER_KEY, nextUser)
      } else {
        cache.session.remove(LOGIN_USER_KEY)
      }
    },

    /**
     * 首次进入/刷新时拉取登录用户（本地缓存）
     */
    async fetchLoginUser() {
      const cached = cache.session.getJSON(LOGIN_USER_KEY)
      const token = getToken()
      if (!token || !cached || !cached.id) {
        this.token = ''
        this.roles = []
        this.permissions = []
        this.setLoginUser(createEmptyLoginUser())
        removeToken()
        return this.loginUser
      }

      this.token = token
      this.setLoginUser(cached)
      await this.getInfo()
      return this.loginUser
    },

    // 登录：后端会把用户写入 Redis（system.user.login.ids:{userId}）
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
          this.openid = user.openid || ''
          this.setLoginUser(user)
          cache.session.remove('sessionObj')
          useLockStore().unlockScreen()
          resolve(user)
        }).catch(error => {
          reject(error)
        })
      })
    },

    // 获取用户信息（供权限路由使用）
    getInfo() {
      return new Promise((resolve, reject) => {
        const user = this.loginUser?.id
          ? this.loginUser
          : cache.session.getJSON(LOGIN_USER_KEY)

        if (!user || !user.id) {
          reject('登录状态已失效，请重新登录')
          return
        }

        let avatar = user.avatarUrl || ''
        if (!isHttp(avatar)) {
          avatar = isEmpty(avatar) ? defAva : import.meta.env.VITE_APP_BASE_API + avatar
        }

        const role = normalizeRole(user.role) || 'ADMIN'
        this.roles = [role]
        this.permissions = ['*:*:*']
        this.id = user.id
        this.name = user.realName || String(user.id)
        this.nickName = user.realName || String(user.id)
        this.avatar = avatar
        this.schoolName = user.schoolName || ''
        this.status = user.status || ''
        this.openid = user.openid || ''
        this.setLoginUser({ ...user, role })
        resolve({ user: this.loginUser, roles: this.roles, permissions: this.permissions })
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
          this.openid = ''
          this.setLoginUser(createEmptyLoginUser())
          removeToken()
          resolve()
        })
      })
    }
  }
})

export default useUserStore
