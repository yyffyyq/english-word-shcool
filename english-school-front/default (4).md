# 英语单词学堂 API 文档


**简介**:英语单词学堂 API 文档


**HOST**:http://localhost:8081/api


**联系人**:yfy


**Version**:1.0.0


**接口路径**:/api/v3/api-docs/default


[TOC]






# 单词管理


## 修改单词


**接口地址**:`/api/word/update`


**请求方式**:`PUT`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>可修改英文、音标、正确释义、错误选项、例句等；更新选项时需同时传入 3 个错误中文释义。</p>



**请求示例**:


```javascript
{
  "id": 0,
  "wordText": "",
  "phonetic": "",
  "correctMeaning": "",
  "wrongMeanings": [],
  "exampleSentence": "",
  "exampleTranslation": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|wordUpdateRequest|WordUpdateRequest|body|true|WordUpdateRequest|WordUpdateRequest|
|&emsp;&emsp;id|||false|integer(int64)||
|&emsp;&emsp;wordText|||false|string||
|&emsp;&emsp;phonetic|||false|string||
|&emsp;&emsp;correctMeaning|||false|string||
|&emsp;&emsp;wrongMeanings|||false|array|string|
|&emsp;&emsp;exampleSentence|||false|string||
|&emsp;&emsp;exampleTranslation|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseWordVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||WordVO|WordVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;wordText||string||
|&emsp;&emsp;phonetic||string||
|&emsp;&emsp;correctMeaning||string||
|&emsp;&emsp;exampleSentence||string||
|&emsp;&emsp;exampleTranslation||string||
|&emsp;&emsp;week||integer(int32)||
|&emsp;&emsp;unitName||integer(int32)||
|&emsp;&emsp;sortOrder||integer(int32)||
|&emsp;&emsp;options||array|WordOptionVO|
|&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;optionText||string||
|&emsp;&emsp;&emsp;&emsp;isCorrect||integer||
|&emsp;&emsp;&emsp;&emsp;sortOrder||integer||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;updatedAt||string(date-time)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"wordText": "",
		"phonetic": "",
		"correctMeaning": "",
		"exampleSentence": "",
		"exampleTranslation": "",
		"week": 0,
		"unitName": 0,
		"sortOrder": 0,
		"options": [
			{
				"id": 0,
				"optionText": "",
				"isCorrect": 0,
				"sortOrder": 0
			}
		],
		"createdAt": "",
		"updatedAt": ""
	},
	"message": ""
}
```


## 物理删除单词


**接口地址**:`/api/word/{id}`


**请求方式**:`DELETE`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>物理删除单词及其选项、词书关联，并回写相关词书 word_count。</p>



**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|id|单词ID|path|true|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseBoolean|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": true,
	"message": ""
}
```


# 班级词书任务


## 班级词书任务分页查询


**接口地址**:`/api/classWordTask/list/page/vo`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>教师仅查自己创建的任务，管理员可查全部；支持按班级、词书、状态、创建人筛选。</p>



**请求示例**:


```javascript
{
  "pageNum": 0,
  "pageSize": 0,
  "sortField": "",
  "sortOrder": "",
  "classId": 0,
  "bookId": 0,
  "status": "",
  "createdBy": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|classWordTaskQueryRequest|ClassWordTaskQueryRequest|body|true|ClassWordTaskQueryRequest|ClassWordTaskQueryRequest|
|&emsp;&emsp;pageNum|||false|integer(int32)||
|&emsp;&emsp;pageSize|||false|integer(int32)||
|&emsp;&emsp;sortField|||false|string||
|&emsp;&emsp;sortOrder|||false|string||
|&emsp;&emsp;classId|||false|integer(int64)||
|&emsp;&emsp;bookId|||false|integer(int64)||
|&emsp;&emsp;status|||false|string||
|&emsp;&emsp;createdBy|||false|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponsePageClassWordTaskVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||PageClassWordTaskVO|PageClassWordTaskVO|
|&emsp;&emsp;records||array|ClassWordTaskVO|
|&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;classId||integer||
|&emsp;&emsp;&emsp;&emsp;bookId||integer||
|&emsp;&emsp;&emsp;&emsp;dailyNewCount||integer||
|&emsp;&emsp;&emsp;&emsp;startDate||string||
|&emsp;&emsp;&emsp;&emsp;endDate||string||
|&emsp;&emsp;&emsp;&emsp;status||string||
|&emsp;&emsp;&emsp;&emsp;createdBy||integer||
|&emsp;&emsp;&emsp;&emsp;createdAt||string||
|&emsp;&emsp;&emsp;&emsp;updatedAt||string||
|&emsp;&emsp;pageNumber||integer(int64)||
|&emsp;&emsp;pageSize||integer(int64)||
|&emsp;&emsp;totalPage||integer(int64)||
|&emsp;&emsp;totalRow||integer(int64)||
|&emsp;&emsp;optimizeCountQuery||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"records": [
			{
				"id": 0,
				"classId": 0,
				"bookId": 0,
				"dailyNewCount": 0,
				"startDate": "",
				"endDate": "",
				"status": "",
				"createdBy": 0,
				"createdAt": "",
				"updatedAt": ""
			}
		],
		"pageNumber": 0,
		"pageSize": 0,
		"totalPage": 0,
		"totalRow": 0,
		"optimizeCountQuery": true
	},
	"message": ""
}
```


## 班级绑定词书


**接口地址**:`/api/classWordTask/bind`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>为班级创建生效中的词书学习任务，可配置每日新学数量与起止日期；已 STOPPED 可重新激活。</p>



**请求示例**:


```javascript
{
  "classId": 0,
  "bookId": 0,
  "dailyNewCount": 0,
  "startDate": "",
  "endDate": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|classWordTaskBindRequest|ClassWordTaskBindRequest|body|true|ClassWordTaskBindRequest|ClassWordTaskBindRequest|
|&emsp;&emsp;classId|||false|integer(int64)||
|&emsp;&emsp;bookId|||false|integer(int64)||
|&emsp;&emsp;dailyNewCount|||false|integer(int32)||
|&emsp;&emsp;startDate|||false|string(date)||
|&emsp;&emsp;endDate|||false|string(date)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseClassWordTaskVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||ClassWordTaskVO|ClassWordTaskVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;classId||integer(int64)||
|&emsp;&emsp;bookId||integer(int64)||
|&emsp;&emsp;dailyNewCount||integer(int32)||
|&emsp;&emsp;startDate||string(date)||
|&emsp;&emsp;endDate||string(date)||
|&emsp;&emsp;status||string||
|&emsp;&emsp;createdBy||integer(int64)||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;updatedAt||string(date-time)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"classId": 0,
		"bookId": 0,
		"dailyNewCount": 0,
		"startDate": "",
		"endDate": "",
		"status": "",
		"createdBy": 0,
		"createdAt": "",
		"updatedAt": ""
	},
	"message": ""
}
```


## 解除班级词书绑定


**接口地址**:`/api/classWordTask/{id}`


**请求方式**:`DELETE`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>将任务状态置为 STOPPED（软解除，保留历史记录）。</p>



**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|id|班级学习任务ID|path|true|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseBoolean|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": true,
	"message": ""
}
```


