<template>
  <view class="page">
    <AuthModals />

    <view class="header">
      <text class="title">班级</text>
      <text class="subtitle">{{ subtitle }}</text>
    </view>

    <view class="empty-card" @tap="handleAction">
      <text class="empty-icon">+</text>
      <text class="empty-text">{{ actionText }}</text>
    </view>

    <view class="class-list">
      <view
        v-for="item in classList"
        :key="item.id"
        class="class-card"
        @tap="goClassDetail(item.id)"
      >
        <view class="class-card-top">
          <text class="class-name">{{ item.className || '-' }}</text>
          <text v-if="canEnterClassDetail" class="class-arrow">›</text>
        </view>
        <view class="info-row">
          <text class="info-label">年级</text>
          <text class="info-value">{{ item.grade || '-' }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">学校</text>
          <text class="info-value">{{ item.schoolName || '-' }}</text>
        </view>
        <view
          v-if="isTeacher"
          class="info-row"
          @tap.stop="handleInviteTap(item)"
        >
          <text class="info-label">邀请码</text>
          <view class="invite-wrap">
            <text class="invite-code">{{ item.inviteCode || '-' }}</text>
            <text v-if="item.inviteCode" class="invite-action">
              {{ refreshingId === item.id ? '刷新中' : '刷新' }}
            </text>
          </view>
        </view>
      </view>

      <view v-if="loading && classList.length === 0" class="list-tip">
        <text class="list-tip-text">加载中...</text>
      </view>
      <view v-else-if="!loading && classList.length === 0" class="list-tip">
        <text class="list-tip-text">{{ emptyListTip }}</text>
      </view>
      <view v-else-if="hasMore" class="list-tip" @tap="loadMore">
        <text class="list-tip-text">{{ loading ? '加载中...' : '加载更多' }}</text>
      </view>
      <view v-else-if="classList.length > 0" class="list-tip">
        <text class="list-tip-text">没有更多了</text>
      </view>
    </view>

    <view v-if="showCreateModal" class="modal-mask" @tap="closeCreateModal">
      <view class="modal-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">创建班级</text>
          <text class="modal-subtitle">填写班级信息并生成邀请码</text>
        </view>

        <view class="form-card">
          <view class="form-item">
            <text class="label">班级名称</text>
            <input
              v-model="form.className"
              class="input"
              placeholder="例如：三年级一班"
              placeholder-class="placeholder"
            />
          </view>
          <view class="form-item">
            <text class="label">年级</text>
            <input
              v-model="form.grade"
              class="input"
              placeholder="例如：三年级"
              placeholder-class="placeholder"
            />
          </view>
          <view class="form-item">
            <text class="label">学校名称</text>
            <input
              v-model="form.schoolName"
              class="input"
              placeholder="可不填，默认使用教师学校"
              placeholder-class="placeholder"
            />
          </view>
        </view>

        <view
          class="submit-btn"
          :class="{ disabled: !canCreate || creating }"
          @tap="submitCreateClass"
        >
          <text class="submit-text">{{ creating ? '创建中...' : '确认创建' }}</text>
        </view>
        <view class="cancel-btn" @tap="closeCreateModal">
          <text class="cancel-text">取消</text>
        </view>
      </view>
    </view>

    <view v-if="showJoinModal" class="modal-mask" @tap="closeJoinModal">
      <view class="modal-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">加入班级</text>
          <text class="modal-subtitle">请输入教师提供的邀请码</text>
        </view>

        <view class="form-card">
          <view class="form-item">
            <text class="label">邀请码</text>
            <input
              v-model="joinForm.inviteCode"
              class="input"
              placeholder="请输入邀请码"
              placeholder-class="placeholder"
            />
          </view>
        </view>

        <view
          class="submit-btn"
          :class="{ disabled: !canJoin || joining }"
          @tap="submitJoinClass"
        >
          <text class="submit-text">{{ joining ? '加入中...' : '确认加入' }}</text>
        </view>
        <view class="cancel-btn" @tap="closeJoinModal">
          <text class="cancel-text">取消</text>
        </view>
      </view>
    </view>

    <AppTabBar current-path="pages/class/index" />
  </view>
</template>

<script setup lang="ts">
import { computed, reactive, ref } from 'vue'
import { onReachBottom, onShow } from '@dcloudio/uni-app'
import {
  addClassInfo,
  listClassInfoByPage,
  refreshInviteCode,
  studentJoinClass,
} from '@/api/classInfoController'
import AuthModals from '@/components/AuthModals.vue'
import AppTabBar from '@/components/AppTabBar.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'
import { getUserStorage } from '@/utils/storage'
import { syncCustomTabBar } from '@/utils/tabBar'

const PAGE_SIZE = 10

const auth = useAuth()
const store = useUserStore()

const classList = ref<API.ClassInfoVO[]>([])
const pageNum = ref(1)
const totalPage = ref(1)
const loading = ref(false)
const creating = ref(false)
const joining = ref(false)
const refreshingId = ref<number | null>(null)
const showCreateModal = ref(false)
const showJoinModal = ref(false)

const form = reactive({
  className: '',
  grade: '',
  schoolName: '',
})

const joinForm = reactive({
  inviteCode: '',
})

const isTeacher = computed(() => store.isTeacher.value)
const isStudent = computed(() => store.isStudent.value)
const canEnterClassDetail = computed(() => !isStudent.value)
const actionText = computed(() => (isTeacher.value ? '创建班级' : '加入班级'))
const subtitle = computed(() =>
  isTeacher.value ? '创建班级，邀请学生加入' : '输入邀请码，加入班级学习',
)
const emptyListTip = computed(() =>
  isTeacher.value ? '暂无班级，点击上方创建' : '暂无班级，点击上方加入',
)
const canCreate = computed(() => Boolean(form.className.trim()))
const canJoin = computed(() => Boolean(joinForm.inviteCode.trim()))
const hasMore = computed(() => pageNum.value < totalPage.value)

onShow(() => {
  syncCustomTabBar('pages/class/index')
  if (!store.isLoggedIn.value) {
    classList.value = []
    return
  }
  // 权限由后端控制，进入页面统一请求班级分页列表
  resetAndFetchClasses()
})

onReachBottom(() => {
  loadMore()
})

function handleAction() {
  if (!auth.guardPageAccess()) return

  if (isTeacher.value) {
    openCreateModal()
    return
  }

  openJoinModal()
}

function openCreateModal() {
  form.className = ''
  form.grade = ''
  form.schoolName = store.state.user?.school || ''
  showCreateModal.value = true
}

function closeCreateModal() {
  if (creating.value) return
  showCreateModal.value = false
}

function openJoinModal() {
  joinForm.inviteCode = ''
  showJoinModal.value = true
}

function closeJoinModal() {
  if (joining.value) return
  showJoinModal.value = false
}

async function submitCreateClass() {
  if (!canCreate.value || creating.value) return
  if (!auth.guardPageAccess()) return

  creating.value = true
  try {
    const response = await addClassInfo({
      className: form.className.trim(),
      grade: form.grade.trim() || undefined,
      schoolName: form.schoolName.trim() || undefined,
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '创建班级失败')
    }

    uni.showToast({ title: '创建成功', icon: 'success' })
    showCreateModal.value = false
    await resetAndFetchClasses()
  } catch (error) {
    const message = error instanceof Error ? error.message : '创建班级失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    creating.value = false
  }
}

async function submitJoinClass() {
  if (!canJoin.value || joining.value) return
  if (!auth.guardPageAccess()) return

  const studentId = Number(store.state.user?.id)
  if (!studentId) {
    uni.showToast({ title: '用户信息异常，请重新登录', icon: 'none' })
    return
  }

  const openid = store.state.user?.openid || getUserStorage()?.openid || ''
  if (!openid) {
    uni.showToast({ title: '登录信息缺失，请重新登录', icon: 'none' })
    return
  }

  joining.value = true
  try {
    const response = await studentJoinClass(
      {
        studentId,
        inviteCode: joinForm.inviteCode.trim(),
      },
      {
        headers: {
          'Content-Type': 'application/json',
          openid,
        },
      },
    )
    const result = response.data

    if (result.code !== 0) {
      throw new Error(result.message || '加入班级失败')
    }

    uni.showToast({ title: '加入成功', icon: 'success' })
    showJoinModal.value = false
    await resetAndFetchClasses()
  } catch (error) {
    const message = error instanceof Error ? error.message : '加入班级失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    joining.value = false
  }
}

function goClassDetail(id?: number) {
  if (!id || !canEnterClassDetail.value) return
  if (!auth.guardPageAccess()) return
  uni.navigateTo({ url: `/pages/class/detail?id=${id}` })
}

function handleInviteTap(item: API.ClassInfoVO) {
  if (!item.id) return
  if (!auth.guardPageAccess()) return
  if (refreshingId.value === item.id) return

  uni.showModal({
    title: '刷新邀请码',
    content: `确认刷新「${item.className || '该班级'}」的邀请码？旧邀请码将失效。`,
    success: async (res) => {
      if (!res.confirm) return
      await doRefreshInvite(item.id as number)
    },
  })
}

async function doRefreshInvite(id: number) {
  refreshingId.value = id
  try {
    const response = await refreshInviteCode({ id })
    const result = response.data
    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '刷新邀请码失败')
    }

    const index = classList.value.findIndex((item) => item.id === id)
    if (index >= 0) {
      classList.value[index] = {
        ...classList.value[index],
        ...result.data,
      }
    }
    uni.showToast({ title: '邀请码已刷新', icon: 'success' })
  } catch (error) {
    const message = error instanceof Error ? error.message : '刷新邀请码失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    refreshingId.value = null
  }
}

