<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <text class="title">作业</text>
      <text class="subtitle">布置与管理班级单词作业</text>
    </view>

    <view class="empty-card" @tap="handleAction">
      <text class="empty-icon">+</text>
      <text class="empty-text">创建作业</text>
    </view>
    <AppTabBar current-path="pages/homework/index" />
  </view>
</template>

<script setup lang="ts">
import { onShow } from '@dcloudio/uni-app'
import AuthModals from '@/components/AuthModals.vue'
import AppTabBar from '@/components/AppTabBar.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'
import { syncCustomTabBar } from '@/utils/tabBar'

const auth = useAuth()
const store = useUserStore()

onShow(() => {
  syncCustomTabBar('pages/homework/index')
  if (store.isLoggedIn.value && !store.isTeacher.value) {
    uni.switchTab({ url: '/pages/index/index' })
  }
})

function handleAction() {
  if (!auth.guardPageAccess()) return
  uni.showToast({ title: '功能开发中', icon: 'none' })
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx 32rpx calc(140rpx + env(safe-area-inset-bottom));
  background: #f5f5f7;
}

.header {
  margin-bottom: 40rpx;
}

.title {
  display: block;
  font-size: 44rpx;
  font-weight: 600;
  color: #1a1a1a;
}

.subtitle {
  display: block;
  margin-top: 8rpx;
  font-size: 26rpx;
  color: #8e8e93;
}

.empty-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 320rpx;
  border: 2rpx dashed #d1d1d6;
  border-radius: 24rpx;
  background: #fff;
}

.empty-icon {
  font-size: 64rpx;
  color: #ff7a30;
}

.empty-text {
  margin-top: 16rpx;
  font-size: 28rpx;
  color: #8e8e93;
}
</style>