# 学生复习


## 手动生成复习计划


**接口地址**:`/api/studentReview/plan/run`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>管理员按复习日生成清单（默认今天）：高频错题&gt;次日必复&gt;艾宾浩斯到期。系统定时任务每天 04:00 也会执行。</p>



**请求示例**:


```javascript
{
  "reviewDate": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|studentReviewPlanRunRequest|StudentReviewPlanRunRequest|body|true|StudentReviewPlanRunRequest|StudentReviewPlanRunRequest|
|&emsp;&emsp;reviewDate|||false|string(date)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseStudentReviewPlanRunResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||StudentReviewPlanRunResultVO|StudentReviewPlanRunResultVO|
|&emsp;&emsp;reviewDate||string(date)||
|&emsp;&emsp;highWrongCount||integer(int32)||
|&emsp;&emsp;day1FollowupCount||integer(int32)||
|&emsp;&emsp;ebbinghausCount||integer(int32)||
|&emsp;&emsp;totalUpsertCount||integer(int32)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"reviewDate": "",
		"highWrongCount": 0,
		"day1FollowupCount": 0,
		"ebbinghausCount": 0,
		"totalUpsertCount": 0
	},
	"message": ""
}
```


## 复习拼写做题


**接口地址**:`/api/studentReview/answer/spell`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>拼写判分并写入 answer_record（REVIEW/SPELL）；答对推进艾宾浩斯，答错次日再复。</p>



**请求示例**:


```javascript
{
  "wordId": 0,
  "spelledText": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|studentReviewSpellAnswerRequest|StudentReviewSpellAnswerRequest|body|true|StudentReviewSpellAnswerRequest|StudentReviewSpellAnswerRequest|
|&emsp;&emsp;wordId|||false|integer(int64)||
|&emsp;&emsp;spelledText|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseStudentAnswerResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||StudentAnswerResultVO|StudentAnswerResultVO|
|&emsp;&emsp;correct||boolean||
|&emsp;&emsp;wordId||integer(int64)||
|&emsp;&emsp;correctAnswer||string||
|&emsp;&emsp;progressStatus||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"correct": true,
		"wordId": 0,
		"correctAnswer": "",
		"progressStatus": ""
	},
	"message": ""
}
```


## 复习四选一做题


**接口地址**:`/api/studentReview/answer/choice`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>判分并写入 answer_record（REVIEW/CHOICE）；答对推进艾宾浩斯，答错次日再复。</p>



**请求示例**:


```javascript
{
  "wordId": 0,
  "optionId": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|studentReviewChoiceAnswerRequest|StudentReviewChoiceAnswerRequest|body|true|StudentReviewChoiceAnswerRequest|StudentReviewChoiceAnswerRequest|
|&emsp;&emsp;wordId|||false|integer(int64)||
|&emsp;&emsp;optionId|||false|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseStudentAnswerResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||StudentAnswerResultVO|StudentAnswerResultVO|
|&emsp;&emsp;correct||boolean||
|&emsp;&emsp;wordId||integer(int64)||
|&emsp;&emsp;correctAnswer||string||
|&emsp;&emsp;progressStatus||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"correct": true,
		"wordId": 0,
		"correctAnswer": "",
		"progressStatus": ""
	},
	"message": ""
}
```


## 获取今日复习词表


**接口地址**:`/api/studentReview/today`


**请求方式**:`GET`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>优先读 Redis（student.review.list），未命中回源；返回 PENDING 复习词及 reason（高频错题/次日必复/艾宾浩斯）。</p>



**请求参数**:


