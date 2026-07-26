// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 DELETE /word/${param0} */
export async function deleteWord(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.deleteWordParams,
  options?: { [key: string]: any }
) {
  const { id: param0, ...queryParams } = params;
  return request<API.BaseResponseBoolean>(`/word/${param0}`, {
    method: "DELETE",
    params: { ...queryParams },
    ...(options || {}),
  });
}

/** 此处后端没有提供注释 PUT /word/update */
export async function updateWord(
  body: API.WordUpdateRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseWordVO>("/word/update", {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}
