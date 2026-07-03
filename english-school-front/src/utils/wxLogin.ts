export interface WxLoginCodeResult {
  code: string
  isMock: boolean
}

/** 获取微信登录 code，H5 等非微信环境自动 Mock */
export async function getWxLoginCode(): Promise<WxLoginCodeResult> {
  // #ifdef MP-WEIXIN
  const loginRes = await uni.login({ provider: 'weixin' })
  if (!loginRes.code) {
    throw new Error('微信登录失败，未获取到 code')
  }
  return { code: loginRes.code, isMock: false }
  // #endif

  // #ifndef MP-WEIXIN
  await delay(600)
  const STORAGE_KEY = 'mock_wx_login_code'
  let mockCode = uni.getStorageSync(STORAGE_KEY)
  if (!mockCode) {
    mockCode = `mock_wx_${Date.now().toString(36)}`
    uni.setStorageSync(STORAGE_KEY, mockCode)
  }
  return { code: mockCode, isMock: true }
  // #endif
}

function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}