暂无


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseStudentReviewCacheVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||StudentReviewCacheVO|StudentReviewCacheVO|
|&emsp;&emsp;studentId||integer(int64)||
|&emsp;&emsp;classId||integer(int64)||
|&emsp;&emsp;wordCount||integer(int32)||
|&emsp;&emsp;words||array|StudentReviewWordVO|
|&emsp;&emsp;&emsp;&emsp;wordId||integer||
|&emsp;&emsp;&emsp;&emsp;wordText||string||
|&emsp;&emsp;&emsp;&emsp;phonetic||string||
|&emsp;&emsp;&emsp;&emsp;correctMeaning||string||
|&emsp;&emsp;&emsp;&emsp;exampleSentence||string||
|&emsp;&emsp;&emsp;&emsp;exampleTranslation||string||
|&emsp;&emsp;&emsp;&emsp;reason||string||
|&emsp;&emsp;&emsp;&emsp;progressStatus||string||
|&emsp;&emsp;&emsp;&emsp;options||array|StudentStudyOptionVO|
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;optionText||string||
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;sortOrder||integer||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"studentId": 0,
		"classId": 0,
		"wordCount": 0,
		"words": [
			{
				"wordId": 0,
				"wordText": "",
				"phonetic": "",
				"correctMeaning": "",
				"exampleSentence": "",
				"exampleTranslation": "",
				"reason": "",
				"progressStatus": "",
				"options": [
					{
						"id": 0,
						"optionText": "",
						"sortOrder": 0
					}
				]
			}
		]
	},
	"message": ""
}
```


# 班级管理


## 刷新班级邀请码


**接口地址**:`/api/classInfo/{id}/refresh-invite`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>教师刷新自己班级的邀请码：删除 Redis 旧码并写入新码缓存。</p>



**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|id|班级ID|path|true|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseClassInfoVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||ClassInfoVO|ClassInfoVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;teacherId||integer(int64)||
|&emsp;&emsp;className||string||
|&emsp;&emsp;grade||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;inviteCode||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;updatedAt||string(date-time)||
|&emsp;&emsp;studentCount||integer(int64)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"teacherId": 0,
		"className": "",
		"grade": "",
		"schoolName": "",
		"inviteCode": "",
		"status": "",
		"createdAt": "",
		"updatedAt": "",
		"studentCount": 0
	},
	"message": ""
}
```


## 班级分页查询


**接口地址**:`/api/classInfo/list/page/vo`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>教师仅看自己创建的班级，学生仅看已加入班级，管理员可查看全部并筛选。</p>



**请求示例**:


```javascript
{
  "pageNum": 0,
  "pageSize": 0,
  "sortField": "",
  "sortOrder": "",
  "className": "",
  "grade": "",
  "schoolName": "",
  "status": "",
  "teacherId": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|classInfoQueryRequest|ClassInfoQueryRequest|body|true|ClassInfoQueryRequest|ClassInfoQueryRequest|
|&emsp;&emsp;pageNum|||false|integer(int32)||
|&emsp;&emsp;pageSize|||false|integer(int32)||
|&emsp;&emsp;sortField|||false|string||
|&emsp;&emsp;sortOrder|||false|string||
|&emsp;&emsp;className|||false|string||
|&emsp;&emsp;grade|||false|string||
|&emsp;&emsp;schoolName|||false|string||
|&emsp;&emsp;status|||false|string||
|&emsp;&emsp;teacherId|||false|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponsePageClassInfoVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||PageClassInfoVO|PageClassInfoVO|
|&emsp;&emsp;records||array|ClassInfoVO|
|&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;teacherId||integer||
|&emsp;&emsp;&emsp;&emsp;className||string||
|&emsp;&emsp;&emsp;&emsp;grade||string||
|&emsp;&emsp;&emsp;&emsp;schoolName||string||
|&emsp;&emsp;&emsp;&emsp;inviteCode||string||
|&emsp;&emsp;&emsp;&emsp;status||string||
|&emsp;&emsp;&emsp;&emsp;createdAt||string||
|&emsp;&emsp;&emsp;&emsp;updatedAt||string||
|&emsp;&emsp;&emsp;&emsp;studentCount||integer||
|&emsp;&emsp;pageNumber||integer(int64)||
|&emsp;&emsp;pageSize||integer(int64)||
|&emsp;&emsp;totalPage||integer(int64)||
|&emsp;&emsp;totalRow||integer(int64)||
|&emsp;&emsp;optimizeCountQuery||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"records": [
			{
				"id": 0,
				"teacherId": 0,
				"className": "",
				"grade": "",
				"schoolName": "",
				"inviteCode": "",
				"status": "",
				"createdAt": "",
				"updatedAt": "",
				"studentCount": 0
			}
		],
		"pageNumber": 0,
		"pageSize": 0,
		"totalPage": 0,
		"totalRow": 0,
		"optimizeCountQuery": true
	},
	"message": ""
}
```


## 创建班级


**接口地址**:`/api/classInfo/add`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>教师创建班级，系统生成邀请码。需教师登录态。</p>



**请求示例**:


```javascript
{
  "className": "",
  "grade": "",
  "schoolName": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|classInfoAddRequest|ClassInfoAddRequest|body|true|ClassInfoAddRequest|ClassInfoAddRequest|
|&emsp;&emsp;className|||false|string||
|&emsp;&emsp;grade|||false|string||
|&emsp;&emsp;schoolName|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseClassInfoVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||ClassInfoVO|ClassInfoVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;teacherId||integer(int64)||
|&emsp;&emsp;className||string||
|&emsp;&emsp;grade||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;inviteCode||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;updatedAt||string(date-time)||
|&emsp;&emsp;studentCount||integer(int64)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"teacherId": 0,
		"className": "",
		"grade": "",
		"schoolName": "",
		"inviteCode": "",
		"status": "",
		"createdAt": "",
		"updatedAt": "",
		"studentCount": 0
	},
	"message": ""
}
```


## 学生加入班级


**接口地址**:`/api/classInfo/add/student`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>学生通过邀请码加入班级：优先读 Redis 邀请码缓存，未命中则查库并回写缓存。入班成功后会补发当日已分配的学习计划。需学生登录态。</p>