async function resetAndFetchClasses() {
  pageNum.value = 1
  totalPage.value = 1
  await fetchClassList(true)
}

async function loadMore() {
  if (loading.value || !hasMore.value) return
  pageNum.value += 1
  await fetchClassList(false)
}

async function fetchClassList(replace: boolean) {
  if (loading.value && !replace) return
  loading.value = true

  try {
    const currentPage = replace ? 1 : pageNum.value
    const response = await listClassInfoByPage({
      pageNum: currentPage,
      pageSize: PAGE_SIZE,
      sortField: 'createdAt',
      sortOrder: 'descend',
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '获取班级列表失败')
    }

    const records = result.data.records || []
    classList.value = replace ? records : [...classList.value, ...records]
    totalPage.value = Math.max(Number(result.data.totalPage) || 1, 1)
    pageNum.value = Number(result.data.pageNumber) || currentPage
  } catch (error) {
    if (!replace) {
      pageNum.value = Math.max(pageNum.value - 1, 1)
    }
    const message = error instanceof Error ? error.message : '获取班级列表失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    loading.value = false
  }
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx 32rpx calc(140rpx + env(safe-area-inset-bottom));
  background: #f3f8fd;
}

.header {
  margin-bottom: 40rpx;
}

.title {
  display: block;
  font-size: 44rpx;
  font-weight: 700;
  color: #1f2a37;
}

