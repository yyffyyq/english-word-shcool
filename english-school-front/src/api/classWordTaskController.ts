// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 DELETE /classWordTask/${param0} */
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

/** 此处后端没有提供注释 POST /classWordTask/bind */
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

/** 此处后端没有提供注释 POST /classWordTask/list/page/vo */
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
