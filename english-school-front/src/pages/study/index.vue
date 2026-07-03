<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <text class="title">今日学习</text>
      <text class="subtitle">完成教师布置的单词任务</text>
    </view>

    <view class="card" @tap="handleAction">
      <text class="card-num">0</text>
      <text class="card-label">待学单词</text>
    </view>

    <view class="start-btn" @tap="handleAction">
      <text class="btn-text">开始学习</text>
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

.card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 280rpx;
  margin-bottom: 40rpx;
  border-radius: 24rpx;
  background: #fff;
  box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.06);
}

.card-num {
  font-size: 72rpx;
  font-weight: 300;
  color: #ff7a30;
}

.card-label {
  margin-top: 8rpx;
  font-size: 26rpx;
  color: #8e8e93;
}

.start-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 96rpx;
  border-radius: 48rpx;
  background: #1a1a1a;
}

.btn-text {
  font-size: 30rpx;
  font-weight: 500;
  color: #fff;
  letter-spacing: 4rpx;
}
</style>
