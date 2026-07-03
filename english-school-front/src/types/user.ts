export type UserRole = 'student' | 'teacher'

export type UserStatus = 'none' | 'pending' | 'approved' | 'rejected'

export interface UserInfo {
  id: string
  openid: string
  role: UserRole
  name: string
  studentId?: string
  school?: string
  status: UserStatus
  avatar?: string
  nickName?: string
}

export interface WxLoginResult {
  code: string
}

export interface RegisterStudentPayload {
  name: string
  studentId: string
  openid: string
  avatar?: string
  nickName?: string
}

export interface RegisterTeacherPayload {
  name: string
  school: string
  openid: string
  avatar?: string
  nickName?: string
}