**请求示例**:


```javascript
{
  "studentId": 0,
  "inviteCode": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|classStudentAddStudentRequest|ClassStudentAddStudentRequest|body|true|ClassStudentAddStudentRequest|ClassStudentAddStudentRequest|
|&emsp;&emsp;studentId|||false|integer(int64)||
|&emsp;&emsp;inviteCode|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseString|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": "",
	"message": ""
}
```


## 班级详情


**接口地址**:`/api/classInfo/{id}`


**请求方式**:`GET`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>查询班级详情（含在班学生数）。教师仅可查看自己的班级，管理员可查看全部。</p>



**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|id|班级ID|path|true|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseClassInfoVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||ClassInfoVO|ClassInfoVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;teacherId||integer(int64)||
|&emsp;&emsp;className||string||
|&emsp;&emsp;grade||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;inviteCode||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;updatedAt||string(date-time)||
|&emsp;&emsp;studentCount||integer(int64)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"teacherId": 0,
		"className": "",
		"grade": "",
		"schoolName": "",
		"inviteCode": "",
		"status": "",
		"createdAt": "",
		"updatedAt": "",
		"studentCount": 0
	},
	"message": ""
}
```


## 班级学生列表


**接口地址**:`/api/classInfo/{id}/students`


**请求方式**:`GET`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>返回当前在班学生列表。教师仅可查看自己的班级，管理员可查看全部。</p>



**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|id|班级ID|path|true|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseListClassStudentVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||array|ClassStudentVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;classId||integer(int64)||
|&emsp;&emsp;studentId||integer(int64)||
|&emsp;&emsp;realName||string||
|&emsp;&emsp;studentNo||string||
|&emsp;&emsp;avatarUrl||string||
|&emsp;&emsp;joinedAt||string(date-time)||
|&emsp;&emsp;status||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": [
		{
			"id": 0,
			"classId": 0,
			"studentId": 0,
			"realName": "",
			"studentNo": "",
			"avatarUrl": "",
			"joinedAt": "",
			"status": ""
		}
	],
	"message": ""
}
```


# 用户账号


## Web 管理端注册管理员


**接口地址**:`/api/userAccount/system/register`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>创建管理员账号：密码使用固定盐值 MD5 加密后写入 password_hash，角色默认 ADMIN。</p>



**请求示例**:


```javascript
{
  "username": "",
  "password": "",
  "realName": "",
  "schoolName": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|systemRegisterRequest|SystemRegisterRequest|body|true|SystemRegisterRequest|SystemRegisterRequest|
|&emsp;&emsp;username|||false|string||
|&emsp;&emsp;password|||false|string||
|&emsp;&emsp;realName|||false|string||
|&emsp;&emsp;schoolName|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseUserAccountVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||UserAccountVO|UserAccountVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;role||string||
|&emsp;&emsp;realName||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;studentNo||string||
|&emsp;&emsp;avatarUrl||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;openid||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"role": "",
		"realName": "",
		"schoolName": "",
		"studentNo": "",
		"avatarUrl": "",
		"status": "",
		"openid": ""
	},
	"message": ""
}
```


## Web 管理端登录


**接口地址**:`/api/userAccount/system/login`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>校验管理员账号与密码（MD5 加盐后与 password_hash 比对），登录成功后将会话写入 Redis：system.user.login.ids:{userId}。后续请求头携带 userId。</p>



**请求示例**:


```javascript
{
  "username": "",
  "password": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|systemLoginRequest|SystemLoginRequest|body|true|SystemLoginRequest|SystemLoginRequest|
|&emsp;&emsp;username|||false|string||
|&emsp;&emsp;password|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseUserAccountVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||UserAccountVO|UserAccountVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;role||string||
|&emsp;&emsp;realName||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;studentNo||string||
|&emsp;&emsp;avatarUrl||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;openid||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"role": "",
		"realName": "",
		"schoolName": "",
		"studentNo": "",
		"avatarUrl": "",
		"status": "",
		"openid": ""
	},
	"message": ""
}
```


## 教师注册申请


**接口地址**:`/api/userAccount/register/teacher`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>小程序提交教师注册信息，写入 teacher_approval 待审批记录；审批通过前不创建 user_account。</p>



**请求示例**:


```javascript
{
  "openid": "",
  "realName": "",
  "schoolName": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|userAccountTeacherRegisterRequest|UserAccountTeacherRegisterRequest|body|true|UserAccountTeacherRegisterRequest|UserAccountTeacherRegisterRequest|
|&emsp;&emsp;openid|||false|string||
|&emsp;&emsp;realName|||false|string||
|&emsp;&emsp;schoolName|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseTeacherApprovalVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||TeacherApprovalVO|TeacherApprovalVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;realName||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;rejectReason||string||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;approvedAt||string(date-time)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"realName": "",
		"schoolName": "",
		"status": "",
		"rejectReason": "",
		"createdAt": "",
		"approvedAt": ""
	},
	"message": ""
}
```


## 学生注册


**接口地址**:`/api/userAccount/register/student`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>小程序提交 openid、姓名、学号等，校验通过后直接写入 user_account；学生注册无需审批。</p>



**请求示例**:


```javascript
{
  "openid": "",
  "realName": "",
  "studentNo": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|userAccountStudentRegisterRequest|UserAccountStudentRegisterRequest|body|true|UserAccountStudentRegisterRequest|UserAccountStudentRegisterRequest|
|&emsp;&emsp;openid|||false|string||
|&emsp;&emsp;realName|||false|string||
|&emsp;&emsp;studentNo|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseUserAccountVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||UserAccountVO|UserAccountVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;role||string||
|&emsp;&emsp;realName||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;studentNo||string||
|&emsp;&emsp;avatarUrl||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;openid||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"role": "",
		"realName": "",
		"schoolName": "",
		"studentNo": "",
		"avatarUrl": "",
		"status": "",
		"openid": ""
	},
	"message": ""
}
```


