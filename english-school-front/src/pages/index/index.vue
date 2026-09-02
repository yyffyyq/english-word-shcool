<template>
  <view class="page" :style="pageStyle">
    <AuthModals />

    <view class="page-content">
      <view class="hero-panel">
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
      </view>

      <view class="sheet">
        <view class="entry-grid">
          <view class="entry-card study" @tap="goStudy">
            <view class="entry-icon study-icon">
              <text class="entry-icon-text">学</text>
            </view>
            <text class="entry-label">学习</text>
            <text class="entry-count">STUDY</text>
          </view>
          <view class="entry-card review" @tap="goReview">
            <view class="entry-icon review-icon">
              <text class="entry-icon-text">习</text>
            </view>
            <text class="entry-label">复习</text>
            <text class="entry-count">REVIEW</text>
          </view>
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
import { useUserStore } from '@/store/user'
import AppTabBar from '@/components/AppTabBar.vue'
import { syncCustomTabBar } from '@/utils/tabBar'

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

function goStudy() {
  uni.navigateTo({ url: '/pages/study/index' })
}

function goReview() {
  uni.navigateTo({ url: '/pages/review/index' })
}

function goMine() {
  uni.switchTab({ url: '/pages/mine/index' })
}
</script>

<style lang="scss">
page {
  width: 100%;
  min-height: 100%;
  background: #4ba8f5;
}
</style>

<style scoped lang="scss">
.page {
  position: relative;
  box-sizing: border-box;
  width: 100%;
  min-height: var(--page-height);
  overflow: visible;
  background: linear-gradient(180deg, #4ba8f5 0%, #6bc4ff 42%, #f3f8fd 42%, #f3f8fd 100%);
}

.page-content {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  width: 100%;
  min-height: var(--page-height);
  padding: calc(var(--status-bar-height, 44px) + 24rpx) 32rpx calc(var(--app-tab-bar-height, 56px) + 34rpx);
}

.hero-panel {
  flex-shrink: 0;
  padding: 8rpx 8rpx 48rpx;
}

.top-bar {
  display: flex;
  flex-shrink: 0;
  align-items: center;
}

.avatar-wrap {
  width: 80rpx;
  height: 80rpx;
  padding: 4rpx;
  border: 3rpx solid rgba(255, 255, 255, 0.9);
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.25);
  box-shadow: 0 8rpx 20rpx rgba(31, 111, 184, 0.2);
}

.avatar {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.35);
}

.hero {
  display: flex;
  flex-direction: column;
  margin-top: 48rpx;
}

.hero-label {
  font-size: 22rpx;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.75);
  letter-spacing: 6rpx;
}

.hero-title {
  margin-top: 16rpx;
  font-size: 64rpx;
  font-weight: 700;
  color: #fff;
  letter-spacing: 4rpx;
  text-shadow: 0 6rpx 16rpx rgba(31, 111, 184, 0.25);
}

.hero-subtitle {
  margin-top: 12rpx;
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.85);
  letter-spacing: 2rpx;
}

.sheet {
  flex: 1;
  margin-top: 12rpx;
  padding: 36rpx 28rpx 28rpx;
  border-radius: 36rpx;
  background: #fff;
  box-shadow: 0 16rpx 40rpx rgba(75, 168, 245, 0.16);
}

.entry-grid {
  display: flex;
  gap: 24rpx;
}

.entry-card {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 260rpx;
  padding: 28rpx 16rpx;
  border-radius: 28rpx;
  box-shadow: 0 10rpx 24rpx rgba(75, 168, 245, 0.1);
  border: 2rpx solid transparent;

  &.study {
    background: linear-gradient(180deg, #eaf6ff 0%, #ffffff 100%);
    border-color: #cfe9ff;
  }

  &.review {
    background: linear-gradient(180deg, #fff4eb 0%, #ffffff 100%);
    border-color: #ffe0c8;
  }
}

.entry-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 96rpx;
  height: 96rpx;
  border-radius: 28rpx;
  margin-bottom: 20rpx;
}

.study-icon {
  background: linear-gradient(135deg, #4ba8f5 0%, #6bc4ff 100%);
  box-shadow: 0 8rpx 18rpx rgba(75, 168, 245, 0.35);
}

.review-icon {
  background: linear-gradient(135deg, #ff8a3d 0%, #ffb074 100%);
  box-shadow: 0 8rpx 18rpx rgba(255, 138, 61, 0.35);
}

.entry-icon-text {
  font-size: 36rpx;
  font-weight: 700;
  color: #fff;
}

.entry-label {
  font-size: 32rpx;
  font-weight: 700;
  color: #1f2a37;
  letter-spacing: 4rpx;
}

.entry-count {
  margin-top: 8rpx;
  font-size: 22rpx;
  font-weight: 600;
  color: #7a8594;
  letter-spacing: 2rpx;
}
</style>
