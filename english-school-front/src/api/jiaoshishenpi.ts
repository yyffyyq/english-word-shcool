// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 审核教师注册申请 管理员审批教师注册：通过后创建教师账号，拒绝则记录拒绝原因。需管理员登录态。 POST /teacherApproval/audit */
export async function auditTeacherApproval(
  body: API.TeacherApprovalAuditRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseTeacherApprovalVO>("/teacherApproval/audit", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 教师审批分页查询 支持按审批状态、姓名、学校名称筛选，返回分页后的教师审批记录。 POST /teacherApproval/list/page/vo */
export async function listTeacherApprovalByPage(
  body: API.TeacherApprovalQueryRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponsePageTeacherApprovalVO>(
    "/teacherApproval/list/page/vo",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      data: body,
      ...(options || {}),
    }
  );
}
