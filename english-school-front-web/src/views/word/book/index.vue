<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="词书名称" prop="bookName">
        <el-input v-model="queryParams.bookName" placeholder="请输入词书名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="词书状态" clearable style="width: 160px">
          <el-option label="启用" value="ACTIVE" />
          <el-option label="停用" value="DISABLED" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd">添加单词本</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="bookList">
      <el-table-column label="ID" align="center" prop="id" width="80" />
      <el-table-column label="封面" align="center" width="90">
        <template #default="scope">
          <el-image v-if="scope.row.coverUrl" :src="scope.row.coverUrl" :preview-src-list="[scope.row.coverUrl]" fit="cover" style="width: 48px; height: 48px; border-radius: 4px" />
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="词书名称" align="center" prop="bookName" :show-overflow-tooltip="true" min-width="140" />
      <el-table-column label="说明" align="center" prop="description" :show-overflow-tooltip="true" min-width="180" />
      <el-table-column label="单词数" align="center" prop="wordCount" width="90" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 'ACTIVE'" type="success">启用</el-tag>
          <el-tag v-else-if="scope.row.status === 'DISABLED'" type="info">停用</el-tag>
          <el-tag v-else>{{ scope.row.status || '-' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180">
        <template #default="scope"><span>{{ parseTime(scope.row.createdAt) }}</span></template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updatedAt" width="180">
        <template #default="scope"><span>{{ parseTime(scope.row.updatedAt) }}</span></template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="240" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Plus" @click="goAddWords(scope.row)">添加单词</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="titleType === 'create' ? '添加单词本' : '修改单词本'" v-model="open" width="520px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="词书名称" prop="bookName">
          <el-input v-model="form.bookName" placeholder="请输入词书名称" maxlength="50" show-word-limit />
        </el-form-item>
        <el-form-item label="说明" prop="description">
          <el-input v-model="form.description" type="textarea" :rows="3" placeholder="请输入词书说明" maxlength="200" show-word-limit />
        </el-form-item>
        <el-form-item label="封面地址" prop="coverUrl">
          <el-input v-model="form.coverUrl" placeholder="请输入封面图片 URL" maxlength="500" />
        </el-form-item>
        <el-form-item v-if="titleType === 'edit'" label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="ACTIVE">启用</el-radio>
            <el-radio label="DISABLED">停用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" :loading="submitLoading" @click="submitForm">确定</el-button>
          <el-button @click="cancel">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="WordBook">
import { listWordBookByPage, addWordBook, updateWordBook, deleteWordBook } from '@/api/wordBook'

const { proxy } = getCurrentInstance()
const router = useRouter()

const bookList = ref([])
const loading = ref(false)
const showSearch = ref(true)
const total = ref(0)
const open = ref(false)
const submitLoading = ref(false)
const titleType = ref('create')

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  bookName: undefined,
  status: undefined,
  sortField: 'createdAt',
  sortOrder: 'descend'
})

const form = ref({
  id: undefined,
  bookName: '',
  description: '',
  coverUrl: '',
  status: 'ACTIVE'
})

const rules = {
  bookName: [{ required: true, message: '词书名称不能为空', trigger: 'blur' }]
}

function getList() {
  loading.value = true
  listWordBookByPage(queryParams.value).then(res => {
    const page = res.data || {}
    bookList.value = page.records || []
    total.value = Number(page.totalRow || 0)
  }).finally(() => {
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  handleQuery()
}

function resetForm() {
  form.value = {
    id: undefined,
    bookName: '',
    description: '',
    coverUrl: '',
    status: 'ACTIVE'
  }
  proxy.resetForm('formRef')
}

function handleAdd() {
  resetForm()
  titleType.value = 'create'
  open.value = true
}

function goAddWords(row) {
  router.push({ path: '/word/manage', query: { bookId: row.id } })
}

function handleUpdate(row) {
  resetForm()
  titleType.value = 'edit'
  form.value = {
    id: row.id,
    bookName: row.bookName || '',
    description: row.description || '',
    coverUrl: row.coverUrl || '',
    status: row.status || 'ACTIVE'
  }
  open.value = true
}

function cancel() {
  open.value = false
  resetForm()
}

function submitForm() {
  proxy.$refs.formRef.validate(valid => {
    if (!valid) return
    submitLoading.value = true
    const payload = {
      bookName: form.value.bookName,
      description: form.value.description || undefined,
      coverUrl: form.value.coverUrl || undefined
    }
    const req = titleType.value === 'create'
      ? addWordBook(payload)
      : updateWordBook({ ...payload, id: form.value.id, status: form.value.status })
    req.then(() => {
      proxy.$modal.msgSuccess(titleType.value === 'create' ? '新增成功' : '修改成功')
      open.value = false
      getList()
    }).finally(() => {
      submitLoading.value = false
    })
  })
}

function handleDelete(row) {
  const bookName = row.bookName || row.id
  proxy.$modal.confirm('是否确认删除词书「' + bookName + '」？删除后将置为停用状态。').then(() => {
    return deleteWordBook(row.id)
  }).then(() => {
    proxy.$modal.msgSuccess('删除成功')
    getList()
  }).catch(() => {})
}

getList()
</script>
