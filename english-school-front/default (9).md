# OpenAPI definition


**简介**:OpenAPI definition


**HOST**:http://localhost:8081/api


**联系人**:


**Version**:v0


**接口路径**:/api/v3/api-docs/default


[TOC]






# user-account-controller


## systemRegister


**接口地址**:`/api/userAccount/system/register`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


## systemLogin


**接口地址**:`/api/userAccount/system/login`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


## registerTeacher


**接口地址**:`/api/userAccount/register/teacher`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


## registerStudent


**接口地址**:`/api/userAccount/register/student`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


## loginUser


**接口地址**:`/api/userAccount/login`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


# teacher-approval-controller


## listTeacherApprovalByPage


**接口地址**:`/api/teacherApproval/list/page/vo`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


## auditTeacherApproval


**接口地址**:`/api/teacherApproval/audit`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


# class-info-controller


## listClassInfoByPage


**接口地址**:`/api/classInfo/list/page/vo`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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


## addClassInfo


**接口地址**:`/api/classInfo/add`


**请求方式**:`POST`


**请求数据类型**:`application/x-www-form-urlencoded,application/json`


**响应数据类型**:`*/*`


**接口描述**:


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
		"updatedAt": ""
	},
	"message": ""
}
```