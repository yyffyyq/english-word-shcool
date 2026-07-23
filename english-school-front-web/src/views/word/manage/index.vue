<template>
  <div class="app-container">
    <el-card shadow="never" class="main-card">
      <template #header>
        <div class="card-header">
          <span>向单词本添加单词</span>
          <div>
            <el-button link type="primary" @click="goCreateBook">去创建单词本</el-button>
            <el-button link type="primary" @click="goBookList">返回词书列表</el-button>
          </div>
        </div>
      </template>

      <el-form ref="formRef" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="所属词书" prop="bookId">
          <el-select
            v-model="form.bookId"
            filterable
            clearable
            placeholder="请选择词书"
            style="width: 360px"
            :loading="bookLoading"
          >
            <el-option
              v-for="item in bookOptions"
              :key="item.id"
              :label="item.bookName + (item.status === 'DISABLED' ? ' (已停用)' : '')"
              :value="item.id"
              :disabled="item.status === 'DISABLED'"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="单元名称" prop="unitName">
          <el-input
            v-model="form.unitName"
            placeholder="Unit 1 (可选)"
            maxlength="50"
            style="width: 360px"
            show-word-limit
          />
        </el-form-item>

        <el-divider content-position="left">单词列表</el-divider>

        <div v-for="(word, index) in form.words" :key="index" class="word-block">
          <div class="word-block__header">
            <span>单词 {{ index + 1 }}</span>
            <el-button
              v-if="form.words.length > 1"
              link
              type="danger"
              @click="removeWord(index)"
            >移除</el-button>
          </div>

          <el-row :gutter="16">
            <el-col :span="12">
              <el-form-item
                label="英文单词"
                :prop="'words.' + index + '.wordText'"
                :rules="wordRules.wordText"
              >
                <el-input v-model="word.wordText" placeholder="请输入英文单词" maxlength="100" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item
                label="音标"
                :prop="'words.' + index + '.phonetic'"
                :rules="wordRules.phonetic"
              >
                <el-input v-model="word.phonetic" placeholder="请输入音标" maxlength="100" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item
                label="正确释义"
                :prop="'words.' + index + '.correctMeaning'"
                :rules="wordRules.correctMeaning"
              >
                <el-input v-model="word.correctMeaning" placeholder="请输入正确中文释义" maxlength="100" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item
                label="错误释义1"
                :prop="'words.' + index + '.wrong1'"
                :rules="wordRules.wrong1"
              >
                <el-input v-model="word.wrong1" placeholder="请输入错误中文释义" maxlength="100" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item
                label="错误释义2"
                :prop="'words.' + index + '.wrong2'"
                :rules="wordRules.wrong2"
              >
                <el-input v-model="word.wrong2" placeholder="请输入错误中文释义" maxlength="100" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item
                label="错误释义3"
                :prop="'words.' + index + '.wrong3'"
                :rules="wordRules.wrong3"
              >
                <el-input v-model="word.wrong3" placeholder="请输入错误中文释义" maxlength="100" />
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item
                label="英文例句"
                :prop="'words.' + index + '.exampleSentence'"
                :rules="wordRules.exampleSentence"
              >
                <el-input v-model="word.exampleSentence" type="textarea" :rows="2" placeholder="请输入英文例句" maxlength="500" show-word-limit />
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item
                label="例句翻译"
                :prop="'words.' + index + '.exampleTranslation'"
                :rules="wordRules.exampleTranslation"
              >
                <el-input v-model="word.exampleTranslation" type="textarea" :rows="2" placeholder="请输入例句中文翻译" maxlength="500" show-word-limit />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <el-form-item>
          <el-button type="primary" plain icon="Plus" @click="addWord" :disabled="form.words.length >= 50">再加一条单词</el-button>
          <span class="tip">单次最多 50 条</span>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" :loading="submitLoading" @click="submitForm">提交导入</el-button>
          <el-button @click="resetAll">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card v-if="importResult" shadow="never" class="result-card">
      <template #header>
        <span>导入结果</span>
      </template>
      <el-descriptions :column="3" border>
        <el-descriptions-item label="成功数">{{ importResult.successCount ?? 0 }}</el-descriptions-item>
        <el-descriptions-item label="失败数">{{ importResult.failCount ?? 0 }}</el-descriptions-item>
        <el-descriptions-item label="词书单词总数">{{ importResult.wordCount ?? 0 }}</el-descriptions-item>
      </el-descriptions>
      <el-table
        v-if="importResult.failList && importResult.failList.length"
        :data="importResult.failList"
        style="margin-top: 16px"
      >
        <el-table-column label="单词" prop="wordText" min-width="140" />
        <el-table-column label="失败原因" prop="reason" min-width="240" show-overflow-tooltip />
      </el-table>
    </el-card>
  </div>
