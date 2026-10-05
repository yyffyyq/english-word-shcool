// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 手动触发每日单词分配 管理员按指定学习日（默认今天）为每个在班学生生成当日计划：已掌握则发新词，未完成则结转后补足每日额度。系统定时任务每天 02:00 也会执行。 POST /classDailyAssignment/run */
export async function runAssign(
  body: API.ClassDailyAssignmentRunRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseClassDailyAssignmentRunResultVO>(
    "/classDailyAssignment/run",
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

/** 按周次单元分配今日学习计划 选择班级、词书、week、unitName，将该单元全部单词只追加到该班级在班学生的今日学习计划。已在今日计划中的单词不重复写入。已掌握的单词会改回 LEARNING，以便出现在今日作业中。 POST /classDailyAssignment/unit */
export async function assignUnitPlan(
  body: API.ClassUnitPlanAssignRequest,
  options?: { [key: string]: any }
) {
  return request<API.BaseResponseClassUnitPlanAssignResultVO>(
    "/classDailyAssignment/unit",
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
