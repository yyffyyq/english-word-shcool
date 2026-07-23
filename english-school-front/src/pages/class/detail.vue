<template>
  <view class="page">
    <AuthModals />

    <view v-if="loading && !classInfo" class="list-tip">
      <text class="list-tip-text">加载中...</text>
    </view>

    <template v-else-if="classInfo">
      <view class="header">
        <text class="title">{{ classInfo.className || '班级详情' }}</text>
        <text class="subtitle">查看班级信息与学生名单</text>
      </view>

      <view class="section-title">班级信息</view>
      <view class="info-card">
        <view class="info-row">
          <text class="info-label">班级名称</text>
          <text class="info-value">{{ classInfo.className || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">年级</text>
          <text class="info-value">{{ classInfo.grade || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">学校</text>
          <text class="info-value">{{ classInfo.schoolName || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">学生人数</text>
          <text class="info-value">{{ studentCountDisplay }}</text>
        </view>
        <view v-if="isTeacher" class="info-row" @tap="handleInviteTap">
          <text class="info-label">邀请码</text>
          <view class="invite-wrap">
            <text class="invite-code">{{ classInfo.inviteCode || '-' }}</text>
            <text v-if="classInfo.inviteCode" class="invite-action">
              {{ refreshing ? '刷新中' : '刷新' }}
            </text>
          </view>
        </view>
        <view class="info-row">
          <text class="info-label">状态</text>
          <text class="info-value">{{ statusLabel }}</text>
        </view>
      </view>

      <view class="section-title">学生名单</view>
      <view v-if="studentsLoading && studentList.length === 0" class="list-tip">
        <text class="list-tip-text">加载学生中...</text>
      </view>
      <view v-else-if="studentList.length === 0" class="empty-students">
        <text class="empty-students-text">暂无学生加入</text>
      </view>
      <view v-else class="student-list">
        <view
          v-for="student in studentList"
          :key="student.id || student.studentId"
          class="student-card"
        >
          <image
            class="student-avatar"
            :src="student.avatarUrl || '/static/default-avatar.png'"
            mode="aspectFill"
          />
          <view class="student-info">
            <text class="student-name">{{ student.realName || '未命名学生' }}</text>
            <text class="student-meta">学号 {{ student.studentNo || '-' }}</text>
          </view>
          <text class="student-status">{{ formatJoinedAt(student.joinedAt) }}</text>
        </view>
      </view>
    </template>

    <view v-else class="list-tip">
      <text class="list-tip-text">班级不存在或无权查看</text>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import {
  getClassInfo,
  listClassStudents,
  refreshInviteCode,
} from '@/api/classInfoController'
import AuthModals from '@/components/AuthModals.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'

const auth = useAuth()
const store = useUserStore()

const classId = ref<number | null>(null)
const classInfo = ref<API.ClassInfoVO | null>(null)
const studentList = ref<API.ClassStudentVO[]>([])
const loading = ref(false)
const studentsLoading = ref(false)
const refreshing = ref(false)

const isTeacher = computed(() => store.isTeacher.value)
const studentCountDisplay = computed(() => {
  if (!studentsLoading.value) return studentList.value.length
  return classInfo.value?.studentCount ?? 0
})
const statusLabel = computed(() => {
  const status = (classInfo.value?.status || '').toUpperCase()
  if (status === 'ACTIVE') return '正常'
  if (status === 'DISABLED') return '已停用'
  return classInfo.value?.status || '-'
})

onLoad((options) => {
  const id = Number(options?.id)
  if (!id) {
    uni.showToast({ title: '班级参数无效', icon: 'none' })
    return
  }
  classId.value = id
})

onShow(() => {
  if (!classId.value) return
  if (!auth.guardPageAccess()) return
  loadDetail()
})

async function loadDetail() {
  if (!classId.value || loading.value) return
  loading.value = true
  try {
    await Promise.all([fetchClassInfo(), fetchStudents()])
  } catch (error) {
    classInfo.value = null
    const message = error instanceof Error ? error.message : '获取班级详情失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    loading.value = false
  }
}

async function fetchClassInfo() {
  if (!classId.value) return
  const response = await getClassInfo({ id: classId.value })
  const result = response.data
  if (result.code !== 0 || !result.data) {
    throw new Error(result.message || '获取班级详情失败')
  }
  classInfo.value = result.data
}

async function fetchStudents() {
  if (!classId.value) return
  studentsLoading.value = true
  try {
    const response = await listClassStudents({ id: classId.value })
    const result = response.data
    if (result.code !== 0) {
      throw new Error(result.message || '获取学生列表失败')
    }
    studentList.value = result.data || []
  } finally {
    studentsLoading.value = false
  }
}

function handleInviteTap() {
  if (!isTeacher.value) return
  confirmRefreshInvite()
}

function confirmRefreshInvite() {
  if (!classId.value || refreshing.value) return
  if (!auth.guardPageAccess()) return

  uni.showModal({
    title: '刷新邀请码',
    content: '刷新后旧邀请码将失效，确认继续？',
    success: async (res) => {
      if (!res.confirm) return
      await doRefreshInvite()
    },
  })
}

async function doRefreshInvite() {
  if (!classId.value || refreshing.value) return
  refreshing.value = true
  try {
    const response = await refreshInviteCode({ id: classId.value })
    const result = response.data
    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '刷新邀请码失败')
    }
    classInfo.value = result.data
    uni.showToast({ title: '邀请码已刷新', icon: 'success' })
  } catch (error) {
    const message = error instanceof Error ? error.message : '刷新邀请码失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    refreshing.value = false
  }
}

function formatJoinedAt(value?: string) {
  if (!value) return ''
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return value.slice(0, 10)
  const y = date.getFullYear()
  const m = String(date.getMonth() + 1).padStart(2, '0')
  const d = String(date.getDate()).padStart(2, '0')
  return `${y}-${m}-${d}`
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx 32rpx calc(48rpx + env(safe-area-inset-bottom));
  background: #f5f5f7;
}

.header {
  margin-bottom: 32rpx;
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

.section-title {
  margin: 8rpx 0 16rpx;
  font-size: 26rpx;
  color: #8e8e93;
}

.info-card {
  padding: 8rpx 32rpx;
  margin-bottom: 32rpx;
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
  max-width: 420rpx;
  font-size: 28rpx;
  color: #1a1a1a;
  text-align: right;
}

.invite-wrap {
  display: flex;
  align-items: center;
}

.invite-code {
  font-size: 28rpx;
  font-weight: 600;
  color: #ff7a30;
  letter-spacing: 2rpx;
}

.invite-action {
  margin-left: 16rpx;
  padding: 4rpx 12rpx;
  font-size: 22rpx;
  color: #ff7a30;
  border-radius: 8rpx;
  background: rgba(255, 122, 48, 0.12);
}

.student-list {
  display: flex;
  flex-direction: column;
  gap: 16rpx;
}

.student-card {
  display: flex;
  align-items: center;
  padding: 24rpx 28rpx;
  border-radius: 24rpx;
  background: #fff;
}

.student-avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  background: #e5e5ea;
}

.student-info {
  flex: 1;
  margin-left: 20rpx;
  min-width: 0;
}

.student-name {
  display: block;
  font-size: 30rpx;
  font-weight: 600;
  color: #1a1a1a;
}

.student-meta {
  display: block;
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #8e8e93;
}

.student-status {
  font-size: 22rpx;
  color: #c7c7cc;
}

.empty-students {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 200rpx;
  border-radius: 24rpx;
  background: #fff;
}

.empty-students-text {
  font-size: 26rpx;
  color: #8e8e93;
}

.list-tip {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 48rpx 0;
}

.list-tip-text {
  font-size: 24rpx;
  color: #8e8e93;
}
</style>
