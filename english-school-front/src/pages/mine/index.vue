<template>
  <view class="page">
    <AuthModals />
    <!-- 未登录状态 -->
    <view v-if="!store.isLoggedIn" class="guest-view">
      <view class="guest-card">
        <text class="guest-title">登录后查看个人信息</text>
        <text class="guest-desc">选择教师或学生身份，微信一键登录</text>
        <view class="login-btn" @tap="auth.openRoleSelect">
          <text class="login-text">立即登录</text>
        </view>
      </view>
    </view>

    <!-- 已登录状态 -->
    <view v-else class="profile-view">
      <view class="profile-header">
        <image class="avatar" :src="store.state.user?.avatar || '/static/default-avatar.png'" mode="aspectFill" />
        <view class="profile-info">
          <text class="name">{{ store.state.user?.name }}</text>
          <text class="role-tag">{{ roleLabel }}</text>
        </view>
      </view>

      <view class="info-card">
        <view v-if="store.isStudent.value" class="info-row">
          <text class="info-label">学号</text>
          <text class="info-value">{{ store.state.user?.studentId || '-' }}</text>
        </view>
        <view v-if="store.isTeacher.value" class="info-row">
          <text class="info-label">学校</text>
          <text class="info-value">{{ store.state.user?.school || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">状态</text>
          <text class="info-value" :class="statusClass">{{ statusLabel }}</text>
        </view>
      </view>

      <view class="logout-btn" @tap="auth.logout">
        <text class="logout-text">退出登录</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { onShow, onTabItemTap } from '@dcloudio/uni-app'
import AuthModals from '@/components/AuthModals.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'

const auth = useAuth()
const store = useUserStore()

const roleLabel = computed(() => (store.isTeacher.value ? '教师' : '学生'))

const statusLabel = computed(() => {
  const status = store.state.user?.status
  if (status === 'approved') return '已通过'
  if (status === 'pending') return '审核中'
  if (status === 'rejected') return '已拒绝'
  return '-'
})

const statusClass = computed(() => {
  const status = store.state.user?.status
  if (status === 'approved') return 'status-approved'
  if (status === 'pending') return 'status-pending'
  return ''
})

onShow(() => {
  if (!store.isLoggedIn.value) {
    auth.openRoleSelect()
  }
})

onTabItemTap(() => {
  if (!store.isLoggedIn.value) {
    auth.openRoleSelect()
  }
})
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx;
  background: #f5f5f7;
}

.guest-view {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 70vh;
}

.guest-card {
  width: 100%;
  padding: 64rpx 48rpx;
  text-align: center;
  border-radius: 24rpx;
  background: #fff;
  box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.06);
}

.guest-title {
  display: block;
  font-size: 34rpx;
  font-weight: 600;
  color: #1a1a1a;
}

.guest-desc {
  display: block;
  margin-top: 16rpx;
  font-size: 26rpx;
  color: #8e8e93;
}

.login-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 88rpx;
  margin-top: 48rpx;
  border-radius: 44rpx;
  background: #1a1a1a;
}

.login-text {
  font-size: 28rpx;
  color: #fff;
  letter-spacing: 2rpx;
}

.profile-header {
  display: flex;
  align-items: center;
  padding: 32rpx;
  margin-bottom: 24rpx;
  border-radius: 24rpx;
  background: #fff;
}

.avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  background: #e5e5ea;
}

.profile-info {
  margin-left: 28rpx;
}

.name {
  display: block;
  font-size: 36rpx;
  font-weight: 600;
  color: #1a1a1a;
}

.role-tag {
  display: inline-block;
  margin-top: 12rpx;
  padding: 4rpx 16rpx;
  font-size: 22rpx;
  color: #ff7a30;
  border-radius: 8rpx;
  background: rgba(255, 122, 48, 0.12);
}

.info-card {
  padding: 8rpx 32rpx;
  border-radius: 24rpx;
  background: #fff;
}

.info-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 28rpx 0;
  border-bottom: 1rpx solid #f0f0f0;

  &:last-child {
    border-bottom: none;
  }
}

.info-label {
  font-size: 28rpx;
  color: #8e8e93;
}

.info-value {
  font-size: 28rpx;
  color: #1a1a1a;
}

.status-approved {
  color: #34c759;
}

.status-pending {
  color: #ff7a30;
}

.logout-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 88rpx;
  margin-top: 48rpx;
  border-radius: 44rpx;
  background: #fff;
  border: 1rpx solid #e5e5ea;
}

.logout-text {
  font-size: 28rpx;
  color: #ff3b30;
}
</style>