## 微信一键登录


**接口地址**:`/api/userAccount/login`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>小程序通过 code + 登录角色登录。优先读 Redis 会话，未命中再查库；未注册时返回仅含 openid 的 VO。学生登录成功后会缓存已加入班级 ID，并刷新今日作业/复习词表缓存。</p>



**请求示例**:


```javascript
{
  "code": "",
  "loginRole": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|userAccountLoginRequest|UserAccountLoginRequest|body|true|UserAccountLoginRequest|UserAccountLoginRequest|
|&emsp;&emsp;code|||false|string||
|&emsp;&emsp;loginRole|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseUserAccountVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||UserAccountVO|UserAccountVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;role||string||
|&emsp;&emsp;realName||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;studentNo||string||
|&emsp;&emsp;avatarUrl||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;openid||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"role": "",
		"realName": "",
		"schoolName": "",
		"studentNo": "",
		"avatarUrl": "",
		"status": "",
		"openid": ""
	},
	"message": ""
}
```


# 教师审批


## 教师审批分页查询


**接口地址**:`/api/teacherApproval/list/page/vo`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>支持按审批状态、姓名、学校名称筛选，返回分页后的教师审批记录。</p>



**请求示例**:


```javascript
{
  "pageNum": 0,
  "pageSize": 0,
  "sortField": "",
  "sortOrder": "",
  "status": "",
  "realName": "",
  "schoolName": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|teacherApprovalQueryRequest|TeacherApprovalQueryRequest|body|true|TeacherApprovalQueryRequest|TeacherApprovalQueryRequest|
|&emsp;&emsp;pageNum|||false|integer(int32)||
|&emsp;&emsp;pageSize|||false|integer(int32)||
|&emsp;&emsp;sortField|||false|string||
|&emsp;&emsp;sortOrder|||false|string||
|&emsp;&emsp;status|||false|string||
|&emsp;&emsp;realName|||false|string||
|&emsp;&emsp;schoolName|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponsePageTeacherApprovalVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||PageTeacherApprovalVO|PageTeacherApprovalVO|
|&emsp;&emsp;records||array|TeacherApprovalVO|
|&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;realName||string||
|&emsp;&emsp;&emsp;&emsp;schoolName||string||
|&emsp;&emsp;&emsp;&emsp;status||string||
|&emsp;&emsp;&emsp;&emsp;rejectReason||string||
|&emsp;&emsp;&emsp;&emsp;createdAt||string||
|&emsp;&emsp;&emsp;&emsp;approvedAt||string||
|&emsp;&emsp;pageNumber||integer(int64)||
|&emsp;&emsp;pageSize||integer(int64)||
|&emsp;&emsp;totalPage||integer(int64)||
|&emsp;&emsp;totalRow||integer(int64)||
|&emsp;&emsp;optimizeCountQuery||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"records": [
			{
				"id": 0,
				"realName": "",
				"schoolName": "",
				"status": "",
				"rejectReason": "",
				"createdAt": "",
				"approvedAt": ""
			}
		],
		"pageNumber": 0,
		"pageSize": 0,
		"totalPage": 0,
		"totalRow": 0,
		"optimizeCountQuery": true
	},
	"message": ""
}
```


## 审核教师注册申请


**接口地址**:`/api/teacherApproval/audit`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>管理员审批教师注册：通过后创建教师账号，拒绝则记录拒绝原因。需管理员登录态。</p>



**请求示例**:


```javascript
{
  "id": 0,
  "status": "",
  "rejectReason": "",
  "approvedBy": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|teacherApprovalAuditRequest|TeacherApprovalAuditRequest|body|true|TeacherApprovalAuditRequest|TeacherApprovalAuditRequest|
|&emsp;&emsp;id|||false|integer(int64)||
|&emsp;&emsp;status|||false|string||
|&emsp;&emsp;rejectReason|||false|string||
|&emsp;&emsp;approvedBy|||false|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseTeacherApprovalVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||TeacherApprovalVO|TeacherApprovalVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;realName||string||
|&emsp;&emsp;schoolName||string||
|&emsp;&emsp;status||string||
|&emsp;&emsp;rejectReason||string||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;approvedAt||string(date-time)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"realName": "",
		"schoolName": "",
		"status": "",
		"rejectReason": "",
		"createdAt": "",
		"approvedAt": ""
	},
	"message": ""
}
```


# 词书管理


## 修改词书


**接口地址**:`/api/wordBook/update`


**请求方式**:`PUT`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>教师/管理员修改词书名称、说明、封面、状态。</p>



**请求示例**:


```javascript
{
  "id": 0,
  "bookName": "",
  "description": "",
  "coverUrl": "",
  "status": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|wordBookUpdateRequest|WordBookUpdateRequest|body|true|WordBookUpdateRequest|WordBookUpdateRequest|
|&emsp;&emsp;id|||false|integer(int64)||
|&emsp;&emsp;bookName|||false|string||
|&emsp;&emsp;description|||false|string||
|&emsp;&emsp;coverUrl|||false|string||
|&emsp;&emsp;status|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseWordBookVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||WordBookVO|WordBookVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;bookName||string||
|&emsp;&emsp;description||string||
|&emsp;&emsp;coverUrl||string||
|&emsp;&emsp;wordCount||integer(int32)||
|&emsp;&emsp;status||string||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;updatedAt||string(date-time)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"bookName": "",
		"description": "",
		"coverUrl": "",
		"wordCount": 0,
		"status": "",
		"createdAt": "",
		"updatedAt": ""
	},
	"message": ""
}
```


