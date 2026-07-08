export function normalizePagePath(pagePath: string) {
  return pagePath.replace(/^\//, '')
}

export function syncCustomTabBar(pagePath: string) {
  const pages = getCurrentPages()
  const page = pages[pages.length - 1] as {
    getTabBar?: () => {
      setSelectedByPath?: (path: string) => void
      refreshTabBar?: () => void
    }
  }

  const tabBar = page?.getTabBar?.()
  if (!tabBar) return

  tabBar.setSelectedByPath?.(normalizePagePath(pagePath))
  tabBar.refreshTabBar?.()
}
