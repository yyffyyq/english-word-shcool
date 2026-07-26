<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <text class="title">作业</text>
      <text class="subtitle">布置与管理班级单词作业</text>
    </view>

    <view class="empty-card" @tap="handleAction">
      <text class="empty-icon">+</text>
      <text class="empty-text">创建作业</text>
    </view>

    <view class="homework-list">
      <view
        v-for="item in homeworkList"
        :key="item.id"
        class="homework-card"
      >
        <view class="homework-card-top">
          <text class="homework-name">{{ getHomeworkTitle(item) }}</text>
          <text class="homework-status">{{ getStatusLabel(item.status) }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">班级</text>
          <text class="info-value">{{ getClassDisplay(item.classId) }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">单词书</text>
          <text class="info-value">{{ getBookDisplay(item.bookId) }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">每日新词</text>
          <text class="info-value">{{ getDailyNewCountDisplay(item.dailyNewCount) }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">起止日期</text>
          <text class="info-value">{{ getDateRangeDisplay(item.startDate, item.endDate) }}</text>
        </view>
      </view>

      <view v-if="listLoading && homeworkList.length === 0" class="list-tip">
        <text class="list-tip-text">加载中...</text>
      </view>
      <view v-else-if="!listLoading && homeworkList.length === 0" class="list-tip">
        <text class="list-tip-text">暂无作业，点击上方创建</text>
      </view>
      <view v-else-if="hasMore" class="list-tip" @tap="loadMoreHomework">
        <text class="list-tip-text">{{ listLoading ? '加载中...' : '加载更多' }}</text>
      </view>
      <view v-else-if="homeworkList.length > 0" class="list-tip">
        <text class="list-tip-text">没有更多了</text>
      </view>
    </view>

    <AppTabBar current-path="pages/homework/index" />

    <view v-if="showCreateModal" class="modal-mask" @tap="closeCreateModal">
      <view class="modal-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">创建作业</text>
          <text class="modal-subtitle">选择班级与单词书，绑定学习任务</text>
        </view>

        <view class="form-card">
          <view class="form-item" @tap="openClassPicker">
            <text class="label">班级</text>
            <view class="select-row">
              <text class="field-text">{{ classDisplayText }}</text>
              <text class="select-arrow">›</text>
            </view>
          </view>

          <view class="form-item" @tap="openBookPicker">
            <text class="label">单词书</text>
            <view class="select-row">
              <text class="field-text">{{ bookDisplayText }}</text>
              <text class="select-arrow">›</text>
            </view>
          </view>

          <view class="form-item">
            <text class="label">每日新词数</text>
            <input
              class="input"
              type="number"
              :value="form.dailyNewCount"
              placeholder="例如：20"
              placeholder-class="placeholder"
              @input="onDailyNewCountInput"
            />
          </view>

          <view class="form-item">
            <text class="label">开始日期</text>
            <picker mode="date" :value="form.startDate" @change="onStartDateChange">
              <view class="select-row">
                <text class="field-text">{{ startDateDisplayText }}</text>
                <text class="select-arrow">›</text>
              </view>
            </picker>
          </view>

          <view class="form-item">
            <text class="label">结束日期</text>
            <picker
              mode="date"
              :value="form.endDate"
              :start="form.startDate"
              @change="onEndDateChange"
            >
              <view class="select-row">
                <text class="field-text">{{ endDateDisplayText }}</text>
                <text class="select-arrow">›</text>
              </view>
            </picker>
          </view>
        </view>

        <view
          class="submit-btn"
          :class="{ disabled: !canSubmit || submitting }"
          @tap="submitCreateHomework"
        >
          <text class="submit-text">{{ submitBtnText }}</text>
        </view>
        <view class="cancel-btn" @tap="closeCreateModal">
          <text class="cancel-text">取消</text>
        </view>
      </view>
    </view>

    <view v-if="showClassPicker" class="modal-mask" @tap="closeClassPicker">
      <view class="modal-panel picker-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">选择班级</text>
          <text class="modal-subtitle">请选择要布置作业的班级</text>
        </view>

        <scroll-view
          scroll-y
          class="picker-scroll"
          @scrolltolower="loadMoreClasses"
        >
          <view
            v-for="item in classList"
            :key="item.id"
            class="picker-item"
            @tap="selectClass(item)"
          >
            <view class="picker-item-main">
              <text class="picker-item-title">{{ item.className || '-' }}</text>
              <text class="picker-item-desc">{{ getClassDesc(item) }}</text>
            </view>
            <text v-if="isSelectedClass(item)" class="picker-check">✓</text>
          </view>

          <view v-if="classLoading && classList.length === 0" class="list-tip">
            <text class="list-tip-text">加载中...</text>
          </view>
          <view v-else-if="!classLoading && classList.length === 0" class="list-tip">
            <text class="list-tip-text">暂无班级，请先去班级页创建</text>
          </view>
          <view v-else-if="classHasMore" class="list-tip" @tap="loadMoreClasses">
            <text class="list-tip-text">{{ classLoading ? '加载中...' : '加载更多' }}</text>
          </view>
          <view v-else-if="classList.length > 0" class="list-tip">
            <text class="list-tip-text">没有更多了</text>
          </view>
        </scroll-view>

        <view class="cancel-btn" @tap="closeClassPicker">
          <text class="cancel-text">关闭</text>
        </view>
      </view>
    </view>

    <view v-if="showBookPicker" class="modal-mask" @tap="closeBookPicker">
      <view class="modal-panel picker-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">选择单词书</text>
          <text class="modal-subtitle">请选择要布置的单词书</text>
        </view>

        <scroll-view
          scroll-y
          class="picker-scroll"
          @scrolltolower="loadMoreBooks"
        >
          <view
            v-for="item in bookList"
            :key="item.id"
            class="picker-item"
            @tap="selectBook(item)"
          >
            <view class="picker-item-main">
              <text class="picker-item-title">{{ item.bookName || '-' }}</text>
              <text class="picker-item-desc">{{ getBookDesc(item) }}</text>
            </view>
            <text v-if="isSelectedBook(item)" class="picker-check">✓</text>
          </view>

          <view v-if="bookLoading && bookList.length === 0" class="list-tip">
            <text class="list-tip-text">加载中...</text>
          </view>
          <view v-else-if="!bookLoading && bookList.length === 0" class="list-tip">
            <text class="list-tip-text">暂无单词书</text>
          </view>
          <view v-else-if="bookHasMore" class="list-tip" @tap="loadMoreBooks">
            <text class="list-tip-text">{{ bookLoading ? '加载中...' : '加载更多' }}</text>
          </view>
          <view v-else-if="bookList.length > 0" class="list-tip">
            <text class="list-tip-text">没有更多了</text>
          </view>
        </scroll-view>

        <view class="cancel-btn" @tap="closeBookPicker">
          <text class="cancel-text">关闭</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed, reactive, ref } from 'vue'
import { onReachBottom, onShow } from '@dcloudio/uni-app'
import { listClassInfoByPage } from '@/api/classInfoController'
import {
  bindClassWordBook,
  listClassWordTaskByPage,
} from '@/api/classWordTaskController'
import { listWordBookByPage } from '@/api/wordBookController'
import AuthModals from '@/components/AuthModals.vue'
import AppTabBar from '@/components/AppTabBar.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'
import { syncCustomTabBar } from '@/utils/tabBar'

const PAGE_SIZE = 10

const auth = useAuth()
const store = useUserStore()

const showCreateModal = ref(false)
const showClassPicker = ref(false)
const showBookPicker = ref(false)
const submitting = ref(false)

const selectedClass = ref<API.ClassInfoVO | null>(null)
const selectedBook = ref<API.WordBookVO | null>(null)

const form = reactive({
  dailyNewCount: '',
  startDate: '',
  endDate: '',
})

const homeworkList = ref<API.ClassWordTaskVO[]>([])
const pageNum = ref(1)
const totalPage = ref(1)
const listLoading = ref(false)

const classList = ref<API.ClassInfoVO[]>([])
const classPageNum = ref(1)
const classTotalPage = ref(1)
const classLoading = ref(false)
const classNameMap = ref<Record<number, string>>({})

const bookList = ref<API.WordBookVO[]>([])
const bookPageNum = ref(1)
const bookTotalPage = ref(1)
const bookLoading = ref(false)
const bookNameMap = ref<Record<number, string>>({})

const hasMore = computed(() => pageNum.value < totalPage.value)
const classHasMore = computed(() => classPageNum.value < classTotalPage.value)
const bookHasMore = computed(() => bookPageNum.value < bookTotalPage.value)

const classDisplayText = computed(() => {
  if (selectedClass.value && selectedClass.value.className) {
    return selectedClass.value.className
  }
  return '请选择班级'
})

const bookDisplayText = computed(() => {
  if (selectedBook.value && selectedBook.value.bookName) {
    return selectedBook.value.bookName
  }
  return '请选择单词书'
})

const startDateDisplayText = computed(() => form.startDate || '请选择开始日期')
const endDateDisplayText = computed(() => form.endDate || '请选择结束日期')
const submitBtnText = computed(() => (submitting.value ? '创建中...' : '确认创建'))

const canSubmit = computed(() => {
  const dailyNewCount = Number(form.dailyNewCount)
  const hasClass = !!(selectedClass.value && selectedClass.value.id)
  const hasBook = !!(selectedBook.value && selectedBook.value.id)
  return (
    hasClass &&
    hasBook &&
    Number.isFinite(dailyNewCount) &&
    dailyNewCount > 0 &&
    !!form.startDate &&
    !!form.endDate
  )
})

onShow(() => {
  syncCustomTabBar('pages/homework/index')
  if (store.isLoggedIn.value && !store.isTeacher.value) {
    uni.switchTab({ url: '/pages/index/index' })
    return
  }
  resetAndFetchHomework()
})

onReachBottom(() => {
  loadMoreHomework()
})

function handleAction() {
  if (!auth.guardPageAccess()) return
  openCreateModal()
}

function formatDate(date: Date) {
  const y = date.getFullYear()
  const m = String(date.getMonth() + 1).padStart(2, '0')
  const d = String(date.getDate()).padStart(2, '0')
  return `${y}-${m}-${d}`
}

function formatDateText(value?: string) {
  if (!value) return '-'
  return String(value).slice(0, 10)
}

function getHomeworkTitle(item: API.ClassWordTaskVO) {
  if (item && item.id != null && item.id !== 0) {
    return `作业 #${item.id}`
  }
  return '作业'
}

function getStatusLabel(status?: string) {
  const value = String(status || '').toUpperCase()
  if (value === 'ACTIVE') return '进行中'
  if (value === 'DISABLED' || value === 'INACTIVE') return '已停用'
  if (value === 'FINISHED' || value === 'ENDED') return '已结束'
  return status || '-'
}

function getClassDisplay(classId?: number) {
  if (classId == null || classId === 0) return '-'
  const name = classNameMap.value[classId]
  return name || `班级 #${classId}`
}

function getBookDisplay(bookId?: number) {
  if (bookId == null || bookId === 0) return '-'
  const name = bookNameMap.value[bookId]
  return name || `词书 #${bookId}`
}

function getDailyNewCountDisplay(count?: number) {
  if (count == null) return '-'
  return String(count)
}

function getDateRangeDisplay(startDate?: string, endDate?: string) {
  return `${formatDateText(startDate)} ~ ${formatDateText(endDate)}`
}

function getClassDesc(item: API.ClassInfoVO) {
  const parts: string[] = []
  if (item.grade) parts.push(item.grade)
  if (item.schoolName) parts.push(item.schoolName)
  return parts.length > 0 ? parts.join(' · ') : '暂无更多信息'
}

function getBookDesc(item: API.WordBookVO) {
  if (item.wordCount != null) return `共 ${item.wordCount} 词`
  return item.description || '暂无描述'
}

function isSelectedClass(item: API.ClassInfoVO) {
  return !!(
    selectedClass.value &&
    item.id != null &&
    selectedClass.value.id === item.id
  )
}

function isSelectedBook(item: API.WordBookVO) {
  return !!(
    selectedBook.value &&
    item.id != null &&
    selectedBook.value.id === item.id
  )
}

function isValidHomework(item: API.ClassWordTaskVO) {
  if (!item) return false
  // 过滤接口示例/空壳数据：没有任何有效业务字段
  const hasId = item.id != null && Number(item.id) !== 0
  const hasClass = item.classId != null && Number(item.classId) !== 0
  const hasBook = item.bookId != null && Number(item.bookId) !== 0
  return hasId || hasClass || hasBook
}

function rememberClassNames(records: API.ClassInfoVO[]) {
  const next = { ...classNameMap.value }
  records.forEach((item) => {
    if (item.id && item.className) {
      next[item.id] = item.className
    }
  })
  classNameMap.value = next
}

function rememberBookNames(records: API.WordBookVO[]) {
  const next = { ...bookNameMap.value }
  records.forEach((item) => {
    if (item.id && item.bookName) {
      next[item.id] = item.bookName
    }
  })
  bookNameMap.value = next
}

async function resetAndFetchHomework() {
  pageNum.value = 1
  totalPage.value = 1
  await fetchHomeworkList(true)
}

async function loadMoreHomework() {
  if (listLoading.value || !hasMore.value) return
  pageNum.value += 1
  await fetchHomeworkList(false)
}

async function fetchHomeworkList(replace: boolean) {
  if (listLoading.value && !replace) return
  listLoading.value = true

  try {
    const currentPage = replace ? 1 : pageNum.value
    const response = await listClassWordTaskByPage({
      pageNum: currentPage,
      pageSize: PAGE_SIZE,
      sortField: 'createdAt',
      sortOrder: 'descend',
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '获取作业列表失败')
    }

    const records = (result.data.records || []).filter(isValidHomework)
    homeworkList.value = replace ? records : [...homeworkList.value, ...records]
    totalPage.value = Math.max(Number(result.data.totalPage) || 1, 1)
    pageNum.value = Number(result.data.pageNumber) || currentPage
  } catch (error) {
    if (!replace) {
      pageNum.value = Math.max(pageNum.value - 1, 1)
    }
    const message = error instanceof Error ? error.message : '获取作业列表失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    listLoading.value = false
  }
}

function openCreateModal() {
  const today = new Date()
  const end = new Date()
  end.setDate(today.getDate() + 30)

  selectedClass.value = null
  selectedBook.value = null
  form.dailyNewCount = '20'
  form.startDate = formatDate(today)
  form.endDate = formatDate(end)
  showCreateModal.value = true
}

function closeCreateModal() {
  if (submitting.value) return
  showCreateModal.value = false
  showClassPicker.value = false
  showBookPicker.value = false
}

function onDailyNewCountInput(event: { detail: { value: string } }) {
  form.dailyNewCount = event.detail.value
}

function onStartDateChange(event: { detail: { value: string } }) {
  form.startDate = event.detail.value
  if (form.endDate && form.endDate < form.startDate) {
    form.endDate = form.startDate
  }
}

function onEndDateChange(event: { detail: { value: string } }) {
  form.endDate = event.detail.value
}

async function openClassPicker() {
  showClassPicker.value = true
  if (classList.value.length === 0) {
    await resetAndFetchClasses()
  }
}

function closeClassPicker() {
  showClassPicker.value = false
}

function selectClass(item: API.ClassInfoVO) {
  selectedClass.value = item
  showClassPicker.value = false
}

async function openBookPicker() {
  showBookPicker.value = true
  if (bookList.value.length === 0) {
    await resetAndFetchBooks()
  }
}

function closeBookPicker() {
  showBookPicker.value = false
}

function selectBook(item: API.WordBookVO) {
  selectedBook.value = item
  showBookPicker.value = false
}

async function resetAndFetchClasses() {
  classPageNum.value = 1
  classTotalPage.value = 1
  await fetchClassList(true)
}

async function loadMoreClasses() {
  if (classLoading.value || !classHasMore.value) return
  classPageNum.value += 1
  await fetchClassList(false)
}

async function fetchClassList(replace: boolean) {
  if (classLoading.value && !replace) return
  classLoading.value = true

  try {
    const currentPage = replace ? 1 : classPageNum.value
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
    rememberClassNames(records)
    classTotalPage.value = Math.max(Number(result.data.totalPage) || 1, 1)
    classPageNum.value = Number(result.data.pageNumber) || currentPage
  } catch (error) {
    if (!replace) {
      classPageNum.value = Math.max(classPageNum.value - 1, 1)
    }
    const message = error instanceof Error ? error.message : '获取班级列表失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    classLoading.value = false
  }
}

async function resetAndFetchBooks() {
  bookPageNum.value = 1
  bookTotalPage.value = 1
  await fetchBookList(true)
}

async function loadMoreBooks() {
  if (bookLoading.value || !bookHasMore.value) return
  bookPageNum.value += 1
  await fetchBookList(false)
}

async function fetchBookList(replace: boolean) {
  if (bookLoading.value && !replace) return
  bookLoading.value = true

  try {
    const currentPage = replace ? 1 : bookPageNum.value
    const response = await listWordBookByPage({
      pageNum: currentPage,
      pageSize: PAGE_SIZE,
      sortField: 'createdAt',
      sortOrder: 'descend',
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '获取单词书列表失败')
    }

    const records = result.data.records || []
    bookList.value = replace ? records : [...bookList.value, ...records]
    rememberBookNames(records)
    bookTotalPage.value = Math.max(Number(result.data.totalPage) || 1, 1)
    bookPageNum.value = Number(result.data.pageNumber) || currentPage
  } catch (error) {
    if (!replace) {
      bookPageNum.value = Math.max(bookPageNum.value - 1, 1)
    }
    const message = error instanceof Error ? error.message : '获取单词书列表失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    bookLoading.value = false
  }
}

async function submitCreateHomework() {
  if (!canSubmit.value || submitting.value) return
  if (!auth.guardPageAccess()) return

  const classId = selectedClass.value && selectedClass.value.id
  const bookId = selectedBook.value && selectedBook.value.id
  const dailyNewCount = Number(form.dailyNewCount)

  if (!classId || !bookId) return

  if (form.endDate < form.startDate) {
    uni.showToast({ title: '结束日期不能早于开始日期', icon: 'none' })
    return
  }

  submitting.value = true
  try {
    const response = await bindClassWordBook({
      classId,
      bookId,
      dailyNewCount,
      startDate: form.startDate,
      endDate: form.endDate,
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '创建作业失败')
    }

    if (selectedClass.value && selectedClass.value.id && selectedClass.value.className) {
      classNameMap.value = {
        ...classNameMap.value,
        [selectedClass.value.id]: selectedClass.value.className,
      }
    }
    if (selectedBook.value && selectedBook.value.id && selectedBook.value.bookName) {
      bookNameMap.value = {
        ...bookNameMap.value,
        [selectedBook.value.id]: selectedBook.value.bookName,
      }
    }

    uni.showToast({ title: '创建成功', icon: 'success' })
    showCreateModal.value = false
    showClassPicker.value = false
    showBookPicker.value = false
    await resetAndFetchHomework()
  } catch (error) {
    const message = error instanceof Error ? error.message : '创建作业失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx 32rpx calc(140rpx + env(safe-area-inset-bottom));
  background: #f5f5f7;
}

.header {
  margin-bottom: 40rpx;
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

.empty-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 320rpx;
  border: 2rpx dashed #d1d1d6;
  border-radius: 24rpx;
  background: #fff;
}

.empty-icon {
  font-size: 64rpx;
  color: #ff7a30;
}

.empty-text {
  margin-top: 16rpx;
  font-size: 28rpx;
  color: #8e8e93;
}

.homework-list {
  margin-top: 24rpx;
}

.homework-card {
  padding: 8rpx 32rpx;
  margin-bottom: 24rpx;
  border-radius: 24rpx;
  background: #fff;
}

.homework-card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 28rpx 0 8rpx;
}

.homework-name {
  flex: 1;
  font-size: 32rpx;
  font-weight: 600;
  color: #1a1a1a;
}

.homework-status {
  margin-left: 12rpx;
  padding: 4rpx 12rpx;
  font-size: 22rpx;
  border-radius: 8rpx;
  color: #ff7a30;
  background: rgba(255, 122, 48, 0.12);
}

.info-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24rpx 0;
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
  background: #f5f5f7;
}

.picker-panel {
  max-height: 75vh;
}

.modal-header {
  margin-bottom: 28rpx;
}

.modal-title {
  display: block;
  font-size: 36rpx;
  font-weight: 600;
  color: #1a1a1a;
}

.modal-subtitle {
  display: block;
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #8e8e93;
}

.form-card {
  padding: 8rpx 32rpx;
  border-radius: 24rpx;
  background: #fff;
}

.form-item {
  padding: 24rpx 0;
  border-bottom: 1rpx solid #f0f0f0;

  &:last-child {
    border-bottom: none;
  }
}

.label {
  display: block;
  margin-bottom: 12rpx;
  font-size: 24rpx;
  color: #8e8e93;
}

.input {
  height: 56rpx;
  width: 100%;
  font-size: 30rpx;
  color: #1a1a1a;
}

.placeholder {
  color: #c7c7cc;
}

.select-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 56rpx;
}

.field-text {
  flex: 1;
  font-size: 30rpx;
  color: #1a1a1a;
}

.select-arrow {
  margin-left: 12rpx;
  font-size: 32rpx;
  color: #c7c7cc;
}

.picker-scroll {
  max-height: 52vh;
  margin-bottom: 8rpx;
  border-radius: 24rpx;
  background: #fff;
}

.picker-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 28rpx 32rpx;
  border-bottom: 1rpx solid #f0f0f0;

  &:last-child {
    border-bottom: none;
  }
}

.picker-item-main {
  flex: 1;
  min-width: 0;
}

.picker-item-title {
  display: block;
  font-size: 30rpx;
  font-weight: 500;
  color: #1a1a1a;
}

.picker-item-desc {
  display: block;
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #8e8e93;
}

.picker-check {
  margin-left: 16rpx;
  font-size: 28rpx;
  font-weight: 600;
  color: #ff7a30;
}

.list-tip {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24rpx 0;
}

.list-tip-text {
  font-size: 24rpx;
  color: #8e8e93;
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 88rpx;
  margin-top: 40rpx;
  border-radius: 44rpx;
  background: #ff7a30;

  &.disabled {
    opacity: 0.45;
  }
}

.submit-text {
  font-size: 30rpx;
  font-weight: 500;
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
  color: #8e8e93;
}
</style>
