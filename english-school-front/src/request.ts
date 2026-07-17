const BASE_URL = 'http://192.168.2.38:8081/api'
const DEFAULT_TIMEOUT = 60000

type RequestMethod =
  | 'GET'
  | 'POST'
  | 'PUT'
  | 'DELETE'
  | 'CONNECT'
  | 'HEAD'
  | 'OPTIONS'
  | 'TRACE'

interface RequestConfig {
  method?: RequestMethod
  headers?: Record<string, string>
  header?: Record<string, string>
  data?: UniApp.RequestOptions['data']
  params?: Record<string, string | number | boolean | null | undefined>
  timeout?: number
  [key: string]: unknown
}

interface RequestResponse<T> {
  data: T
  statusCode: number
  header: unknown
  config: RequestConfig
}

function myAxios<T = unknown>(
  url: string,
  config: RequestConfig = {},
): Promise<RequestResponse<T>> {
  const requestUrl = buildUrl(url, config.params)
  const header = buildRequestHeader(config)

  return new Promise((resolve, reject) => {
    uni.request({
      url: requestUrl,
      method: config.method || 'GET',
      data: config.data,
      header,
      timeout: config.timeout || DEFAULT_TIMEOUT,
      success(response) {
        const result = {
          data: response.data as T,
          statusCode: response.statusCode,
          header: response.header,
          config,
        }

        handleUnauthorized(url, result.data)

        if (response.statusCode >= 200 && response.statusCode < 300) {
          resolve(result)
          return
        }

        reject(new Error(`请求失败：${response.statusCode}`))
      },
      fail(error) {
        reject(new Error(error.errMsg || '网络请求失败'))
      },
    })
  })
}

function buildUrl(
  url: string,
  params?: RequestConfig['params'],
) {
  const fullUrl = url.startsWith('http') ? url : `${BASE_URL}${url}`
  if (!params) return fullUrl

  const query = Object.entries(params)
    .filter(([, value]) => value !== null && value !== undefined)
    .map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(String(value))}`)
    .join('&')

  if (!query) return fullUrl
  return `${fullUrl}${fullUrl.includes('?') ? '&' : '?'}${query}`
}

function buildRequestHeader(config: RequestConfig): Record<string, string> {
  const header: Record<string, string> = {
    ...(config.header || config.headers || {}),
  }

  if (!header.openid) {
    try {
      const user = uni.getStorageSync('english_school_user') as { openid?: string } | ''
      const openid = user && typeof user === 'object' ? user.openid : ''
      if (openid) {
        header.openid = openid
      }
    } catch {
      // ignore storage read errors
    }
  }

  return header
}

function handleUnauthorized(url: string, data: unknown) {
  if (!isBaseResponse(data) || data.code !== 40100) return
  if (url.includes('user/get/login')) return

  uni.showToast({ title: '请先登录', icon: 'none' })

  if (typeof window !== 'undefined' && !window.location.pathname.includes('/user/login')) {
    window.location.href = `/user/login?redirect=${window.location.href}`
  }
}

function isBaseResponse(data: unknown): data is { code?: number } {
  return typeof data === 'object' && data !== null && 'code' in data
}

export { myAxios }
export default myAxios