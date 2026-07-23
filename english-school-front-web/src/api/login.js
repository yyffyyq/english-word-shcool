import request from '@/utils/request'

// 管理端登录（对接 /api/userAccount/system/login）
export function login(username, password) {
  return request({
    url: '/userAccount/system/login',
    headers: {
      isToken: false,
      repeatSubmit: false
    },
    method: 'post',
    data: {
      username,
      password
    }
  })
}

// 注册方法（后端有 system/register，后续可接）
export function register(data) {
  return request({
    url: '/userAccount/system/register',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}

// 获取用户详细信息（当前后端无独立接口，由 store 使用登录缓存）
export function getInfo() {
  return Promise.reject(new Error('请使用本地登录缓存获取用户信息'))
}

// 解锁屏幕（本地校验，无后端接口）
export function unlockScreen(password) {
  return Promise.resolve({ code: 0, message: 'ok', data: { password } })
}

// 退出方法（当前后端无独立接口，前端本地清理即可）
export function logout() {
  return Promise.resolve({ code: 0, message: 'ok' })
}

// 获取验证码（本项目登录不使用验证码）
export function getCodeImg() {
  return Promise.resolve({
    captchaEnabled: false,
    img: '',
    uuid: ''
  })
}
