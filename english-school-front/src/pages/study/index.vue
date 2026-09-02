<template>
  <view class="page">
    <AuthModals />
    <view class="header">
      <text class="title">今日学习</text>
      <text class="subtitle">完成教师布置的单词任务</text>
    </view>

    <view class="card" @tap="handleStart">
      <text class="card-num">{{ pendingCount }}</text>
      <text class="card-label">待学单词</text>
      <text v-if="loading" class="card-tip">加载中...</text>
      <text v-else-if="totalCount > 0" class="card-tip">
        已掌握 {{ masteredCount }} / {{ totalCount }}
      </text>
    </view>

    <view
      class="start-btn"
      :class="{ disabled: loading || pendingCount <= 0 }"
      @tap="handleStart"
    >
      <text class="btn-text">{{ startBtnText }}</text>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getTodayHomework } from '@/api/studentStudyController'
import AuthModals from '@/components/AuthModals.vue'
import { useAuth } from '@/composables/useAuth'
import {
  getMasteredWordCount,
  getPendingWordCount,
  getStudyHomeworkCache,
  setStudyHomeworkCache,
} from '@/utils/studyCache'

const auth = useAuth()

const loading = ref(false)
const words = ref<API.StudentHomeworkWordVO[]>([])

const totalCount = computed(() => words.value.length)
const pendingCount = computed(() => getPendingWordCount(words.value))
const masteredCount = computed(() => getMasteredWordCount(words.value))
const startBtnText = computed(() => {
  if (loading.value) return '加载中...'
  if (totalCount.value === 0) return '暂无学习任务'
  if (pendingCount.value <= 0) return '今日已完成'
  return '开始学习'
})

onShow(() => {
  loadTodayHomework()
})

async function loadTodayHomework() {
  const cache = getStudyHomeworkCache()
  if (cache) {
    words.value = cache.words || []
    return
  }

  if (!auth.guardPageAccess({ silent: true })) {
    words.value = []
    return
  }

  loading.value = true
  try {
    const response = await getTodayHomework()
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '获取今日学习任务失败')
    }

    const saved = setStudyHomeworkCache(result.data)
    words.value = saved.words || []
  } catch (error) {
    words.value = []
    const message = error instanceof Error ? error.message : '获取今日学习任务失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    loading.value = false
  }
}

function handleStart() {
  if (!auth.guardPageAccess()) return
  if (loading.value) return

  if (pendingCount.value <= 0) {
    uni.showToast({
      title: totalCount.value > 0 ? '今日单词已全部掌握' : '暂无待学单词',
      icon: 'none',
    })
    return
  }

  uni.navigateTo({ url: '/pages/study/learn' })
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx;
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

.card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 280rpx;
  margin-bottom: 40rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.12);
  border: 2rpx solid #e8f4fe;
}

.card-num {
  font-size: 72rpx;
  font-weight: 700;
  color: #4ba8f5;
}

.card-label {
  margin-top: 8rpx;
  font-size: 26rpx;
  color: #7a8594;
}

.card-tip {
  margin-top: 16rpx;
  font-size: 22rpx;
  color: #a8b0bc;
}

.start-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 96rpx;
  border-radius: 48rpx;
  background: linear-gradient(135deg, #ff8a3d 0%, #ffb074 100%);
  box-shadow: 0 10rpx 24rpx rgba(255, 138, 61, 0.3);

  &.disabled {
    opacity: 0.45;
    box-shadow: none;
  }
}

.btn-text {
  font-size: 30rpx;
  font-weight: 600;
  color: #fff;
  letter-spacing: 4rpx;
}
</style>
