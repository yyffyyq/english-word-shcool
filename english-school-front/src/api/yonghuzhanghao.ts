// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 微信一键登录 小程序通过 code + 登录角色登录。优先读 Redis 会话，未命中再查库；未注册时返回仅含 openid 的 VO。学生登录成功后会缓存已加入班级 ID，并刷新今日作业/复习词表缓存。 POST /userAccount/login */
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

/** 学生注册 小程序提交 openid、姓名、学号等，校验通过后直接写入 user_account；学生注册无需审批。 POST /userAccount/register/student */
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

/** 教师注册申请 小程序提交教师注册信息，写入 teacher_approval 待审批记录；审批通过前不创建 user_account。 POST /userAccount/register/teacher */
export async function registerTeacher(
  body: API.UserAccountTeacherRegisterRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseTeacherApprovalVO>(
    "/userAccount/register/teacher",
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

/** Web 管理端登录 校验管理员账号与密码（MD5 加盐后与 password_hash 比对），登录成功后将会话写入 Redis：system.user.login.ids:{userId}。后续请求头携带 userId。 POST /userAccount/system/login */
export async function systemLogin(
  body: API.SystemLoginRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseUserAccountVO>("/userAccount/system/login", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}

/** Web 管理端注册管理员 创建管理员账号：密码使用固定盐值 MD5 加密后写入 password_hash，角色默认 ADMIN。 POST /userAccount/system/register */
export async function systemRegister(
  body: API.SystemRegisterRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseUserAccountVO>(
    "/userAccount/system/register",
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