## 词书内单词分页查询


**接口地址**:`/api/wordBook/{bookId}/words/list/page/vo`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>按词书 ID 分页查询关联单词，支持按英文、整数周次、整数单元筛选；默认按 week、unitName、sortOrder 升序。</p>



**请求示例**:


```javascript
{
  "pageNum": 0,
  "pageSize": 0,
  "sortField": "",
  "sortOrder": "",
  "wordText": "",
  "week": 0,
  "unitName": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|bookId|词书ID|path|true|integer(int64)||
|wordBookWordQueryRequest|WordBookWordQueryRequest|body|true|WordBookWordQueryRequest|WordBookWordQueryRequest|
|&emsp;&emsp;pageNum|||false|integer(int32)||
|&emsp;&emsp;pageSize|||false|integer(int32)||
|&emsp;&emsp;sortField|||false|string||
|&emsp;&emsp;sortOrder|||false|string||
|&emsp;&emsp;wordText|||false|string||
|&emsp;&emsp;week|||false|integer(int32)||
|&emsp;&emsp;unitName|||false|integer(int32)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponsePageWordVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||PageWordVO|PageWordVO|
|&emsp;&emsp;records||array|WordVO|
|&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;wordText||string||
|&emsp;&emsp;&emsp;&emsp;phonetic||string||
|&emsp;&emsp;&emsp;&emsp;correctMeaning||string||
|&emsp;&emsp;&emsp;&emsp;exampleSentence||string||
|&emsp;&emsp;&emsp;&emsp;exampleTranslation||string||
|&emsp;&emsp;&emsp;&emsp;week||integer||
|&emsp;&emsp;&emsp;&emsp;unitName||integer||
|&emsp;&emsp;&emsp;&emsp;sortOrder||integer||
|&emsp;&emsp;&emsp;&emsp;options||array|WordOptionVO|
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;optionText||string||
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;isCorrect||integer||
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;sortOrder||integer||
|&emsp;&emsp;&emsp;&emsp;createdAt||string||
|&emsp;&emsp;&emsp;&emsp;updatedAt||string||
|&emsp;&emsp;pageNumber||integer(int64)||
|&emsp;&emsp;pageSize||integer(int64)||
|&emsp;&emsp;totalPage||integer(int64)||
|&emsp;&emsp;totalRow||integer(int64)||
|&emsp;&emsp;optimizeCountQuery||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"records": [
			{
				"id": 0,
				"wordText": "",
				"phonetic": "",
				"correctMeaning": "",
				"exampleSentence": "",
				"exampleTranslation": "",
				"week": 0,
				"unitName": 0,
				"sortOrder": 0,
				"options": [
					{
						"id": 0,
						"optionText": "",
						"isCorrect": 0,
						"sortOrder": 0
					}
				],
				"createdAt": "",
				"updatedAt": ""
			}
		],
		"pageNumber": 0,
		"pageSize": 0,
		"totalPage": 0,
		"totalRow": 0,
		"optimizeCountQuery": true
	},
	"message": ""
}
```


## 批量导入词书单词


**接口地址**:`/api/wordBook/{bookId}/words/import`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>手工录入英文、音标、正确中文、3 个错误中文、例句及翻译；可带整数 week、unitName。正确项写入 word_option.is_correct=1。</p>



**请求示例**:


```javascript
{
  "week": 0,
  "unitName": 0,
  "words": [
    {
      "wordText": "",
      "phonetic": "",
      "correctMeaning": "",
      "wrongMeanings": [],
      "exampleSentence": "",
      "exampleTranslation": ""
    }
  ]
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|bookId|词书ID|path|true|integer(int64)||
|wordBookImportRequest|WordBookImportRequest|body|true|WordBookImportRequest|WordBookImportRequest|
|&emsp;&emsp;week|||false|integer(int32)||
|&emsp;&emsp;unitName|||false|integer(int32)||
|&emsp;&emsp;words|||false|array|WordImportItem|
|&emsp;&emsp;&emsp;&emsp;wordText|||false|string||
|&emsp;&emsp;&emsp;&emsp;phonetic|||false|string||
|&emsp;&emsp;&emsp;&emsp;correctMeaning|||false|string||
|&emsp;&emsp;&emsp;&emsp;wrongMeanings|||false|array|string|
|&emsp;&emsp;&emsp;&emsp;exampleSentence|||false|string||
|&emsp;&emsp;&emsp;&emsp;exampleTranslation|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseWordBookImportResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||WordBookImportResultVO|WordBookImportResultVO|
|&emsp;&emsp;successCount||integer(int32)||
|&emsp;&emsp;failCount||integer(int32)||
|&emsp;&emsp;wordCount||integer(int32)||
|&emsp;&emsp;failList||array|WordImportFailVO|
|&emsp;&emsp;&emsp;&emsp;wordText||string||
|&emsp;&emsp;&emsp;&emsp;reason||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"successCount": 0,
		"failCount": 0,
		"wordCount": 0,
		"failList": [
			{
				"wordText": "",
				"reason": ""
			}
		]
	},
	"message": ""
}
```


## 词书分页查询


**接口地址**:`/api/wordBook/list/page/vo`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>教师/管理员分页查询词书，支持按名称、状态筛选。</p>



**请求示例**:


