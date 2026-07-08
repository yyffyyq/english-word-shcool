<template>
  <view class="page" :style="pageStyle">
    <AuthModals />

    <view class="page-content">
      <view class="top-bar">
        <view class="avatar-wrap" @tap="goMine">
          <image
            class="avatar"
            :src="userAvatar"
            mode="aspectFill"
          />
        </view>
      </view>

      <view class="hero">
        <text class="hero-label">CAMPUS WORDS</text>
        <text class="hero-title">校园背单词</text>
        <text class="hero-subtitle">每天进步一点点</text>
      </view>

      <view class="entry-bar">
        <view class="entry-item" @tap="goStudy">
          <text class="entry-label">学习</text>
          <text class="entry-count">STUDY</text>
        </view>
        <view class="entry-divider" />
        <view class="entry-item" @tap="goReview">
          <text class="entry-label">复习</text>
          <text class="entry-count">REVIEW</text>
        </view>
      </view>
    </view>
    <AppTabBar current-path="pages/index/index" />
  </view>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import AuthModals from '@/components/AuthModals.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'
import AppTabBar from '@/components/AppTabBar.vue'
import { syncCustomTabBar } from '@/utils/tabBar'

const auth = useAuth()
const store = useUserStore()

const pageStyle = ref<Record<string, string>>({
  height: '100%',
})

const userAvatar = computed(() => store.state.user?.avatar || '/static/default-avatar.png')

function initPageLayout() {
  const info = uni.getWindowInfo()
  const statusBarHeight = info.statusBarHeight || 0
  const tabBarHeight = 56 + (info.safeAreaInsets?.bottom || 0)
  const pageHeight = Math.max(info.windowHeight, 0)
  pageStyle.value = {
    minHeight: `${pageHeight}px`,
    width: '100%',
    '--status-bar-height': `${statusBarHeight}px`,
    '--page-height': `${pageHeight}px`,
    '--app-tab-bar-height': `${tabBarHeight}px`,
  }
}
onLoad(initPageLayout)
onShow(() => {
  initPageLayout()
  syncCustomTabBar('pages/index/index')
})

function requireLogin(): boolean {
  if (store.isLoggedIn.value) return true
  uni.showToast({ title: '请先登录', icon: 'none' })
  auth.openRoleSelect()
  return false
}

function goStudy() {
  if (!requireLogin()) return
  if (!auth.guardPageAccess()) return
  uni.navigateTo({ url: '/pages/study/index' })
}

function goReview() {
  if (!requireLogin()) return
  if (!auth.guardPageAccess()) return
  uni.navigateTo({ url: '/pages/review/index' })
}

function goMine() {
  if (!auth.handleMineTabAccess()) return
  uni.switchTab({ url: '/pages/mine/index' })
}
</script>

<style lang="scss">
page {
  width: 100%;
  min-height: 100%;
  background: #1e4d3b;
}
</style>

<style scoped lang="scss">
.page {
  position: relative;
  box-sizing: border-box;
  width: 100%;
  min-height: var(--page-height);
  overflow: visible;
  background: linear-gradient(180deg, #1e4d3b 0%, #0f2e24 100%);
}

.page-content {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  width: 100%;
  min-height: var(--page-height);
  padding: calc(var(--status-bar-height, 44px) + 24rpx) 40rpx calc(var(--app-tab-bar-height, 56px) + 34rpx);
}

.top-bar {
  display: flex;
  flex-shrink: 0;
  align-items: center;
}

.avatar-wrap {
  width: 72rpx;
  height: 72rpx;
  padding: 4rpx;
  border: 2rpx solid rgba(255, 255, 255, 0.85);
  border-radius: 50%;
}

.avatar {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.2);
}

.hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 300rpx;
}

.hero-label {
  font-size: 22rpx;
  color: rgba(255, 255, 255, 0.5);
  letter-spacing: 8rpx;
}

.hero-title {
  margin-top: 20rpx;
  font-size: 72rpx;
  font-weight: 300;
  color: #fff;
  letter-spacing: 12rpx;
}

.hero-subtitle {
  margin-top: 16rpx;
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.45);
  letter-spacing: 4rpx;
}

.entry-bar {
  display: flex;
  flex-shrink: 0;
  align-items: stretch;
  width: 100%;
  height: 120rpx;
  margin-top: auto;
  background: rgba(0, 0, 0, 0.22);
  backdrop-filter: blur(16px);
}

.entry-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.entry-divider {
  width: 1rpx;
  margin: 24rpx 0;
  background: rgba(255, 255, 255, 0.15);
}

.entry-label {
  font-size: 28rpx;
  font-weight: 600;
  color: #fff;
  letter-spacing: 6rpx;
}

.entry-count {
  margin-top: 8rpx;
  font-size: 22rpx;
  font-weight: 500;
  color: #ff7a30;
  letter-spacing: 2rpx;
}

</style>
