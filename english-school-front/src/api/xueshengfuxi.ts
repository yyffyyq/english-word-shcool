// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 复习四选一做题 判分并写入 answer_record（REVIEW/CHOICE）；答对推进艾宾浩斯，答错次日再复。 POST /studentReview/answer/choice */
export async function answerChoice1(
  body: API.StudentReviewChoiceAnswerRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseStudentAnswerResultVO>(
    "/studentReview/answer/choice",
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

/** 复习拼写做题 拼写判分并写入 answer_record（REVIEW/SPELL）；答对推进艾宾浩斯，答错次日再复。 POST /studentReview/answer/spell */
export async function answerSpell1(
  body: API.StudentReviewSpellAnswerRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseStudentAnswerResultVO>(
    "/studentReview/answer/spell",
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

/** 手动生成复习计划 管理员按复习日生成清单（默认今天）：高频错题>次日必复>艾宾浩斯到期。系统定时任务每天 04:00 也会执行。 POST /studentReview/plan/run */
export async function runPlan(
  body: API.StudentReviewPlanRunRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseStudentReviewPlanRunResultVO>(
    "/studentReview/plan/run",
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

/** 获取今日复习词表 优先读 Redis（student.review.list），未命中回源；返回 PENDING 复习词及 reason（高频错题/次日必复/艾宾浩斯）。 GET /studentReview/today */
export async function getTodayReview(options?: { [key: string]: any }) {
  return request<API.BaseResponseStudentReviewCacheVO>("/studentReview/today", {
    method: "GET",
    ...(options || {}),
  });
}
