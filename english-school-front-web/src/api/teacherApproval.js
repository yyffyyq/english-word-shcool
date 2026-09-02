import request from '@/utils/request'

// POST /teacherApproval/list/page/vo
export function listTeacherApprovalByPage(data) {
  return request({
    url: '/teacherApproval/list/page/vo',
    method: 'post',
    data: data
  })
}

// POST /teacherApproval/audit
export function auditTeacherApproval(data) {
  return request({
    url: '/teacherApproval/audit',
    method: 'post',
    data: data
  })
}
