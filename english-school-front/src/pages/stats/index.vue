<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <text class="title">统计</text>
      <text class="subtitle">学习数据与打卡记录</text>
    </view>

    <view class="stats-grid">
      <view class="stat-item" @tap="handleAction">
        <text class="stat-num">0</text>
        <text class="stat-label">已学单词</text>
      </view>
      <view class="stat-item" @tap="handleAction">
        <text class="stat-num">0</text>
        <text class="stat-label">连续打卡</text>
      </view>
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

.stats-grid {
  display: flex;
  gap: 24rpx;
}

.stat-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 200rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.12);
  border: 2rpx solid #e8f4fe;
}

.stat-num {
  font-size: 56rpx;
  font-weight: 700;
  color: #4ba8f5;
}

.stat-label {
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #7a8594;
}
</style>
