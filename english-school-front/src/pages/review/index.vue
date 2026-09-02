<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <text class="title">复习</text>
      <text class="subtitle">按遗忘曲线巩固已学单词</text>
    </view>

    <view class="card" @tap="handleAction">
      <text class="card-num">0</text>
      <text class="card-label">待复习</text>
    </view>

    <view class="start-btn" @tap="handleAction">
      <text class="btn-text">开始复习</text>
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
  background: #f3f8fd;
}

.header {
  margin-bottom: 40rpx;
}

.title {
  display: block;
  font-size: 44rpx;
  font-weight: 700;
  color: #1f2a37;
}

.subtitle {
  display: block;
  margin-top: 8rpx;
  font-size: 26rpx;
  color: #7a8594;
}

.card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 280rpx;
  margin-bottom: 40rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.12);
  border: 2rpx solid #e8f4fe;
}

.card-num {
  font-size: 72rpx;
  font-weight: 700;
  color: #ff8a3d;
}

.card-label {
  margin-top: 8rpx;
  font-size: 26rpx;
  color: #7a8594;
}

.start-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 96rpx;
  border-radius: 48rpx;
  background: linear-gradient(135deg, #ff8a3d 0%, #ffb074 100%);
  box-shadow: 0 10rpx 24rpx rgba(255, 138, 61, 0.3);
}

.btn-text {
  font-size: 30rpx;
  font-weight: 600;
  color: #fff;
  letter-spacing: 4rpx;
}
</style>
