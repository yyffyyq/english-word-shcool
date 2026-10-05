<template>
  <view class="page">
    <AuthModals />

    <view class="progress-bar">
      <text class="progress-text">已掌握 {{ masteredCount }} / {{ totalCount }}</text>
    </view>

    <view v-if="phase === 'finished'" class="finished-card">
      <text class="finished-icon">✓</text>
      <text class="finished-title">今日学习完成</text>
      <text class="finished-desc">已掌握全部 {{ totalCount }} 个单词</text>
      <view class="action-btn" @tap="handleComplete">
        <text class="action-btn-text">完成</text>
      </view>
    </view>

    <template v-else-if="currentWord">
      <!-- 选择题阶段 -->
      <view v-if="phase === 'choice'" class="stage">
        <view class="word-panel">
          <view class="word-row">
            <text class="word-text">{{ currentWord.wordText }}</text>
            <text v-if="choiceResult === true" class="result-icon correct">✓</text>
          </view>
          <text class="phonetic">{{ currentWord.phonetic || '' }}</text>
        </view>

        <view class="options">
          <view
            v-for="option in currentOptions"
            :key="option.id"
            class="option-card"
            :class="getOptionClass(option)"
            @tap="handleSelectOption(option)"
          >
            <text class="option-text">{{ option.optionText }}</text>
          </view>
        </view>

        <view v-if="choiceResult === false" class="correct-tip">
          <text class="correct-tip-label">正确答案</text>
          <text class="correct-tip-value">{{ choiceCorrectAnswer }}</text>
        </view>

        <view
          v-if="choiceResult !== null"
          class="action-btn"
          :class="{ disabled: submitting }"
          @tap="handleChoiceNext"
        >
          <text class="action-btn-text">下一步</text>
        </view>
      </view>

      <!-- 拼写阶段 -->
      <view v-else-if="phase === 'spell'" class="stage">
        <view
          class="word-panel"
          :class="{
            'panel-correct': spellResult === true,
            'panel-wrong': spellResult === false,
          }"
        >
          <text class="meaning-text">{{ currentWord.correctMeaning }}</text>
          <text class="phonetic">{{ currentWord.phonetic || '' }}</text>
        </view>

        <view class="spell-row">
          <input
            class="spell-input"
            :class="{
              'input-correct': spellResult === true,
              'input-wrong': spellResult === false,
            }"
            :value="spellText"
            :disabled="spellResult !== null || submitting"
            placeholder="请输入英文拼写"
            placeholder-class="placeholder"
            confirm-type="done"
            @input="onSpellInput"
            @confirm="handleSubmitSpell"
          />
          <text v-if="spellResult === true" class="result-icon correct">✓</text>
          <text v-else-if="spellResult === false" class="result-icon wrong">✕</text>
        </view>

        <view v-if="spellResult === false" class="correct-tip">
          <text class="correct-tip-label">正确拼写</text>
          <text class="correct-tip-value">{{ spellCorrectAnswer }}</text>
        </view>

        <view
          v-if="spellResult === null"
          class="action-btn"
          :class="{ disabled: !canSubmitSpell || submitting }"
          @tap="handleSubmitSpell"
        >
          <text class="action-btn-text">{{ submitting ? '判断中...' : '提交拼写' }}</text>
        </view>
        <view
          v-else
          class="action-btn"
          :class="{ disabled: submitting }"
          @tap="handleSpellNext"
        >
          <text class="action-btn-text">下一步</text>
        </view>
      </view>

      <!-- 例句阶段 -->
      <view v-else-if="phase === 'example'" class="stage">
        <view class="word-panel">
          <text class="word-text">{{ currentWord.wordText }}</text>
          <text class="phonetic">{{ currentWord.phonetic || '' }}</text>
          <text class="meaning-text small">{{ currentWord.correctMeaning }}</text>
        </view>

        <view class="example-card">
          <text class="example-en">{{ currentWord.exampleSentence || '暂无例句' }}</text>
          <text class="example-zh">{{ currentWord.exampleTranslation || '' }}</text>
        </view>

        <view
          class="action-btn"
          :class="{ disabled: submitting }"
          @tap="handleExampleNext"
        >
          <text class="action-btn-text">{{ submitting ? '更新中...' : '下一步' }}</text>
        </view>
      </view>
    </template>

    <view v-else class="empty-wrap">
      <text class="empty-text">{{ emptyText }}</text>
      <view class="action-btn ghost" @tap="handleComplete">
        <text class="action-btn-text ghost-text">返回</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import {
  answerChoice,
  answerSpell,
  getTodayHomework,
  updateWordStatus,
} from '@/api/xueshengxuexi'
import AuthModals from '@/components/AuthModals.vue'
import { useAuth } from '@/composables/useAuth'
import {
  getMasteredWordCount,
  getStudyHomeworkCache,
  getUnmasteredWords,
  setStudyHomeworkCache,
  updateStudyWordInCache,
  WORD_STATUS,
} from '@/utils/studyCache'

