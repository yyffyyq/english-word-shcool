<template>
  <view class="page">
    <AuthModals />

    <view class="profile-view">
      <view class="profile-header">
        <image
          class="avatar"
          :src="avatarUrl"
          mode="aspectFill"
        />
        <view class="profile-info">
          <text class="name">{{ displayName }}</text>
          <text v-if="isLoggedIn" class="role-tag">{{ roleLabel }}</text>
        </view>
      </view>

      <view class="info-card">
        <view v-if="isLoggedIn && isStudent" class="info-row">
          <text class="info-label">学号</text>
          <text class="info-value">{{ store.state.user?.studentId || '-' }}</text>
        </view>
        <view v-if="isLoggedIn && isTeacher" class="info-row">
          <text class="info-label">学校</text>
          <text class="info-value">{{ store.state.user?.school || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">状态</text>
          <text class="info-value" :class="statusClass">{{ statusLabel }}</text>
        </view>
      </view>

      <view class="action-btn" :class="{ login: !isLoggedIn }" @tap="handleAction">
        <text class="action-text" :class="{ 'login-text': !isLoggedIn }">
          {{ isLoggedIn ? '退出登录' : '微信一键登录' }}
        </text>
      </view>
    </view>
    <AppTabBar current-path="pages/mine/index" />
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import AuthModals from '@/components/AuthModals.vue'
import AppTabBar from '@/components/AppTabBar.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'
import { syncCustomTabBar } from '@/utils/tabBar'

const auth = useAuth()
const store = useUserStore()
const isLoggedIn = store.isLoggedIn
const isStudent = store.isStudent
const isTeacher = store.isTeacher

onShow(() => {
  syncCustomTabBar('pages/mine/index')
})

const avatarUrl = computed(() =>
  store.isLoggedIn.value
    ? store.state.user?.avatar || '/static/default-avatar.png'
    : '/static/default-avatar.png',
)

const displayName = computed(() =>
  store.isLoggedIn.value ? store.state.user?.name || '微信用户' : '未登录',
)

const roleLabel = computed(() => (store.isTeacher.value ? '教师' : '学生'))

const statusLabel = computed(() => {
  if (!store.isLoggedIn.value) return '未登录'

  const status = store.state.user?.status
  if (status === 'approved') return '已通过'
  if (status === 'pending') return '审核中'
  if (status === 'rejected') return '已拒绝'
  return '-'
})

const statusClass = computed(() => {
  if (!store.isLoggedIn.value) return 'status-guest'

  const status = store.state.user?.status
  if (status === 'approved') return 'status-approved'
  if (status === 'pending') return 'status-pending'
  return ''
})

function handleAction() {
  if (store.isLoggedIn.value) {
    auth.logout()
    return
  }
  auth.openRoleSelect()
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx 32rpx calc(140rpx + env(safe-area-inset-bottom));
  background: #f3f8fd;
}

.profile-header {
  display: flex;
  align-items: center;
  padding: 32rpx;
  margin-bottom: 24rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.12);
  border: 2rpx solid #e8f4fe;
}

.avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  background: #e8f4fe;
  border: 4rpx solid #cfe9ff;
}

.profile-info {
  margin-left: 28rpx;
}

.name {
  display: block;
  font-size: 36rpx;
  font-weight: 700;
  color: #1f2a37;
}

.role-tag {
  display: inline-block;
  margin-top: 12rpx;
  padding: 4rpx 16rpx;
  font-size: 22rpx;
  color: #4ba8f5;
  border-radius: 999rpx;
  background: rgba(75, 168, 245, 0.12);
}

.info-card {
  padding: 8rpx 32rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.1);
  border: 2rpx solid #e8f4fe;
}

.info-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 28rpx 0;
  border-bottom: 1rpx solid #eef4fa;

  &:last-child {
    border-bottom: none;
  }
}

.info-label {
  font-size: 28rpx;
  color: #7a8594;
}

.info-value {
  font-size: 28rpx;
  color: #1f2a37;
}

.status-guest {
  color: #7a8594;
}

.status-approved {
  color: #34c759;
}

.status-pending {
  color: #ff8a3d;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 88rpx;
  margin-top: 48rpx;
  border-radius: 44rpx;
  background: #fff;
  border: 2rpx solid #e3eaf2;

  &.login {
    background: linear-gradient(135deg, #4ba8f5 0%, #6bc4ff 100%);
    border-color: transparent;
    box-shadow: 0 10rpx 24rpx rgba(75, 168, 245, 0.28);
  }
}

.action-text {
  font-size: 28rpx;
  color: #ff3b30;
}

.login-text {
  color: #fff;
  letter-spacing: 2rpx;
  font-weight: 600;
}
</style>
