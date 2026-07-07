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

/** 此处后端没有提供注释 POST /userAccount/register/student */
export async function registerStudent(
  body: API.UserAccountStudentRegisterRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseUserAccountVO>(
    "/userAccount/register/student",
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

/** 此处后端没有提供注释 POST /userAccount/register/teacher */
export async function registerTeacher(options?: { [key: string]: any }) {
  return request<API.BaseResponseVoid>("/userAccount/register/teacher", {
    method: "POST",
    ...(options || {}),
  });
}
