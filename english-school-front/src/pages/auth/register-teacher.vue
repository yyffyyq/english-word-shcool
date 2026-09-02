<template>
  <view class="page">
    <image class="bg-image" src="/static/bg-home.png" mode="aspectFill" />
    <view class="bg-overlay" />

    <view class="form-wrap">
      <view class="form-header">
        <text class="form-title">教师注册</text>
        <text class="form-subtitle">提交后需等待管理员审批</text>
      </view>

      <view class="auth-card">
        <view class="auth-icon">
          <text class="auth-icon-text">微</text>
        </view>
        <view class="auth-info">
          <text class="auth-title">微信授权已完成</text>
          <text class="auth-desc">
            {{ pendingAuth?.openid ? '已获取微信身份，将用于提交教师注册申请' : '微信身份信息缺失，请返回重新授权' }}
          </text>
        </view>
      </view>

      <view class="form-card">
        <view class="form-item">
          <text class="label">姓名</text>
          <input
            v-model="name"
            class="input"
            placeholder="请输入真实姓名"
            placeholder-class="placeholder"
            maxlength="20"
          />
        </view>
        <view class="form-item">
          <text class="label">学校</text>
          <input
            v-model="school"
            class="input"
            placeholder="请输入所在学校"
            placeholder-class="placeholder"
            maxlength="50"
          />
        </view>
      </view>

      <text class="form-tip">请填写真实信息，管理员审批通过后即可使用教师功能</text>

      <view class="submit-btn" :class="{ disabled: !canSubmit }" @tap="handleSubmit">
        <text class="submit-text">{{ auth.loading ? '提交中...' : '提交申请' }}</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'

const auth = useAuth()
const store = useUserStore()

const name = ref('')
const school = ref('')
const pendingAuth = computed(() => store.state.pendingRegisterAuth)

const canSubmit = computed(
  () =>
    Boolean(
      pendingAuth.value?.role === 'teacher' &&
        pendingAuth.value.openid &&
        name.value.trim() &&
        school.value.trim() &&
        !auth.loading.value,
    ),
)

onLoad(() => {
  if (pendingAuth.value?.role !== 'teacher') {
    uni.showToast({ title: '请先完成微信授权', icon: 'none' })
    uni.navigateBack()
    return
  }

  name.value = pendingAuth.value.realName || ''
  school.value = pendingAuth.value.schoolName || ''
})

async function handleSubmit() {
  if (!canSubmit.value) {
    uni.showToast({ title: '请完整填写注册信息', icon: 'none' })
    return
  }
  await auth.submitTeacherRegister(name.value, school.value)
}
</script>

<style scoped lang="scss">
.page {
  position: relative;
  min-height: 100vh;
  background: #1a1a1a;
}

.bg-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  opacity: 0.4;
}

.bg-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.55);
}

.form-wrap {
  position: relative;
  z-index: 1;
  padding: calc(var(--status-bar-height, 44px) + 80rpx) 40rpx 80rpx;
}

.form-header {
  margin-bottom: 48rpx;
}

.form-title {
  display: block;
  font-size: 48rpx;
  font-weight: 300;
  color: #fff;
  letter-spacing: 4rpx;
}

.form-subtitle {
  display: block;
  margin-top: 12rpx;
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.5);
}

.auth-card {
  display: flex;
  align-items: center;
  margin-bottom: 28rpx;
  padding: 28rpx 32rpx;
  border-radius: 24rpx;
  background: rgba(7, 193, 96, 0.12);
  backdrop-filter: blur(12px);
}

.auth-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 72rpx;
  height: 72rpx;
  border-radius: 50%;
  background: #07c160;
}

.auth-icon-text {
  font-size: 30rpx;
  font-weight: 600;
  color: #fff;
}

.auth-info {
  flex: 1;
  margin-left: 22rpx;
}

.auth-title {
  display: block;
  font-size: 28rpx;
  font-weight: 500;
  color: #fff;
}

.auth-desc {
  display: block;
  margin-top: 8rpx;
  font-size: 22rpx;
  line-height: 1.4;
  color: rgba(255, 255, 255, 0.55);
}

.form-card {
  padding: 8rpx 32rpx;
  border-radius: 24rpx;
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(12px);
}

.form-item {
  padding: 28rpx 0;
  border-bottom: 1rpx solid rgba(255, 255, 255, 0.08);

  &:last-child {
    border-bottom: none;
  }
}

.label {
  display: block;
  margin-bottom: 16rpx;
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.5);
}

.input {
  height: 64rpx;
  font-size: 30rpx;
  color: #fff;
}

.placeholder {
  color: rgba(255, 255, 255, 0.25);
}

.form-tip {
  display: block;
  margin-top: 20rpx;
  font-size: 22rpx;
  line-height: 1.5;
  color: rgba(255, 255, 255, 0.42);
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 96rpx;
  margin-top: 64rpx;
  border-radius: 48rpx;
  background: linear-gradient(135deg, #ff8a3d 0%, #ffb074 100%);
  box-shadow: 0 10rpx 24rpx rgba(255, 138, 61, 0.3);

  &.disabled {
    opacity: 0.45;
    box-shadow: none;
  }
}

.submit-text {
  font-size: 30rpx;
  font-weight: 600;
  color: #fff;
  letter-spacing: 4rpx;
}
</style>
