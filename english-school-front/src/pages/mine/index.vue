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
          <text v-if="store.isLoggedIn" class="role-tag">{{ roleLabel }}</text>
        </view>
      </view>

      <view class="info-card">
        <view v-if="store.isLoggedIn && store.isStudent.value" class="info-row">
          <text class="info-label">学号</text>
          <text class="info-value">{{ store.state.user?.studentId || '-' }}</text>
        </view>
        <view v-if="store.isLoggedIn && store.isTeacher.value" class="info-row">
          <text class="info-label">学校</text>
          <text class="info-value">{{ store.state.user?.school || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">状态</text>
          <text class="info-value" :class="statusClass">{{ statusLabel }}</text>
        </view>
      </view>

      <view class="action-btn" :class="{ login: !store.isLoggedIn }" @tap="handleAction">
        <text class="action-text" :class="{ 'login-text': !store.isLoggedIn }">
          {{ store.isLoggedIn ? '退出登录' : '请登录' }}
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
  background: #f5f5f7;
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

.status-guest {
  color: #8e8e93;
}

.status-approved {
  color: #34c759;
}

.status-pending {
  color: #ff7a30;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 88rpx;
  margin-top: 48rpx;
  border-radius: 44rpx;
  background: #fff;
  border: 1rpx solid #e5e5ea;

  &.login {
    background: #1a1a1a;
    border-color: #1a1a1a;
  }
}

.action-text {
  font-size: 28rpx;
  color: #ff3b30;
}

.login-text {
  color: #fff;
  letter-spacing: 2rpx;
}
</style>
