<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <view class="header-main">
        <text class="title">作业</text>
        <text class="subtitle">布置与管理班级单词作业</text>
      </view>
      <view
        v-if="isTeacher"
        class="dispatch-btn"
        :class="{ disabled: dispatching }"
        @tap="handleDispatchHomework"
      >
        <text class="dispatch-text">{{ dispatching ? '下派中' : '作业下派' }}</text>
      </view>
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
        @tap="openStatusPicker(item)"
      >
        <view class="homework-card-top">
          <text class="homework-name">{{ getHomeworkTitle(item) }}</text>
          <text
            class="homework-status"
            :class="{ stopped: isStoppedStatus(item.status) }"
          >{{ getStatusLabel(item.status) }}</text>
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
          <text class="modal-subtitle">{{ createSubtitle }}</text>
        </view>

        <view class="mode-switch">
          <view
            class="mode-item"
            :class="{ active: assignMode === 'daily' }"
            @tap="setAssignMode('daily')"
          >
            <text class="mode-text">每日自动</text>
          </view>
          <view
            class="mode-item"
            :class="{ active: assignMode === 'unit' }"
            @tap="setAssignMode('unit')"
          >
            <text class="mode-text">按周次单元</text>
          </view>
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

          <template v-if="assignMode === 'daily'">
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
          </template>

          <template v-else>
            <view class="form-item" @tap="openWeekPicker">
              <text class="label">周次</text>
              <view class="select-row">
                <text class="field-text">{{ weekDisplayText }}</text>
                <text class="select-arrow">›</text>
              </view>
            </view>

            <view class="form-item" @tap="openUnitPicker">
              <text class="label">单元</text>
              <view class="select-row">
                <text class="field-text">{{ unitDisplayText }}</text>
                <text class="select-arrow">›</text>
              </view>
            </view>
          </template>
        </view>

        <view v-if="assignMode === 'unit'" class="form-hint">
          <text class="form-hint-text">将该单元全部单词只追加到所选班级在班学生的今日计划。已在今日计划中的单词不会重复写入。</text>
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

    <view v-if="showWeekPicker" class="modal-mask" @tap="closeWeekPicker">
      <view class="modal-panel picker-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">选择周次</text>
          <text class="modal-subtitle">请选择要分配到今日计划的周次</text>
        </view>

        <scroll-view scroll-y class="picker-scroll">
          <view
            v-for="item in weekList"
            :key="item.week"
            class="picker-item"
            @tap="selectWeek(item.week)"
          >
            <view class="picker-item-main">
              <text class="picker-item-title">第 {{ item.week }} 周</text>
              <text class="picker-item-desc">{{ item.unitCount }} 个单元 · {{ item.wordCount }} 词</text>
            </view>
            <text v-if="selectedWeek === item.week" class="picker-check">✓</text>
          </view>

          <view v-if="unitLoading && weekList.length === 0" class="list-tip">
            <text class="list-tip-text">加载中...</text>
          </view>
          <view v-else-if="!unitLoading && weekList.length === 0" class="list-tip">
            <text class="list-tip-text">该词书暂无周次单元</text>
          </view>
        </scroll-view>

        <view class="cancel-btn" @tap="closeWeekPicker">
          <text class="cancel-text">关闭</text>
        </view>
      </view>
    </view>

    <view v-if="showUnitPicker" class="modal-mask" @tap="closeUnitPicker">
      <view class="modal-panel picker-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">选择单元</text>
          <text class="modal-subtitle">请选择要分配到今日计划的单元</text>
        </view>

        <scroll-view scroll-y class="picker-scroll">
          <view
            v-for="item in unitList"
            :key="item.unitName"
            class="picker-item"
            @tap="selectUnit(item.unitName)"
          >
            <view class="picker-item-main">
              <text class="picker-item-title">第 {{ item.unitName }} 单元</text>
              <text class="picker-item-desc">共 {{ item.wordCount }} 词</text>
            </view>
            <text v-if="selectedUnit === item.unitName" class="picker-check">✓</text>
          </view>

          <view v-if="unitLoading && unitList.length === 0" class="list-tip">
            <text class="list-tip-text">加载中...</text>
          </view>
          <view v-else-if="!unitLoading && unitList.length === 0" class="list-tip">
            <text class="list-tip-text">该周次暂无单元</text>
          </view>
        </scroll-view>

        <view class="cancel-btn" @tap="closeUnitPicker">
          <text class="cancel-text">关闭</text>
        </view>
      </view>
    </view>

    <view v-if="showStatusPicker" class="modal-mask" @tap="closeStatusPicker">
      <view class="modal-panel picker-panel" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">{{ statusPickerTitle }}</text>
          <text class="modal-subtitle">选择计划状态，停止后保留历史记录</text>
        </view>

        <view class="picker-scroll">
          <view
            v-for="option in planStatusOptions"
            :key="option.value"
            class="picker-item"
            @tap="selectPlanStatus(option.value)"
          >
            <view class="picker-item-main">
              <text class="picker-item-title">{{ option.title }}</text>
              <text class="picker-item-desc">{{ option.desc }}</text>
            </view>
            <text v-if="isCurrentStatus(option.value)" class="picker-check">✓</text>
          </view>
        </view>

        <view class="cancel-btn" @tap="closeStatusPicker">
          <text class="cancel-text">取消</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed, reactive, ref } from 'vue'
