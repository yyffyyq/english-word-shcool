// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 物理删除单词 物理删除单词及其选项、词书关联，并回写相关词书 word_count。 DELETE /word/${param0} */
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

/** 修改单词 可修改英文、音标、正确释义、错误选项、例句等；更新选项时需同时传入 3 个错误中文释义。 PUT /word/update */
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
