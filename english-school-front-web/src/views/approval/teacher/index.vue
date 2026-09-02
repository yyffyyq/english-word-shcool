<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="姓名" prop="realName">
        <el-input
          v-model="queryParams.realName"
          placeholder="请输入姓名"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学校" prop="schoolName">
        <el-input
          v-model="queryParams.schoolName"
          placeholder="请输入学校名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="审批状态" clearable style="width: 160px">
          <el-option label="待审批" value="PENDING" />
          <el-option label="已通过" value="APPROVED" />
          <el-option label="已拒绝" value="REJECTED" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="approvalList">
      <el-table-column label="ID" align="center" prop="id" width="80" />
      <el-table-column label="姓名" align="center" prop="realName" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="学校" align="center" prop="schoolName" min-width="160" :show-overflow-tooltip="true" />
      <el-table-column label="状态" align="center" prop="status" width="110">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 'PENDING'" type="warning">待审批</el-tag>
          <el-tag v-else-if="scope.row.status === 'APPROVED'" type="success">已通过</el-tag>
          <el-tag v-else-if="scope.row.status === 'REJECTED'" type="danger">已拒绝</el-tag>
          <el-tag v-else>{{ scope.row.status || '-' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="拒绝原因" align="center" prop="rejectReason" min-width="160" :show-overflow-tooltip="true">
        <template #default="scope">
          <span>{{ scope.row.rejectReason || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请时间" align="center" prop="createdAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createdAt) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审批时间" align="center" prop="approvedAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.approvedAt) || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
        <template #default="scope">
          <template v-if="scope.row.status === 'PENDING'">
            <el-button link type="primary" icon="Check" @click="handleApprove(scope.row)">通过</el-button>
            <el-button link type="danger" icon="Close" @click="handleReject(scope.row)">不通过</el-button>
          </template>
          <span v-else>-</span>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog title="拒绝申请" v-model="rejectOpen" width="480px" append-to-body>
      <el-form ref="rejectFormRef" :model="rejectForm" :rules="rejectRules" label-width="90px">
        <el-form-item label="申请人">
          <span>{{ rejectForm.realName || '-' }}</span>
        </el-form-item>
        <el-form-item label="拒绝原因" prop="rejectReason">
          <el-input
            v-model="rejectForm.rejectReason"
            type="textarea"
            :rows="3"
            placeholder="请输入拒绝原因"
            maxlength="200"
            show-word-limit
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" :loading="submitLoading" @click="submitReject">确定</el-button>
          <el-button @click="rejectOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="TeacherApproval">
import { listTeacherApprovalByPage, auditTeacherApproval } from '@/api/teacherApproval'
import useUserStore from '@/store/modules/user'

const { proxy } = getCurrentInstance()
const userStore = useUserStore()

const approvalList = ref([])
const loading = ref(false)
const showSearch = ref(true)
const total = ref(0)
const submitLoading = ref(false)
const rejectOpen = ref(false)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  realName: undefined,
  schoolName: undefined,
  status: undefined,
  sortField: 'createdAt',
  sortOrder: 'descend'
})

const rejectForm = ref({
  id: undefined,
  realName: '',
  rejectReason: ''
})

const rejectRules = {
  rejectReason: [{ required: true, message: '拒绝原因不能为空', trigger: 'blur' }]
}

function getApprovedBy() {
  const id = userStore.loginUser?.id
  if (id === undefined || id === null || id === '') {
    proxy.$modal.msgError('未获取到当前管理员信息，请重新登录')
    return null
  }
  return Number(id)
}

function getList() {
  loading.value = true
  listTeacherApprovalByPage(queryParams.value).then(res => {
    const page = res.data || {}
    approvalList.value = page.records || []
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

function handleApprove(row) {
  const approvedBy = getApprovedBy()
  if (approvedBy === null) return
  proxy.$modal.confirm('是否确认通过「' + (row.realName || row.id) + '」的教师注册申请？').then(() => {
    return auditTeacherApproval({
      id: row.id,
      status: 'APPROVED',
      approvedBy
    })
  }).then(() => {
    proxy.$modal.msgSuccess('审批通过')
    getList()
  }).catch(() => {})
}

function handleReject(row) {
  rejectForm.value = {
    id: row.id,
    realName: row.realName || '',
    rejectReason: ''
  }
  rejectOpen.value = true
}

function submitReject() {
  proxy.$refs.rejectFormRef.validate(valid => {
    if (!valid) return
    const approvedBy = getApprovedBy()
    if (approvedBy === null) return
    submitLoading.value = true
    auditTeacherApproval({
      id: rejectForm.value.id,
      status: 'REJECTED',
      rejectReason: rejectForm.value.rejectReason,
      approvedBy
    }).then(() => {
      proxy.$modal.msgSuccess('已拒绝该申请')
      rejectOpen.value = false
      getList()
    }).finally(() => {
      submitLoading.value = false
    })
  })
}

getList()
</script>