type StudyPhase = 'choice' | 'spell' | 'example' | 'finished'

const auth = useAuth()

const words = ref<API.StudentHomeworkWordVO[]>([])
const queue = ref<API.StudentHomeworkWordVO[]>([])
const queueIndex = ref(0)
const phase = ref<StudyPhase>('choice')
const submitting = ref(false)
const emptyText = ref('暂无待学单词')

const selectedOptionId = ref<number | null>(null)
const choiceResult = ref<boolean | null>(null)
const choiceCorrectAnswer = ref('')

const spellText = ref('')
const spellResult = ref<boolean | null>(null)
const spellCorrectAnswer = ref('')

const currentWord = computed(() => queue.value[queueIndex.value] || null)
const currentOptions = computed(() => currentWord.value?.options || [])
const totalCount = computed(() => words.value.length)
const masteredCount = computed(() => getMasteredWordCount(words.value))
const canSubmitSpell = computed(() => Boolean(spellText.value.trim()))

onLoad(() => {
  initStudySession()
})

function initStudySession() {
  if (!auth.guardPageAccess({ silent: true })) {
    emptyText.value = '请先登录'
    return
  }

  const cache = getStudyHomeworkCache()
  if (!cache?.words?.length) {
    emptyText.value = '学习数据已过期，请返回重新进入'
    words.value = []
    queue.value = []
    return
  }

  words.value = [...cache.words]
  rebuildQueue()

  if (queue.value.length === 0) {
    if (masteredCount.value >= totalCount.value && totalCount.value > 0) {
      phase.value = 'finished'
      return
    }
    emptyText.value = '暂无待学单词'
    return
  }

  loadCurrentWord()
}

function rebuildQueue() {
  queue.value = getUnmasteredWords(words.value)
  queueIndex.value = 0
}

function loadCurrentWord() {
  selectedOptionId.value = null
  choiceResult.value = null
  choiceCorrectAnswer.value = ''
  spellText.value = ''
  spellResult.value = null
  spellCorrectAnswer.value = ''
  phase.value = 'choice'
}

function getOptionClass(option: API.StudentStudyOptionVO) {
  if (choiceResult.value === null || selectedOptionId.value === null) return ''

  if (choiceResult.value === true && option.id === selectedOptionId.value) {
    return 'option-correct'
  }

  if (choiceResult.value === false && option.id === selectedOptionId.value) {
    return 'option-wrong'
  }

  return 'option-disabled'
}

async function handleSelectOption(option: API.StudentStudyOptionVO) {
  if (choiceResult.value !== null || submitting.value) return
  if (!currentWord.value?.wordId || !option.id) return

  submitting.value = true
  selectedOptionId.value = option.id

  try {
    const response = await answerChoice({
      wordId: currentWord.value.wordId,
      optionId: option.id,
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '判题失败')
    }

    choiceResult.value = Boolean(result.data.correct)
    choiceCorrectAnswer.value =
      result.data.correctAnswer || currentWord.value.correctMeaning || ''

    syncLocalWordStatus(currentWord.value.wordId, {
      progressStatus: result.data.progressStatus || WORD_STATUS.LEARNING,
    })
  } catch (error) {
    selectedOptionId.value = null
    const message = error instanceof Error ? error.message : '判题失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    submitting.value = false
  }
}

function handleChoiceNext() {
  if (choiceResult.value === null || submitting.value) return

  if (choiceResult.value) {
    spellText.value = ''
    spellResult.value = null
    spellCorrectAnswer.value = ''
    phase.value = 'spell'
    return
  }

  void goNextWord()
}

function onSpellInput(event: { detail?: { value?: string } }) {
  if (spellResult.value !== null) return
  spellText.value = event.detail?.value || ''
}

async function handleSubmitSpell() {
  if (!canSubmitSpell.value || spellResult.value !== null || submitting.value) return
  if (!currentWord.value?.wordId) return

  submitting.value = true
  try {
    const response = await answerSpell({
      wordId: currentWord.value.wordId,
      spelledText: spellText.value.trim(),
    })
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '拼写判题失败')
    }

    spellResult.value = Boolean(result.data.correct)
    spellCorrectAnswer.value =
      result.data.correctAnswer || currentWord.value.wordText || ''

    // 答错时不改本地缓存；答对后在例句阶段再更新为 MASTERED
    if (result.data.correct) {
      syncLocalWordStatus(currentWord.value.wordId, {
        progressStatus: result.data.progressStatus || WORD_STATUS.LEARNING,
      })
    }
  } catch (error) {
    const message = error instanceof Error ? error.message : '拼写判题失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    submitting.value = false
  }
}

