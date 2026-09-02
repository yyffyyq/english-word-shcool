// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 POST /studentStudy/answer/choice */
export async function answerChoice(
  body: API.StudentChoiceAnswerRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseStudentAnswerResultVO>(
    "/studentStudy/answer/choice",
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

/** 此处后端没有提供注释 POST /studentStudy/answer/spell */
export async function answerSpell(
  body: API.StudentSpellAnswerRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseStudentAnswerResultVO>(
    "/studentStudy/answer/spell",
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

/** 此处后端没有提供注释 GET /studentStudy/homework/today */
export async function getTodayHomework(options?: { [key: string]: any }) {
  return request<API.BaseResponseStudentHomeworkCacheVO>(
    "/studentStudy/homework/today",
    {
      method: "GET",
      ...(options || {}),
    }
  );
}

/** 此处后端没有提供注释 PUT /studentStudy/progress/status */
export async function updateWordStatus(
  body: API.StudentWordStatusUpdateRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseBoolean>("/studentStudy/progress/status", {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    data: body,
    ...(options || {}),
  });
}
