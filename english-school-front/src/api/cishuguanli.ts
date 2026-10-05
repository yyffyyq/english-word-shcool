// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 删除词书（软删除） 将词书状态置为 DISABLED，不物理删除。 DELETE /wordBook/${param0} */
export async function deleteWordBook(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.deleteWordBookParams,
  options?: { [key: string]: any }
) {
  const { id: param0, ...queryParams } = params;
  return request<API.BaseResponseBoolean>(`/wordBook/${param0}`, {
    method: "DELETE",
    params: { ...queryParams },
    ...(options || {}),
  });
}

/** 批量导入词书单词 手工录入英文、音标、正确中文、3 个错误中文、例句及翻译；可带整数 week、unitName。正确项写入 word_option.is_correct=1。 POST /wordBook/${param0}/words/import */
export async function importWords(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.importWordsParams,
  body: API.WordBookImportRequest,
  options?: { [key: string]: any }
) {
  const { bookId: param0, ...queryParams } = params;
  return request<API.BaseResponseWordBookImportResultVO>(
    `/wordBook/${param0}/words/import`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      params: { ...queryParams },
      data: body,
      ...(options || {}),
    }
  );
}

/** 词书内单词分页查询 按词书 ID 分页查询关联单词，支持按英文、整数周次、整数单元筛选；默认按 week、unitName、sortOrder 升序。 POST /wordBook/${param0}/words/list/page/vo */
export async function listWordsByBookPage(
  // 叠加生成的Param类型 (非body参数swagger默认没有生成对象)
  params: API.listWordsByBookPageParams,
  body: API.WordBookWordQueryRequest,
  options?: { [key: string]: any }
) {
  const { bookId: param0, ...queryParams } = params;
  return request<API.BaseResponsePageWordVO>(
    `/wordBook/${param0}/words/list/page/vo`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      params: { ...queryParams },
      data: body,
      ...(options || {}),
    }
  );
}

/** 创建词书 教师/管理员创建词书，可填写名称、说明、封面。 POST /wordBook/add */
export async function addWordBook(
  body: API.WordBookAddRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseWordBookVO>("/wordBook/add", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 词书分页查询 教师/管理员分页查询词书，支持按名称、状态筛选。 POST /wordBook/list/page/vo */
export async function listWordBookByPage(
  body: API.WordBookQueryRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponsePageWordBookVO>("/wordBook/list/page/vo", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** 修改词书 教师/管理员修改词书名称、说明、封面、状态。 PUT /wordBook/update */
export async function updateWordBook(
  body: API.WordBookUpdateRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseWordBookVO>("/wordBook/update", {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}