```javascript
{
  "pageNum": 0,
  "pageSize": 0,
  "sortField": "",
  "sortOrder": "",
  "bookName": "",
  "status": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|wordBookQueryRequest|WordBookQueryRequest|body|true|WordBookQueryRequest|WordBookQueryRequest|
|&emsp;&emsp;pageNum|||false|integer(int32)||
|&emsp;&emsp;pageSize|||false|integer(int32)||
|&emsp;&emsp;sortField|||false|string||
|&emsp;&emsp;sortOrder|||false|string||
|&emsp;&emsp;bookName|||false|string||
|&emsp;&emsp;status|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponsePageWordBookVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||PageWordBookVO|PageWordBookVO|
|&emsp;&emsp;records||array|WordBookVO|
|&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;bookName||string||
|&emsp;&emsp;&emsp;&emsp;description||string||
|&emsp;&emsp;&emsp;&emsp;coverUrl||string||
|&emsp;&emsp;&emsp;&emsp;wordCount||integer||
|&emsp;&emsp;&emsp;&emsp;status||string||
|&emsp;&emsp;&emsp;&emsp;createdAt||string||
|&emsp;&emsp;&emsp;&emsp;updatedAt||string||
|&emsp;&emsp;pageNumber||integer(int64)||
|&emsp;&emsp;pageSize||integer(int64)||
|&emsp;&emsp;totalPage||integer(int64)||
|&emsp;&emsp;totalRow||integer(int64)||
|&emsp;&emsp;optimizeCountQuery||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"records": [
			{
				"id": 0,
				"bookName": "",
				"description": "",
				"coverUrl": "",
				"wordCount": 0,
				"status": "",
				"createdAt": "",
				"updatedAt": ""
			}
		],
		"pageNumber": 0,
		"pageSize": 0,
		"totalPage": 0,
		"totalRow": 0,
		"optimizeCountQuery": true
	},
	"message": ""
}
```


## 创建词书


**接口地址**:`/api/wordBook/add`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>教师/管理员创建词书，可填写名称、说明、封面。</p>



**请求示例**:


```javascript
{
  "bookName": "",
  "description": "",
  "coverUrl": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|wordBookAddRequest|WordBookAddRequest|body|true|WordBookAddRequest|WordBookAddRequest|
|&emsp;&emsp;bookName|||false|string||
|&emsp;&emsp;description|||false|string||
|&emsp;&emsp;coverUrl|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseWordBookVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||WordBookVO|WordBookVO|
|&emsp;&emsp;id||integer(int64)||
|&emsp;&emsp;bookName||string||
|&emsp;&emsp;description||string||
|&emsp;&emsp;coverUrl||string||
|&emsp;&emsp;wordCount||integer(int32)||
|&emsp;&emsp;status||string||
|&emsp;&emsp;createdAt||string(date-time)||
|&emsp;&emsp;updatedAt||string(date-time)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"id": 0,
		"bookName": "",
		"description": "",
		"coverUrl": "",
		"wordCount": 0,
		"status": "",
		"createdAt": "",
		"updatedAt": ""
	},
	"message": ""
}
```


## 删除词书（软删除）


**接口地址**:`/api/wordBook/{id}`


**请求方式**:`DELETE`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>将词书状态置为 DISABLED，不物理删除。</p>



