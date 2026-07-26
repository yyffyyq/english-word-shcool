<template>
  <div class="app-container">
    <el-card shadow="never" class="main-card">
      <template #header>
        <div class="card-header">
          <span>单词管理</span>
          <div>
            <el-button link type="primary" @click="goCreateBook">去创建单词本</el-button>
            <el-button link type="primary" @click="goBookList">返回词书列表</el-button>
          </div>
        </div>
      </template>

      <el-form :inline="true" label-width="80px" class="book-select-form">
        <el-form-item label="所属词书">
          <el-select
            v-model="selectedBookId"
            filterable
            clearable
            placeholder="请选择词书"
            style="width: 360px"
            :loading="bookLoading"
            @change="handleBookChange"
          >
            <el-option
              v-for="item in bookOptions"
              :key="item.id"
              :label="item.bookName + (item.status === 'DISABLED' ? ' (已停用)' : '')"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
      </el-form>

      <el-tabs v-model="activeTab" @tab-change="handleTabChange">
        <el-tab-pane label="单词列表" name="list">
          <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
            <el-form-item label="英文单词" prop="wordText">
              <el-input
                v-model="queryParams.wordText"
                placeholder="请输入英文单词"
                clearable
                style="width: 200px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="单元名称" prop="unitName">
              <el-input
                v-model="queryParams.unitName"
                placeholder="请输入单元名称"
                clearable
                style="width: 200px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>

          <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
              <el-button type="primary" plain icon="Plus" @click="activeTab = 'import'">添加单词</el-button>
            </el-col>
            <right-toolbar v-model:showSearch="showSearch" @queryTable="getWordList"></right-toolbar>
          </el-row>

          <el-table v-loading="listLoading" :data="wordList">
            <el-table-column label="ID" align="center" prop="id" width="80" />
            <el-table-column label="排序" align="center" prop="sortOrder" width="70" />
            <el-table-column label="英文单词" align="center" prop="wordText" min-width="120" show-overflow-tooltip />
            <el-table-column label="音标" align="center" prop="phonetic" min-width="120" show-overflow-tooltip />
            <el-table-column label="正确释义" align="center" prop="correctMeaning" min-width="120" show-overflow-tooltip />
            <el-table-column label="单元" align="center" prop="unitName" width="100" show-overflow-tooltip>
              <template #default="scope">
                <span>{{ scope.row.unitName || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column label="英文例句" align="center" prop="exampleSentence" min-width="180" show-overflow-tooltip />
            <el-table-column label="例句翻译" align="center" prop="exampleTranslation" min-width="160" show-overflow-tooltip />
            <el-table-column label="选项" align="center" min-width="220">
              <template #default="scope">
                <template v-if="scope.row.options && scope.row.options.length">
                  <el-tag
                    v-for="opt in scope.row.options"
                    :key="opt.id || opt.optionText"
                    :type="opt.isCorrect === 1 ? 'success' : 'info'"
                    size="small"
                    class="option-tag"
                  >
                    {{ opt.optionText }}
                  </el-tag>
                </template>
                <span v-else>-</span>
              </template>
            </el-table-column>
            <el-table-column label="创建时间" align="center" prop="createdAt" width="170">
              <template #default="scope">
                <span>{{ parseTime(scope.row.createdAt) }}</span>
              </template>
            </el-table-column>
            <el-table-column label="操作" align="center" width="160" class-name="small-padding fixed-width">
              <template #default="scope">
                <el-button link type="primary" icon="Edit" @click="handleUpdateWord(scope.row)">修改</el-button>
                <el-button link type="primary" icon="Delete" @click="handleDeleteWord(scope.row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>

          <pagination
            v-show="total > 0"
            :total="total"
            v-model:page="queryParams.pageNum"
            v-model:limit="queryParams.pageSize"
            @pagination="getWordList"
          />

          <el-dialog title="修改单词" v-model="editOpen" width="640px" append-to-body>
            <el-form ref="editFormRef" :model="editForm" :rules="editRules" label-width="110px">
              <el-form-item label="英文单词" prop="wordText">
                <el-input v-model="editForm.wordText" placeholder="请输入英文单词" maxlength="100" />
              </el-form-item>
              <el-form-item label="音标" prop="phonetic">
                <el-input v-model="editForm.phonetic" placeholder="请输入音标" maxlength="100" />
              </el-form-item>
              <el-form-item label="正确释义" prop="correctMeaning">
                <el-input v-model="editForm.correctMeaning" placeholder="请输入正确中文释义" maxlength="100" />
              </el-form-item>
              <el-form-item label="错误释义1" prop="wrong1">
                <el-input v-model="editForm.wrong1" placeholder="请输入错误中文释义" maxlength="100" />
              </el-form-item>
              <el-form-item label="错误释义2" prop="wrong2">
                <el-input v-model="editForm.wrong2" placeholder="请输入错误中文释义" maxlength="100" />
              </el-form-item>
              <el-form-item label="错误释义3" prop="wrong3">
                <el-input v-model="editForm.wrong3" placeholder="请输入错误中文释义" maxlength="100" />
              </el-form-item>
              <el-form-item label="英文例句" prop="exampleSentence">
                <el-input v-model="editForm.exampleSentence" type="textarea" :rows="2" placeholder="请输入英文例句" maxlength="500" show-word-limit />
              </el-form-item>
              <el-form-item label="例句翻译" prop="exampleTranslation">
                <el-input v-model="editForm.exampleTranslation" type="textarea" :rows="2" placeholder="请输入例句中文翻译" maxlength="500" show-word-limit />
              </el-form-item>
            </el-form>
            <template #footer>
              <div class="dialog-footer">
                <el-button type="primary" :loading="editSubmitLoading" @click="submitEditForm">确定</el-button>
                <el-button @click="cancelEdit">取消</el-button>
              </div>
            </template>
          </el-dialog>
        </el-tab-pane>

        <el-tab-pane label="添加单词" name="import">
          <el-form ref="formRef" :model="form" :rules="rules" label-width="110px">
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
              <el-button @click="resetImportForm">重置</el-button>
            </el-form-item>
          </el-form>

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
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script setup name="WordManage">
import { listWordBookByPage, importWords, listWordsByBookPage } from '@/api/wordBook'
import { updateWord, deleteWord } from '@/api/word'

const { proxy } = getCurrentInstance()
const route = useRoute()
const router = useRouter()

const activeTab = ref(route.query.tab === 'import' ? 'import' : 'list')
const selectedBookId = ref(undefined)
const bookOptions = ref([])
const bookLoading = ref(false)

const showSearch = ref(true)
const listLoading = ref(false)
const wordList = ref([])
const total = ref(0)
const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  wordText: undefined,
  unitName: undefined,
  sortField: 'sortOrder',
  sortOrder: 'ascend'
})