import { onReachBottom, onShow } from '@dcloudio/uni-app'
import { listClassInfoByPage } from '@/api/banjiguanli'
import {
  bindClassWordBook,
  listClassWordTaskByPage,
  unbindClassWordBook,
} from '@/api/banjicishurenwu'
import { listWordBookByPage, listWordsByBookPage } from '@/api/cishuguanli'
import { assignUnitPlan, runAssign } from '@/api/meiridancifenpei'
import AuthModals from '@/components/AuthModals.vue'
import AppTabBar from '@/components/AppTabBar.vue'
import { useAuth } from '@/composables/useAuth'
import { useUserStore } from '@/store/user'
import { syncCustomTabBar } from '@/utils/tabBar'

const PAGE_SIZE = 10
const UNIT_PAGE_SIZE = 200
const UNIT_PAGE_LIMIT = 50

type AssignMode = 'daily' | 'unit'

type BookUnitOption = {
  week: number
  unitName: number
  wordCount: number
}

const auth = useAuth()
const store = useUserStore()
const isTeacher = computed(() => store.isTeacher.value)
const dispatching = ref(false)

const showCreateModal = ref(false)
const showClassPicker = ref(false)
const showBookPicker = ref(false)
const showWeekPicker = ref(false)
const showUnitPicker = ref(false)
const showStatusPicker = ref(false)
const statusTarget = ref<API.ClassWordTaskVO | null>(null)
const statusUpdating = ref(false)
const submitting = ref(false)

const planStatusOptions = [
  { value: 'ACTIVE' as const, title: '进行中', desc: '继续按每日额度分配新词' },
  { value: 'STOPPED' as const, title: '已停止', desc: '解除绑定，保留历史记录' },
]
const assignMode = ref<AssignMode>('daily')

const selectedClass = ref<API.ClassInfoVO | null>(null)
const selectedBook = ref<API.WordBookVO | null>(null)
const selectedWeek = ref<number | null>(null)
const selectedUnit = ref<number | null>(null)
const unitOptions = ref<BookUnitOption[]>([])
const unitLoading = ref(false)
const loadedUnitBookId = ref<number | null>(null)
let unitRequestSeq = 0

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
const createSubtitle = computed(() => {
  if (assignMode.value === 'unit') {
    return '选择班级、词书、周次与单元，追加到该班今日计划'
  }
  return '选择班级与单词书，绑定学习任务'
})
const submitBtnText = computed(() => {
  if (submitting.value) {
    return assignMode.value === 'unit' ? '分配中...' : '创建中...'
  }
  return assignMode.value === 'unit' ? '确认分配' : '确认创建'
})

const weekList = computed(() => {
  const map = new Map<number, { unitCount: number; wordCount: number }>()
  unitOptions.value.forEach((item) => {
    const current = map.get(item.week) || { unitCount: 0, wordCount: 0 }
    current.unitCount += 1
    current.wordCount += item.wordCount
    map.set(item.week, current)
  })
  return Array.from(map.entries())
    .map(([week, stat]) => ({ week, unitCount: stat.unitCount, wordCount: stat.wordCount }))
    .sort((a, b) => a.week - b.week)
})

const unitList = computed(() => {
  if (!selectedWeek.value) return []
  return unitOptions.value
    .filter((item) => item.week === selectedWeek.value)
    .slice()
    .sort((a, b) => a.unitName - b.unitName)
})

const weekDisplayText = computed(() => {
  if (unitLoading.value && !selectedWeek.value) return '加载周次中...'
  if (selectedWeek.value) return `第 ${selectedWeek.value} 周`
  return '请选择周次'
})

const unitDisplayText = computed(() => {
  if (!selectedWeek.value) return '请先选择周次'
  if (!selectedUnit.value) return '请选择单元'
  const matched = unitOptions.value.find(
    (item) => item.week === selectedWeek.value && item.unitName === selectedUnit.value,
  )
  if (matched) return `第 ${matched.unitName} 单元 · ${matched.wordCount} 词`
  return `第 ${selectedUnit.value} 单元`
})

