// @ts-ignore
/* eslint-disable */
import request from "@/request";

/** 此处后端没有提供注释 POST /classDailyAssignment/run */
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