const submitLoading = ref(false)
const importResult = ref(null)

const editOpen = ref(false)
const editSubmitLoading = ref(false)
const editForm = ref({
  id: undefined,
  wordText: '',
  phonetic: '',
  correctMeaning: '',
  wrong1: '',
  wrong2: '',
  wrong3: '',
  exampleSentence: '',
  exampleTranslation: ''
})
const editRules = {
  wordText: [{ required: true, message: '英文单词不能为空', trigger: 'blur' }],
  phonetic: [{ required: true, message: '音标不能为空', trigger: 'blur' }],
  correctMeaning: [{ required: true, message: '正确释义不能为空', trigger: 'blur' }],
  wrong1: [{ required: true, message: '错误释义不能为空', trigger: 'blur' }],
  wrong2: [{ required: true, message: '错误释义不能为空', trigger: 'blur' }],
  wrong3: [{ required: true, message: '错误释义不能为空', trigger: 'blur' }],
  exampleSentence: [{ required: true, message: '英文例句不能为空', trigger: 'blur' }],
  exampleTranslation: [{ required: true, message: '例句翻译不能为空', trigger: 'blur' }]
}

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
  unitName: '',
  words: [createEmptyWord()]
})

const rules = {}

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

function ensureBookSelected() {
  if (!selectedBookId.value) {
    proxy.$modal.msgWarning('请先选择词书')
    return false
  }
  return true
}

