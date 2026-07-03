<template>
  <view class="page">
    <AuthModals />
    <image class="bg-image" src="/static/bg-home.png" mode="aspectFill" />
    <view class="bg-overlay" />

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
        <view class="entry-item" @tap="handleStudentLogin">
          <text class="entry-label">学生登录</text>
          <text class="entry-count">STUDENT</text>
        </view>
        <view class="entry-divider" />
        <view class="entry-item" @tap="handleTeacherLogin">
          <text class="entry-label">教师登录</text>
          <text class="entry-count">TEACHER</text>
        </view>
      </view>

      <view class="bottom-tools">
        <view class="tool-btn" @tap="goStudy">
          <text class="tool-icon">▦</text>
        </view>
        <view class="tool-btn" @tap="goMine">
          <text class="tool-icon">⌕</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import AuthModals from '@/components/AuthModals.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'

const auth = useAuth()
const store = useUserStore()

const userAvatar = computed(() => store.state.user?.avatar || '/static/default-avatar.png')

function handleStudentLogin() {
  auth.loginWithRole('student')
}

function handleTeacherLogin() {
  auth.loginWithRole('teacher')
}

function goStudy() {
  if (!auth.guardPageAccess()) return
  uni.switchTab({ url: '/pages/study/index' })
}

function goMine() {
  if (!auth.handleMineTabAccess()) return
  uni.switchTab({ url: '/pages/mine/index' })
}
</script>

<style scoped lang="scss">
.page {
  position: relative;
  min-height: 100vh;
  overflow: hidden;
  background: #1a1a1a;
}

.bg-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
}

.bg-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    180deg,
    rgba(0, 0, 0, 0.15) 0%,
    rgba(0, 0, 0, 0.35) 55%,
    rgba(0, 0, 0, 0.65) 100%
  );
}

.page-content {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  padding: calc(var(--status-bar-height, 44px) + 24rpx) 40rpx calc(120rpx + env(safe-area-inset-bottom));
}

.top-bar {
  display: flex;
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
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: -80rpx;
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
  align-items: stretch;
  height: 120rpx;
  background: rgba(0, 0, 0, 0.42);
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

.bottom-tools {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 32rpx;
  padding: 0 8rpx;
}

.tool-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 64rpx;
  height: 64rpx;
}

.tool-icon {
  font-size: 36rpx;
  color: rgba(255, 255, 255, 0.75);
}
</style>