function handleSpellNext() {
  if (spellResult.value === null || submitting.value) return

  if (spellResult.value) {
    phase.value = 'example'
    return
  }

  void goNextWord()
}

async function handleExampleNext() {
  if (submitting.value || !currentWord.value?.wordId) return

  submitting.value = true
  try {
    const wordId = currentWord.value.wordId
    const response = await updateWordStatus({
      wordId,
      status: WORD_STATUS.MASTERED,
    })
    const result = response.data

    if (result.code !== 0) {
      throw new Error(result.message || '更新单词状态失败')
    }

    syncLocalWordStatus(wordId, {
      progressStatus: WORD_STATUS.MASTERED,
    })

    await goNextWord()
  } catch (error) {
    const message = error instanceof Error ? error.message : '更新单词状态失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    submitting.value = false
  }
}

function syncLocalWordStatus(
  wordId: number,
  patch: Partial<API.StudentHomeworkWordVO>,
) {
  const updatedCache = updateStudyWordInCache(wordId, patch)
  if (updatedCache?.words) {
    words.value = [...updatedCache.words]
  } else {
    words.value = words.value.map((word) =>
      word.wordId === wordId ? { ...word, ...patch } : word,
    )
  }

  queue.value = queue.value.map((word) =>
    word.wordId === wordId ? { ...word, ...patch } : word,
  )
}

/**
 * 加载下一词前校验缓存：有效则同步本地状态，过期则重新拉取接口。
 * @returns true 表示缓存已刷新（需重建队列），false 表示沿用原队列
 */
async function ensureHomeworkCacheForNext(): Promise<boolean> {
  const cache = getStudyHomeworkCache()
  if (cache) {
    words.value = [...(cache.words || [])]
    return false
  }

  uni.showLoading({ title: '同步学习数据...', mask: true })
  try {
    const response = await getTodayHomework()
    const result = response.data

    if (result.code !== 0 || !result.data) {
      throw new Error(result.message || '获取今日学习任务失败')
    }

    const saved = setStudyHomeworkCache(result.data)
    words.value = [...(saved.words || [])]
    return true
  } finally {
    uni.hideLoading()
  }
}

async function goNextWord() {
  if (submitting.value && phase.value !== 'example') return

  const wasSubmitting = submitting.value
  if (!wasSubmitting) submitting.value = true

  try {
    const cacheRefreshed = await ensureHomeworkCacheForNext()

    if (cacheRefreshed) {
      // 缓存过期后数据以接口为准，重建未掌握队列
      rebuildQueue()
      if (queue.value.length === 0) {
        phase.value = 'finished'
        return
      }
      loadCurrentWord()
      return
    }

    if (masteredCount.value >= totalCount.value && totalCount.value > 0) {
      phase.value = 'finished'
      return
    }

    const nextIndex = queueIndex.value + 1
    if (nextIndex < queue.value.length) {
      const nextWord = queue.value[nextIndex]
      if (nextWord && !isMasteredStatus(nextWord.progressStatus)) {
        queueIndex.value = nextIndex
        loadCurrentWord()
        return
      }
    }

    // 本轮结束：还有未掌握单词则重新排队继续学
    rebuildQueue()
    if (queue.value.length === 0) {
      phase.value = 'finished'
      return
    }

    loadCurrentWord()
  } catch (error) {
    const message = error instanceof Error ? error.message : '加载下一单词失败'
    uni.showToast({ title: message, icon: 'none' })
  } finally {
    if (!wasSubmitting) submitting.value = false
  }
}

function isMasteredStatus(status?: string) {
  return (status || '').toUpperCase() === WORD_STATUS.MASTERED
}

function handleComplete() {
  uni.navigateBack({
    fail: () => {
      uni.redirectTo({ url: '/pages/study/index' })
    },
  })
}
</script>

<style scoped lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx;
  padding-bottom: 80rpx;
  background: #f3f8fd;
  box-sizing: border-box;
}

.progress-bar {
  display: flex;
  justify-content: center;
  margin-bottom: 32rpx;
}

.progress-text {
  font-size: 28rpx;
  font-weight: 600;
  color: #4ba8f5;
  letter-spacing: 2rpx;
}

.stage {
  display: flex;
  flex-direction: column;
}

.word-panel {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 220rpx;
  padding: 40rpx 32rpx;
  margin-bottom: 32rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.12);
  border: 2rpx solid #e8f4fe;
  transition: background 0.2s ease;

  &.panel-correct {
    background: #eaf7ef;
  }

  &.panel-wrong {
    background: #fdeeee;
  }
}

