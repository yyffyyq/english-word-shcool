<template>
  <view class="page">
    <image class="bg-image" src="/static/bg-home.png" mode="aspectFill" />
    <view class="bg-overlay" />

    <view class="form-wrap">
      <view class="form-header">
        <text class="form-title">教师注册</text>
        <text class="form-subtitle">提交后需等待管理员审批</text>
      </view>

      <view class="form-card">
        <view class="form-item">
          <text class="label">姓名</text>
          <input
            v-model="name"
            class="input"
            placeholder="请输入真实姓名"
            placeholder-class="placeholder"
          />
        </view>
        <view class="form-item">
          <text class="label">学校</text>
          <input
            v-model="school"
            class="input"
            placeholder="请输入所在学校"
            placeholder-class="placeholder"
          />
        </view>
      </view>

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

const canSubmit = computed(
  () => name.value.trim() && school.value.trim() && !auth.loading.value,
)

onLoad(() => {
  if (store.state.pendingRole !== 'teacher') {
    uni.navigateBack()
  }
})

async function handleSubmit() {
  if (!canSubmit.value) return
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

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 96rpx;
  margin-top: 64rpx;
  border-radius: 48rpx;
  background: #ff7a30;

  &.disabled {
    opacity: 0.45;
  }
}

.submit-text {
  font-size: 30rpx;
  font-weight: 500;
  color: #fff;
  letter-spacing: 4rpx;
}
</style>