const canSubmit = computed(() => {
  const hasClass = !!(selectedClass.value && selectedClass.value.id)
  const hasBook = !!(selectedBook.value && selectedBook.value.id)
  if (assignMode.value === 'unit') {
    return (
      hasClass &&
      hasBook &&
      !!selectedWeek.value &&
      selectedWeek.value > 0 &&
      !!selectedUnit.value &&
      selectedUnit.value > 0 &&
      !unitLoading.value
    )
  }
  const dailyNewCount = Number(form.dailyNewCount)
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
  if (!store.isLoggedIn.value) {
    homeworkList.value = []
    return
  }
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

function handleDispatchHomework() {
  if (!isTeacher.value || dispatching.value) return
  if (!auth.guardPageAccess()) return
  uni.showModal({
    title: '作业下派',
    content: '将按今天为在班学生生成当日学习计划。已有今日计划的不会重复生成。',
    success(res) {
      if (!res.confirm) return
      dispatchTodayHomework()
    },
  })
}

async function dispatchTodayHomework() {
  if (dispatching.value) return
  dispatching.value = true
  try {
    const response = await runAssign({
      assignDate: formatDate(new Date()),
    })
    const result = response.data
    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '作业下派失败')
    }
    const data = result.data
    const assignDate = data.assignDate ? String(data.assignDate).slice(0, 10) : formatDate(new Date())
    uni.showModal({
      title: '下派完成',
      content: `${assignDate}：任务 ${Number(data.taskCount) || 0} 个，新建 ${Number(data.createdCount) || 0} 个，成功 ${Number(data.successCount) || 0} 个，已存在跳过 ${Number(data.skippedExistCount) || 0} 个。`,
      showCancel: false,
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : '作业下派失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    dispatching.value = false
  }
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
  if (value === 'STOPPED') return '已停止'
  if (value === 'DISABLED' || value === 'INACTIVE') return '已停用'
  if (value === 'FINISHED' || value === 'ENDED') return '已结束'
  return status || '-'
}

function isStoppedStatus(status?: string) {
  return String(status || '').toUpperCase() === 'STOPPED'
}

const statusPickerTitle = computed(() => {
  if (statusTarget.value) return getHomeworkTitle(statusTarget.value)
  return '计划状态'
})

function openStatusPicker(item: API.ClassWordTaskVO) {
  if (!auth.guardPageAccess()) return
  if (item.id == null) return
  statusTarget.value = item
  showStatusPicker.value = true
}

function closeStatusPicker() {
  if (statusUpdating.value) return
  showStatusPicker.value = false
}

function isCurrentStatus(status: string) {
  return String((statusTarget.value && statusTarget.value.status) || '').toUpperCase() === status
}

function updateHomeworkStatus(id: number, status: string) {
  const index = homeworkList.value.findIndex((item) => item.id === id)
  if (index < 0) return
  homeworkList.value[index] = {
    ...homeworkList.value[index],
    status,
  }
  if (statusTarget.value && statusTarget.value.id === id) {
    statusTarget.value = {
      ...statusTarget.value,
      status,
    }
  }
}

function selectPlanStatus(status: 'ACTIVE' | 'STOPPED') {
  if (statusUpdating.value) return
  const task = statusTarget.value
  if (!task || task.id == null) return
  if (isCurrentStatus(status)) {
    showStatusPicker.value = false
    return
  }
  if (status === 'STOPPED') {
    uni.showModal({
      title: '停止计划',
      content: '停止后不再按日分配新词，历史记录会保留。',
      success(res) {
        if (!res.confirm) return
        stopPlan(task.id as number)
      },
    })
    return
  }
  resumePlan(task)
}

async function stopPlan(id: number) {
  if (statusUpdating.value) return
  statusUpdating.value = true
  try {
    const response = await unbindClassWordBook({ id })
    const result = response.data
    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '停止计划失败')
    }
    updateHomeworkStatus(id, 'STOPPED')
    uni.showToast({ title: '已停止', icon: 'success' })
    showStatusPicker.value = false
  } catch (error) {
    const message = error instanceof Error ? error.message : '停止计划失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    statusUpdating.value = false
  }
}