.word-row {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 16rpx;
}

.word-text {
  font-size: 56rpx;
  font-weight: 600;
  color: #1a1a1a;
  line-height: 1.3;
}

.meaning-text {
  font-size: 44rpx;
  font-weight: 500;
  color: #1a1a1a;
  text-align: center;
  line-height: 1.4;

  &.small {
    margin-top: 20rpx;
    font-size: 30rpx;
    font-weight: 400;
    color: #636366;
  }
}

.phonetic {
  margin-top: 12rpx;
  font-size: 28rpx;
  color: #8e8e93;
}

.result-icon {
  font-size: 40rpx;
  font-weight: 600;
  line-height: 1;

  &.correct {
    color: #34c759;
  }

  &.wrong {
    color: #ff3b30;
  }
}

.options {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
  margin-bottom: 24rpx;
}

.option-card {
  display: flex;
  align-items: center;
  min-height: 96rpx;
  padding: 28rpx 32rpx;
  border-radius: 24rpx;
  background: #fff;
  box-shadow: 0 6rpx 18rpx rgba(75, 168, 245, 0.08);
  border: 2rpx solid #e8f4fe;
  box-sizing: border-box;

  &.option-correct {
    background: #eaf7ef;
    border-color: #34c759;
  }

  &.option-wrong {
    background: #fdeeee;
    border-color: #ff9f9a;
  }

  &.option-disabled {
    opacity: 0.55;
  }
}

.option-text {
  font-size: 30rpx;
  color: #1a1a1a;
  line-height: 1.4;
}

.spell-row {
  display: flex;
  align-items: center;
  gap: 16rpx;
  margin-bottom: 24rpx;
}

.spell-input {
  flex: 1;
  height: 96rpx;
  padding: 0 28rpx;
  border-radius: 20rpx;
  background: #fff;
  font-size: 32rpx;
  color: #1a1a1a;
  box-sizing: border-box;
  border: 2rpx solid transparent;

  &.input-correct {
    background: #eaf7ef;
    border-color: #34c759;
  }

  &.input-wrong {
    background: #fdeeee;
    border-color: #ff9f9a;
  }
}

.placeholder {
  color: #c7c7cc;
}

.correct-tip {
  display: flex;
  flex-direction: column;
  gap: 8rpx;
  padding: 24rpx 28rpx;
  margin-bottom: 24rpx;
  border-radius: 16rpx;
  background: rgba(255, 122, 48, 0.08);
}

.correct-tip-label {
  font-size: 22rpx;
  color: #8e8e93;
}

.correct-tip-value {
  font-size: 30rpx;
  font-weight: 500;
  color: #1a1a1a;
}

.example-card {
  display: flex;
  flex-direction: column;
  gap: 16rpx;
  padding: 32rpx;
  margin-bottom: 32rpx;
  border-radius: 20rpx;
  background: #fff;
  box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.04);
}

.example-en {
  font-size: 30rpx;
  line-height: 1.6;
  color: #1a1a1a;
}

.example-zh {
  font-size: 26rpx;
  line-height: 1.6;
  color: #8e8e93;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 96rpx;
  margin-top: 16rpx;
  border-radius: 48rpx;
  background: linear-gradient(135deg, #ff8a3d 0%, #ffb074 100%);
  box-shadow: 0 10rpx 24rpx rgba(255, 138, 61, 0.28);
  box-sizing: border-box;

  &.disabled {
    opacity: 0.45;
    box-shadow: none;
  }

  &.ghost {
    background: transparent;
    border: 2rpx solid #4ba8f5;
    box-shadow: none;
  }
}

.action-btn-text {
  font-size: 30rpx;
  font-weight: 600;
  color: #fff;
  letter-spacing: 4rpx;

  &.ghost-text {
    color: #4ba8f5;
  }
}

.finished-card,
.empty-wrap {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 80rpx 40rpx;
  border-radius: 32rpx;
  background: #fff;
  box-shadow: 0 10rpx 28rpx rgba(75, 168, 245, 0.12);
  border: 2rpx solid #e8f4fe;

  .action-btn {
    width: 100%;
    align-self: stretch;
    margin-top: 8rpx;
  }
}

.finished-icon {
  font-size: 72rpx;
  color: #34c759;
  line-height: 1;
}

.finished-title {
  margin-top: 24rpx;
  font-size: 36rpx;
  font-weight: 600;
  color: #1a1a1a;
}

.finished-desc,
.empty-text {
  margin-top: 12rpx;
  margin-bottom: 40rpx;
  font-size: 26rpx;
  color: #8e8e93;
  text-align: center;
}
</style>
