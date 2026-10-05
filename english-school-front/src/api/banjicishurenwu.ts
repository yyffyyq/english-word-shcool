// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 解除班级词书绑定 将任务状态置为 STOPPED（软解除，保留历史记录）。 DELETE /classWordTask/${param0} */
export async function unbindClassWordBook(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.unbindClassWordBookParams,
  options?: { [key: string]: any }
) {
  const { id: param0, ...queryParams } = params;
  return request<API.BaseResponseBoolean>(`/classWordTask/${param0}`, {
    method: "DELETE",
    params: { ...queryParams },
    ...(options || {}),
  });
}

/** 班级绑定词书 为班级创建生效中的词书学习任务，可配置每日新学数量与起止日期；已 STOPPED 可重新激活。 POST /classWordTask/bind */
export async function bindClassWordBook(
  body: API.ClassWordTaskBindRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseClassWordTaskVO>("/classWordTask/bind", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 班级词书任务分页查询 教师仅查自己创建的任务，管理员可查全部；支持按班级、词书、状态、创建人筛选。 POST /classWordTask/list/page/vo */
export async function listClassWordTaskByPage(
  body: API.ClassWordTaskQueryRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponsePageClassWordTaskVO>(
    "/classWordTask/list/page/vo",
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
