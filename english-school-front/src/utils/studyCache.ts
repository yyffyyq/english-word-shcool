import { getStorage, removeStorage, setStorage } from '@/utils/storage'

const STUDY_HOMEWORK_CACHE_KEY = 'english_school_today_homework'
const CACHE_TTL_MS = 10 * 60 * 1000

export const WORD_STATUS = {
  NEW: 'NEW',
  LEARNING: 'LEARNING',
  MASTERED: 'MASTERED',
} as const

export type StudyWordStatus = (typeof WORD_STATUS)[keyof typeof WORD_STATUS]

export type StudyHomeworkCache = API.StudentHomeworkCacheVO & {
  expireAt: number
}

export function isWordMastered(status?: string) {
  return (status || '').toUpperCase() === WORD_STATUS.MASTERED
}

export function getPendingWordCount(words: API.StudentHomeworkWordVO[] = []) {
  return words.filter((word) => !isWordMastered(word.progressStatus)).length
}

export function getMasteredWordCount(words: API.StudentHomeworkWordVO[] = []) {
  return words.filter((word) => isWordMastered(word.progressStatus)).length
}

export function getStudyHomeworkCache(): StudyHomeworkCache | null {
  const cache = getStorage<StudyHomeworkCache>(STUDY_HOMEWORK_CACHE_KEY)
  if (!cache) return null

  if (!cache.expireAt || Date.now() > cache.expireAt) {
    removeStorage(STUDY_HOMEWORK_CACHE_KEY)
    return null
  }

  return cache
}

export function setStudyHomeworkCache(data: API.StudentHomeworkCacheVO) {
  const cache: StudyHomeworkCache = {
    ...data,
    words: data.words || [],
    wordCount: data.wordCount ?? (data.words?.length || 0),
    expireAt: Date.now() + CACHE_TTL_MS,
  }
  setStorage(STUDY_HOMEWORK_CACHE_KEY, cache)
  return cache
}

export function clearStudyHomeworkCache() {
  removeStorage(STUDY_HOMEWORK_CACHE_KEY)
}

export function updateStudyWordInCache(
  wordId: number,
  patch: Partial<API.StudentHomeworkWordVO>,
) {
  const cache = getStudyHomeworkCache()
  if (!cache?.words?.length) return null

  const words = cache.words.map((word) => {
    if (word.wordId !== wordId) return word
    return { ...word, ...patch }
  })

  return setStudyHomeworkCache({
    ...cache,
    words,
    wordCount: words.length,
  })
}

export function getUnmasteredWords(words: API.StudentHomeworkWordVO[] = []) {
  return words.filter((word) => !isWordMastered(word.progressStatus))
}
