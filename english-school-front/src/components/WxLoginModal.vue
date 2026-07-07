<template>
  <view v-if="visible" class="modal-mask" @tap="handleClose">
    <view class="modal-panel" @tap.stop>
      <view class="modal-header">
        <text class="modal-title">微信一键登录</text>
        <text class="modal-subtitle">
          以{{ roleLabel }}身份登录校园背单词
        </text>
      </view>

      <view class="wx-info">
        <view class="wx-icon-wrap">
          <text class="wx-icon">微</text>
        </view>
        <text class="wx-desc">{{ loginDesc }}</text>
        <text v-if="isMockEnv" class="mock-tip">当前为模拟环境，点击按钮即可体验完整流程</text>
      </view>

      <view class="auth-tips">
        <view class="tip-item">
          <text class="tip-dot" />
          <text class="tip-text">仅用于确认微信身份并匹配{{ roleLabel }}账号</text>
        </view>
        <view class="tip-item">
          <text class="tip-dot" />
          <text class="tip-text">未注册账号会先提示，再进入注册页面</text>
        </view>
      </view>

      <button
        class="wx-login-btn"
        :loading="loading"
        :disabled="loading"
        @tap="handleConfirm"
      >
        {{ buttonText }}
      </button>

      <view class="cancel-btn" @tap="handleClose">
        <text class="cancel-text">取消</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import type { UserRole } from '@/types/user'

const props = defineProps<{
  visible: boolean
  role: UserRole | null
  loading?: boolean
  isMockEnv?: boolean
}>()

const emit = defineEmits<{
  close: []
  confirm: []
}>()

const roleLabel = computed(() => (props.role === 'teacher' ? '教师' : '学生'))
const loginDesc = computed(() =>
  props.role === 'teacher'
    ? '授权后将使用微信身份登录教师端，账号需审核通过后使用'
    : '授权后将使用微信身份登录学生端，继续学习进度',
)
const buttonText = computed(() => (props.loading ? '微信授权中...' : '微信一键登录'))

function handleClose() {
  if (props.loading) return
  emit('close')
}

function handleConfirm() {
  if (props.loading) return
  emit('confirm')
}
</script>

<style scoped lang="scss">
.modal-mask {
  position: fixed;
  inset: 0;
  z-index: 1001;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 48rpx;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(8px);
}

.modal-panel {
  width: 100%;
  padding: 48rpx 40rpx 40rpx;
  background: rgba(28, 28, 30, 0.98);
  border-radius: 28rpx;
  box-shadow: 0 24rpx 80rpx rgba(0, 0, 0, 0.28);
}

.modal-header {
  margin-bottom: 40rpx;
  text-align: center;
}

.modal-title {
  display: block;
  font-size: 36rpx;
  font-weight: 600;
  color: #fff;
}

.modal-subtitle {
  display: block;
  margin-top: 12rpx;
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.55);
}

.wx-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 32rpx;
}

.wx-icon-wrap {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 120rpx;
  height: 120rpx;
  margin-bottom: 24rpx;
  border-radius: 50%;
  background: #07c160;
  box-shadow: 0 16rpx 32rpx rgba(7, 193, 96, 0.28);
}

.wx-icon {
  font-size: 48rpx;
  font-weight: 600;
  color: #fff;
}

.wx-desc {
  font-size: 26rpx;
  line-height: 1.6;
  color: rgba(255, 255, 255, 0.65);
  text-align: center;
}

.mock-tip {
  margin-top: 16rpx;
  padding: 12rpx 20rpx;
  font-size: 22rpx;
  color: #ff7a30;
  border-radius: 8rpx;
  background: rgba(255, 122, 48, 0.12);
}

.auth-tips {
  margin-bottom: 36rpx;
  padding: 24rpx;
  border-radius: 18rpx;
  background: rgba(255, 255, 255, 0.06);
}

.tip-item {
  display: flex;
  align-items: flex-start;

  & + & {
    margin-top: 16rpx;
  }
}

.tip-dot {
  width: 8rpx;
  height: 8rpx;
  margin-top: 14rpx;
  margin-right: 14rpx;
  border-radius: 50%;
  background: #07c160;
}

.tip-text {
  flex: 1;
  font-size: 23rpx;
  line-height: 1.5;
  color: rgba(255, 255, 255, 0.48);
}

.wx-login-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 96rpx;
  margin: 0;
  padding: 0;
  font-size: 30rpx;
  font-weight: 500;
  color: #fff;
  letter-spacing: 2rpx;
  border: none;
  border-radius: 48rpx;
  background: #07c160;

  &::after {
    border: none;
  }

  &[disabled] {
    opacity: 0.7;
  }
}

.cancel-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 80rpx;
  margin-top: 20rpx;
}

.cancel-text {
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.45);
}
</style>
