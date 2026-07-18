// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 GET /classInfo/${param0} */
export async function getClassInfo(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.getClassInfoParams,
  options?: { [key: string]: any }
) {
  const { id: param0, ...queryParams } = params;
  return request<API.BaseResponseClassInfoVO>(`/classInfo/${param0}`, {
    method: "GET",
    params: { ...queryParams },
    ...(options || {}),
  });
}

/** 此处后端没有提供注释 POST /classInfo/${param0}/refresh-invite */
export async function refreshInviteCode(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.refreshInviteCodeParams,
  options?: { [key: string]: any }
) {
  const { id: param0, ...queryParams } = params;
  return request<API.BaseResponseClassInfoVO>(
    `/classInfo/${param0}/refresh-invite`,
    {
      method: "POST",
      params: { ...queryParams },
      ...(options || {}),
    }
  );
}

/** 此处后端没有提供注释 GET /classInfo/${param0}/students */
export async function listClassStudents(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.listClassStudentsParams,
  options?: { [key: string]: any }
) {
  const { id: param0, ...queryParams } = params;
  return request<API.BaseResponseListClassStudentVO>(
    `/classInfo/${param0}/students`,
    {
      method: "GET",
      params: { ...queryParams },
      ...(options || {}),
    }
  );
}

/** 此处后端没有提供注释 POST /classInfo/add */
export async function addClassInfo(
  body: API.ClassInfoAddRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseClassInfoVO>("/classInfo/add", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 此处后端没有提供注释 POST /classInfo/list/page/vo */
export async function listClassInfoByPage(
  body: API.ClassInfoQueryRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponsePageClassInfoVO>("/classInfo/list/page/vo", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}
