// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 新词四选一做题 根据 optionId 判分，写入 answer_record（NEW/CHOICE），并更新学习进度（NEW→LEARNING）。 POST /studentStudy/answer/choice */
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

/** 新词拼写做题 比对拼写字符串与单词原文（忽略大小写），写入 answer_record（NEW/SPELL）并更新进度。 POST /studentStudy/answer/spell */
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

/** 获取今日新词作业 优先读 Redis（student.homework.list），未命中则回源 DB 并回写；返回词表与 wordCount。含英文、音标、释义及四选一选项（不含答案标记）。 GET /studentStudy/homework/today */
export async function getTodayHomework(options?: { [key: string]: any }) {
  return request<API.BaseResponseStudentHomeworkCacheVO>(
    "/studentStudy/homework/today",
    {
      method: "GET",
      ...(options || {}),
    }
  );
}

/** 修改单词学习状态 可将状态改为 LEARNING 或 MASTERED；置为 MASTERED 后会刷新今日作业 Redis 缓存。 PUT /studentStudy/progress/status */
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
