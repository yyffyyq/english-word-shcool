// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 DELETE /wordBook/${param0} */
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

/** 此处后端没有提供注释 POST /wordBook/${param0}/words/import */
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

/** 此处后端没有提供注释 POST /wordBook/${param0}/words/list/page/vo */
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

/** 此处后端没有提供注释 POST /wordBook/add */
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

/** 此处后端没有提供注释 POST /wordBook/list/page/vo */
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

/** 此处后端没有提供注释 PUT /wordBook/update */
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
