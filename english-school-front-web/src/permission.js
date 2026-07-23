import router from './router'
import { ElMessage } from 'element-plus'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { getToken } from '@/utils/auth'
import { isHttp, isPathMatch } from '@/utils/validate'
import { isRelogin } from '@/utils/request'
import useUserStore from '@/store/modules/user'
import useLockStore from '@/store/modules/lock'
import useSettingsStore from '@/store/modules/settings'
import usePermissionStore from '@/store/modules/permission'

NProgress.configure({ showSpinner: false })

const whiteList = ['/login', '/register']

// 是否为首次获取登录用户（参考 access.ts）
let firstFetchLoginUser = true

const isWhiteList = (path) => whiteList.some(pattern => isPathMatch(pattern, path))

function hasRouteRole(to, userRole) {
  const needRoles = to.matched
    .map(r => r.meta?.roles)
    .filter(roles => Array.isArray(roles) && roles.length > 0)
  if (!needRoles.length) return true
  return needRoles.every(roles => roles.map(r => String(r).toUpperCase()).includes(userRole))
}

/**
 * 全局登录/权限校验
 */
router.beforeEach(async (to, from) => {
  NProgress.start()

  const userStore = useUserStore()

  // 刷新页面时，先拉取登录用户，再做权限判断
  if (firstFetchLoginUser) {
    try {
      await userStore.fetchLoginUser()
    } catch (e) {
      // 拉取失败按未登录处理
      await userStore.logOut()
    } finally {
      firstFetchLoginUser = false
    }
  }

  const loginUser = userStore.loginUser
  const hasLogin = Boolean(getToken() && loginUser && loginUser.id)

  if (hasLogin) {
    to.meta.title && useSettingsStore().setTitle(to.meta.title)

    const isLock = useLockStore().isLock
    if (to.path === '/login') {
      NProgress.done()
      return { path: '/' }
    }
    if (isWhiteList(to.path)) {
      return true
    }
    if (isLock && to.path !== '/lock') {
      NProgress.done()
      return { path: '/lock' }
    }
    if (!isLock && to.path === '/lock') {
      NProgress.done()
      return { path: '/' }
    }

    // 角色权限：词书等页面要求 ADMIN / TEACHER
    const userRole = userStore.userRole
    if (!hasRouteRole(to, userRole)) {
      ElMessage.error('没有权限')
      NProgress.done()
      return { path: '/index' }
    }

    if (userStore.roles.length === 0) {
      isRelogin.show = true
      try {
        await userStore.getInfo()
        isRelogin.show = false
        const accessRoutes = await usePermissionStore().generateRoutes()
        accessRoutes.forEach(route => {
          if (!isHttp(route.path)) {
            router.addRoute(route)
          }
        })
        return { ...to, replace: true }
      } catch (err) {
        await userStore.logOut()
        ElMessage.error(typeof err === 'string' ? err : (err?.message || '请先登录'))
        NProgress.done()
        return `/login?redirect=${to.fullPath}`
      }
    }
    return true
  }

  // 未登录
  if (isWhiteList(to.path)) {
    return true
  }
  ElMessage.warning('请先登录')
  NProgress.done()
  return `/login?redirect=${to.fullPath}`
})

router.afterEach(() => {
  NProgress.done()
})