async function resumePlan(task: API.ClassWordTaskVO) {
  if (statusUpdating.value) return
  if (!task.id || !task.classId || !task.bookId) return
  const startDate = formatDateText(task.startDate)
  const endDate = formatDateText(task.endDate)
  statusUpdating.value = true
  try {
    const response = await bindClassWordBook({
      classId: task.classId,
      bookId: task.bookId,
      dailyNewCount: task.dailyNewCount,
      startDate: startDate === '-' ? undefined : startDate,
      endDate: endDate === '-' ? undefined : endDate,
    })
    const result = response.data
    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '恢复计划失败')
    }
    updateHomeworkStatus(task.id, 'ACTIVE')
    uni.showToast({ title: '已恢复', icon: 'success' })
    showStatusPicker.value = false
  } catch (error) {
    const message = error instanceof Error ? error.message : '恢复计划失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    statusUpdating.value = false
  }
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

  assignMode.value = 'daily'
  selectedClass.value = null
  selectedBook.value = null
  resetUnitSelection()
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
  showWeekPicker.value = false
  showUnitPicker.value = false
}

function setAssignMode(mode: AssignMode) {
  if (submitting.value || assignMode.value === mode) return
  assignMode.value = mode
  if (mode === 'unit') {
    const bookId = selectedBook.value && selectedBook.value.id
    if (bookId) {
      ensureBookUnits(bookId)
    }
  }
}

function resetUnitSelection() {
  unitRequestSeq += 1
  selectedWeek.value = null
  selectedUnit.value = null
  unitOptions.value = []
  unitLoading.value = false
  loadedUnitBookId.value = null
  showWeekPicker.value = false
  showUnitPicker.value = false
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
  const bookChanged = !(selectedBook.value && item.id != null && selectedBook.value.id === item.id)
  selectedBook.value = item
  showBookPicker.value = false
  if (bookChanged) {
    resetUnitSelection()
    if (assignMode.value === 'unit' && item.id) {
      ensureBookUnits(item.id)
    }
  }
}

function openWeekPicker() {
  const bookId = selectedBook.value && selectedBook.value.id
  if (!bookId) {
    uni.showToast({ title: '请先选择单词书', icon: 'none' })
    return
  }
  showWeekPicker.value = true
  ensureBookUnits(bookId)
}

function closeWeekPicker() {
  showWeekPicker.value = false
}

function selectWeek(week: number) {
  if (selectedWeek.value !== week) {
    selectedUnit.value = null
  }
  selectedWeek.value = week
  showWeekPicker.value = false
}

function openUnitPicker() {
  if (!selectedWeek.value) {
    uni.showToast({ title: '请先选择周次', icon: 'none' })
    return
  }
  showUnitPicker.value = true
}

function closeUnitPicker() {
  showUnitPicker.value = false
}

function selectUnit(unitName: number) {
  selectedUnit.value = unitName
  showUnitPicker.value = false
}

function ensureBookUnits(bookId: number) {
  if (loadedUnitBookId.value === bookId || unitLoading.value) return
  fetchBookUnits(bookId)
}

async function fetchBookUnits(bookId: number) {
  const seq = ++unitRequestSeq
  unitLoading.value = true
  unitOptions.value = []
  loadedUnitBookId.value = null

  try {
    const counter = new Map<string, BookUnitOption>()
    let page = 1
    let totalPage = 1

    do {
      const response = await listWordsByBookPage(
        { bookId },
        {
          pageNum: page,
          pageSize: UNIT_PAGE_SIZE,
        },
      )
      if (seq !== unitRequestSeq) return
      const result = response.data

      if (result.code !== 0 || !result.data) {
        throw new Error(result.message || '获取周次单元失败')
      }

      const records = result.data.records || []
      records.forEach((item) => {
        const week = Number(item.week)
        const unitName = Number(item.unitName)
        if (!Number.isFinite(week) || week <= 0) return
        if (!Number.isFinite(unitName) || unitName <= 0) return
        const key = `${week}-${unitName}`
        const current = counter.get(key)
        if (current) {
          current.wordCount += 1
        } else {
          counter.set(key, { week, unitName, wordCount: 1 })
        }
      })

      const reportedTotal = Number(result.data.totalPage)
      const totalRow = Number(result.data.totalRow) || 0
      const size = Number(result.data.pageSize) || UNIT_PAGE_SIZE
      if (reportedTotal > 0) {
        totalPage = reportedTotal
      } else if (totalRow > 0) {
        totalPage = Math.max(Math.ceil(totalRow / size), 1)
      } else if (records.length < UNIT_PAGE_SIZE) {
        totalPage = page
      } else {
        totalPage = page + 1
      }
      if (records.length === 0) break
      page += 1
    } while (page <= totalPage && page <= UNIT_PAGE_LIMIT)

    if (seq !== unitRequestSeq) return
    unitOptions.value = Array.from(counter.values()).sort((a, b) => {
      if (a.week !== b.week) return a.week - b.week
      return a.unitName - b.unitName
    })
    loadedUnitBookId.value = bookId
  } catch (error) {
    if (seq !== unitRequestSeq) return
    const message = error instanceof Error ? error.message : '获取周次单元失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    if (seq === unitRequestSeq) {
      unitLoading.value = false
    }
  }
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
  if (assignMode.value === 'unit') {
    await submitUnitAssign()
    return
  }
  await submitDailyHomework()
}

