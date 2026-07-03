<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <text class="title">班级</text>
      <text class="subtitle">选择班级，加入学习</text>
    </view>

    <view class="empty-card" @tap="handleAction">
      <text class="empty-icon">+</text>
      <text class="empty-text">加入班级</text>
    </view>
  </view>
</template>

<script setup lang="ts">
import AuthModals from '@/components/AuthModals.vue'
import { useAuth } from '@/composables/useAuth'

const auth = useAuth()

function handleAction() {
  if (!auth.guardPageAccess()) return
  uni.showToast({ title: '功能开发中', icon: 'none' })
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx;
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
