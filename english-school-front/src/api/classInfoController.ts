// @ts-ignore
/* eslint-disable */
import request from "@/request";

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
