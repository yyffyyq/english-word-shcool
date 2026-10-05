// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 班级详情 查询班级详情（含在班学生数）。教师仅可查看自己的班级，管理员可查看全部。 GET /classInfo/${param0} */
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

/** 刷新班级邀请码 教师刷新自己班级的邀请码：删除 Redis 旧码并写入新码缓存。 POST /classInfo/${param0}/refresh-invite */
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

/** 班级学生列表 返回当前在班学生列表。教师仅可查看自己的班级，管理员可查看全部。 GET /classInfo/${param0}/students */
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

/** 创建班级 教师创建班级，系统生成邀请码。需教师登录态。 POST /classInfo/add */
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

/** 学生加入班级 学生通过邀请码加入班级：优先读 Redis 邀请码缓存，未命中则查库并回写缓存。入班成功后会补发当日已分配的学习计划。需学生登录态。 POST /classInfo/add/student */
export async function studentJoinClass(
  body: API.ClassStudentAddStudentRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseString>("/classInfo/add/student", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 班级分页查询 教师仅看自己创建的班级，学生仅看已加入班级，管理员可查看全部并筛选。 POST /classInfo/list/page/vo */
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
