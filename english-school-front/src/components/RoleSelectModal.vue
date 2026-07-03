<template>
  <view v-if="visible" class="modal-mask" @tap="handleMaskTap">
    <view class="modal-panel" @tap.stop>
      <view class="modal-header">
        <text class="modal-title">选择登录身份</text>
        <text class="modal-subtitle">请选择您的身份进行微信授权登录</text>
      </view>

      <view class="role-list">
        <view class="role-item" @tap="emit('select', 'student')">
          <view class="role-icon student-icon">
            <text class="role-icon-text">学</text>
          </view>
          <view class="role-info">
            <text class="role-name">学生登录</text>
            <text class="role-desc">填写姓名与学号，自动通过</text>
          </view>
          <text class="role-arrow">›</text>
        </view>

        <view class="role-divider" />

        <view class="role-item" @tap="emit('select', 'teacher')">
          <view class="role-icon teacher-icon">
            <text class="role-icon-text">师</text>
          </view>
          <view class="role-info">
            <text class="role-name">教师登录</text>
            <text class="role-desc">填写姓名与学校，等待审批</text>
          </view>
          <text class="role-arrow">›</text>
        </view>
      </view>

      <view class="modal-footer">
        <view class="cancel-btn" @tap="emit('close')">
          <text class="cancel-text">暂不登录</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import type { UserRole } from '@/types/user'

defineProps<{
  visible: boolean
}>()

const emit = defineEmits<{
  close: []
  select: [role: UserRole]
}>()

function handleMaskTap() {
  emit('close')
}
</script>

<style scoped lang="scss">
.modal-mask {
  position: fixed;
  inset: 0;
  z-index: 1000;
  display: flex;
  align-items: flex-end;
  background: rgba(0, 0, 0, 0.55);
  backdrop-filter: blur(6px);
}

.modal-panel {
  width: 100%;
  padding: 48rpx 40rpx calc(48rpx + env(safe-area-inset-bottom));
  background: rgba(28, 28, 30, 0.96);
  border-radius: 32rpx 32rpx 0 0;
}

.modal-header {
  margin-bottom: 40rpx;
}

.modal-title {
  display: block;
  font-size: 36rpx;
  font-weight: 600;
  color: #fff;
  letter-spacing: 2rpx;
}

.modal-subtitle {
  display: block;
  margin-top: 12rpx;
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.55);
}

.role-list {
  overflow: hidden;
  border-radius: 20rpx;
  background: rgba(255, 255, 255, 0.06);
}

.role-item {
  display: flex;
  align-items: center;
  padding: 32rpx 28rpx;
}

.role-divider {
  height: 1rpx;
  margin: 0 28rpx;
  background: rgba(255, 255, 255, 0.08);
}

.role-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
}

.student-icon {
  background: rgba(255, 122, 48, 0.18);
}

.teacher-icon {
  background: rgba(255, 255, 255, 0.12);
}

.role-icon-text {
  font-size: 32rpx;
  font-weight: 600;
  color: #ff7a30;
}

.role-info {
  flex: 1;
  margin-left: 24rpx;
}

.role-name {
  display: block;
  font-size: 30rpx;
  font-weight: 500;
  color: #fff;
}

.role-desc {
  display: block;
  margin-top: 8rpx;
  font-size: 22rpx;
  color: rgba(255, 255, 255, 0.45);
}

.role-arrow {
  font-size: 40rpx;
  color: rgba(255, 255, 255, 0.3);
}

.modal-footer {
  margin-top: 32rpx;
}

.cancel-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 88rpx;
  border-radius: 44rpx;
  background: rgba(255, 255, 255, 0.08);
}

.cancel-text {
  font-size: 28rpx;
  color: rgba(255, 255, 255, 0.65);
}
</style>