function getWordList() {
  if (!selectedBookId.value) {
    wordList.value = []
    total.value = 0
    return
  }
  listLoading.value = true
  listWordsByBookPage(selectedBookId.value, {
    pageNum: queryParams.value.pageNum,
    pageSize: queryParams.value.pageSize,
    wordText: queryParams.value.wordText || undefined,
    unitName: queryParams.value.unitName || undefined,
    sortField: queryParams.value.sortField,
    sortOrder: queryParams.value.sortOrder
  }).then(res => {
    const page = res.data || {}
    wordList.value = page.records || []
    total.value = Number(page.totalRow || 0)
  }).finally(() => {
    listLoading.value = false
  })
}

function handleQuery() {
  if (!ensureBookSelected()) return
  queryParams.value.pageNum = 1
  getWordList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  queryParams.value.pageNum = 1
  getWordList()
}

function handleBookChange() {
  queryParams.value.pageNum = 1
  importResult.value = null
  if (activeTab.value === 'list') {
    getWordList()
  }
}

function handleTabChange(name) {
  if (name === 'list' && selectedBookId.value) {
    getWordList()
  }
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

function resetImportForm() {
  form.value = {
    unitName: '',
    words: [createEmptyWord()]
  }
  importResult.value = null
  proxy.resetForm('formRef')
}

function submitForm() {
  if (!ensureBookSelected()) return
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
    importWords(selectedBookId.value, {
      unitName: form.value.unitName || undefined,
      words
    }).then(res => {
      importResult.value = res.data || {}
      const successCount = importResult.value.successCount || 0
      const failCount = importResult.value.failCount || 0
      if (failCount > 0) {
        proxy.$modal.msgWarning(`导入完成：成功 ${successCount} 条，失败 ${failCount} 条`)
      } else {
        proxy.$modal.msgSuccess(`导入成功，共 ${successCount} 条`)
        resetImportForm()
      }
      // 导入后刷新列表
      getWordList()
    }).finally(() => {
      submitLoading.value = false
    })
  })
}

function handleUpdateWord(row) {
  const wrongList = (row.options || [])
    .filter(opt => opt && opt.isCorrect !== 1)
    .map(opt => opt.optionText)
    .filter(Boolean)
  editForm.value = {
    id: row.id,
    wordText: row.wordText || '',
    phonetic: row.phonetic || '',
    correctMeaning: row.correctMeaning || '',
    wrong1: wrongList[0] || '',
    wrong2: wrongList[1] || '',
    wrong3: wrongList[2] || '',
    exampleSentence: row.exampleSentence || '',
    exampleTranslation: row.exampleTranslation || ''
  }
  editOpen.value = true
}

function handleDeleteWord(row) {
  const wordText = row.wordText || row.id
  proxy.$modal.confirm('是否确认删除单词「' + wordText + '」？删除后不可恢复。').then(() => {
    return deleteWord(row.id)
  }).then(() => {
    proxy.$modal.msgSuccess('删除成功')
    getWordList()
  }).catch(() => {})
}

function cancelEdit() {
  editOpen.value = false
  editForm.value = {
    id: undefined,
    wordText: '',
    phonetic: '',
    correctMeaning: '',
    wrong1: '',
    wrong2: '',
    wrong3: '',
    exampleSentence: '',
    exampleTranslation: ''
  }
  proxy.resetForm('editFormRef')
}

function submitEditForm() {
  proxy.$refs.editFormRef.validate(valid => {
    if (!valid) return
    editSubmitLoading.value = true
    updateWord({
      id: editForm.value.id,
      wordText: editForm.value.wordText,
      phonetic: editForm.value.phonetic,
      correctMeaning: editForm.value.correctMeaning,
      wrongMeanings: [editForm.value.wrong1, editForm.value.wrong2, editForm.value.wrong3],
      exampleSentence: editForm.value.exampleSentence,
      exampleTranslation: editForm.value.exampleTranslation
    }).then(() => {
      proxy.$modal.msgSuccess('修改成功')
      editOpen.value = false
      getWordList()
    }).finally(() => {
      editSubmitLoading.value = false
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
    selectedBookId.value = Number(route.query.bookId)
  }
  if (route.query.tab === 'import') {
    activeTab.value = 'import'
  }
  if (selectedBookId.value && activeTab.value === 'list') {
    getWordList()
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

.book-select-form {
  margin-bottom: 8px;
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
  margin-top: 16px;
  max-width: 960px;
}

.option-tag {
  margin: 2px 4px;
}
</style>