</template>

<script setup name="WordManage">
import { listWordBookByPage, importWords } from '@/api/wordBook'

const { proxy } = getCurrentInstance()
const route = useRoute()
const router = useRouter()

const bookOptions = ref([])
const bookLoading = ref(false)
const submitLoading = ref(false)
const importResult = ref(null)

function createEmptyWord() {
  return {
    wordText: '',
    phonetic: '',
    correctMeaning: '',
    wrong1: '',
    wrong2: '',
    wrong3: '',
    exampleSentence: '',
    exampleTranslation: ''
  }
}

const form = ref({
  bookId: undefined,
  unitName: '',
  words: [createEmptyWord()]
})

const rules = {
  bookId: [{ required: true, message: '请选择词书', trigger: 'change' }]
}

const wordRules = {
  wordText: [{ required: true, message: '英文单词不能为空', trigger: 'blur' }],
  phonetic: [{ required: true, message: '音标不能为空', trigger: 'blur' }],
  correctMeaning: [{ required: true, message: '正确释义不能为空', trigger: 'blur' }],
  wrong1: [{ required: true, message: '错误释义不能为空', trigger: 'blur' }],
  wrong2: [{ required: true, message: '错误释义不能为空', trigger: 'blur' }],
  wrong3: [{ required: true, message: '错误释义不能为空', trigger: 'blur' }],
  exampleSentence: [{ required: true, message: '英文例句不能为空', trigger: 'blur' }],
  exampleTranslation: [{ required: true, message: '例句翻译不能为空', trigger: 'blur' }]
}

function loadBooks() {
  bookLoading.value = true
  listWordBookByPage({
    pageNum: 1,
    pageSize: 100,
    sortField: 'createdAt',
    sortOrder: 'descend'
  }).then(res => {
    const page = res.data || {}
    bookOptions.value = page.records || []
  }).finally(() => {
    bookLoading.value = false
  })
}

function addWord() {
  if (form.value.words.length >= 50) {
    proxy.$modal.msgWarning('单次最多导入 50 条')
    return
  }
  form.value.words.push(createEmptyWord())
}

function removeWord(index) {
  form.value.words.splice(index, 1)
}

function resetAll() {
  form.value = {
    bookId: route.query.bookId ? Number(route.query.bookId) : undefined,
    unitName: '',
    words: [createEmptyWord()]
  }
  importResult.value = null
  proxy.resetForm('formRef')
}

function submitForm() {
  proxy.$refs.formRef.validate(valid => {
    if (!valid) return
    const words = form.value.words.map(item => ({
      wordText: item.wordText,
      phonetic: item.phonetic,
      correctMeaning: item.correctMeaning,
      wrongMeanings: [item.wrong1, item.wrong2, item.wrong3],
      exampleSentence: item.exampleSentence,
      exampleTranslation: item.exampleTranslation
    }))
    submitLoading.value = true
    importWords(form.value.bookId, {
      unitName: form.value.unitName || undefined,
      words
    }).then(res => {
      importResult.value = res.data || {}
      const successCount = importResult.value.successCount || 0
      const failCount = importResult.value.failCount || 0
      if (failCount > 0) {
        proxy.$modal.msgWarning('导入完成：成功 {0} 条，失败 {1} 条'.replace('{0}', successCount).replace('{1}', failCount))
      } else {
        proxy.$modal.msgSuccess('导入成功，共 {0} 条'.replace('{0}', successCount))
      }
    }).finally(() => {
      submitLoading.value = false
    })
  })
}

function goBookList() {
  router.push('/word/book')
}

function goCreateBook() {
  router.push('/word/book')
}

onMounted(() => {
  loadBooks()
  if (route.query.bookId) {
    form.value.bookId = Number(route.query.bookId)
  }
})
</script>

<style scoped lang="scss">
.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.main-card {
  margin-bottom: 16px;
}

.word-block {
  margin-bottom: 16px;
  padding: 12px 12px 0;
  border: 1px solid var(--el-border-color-lighter);
  border-radius: 6px;
  background: var(--el-fill-color-blank);
}

.word-block__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
  font-weight: 600;
}

.tip {
  margin-left: 12px;
  color: #909399;
  font-size: 13px;
}

.result-card {
  max-width: 960px;
}
</style>
