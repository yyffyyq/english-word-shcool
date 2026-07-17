// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 POST /teacherApproval/audit */
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

/** 此处后端没有提供注释 POST /teacherApproval/list/page/vo */
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
