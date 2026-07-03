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
  border-radius: 24rpx;
  background: #fff;
  box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.06);
}

.stat-num {
  font-size: 56rpx;
  font-weight: 300;
  color: #ff7a30;
}

.stat-label {
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #8e8e93;
}
</style>
