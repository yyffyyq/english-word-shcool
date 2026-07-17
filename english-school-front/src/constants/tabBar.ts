import type { UserRole } from '@/types/user'
import { normalizeRole } from '@/types/user'

export interface TabBarItem {
  pagePath: string
  text: string
  iconPath: string
  selectedIconPath: string
}

const HOME_TAB: TabBarItem = {
  pagePath: 'pages/index/index',
  text: '首页',
  iconPath: '/static/tabbar/home.png',
  selectedIconPath: '/static/tabbar/home-active.png',
}

const CLASS_TAB: TabBarItem = {
  pagePath: 'pages/class/index',
  text: '班级',
  iconPath: '/static/tabbar/class.png',
  selectedIconPath: '/static/tabbar/class-active.png',
}

const HOMEWORK_TAB: TabBarItem = {
  pagePath: 'pages/homework/index',
  text: '作业',
  iconPath: '/static/tabbar/study.png',
  selectedIconPath: '/static/tabbar/study-active.png',
}

const MINE_TAB: TabBarItem = {
  pagePath: 'pages/mine/index',
  text: '我的',
  iconPath: '/static/tabbar/mine.png',
  selectedIconPath: '/static/tabbar/mine-active.png',
}

export function getTabBarConfig(isLoggedIn: boolean, role?: UserRole | string | null): TabBarItem[] {
  if (!isLoggedIn) {
    return [HOME_TAB, MINE_TAB]
  }
  if (normalizeRole(role) === 'teacher') {
    return [HOME_TAB, CLASS_TAB, HOMEWORK_TAB, MINE_TAB]
  }
  return [HOME_TAB, CLASS_TAB, MINE_TAB]
}