**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|id|词书ID|path|true|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseBoolean|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": true,
	"message": ""
}
```


# 学生学习


## 修改单词学习状态


**接口地址**:`/api/studentStudy/progress/status`


**请求方式**:`PUT`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>可将状态改为 LEARNING 或 MASTERED；置为 MASTERED 后会刷新今日作业 Redis 缓存。</p>



**请求示例**:


```javascript
{
  "wordId": 0,
  "status": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|studentWordStatusUpdateRequest|StudentWordStatusUpdateRequest|body|true|StudentWordStatusUpdateRequest|StudentWordStatusUpdateRequest|
|&emsp;&emsp;wordId|||false|integer(int64)||
|&emsp;&emsp;status|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseBoolean|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": true,
	"message": ""
}
```


## 新词拼写做题


**接口地址**:`/api/studentStudy/answer/spell`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>比对拼写字符串与单词原文（忽略大小写），写入 answer_record（NEW/SPELL）并更新进度。</p>



**请求示例**:


```javascript
{
  "wordId": 0,
  "spelledText": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|studentSpellAnswerRequest|StudentSpellAnswerRequest|body|true|StudentSpellAnswerRequest|StudentSpellAnswerRequest|
|&emsp;&emsp;wordId|||false|integer(int64)||
|&emsp;&emsp;spelledText|||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseStudentAnswerResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||StudentAnswerResultVO|StudentAnswerResultVO|
|&emsp;&emsp;correct||boolean||
|&emsp;&emsp;wordId||integer(int64)||
|&emsp;&emsp;correctAnswer||string||
|&emsp;&emsp;progressStatus||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"correct": true,
		"wordId": 0,
		"correctAnswer": "",
		"progressStatus": ""
	},
	"message": ""
}
```


## 新词四选一做题


**接口地址**:`/api/studentStudy/answer/choice`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>根据 optionId 判分，写入 answer_record（NEW/CHOICE），并更新学习进度（NEW→LEARNING）。</p>



**请求示例**:


```javascript
{
  "wordId": 0,
  "optionId": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|studentChoiceAnswerRequest|StudentChoiceAnswerRequest|body|true|StudentChoiceAnswerRequest|StudentChoiceAnswerRequest|
|&emsp;&emsp;wordId|||false|integer(int64)||
|&emsp;&emsp;optionId|||false|integer(int64)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseStudentAnswerResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||StudentAnswerResultVO|StudentAnswerResultVO|
|&emsp;&emsp;correct||boolean||
|&emsp;&emsp;wordId||integer(int64)||
|&emsp;&emsp;correctAnswer||string||
|&emsp;&emsp;progressStatus||string||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"correct": true,
		"wordId": 0,
		"correctAnswer": "",
		"progressStatus": ""
	},
	"message": ""
}
```


## 获取今日新词作业


**接口地址**:`/api/studentStudy/homework/today`


**请求方式**:`GET`


**请求数据类型**:`application/x-www-form-urlencoded`


**响应数据类型**:`*/*`


**接口描述**:<p>优先读 Redis（student.homework.list），未命中则回源 DB 并回写；返回词表与 wordCount。含英文、音标、释义及四选一选项（不含答案标记）。</p>



**请求参数**:


暂无


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseStudentHomeworkCacheVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||StudentHomeworkCacheVO|StudentHomeworkCacheVO|
|&emsp;&emsp;studentId||integer(int64)||
|&emsp;&emsp;classId||integer(int64)||
|&emsp;&emsp;wordCount||integer(int32)||
|&emsp;&emsp;words||array|StudentHomeworkWordVO|
|&emsp;&emsp;&emsp;&emsp;wordId||integer||
|&emsp;&emsp;&emsp;&emsp;wordText||string||
|&emsp;&emsp;&emsp;&emsp;phonetic||string||
|&emsp;&emsp;&emsp;&emsp;correctMeaning||string||
|&emsp;&emsp;&emsp;&emsp;exampleSentence||string||
|&emsp;&emsp;&emsp;&emsp;exampleTranslation||string||
|&emsp;&emsp;&emsp;&emsp;progressStatus||string||
|&emsp;&emsp;&emsp;&emsp;correctCount||integer||
|&emsp;&emsp;&emsp;&emsp;wrongCount||integer||
|&emsp;&emsp;&emsp;&emsp;options||array|StudentStudyOptionVO|
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;id||integer||
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;optionText||string||
|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;sortOrder||integer||
|&emsp;&emsp;progressSynced||boolean||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"studentId": 0,
		"classId": 0,
		"wordCount": 0,
		"words": [
			{
				"wordId": 0,
				"wordText": "",
				"phonetic": "",
				"correctMeaning": "",
				"exampleSentence": "",
				"exampleTranslation": "",
				"progressStatus": "",
				"correctCount": 0,
				"wrongCount": 0,
				"options": [
					{
						"id": 0,
						"optionText": "",
						"sortOrder": 0
					}
				]
			}
		],
		"progressSynced": true
	},
	"message": ""
}
```


# 每日单词分配


## 按周次单元分配今日学习计划


**接口地址**:`/api/classDailyAssignment/unit`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>选择词书、week、unitName，将该单元全部单词追加到已绑定该词书且今天生效的班级中，在班学生的今日学习计划。已在今日计划中的单词不重复写入。已掌握的单词会改回 LEARNING，以便出现在今日作业中。</p>



**请求示例**:


```javascript
{
  "bookId": 0,
  "week": 0,
  "unitName": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|classUnitPlanAssignRequest|ClassUnitPlanAssignRequest|body|true|ClassUnitPlanAssignRequest|ClassUnitPlanAssignRequest|
|&emsp;&emsp;bookId|||false|integer(int64)||
|&emsp;&emsp;week|||false|integer(int32)||
|&emsp;&emsp;unitName|||false|integer(int32)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseClassUnitPlanAssignResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||ClassUnitPlanAssignResultVO|ClassUnitPlanAssignResultVO|
|&emsp;&emsp;assignDate||string(date)||
|&emsp;&emsp;bookId||integer(int64)||
|&emsp;&emsp;week||integer(int32)||
|&emsp;&emsp;unitName||integer(int32)||
|&emsp;&emsp;wordCount||integer(int32)||
|&emsp;&emsp;classCount||integer(int32)||
|&emsp;&emsp;studentCount||integer(int32)||
|&emsp;&emsp;addedCount||integer(int32)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"assignDate": "",
		"bookId": 0,
		"week": 0,
		"unitName": 0,
		"wordCount": 0,
		"classCount": 0,
		"studentCount": 0,
		"addedCount": 0
	},
	"message": ""
}
```


## 手动触发每日单词分配


**接口地址**:`/api/classDailyAssignment/run`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:<p>管理员按指定学习日（默认今天）为每个在班学生生成当日计划：已掌握则发新词，未完成则结转后补足每日额度。系统定时任务每天 02:00 也会执行。</p>



**请求示例**:


```javascript
{
  "assignDate": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | 请求类型    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|classDailyAssignmentRunRequest|ClassDailyAssignmentRunRequest|body|true|ClassDailyAssignmentRunRequest|ClassDailyAssignmentRunRequest|
|&emsp;&emsp;assignDate|||false|string(date)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|BaseResponseClassDailyAssignmentRunResultVO|


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||ClassDailyAssignmentRunResultVO|ClassDailyAssignmentRunResultVO|
|&emsp;&emsp;assignDate||string(date)||
|&emsp;&emsp;taskCount||integer(int32)||
|&emsp;&emsp;createdCount||integer(int32)||
|&emsp;&emsp;skippedExistCount||integer(int32)||
|&emsp;&emsp;skippedEmptyCount||integer(int32)||
|&emsp;&emsp;successCount||integer(int32)||
|&emsp;&emsp;partialCount||integer(int32)||
|message||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {
		"assignDate": "",
		"taskCount": 0,
		"createdCount": 0,
		"skippedExistCount": 0,
		"skippedEmptyCount": 0,
		"successCount": 0,
		"partialCount": 0
	},
	"message": ""
}
```