.subtitle {
  display: block;
  margin-top: 8rpx;
  font-size: 26rpx;
  color: #7a8594;
}

.empty-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 320rpx;
  border: 2rpx dashed #cfe9ff;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.08);
}

.empty-icon {
  font-size: 64rpx;
  color: #4ba8f5;
}

.empty-text {
  margin-top: 16rpx;
  font-size: 28rpx;
  color: #7a8594;
}

.class-list {
  margin-top: 24rpx;
}

.class-card {
  padding: 8rpx 32rpx 8rpx;
  margin-bottom: 24rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.1);
  border: 2rpx solid #e8f4fe;
}

.class-card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 28rpx 0 8rpx;
}

.class-name {
  flex: 1;
  font-size: 32rpx;
  font-weight: 700;
  color: #1f2a37;
}

.class-arrow {
  margin-left: 12rpx;
  font-size: 36rpx;
  color: #b7c0cc;
}

.info-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24rpx 0;
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
  max-width: 420rpx;
  font-size: 28rpx;
  color: #1f2a37;
  text-align: right;
}

.invite-wrap {
  display: flex;
  align-items: center;
}

.invite-code {
  font-size: 28rpx;
  font-weight: 600;
  color: #ff8a3d;
  letter-spacing: 2rpx;
}

.invite-action {
  margin-left: 16rpx;
  padding: 4rpx 12rpx;
  font-size: 22rpx;
  color: #4ba8f5;
  border-radius: 999rpx;
  background: rgba(75, 168, 245, 0.12);
}

.list-tip {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16rpx 0 8rpx;
}

.list-tip-text {
  font-size: 24rpx;
  color: #7a8594;
}

.modal-mask {
  position: fixed;
  inset: 0;
  z-index: 1001;
  display: flex;
  align-items: flex-end;
  justify-content: center;
  background: rgba(0, 0, 0, 0.45);
}

.modal-panel {
  width: 100%;
  padding: 40rpx 32rpx calc(40rpx + env(safe-area-inset-bottom));
  border-radius: 32rpx 32rpx 0 0;
  background: #f3f8fd;
}

.modal-header {
  margin-bottom: 28rpx;
}

.modal-title {
  display: block;
  font-size: 36rpx;
  font-weight: 700;
  color: #1f2a37;
}

.modal-subtitle {
  display: block;
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #7a8594;
}

.form-card {
  padding: 8rpx 32rpx;
  border-radius: 28rpx;
  background: #fff;
  border: 2rpx solid #e8f4fe;
}

.form-item {
  padding: 24rpx 0;
  border-bottom: 1rpx solid #eef4fa;

  &:last-child {
    border-bottom: none;
  }
}

.label {
  display: block;
  margin-bottom: 12rpx;
  font-size: 24rpx;
  color: #7a8594;
}

.input {
  height: 56rpx;
  font-size: 30rpx;
  color: #1f2a37;
}

.placeholder {
  color: #a8b0bc;
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 88rpx;
  margin-top: 40rpx;
  border-radius: 44rpx;
  background: linear-gradient(135deg, #ff8a3d 0%, #ffb074 100%);
  box-shadow: 0 10rpx 24rpx rgba(255, 138, 61, 0.28);

  &.disabled {
    opacity: 0.45;
    box-shadow: none;
  }
}

.submit-text {
  font-size: 30rpx;
  font-weight: 600;
  color: #fff;
  letter-spacing: 2rpx;
}

.cancel-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 80rpx;
  margin-top: 8rpx;
}

.cancel-text {
  font-size: 26rpx;
  color: #7a8594;
}
</style>
