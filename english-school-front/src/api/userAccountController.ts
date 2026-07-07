// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 POST /userAccount/login */
export async function loginUser(
  body: API.UserAccountLoginRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseUserAccountVO>("/userAccount/login", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}