async function submitUnitAssign() {
  const classId = selectedClass.value && selectedClass.value.id
  const bookId = selectedBook.value && selectedBook.value.id
  const week = selectedWeek.value
  const unitName = selectedUnit.value
  if (!classId || !bookId || !week || !unitName) return

  submitting.value = true
  try {
    const response = await assignUnitPlan({
      classId,
      bookId,
      week,
      unitName,
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '分配今日学习计划失败')
    }

    const addedCount = Number(result.data.addedCount) || 0
    const studentCount = Number(result.data.studentCount) || 0
    uni.showToast({
      title: `已写入${studentCount}名学生，新增${addedCount}条`,
      icon: 'none',
    })
    showCreateModal.value = false
    showClassPicker.value = false
    showBookPicker.value = false
    showWeekPicker.value = false
    showUnitPicker.value = false
  } catch (error) {
    const message = error instanceof Error ? error.message : '分配今日学习计划失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    submitting.value = false
  }
}

async function submitDailyHomework() {
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
  background: #f3f8fd;
}

.header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  margin-bottom: 40rpx;
}

.header-main {
  flex: 1;
  min-width: 0;
}

.dispatch-btn {
  flex-shrink: 0;
  margin-top: 8rpx;
  margin-left: 16rpx;
  padding: 12rpx 24rpx;
  border-radius: 999rpx;
  background: #4ba8f5;

  &.disabled {
    opacity: 0.45;
  }
}

.dispatch-text {
  font-size: 24rpx;
  font-weight: 600;
  color: #fff;
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

.homework-list {
  margin-top: 24rpx;
}

.homework-card {
  padding: 8rpx 32rpx;
  margin-bottom: 24rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.1);
  border: 2rpx solid #e8f4fe;
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
  font-weight: 700;
  color: #1f2a37;
}

.homework-status {
  margin-left: 12rpx;
  padding: 4rpx 12rpx;
  font-size: 22rpx;
  border-radius: 999rpx;
  color: #4ba8f5;
  background: rgba(75, 168, 245, 0.12);

  &.stopped {
    color: #8e8e93;
    background: rgba(142, 142, 147, 0.12);
  }
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

.picker-panel {
  max-height: 75vh;
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

.mode-switch {
  display: flex;
  padding: 8rpx;
  margin-bottom: 24rpx;
  border-radius: 20rpx;
  background: #fff;
  border: 2rpx solid #e8f4fe;
}

.mode-item {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 72rpx;
  border-radius: 16rpx;

  &.active {
    background: rgba(75, 168, 245, 0.12);
  }
}

.mode-text {
  font-size: 28rpx;
  color: #7a8594;
}

.mode-item.active .mode-text {
  color: #4ba8f5;
  font-weight: 600;
}

.form-card {
  padding: 8rpx 32rpx;
  border-radius: 28rpx;
  background: #fff;
  border: 2rpx solid #e8f4fe;
}

.form-hint {
  margin-top: 20rpx;
  padding: 0 8rpx;
}

.form-hint-text {
  font-size: 24rpx;
  line-height: 1.6;
  color: #7a8594;
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
  width: 100%;
  font-size: 30rpx;
  color: #1f2a37;
}

.placeholder {
  color: #a8b0bc;
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
  color: #1f2a37;
}

.select-arrow {
  margin-left: 12rpx;
  font-size: 32rpx;
  color: #b7c0cc;
}

.picker-scroll {
  max-height: 52vh;
  margin-bottom: 8rpx;
  border-radius: 28rpx;
  background: #fff;
  border: 2rpx solid #e8f4fe;
}

.picker-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 28rpx 32rpx;
  border-bottom: 1rpx solid #eef4fa;

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
  color: #1f2a37;
}

.picker-item-desc {
  display: block;
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #7a8594;
}

.picker-check {
  margin-left: 16rpx;
  font-size: 28rpx;
  font-weight: 600;
  color: #4ba8f5;
}

.list-tip {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24rpx 0;
}

.list-tip-text {
  font-size: 24rpx;
  color: #7a8594;
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
  color: #8e8e93;
}
</style>
