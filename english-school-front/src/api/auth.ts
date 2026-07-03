import type {
  RegisterStudentPayload,
  RegisterTeacherPayload,
  UserInfo,
} from '@/types/user'

const MOCK_USERS_KEY = 'english_school_mock_users'

interface MockUserRecord extends UserInfo {
  createdAt: number
}

function getMockUsers(): MockUserRecord[] {
  try {
    return uni.getStorageSync(MOCK_USERS_KEY) || []
  } catch {
    return []
  }
}

function saveMockUsers(users: MockUserRecord[]) {
  uni.setStorageSync(MOCK_USERS_KEY, users)
}

/**
 * 微信登录 — 后续替换为真实后端接口
 * POST /api/auth/wx-login { code, role }
 */
export async function wxLogin(code: string, role: 'student' | 'teacher'): Promise<{
  token: string
  user: UserInfo | null
  isNewUser: boolean
}> {
  await delay(400)

  const openid = `mock_openid_${code.slice(-8)}`
  const users = getMockUsers()
  const existing = users.find((item) => item.openid === openid && item.role === role)

  if (existing) {
    return {
      token: `token_${existing.id}`,
      user: existing,
      isNewUser: false,
    }
  }

  return {
    token: '',
    user: null,
    isNewUser: true,
  }
}

/**
 * 学生注册 — 自动通过
 * POST /api/auth/register/student
 */
export async function registerStudent(payload: RegisterStudentPayload): Promise<UserInfo> {
  await delay(500)

  const user: MockUserRecord = {
    id: `stu_${Date.now()}`,
    openid: payload.openid,
    role: 'student',
    name: payload.name,
    studentId: payload.studentId,
    status: 'approved',
    avatar: payload.avatar,
    nickName: payload.nickName,
    createdAt: Date.now(),
  }

  const users = getMockUsers()
  users.push(user)
  saveMockUsers(users)

  return user
}

/**
 * 教师注册 — 待审批
 * POST /api/auth/register/teacher
 */
export async function registerTeacher(payload: RegisterTeacherPayload): Promise<UserInfo> {
  await delay(500)

  const user: MockUserRecord = {
    id: `tea_${Date.now()}`,
    openid: payload.openid,
    role: 'teacher',
    name: payload.name,
    school: payload.school,
    status: 'pending',
    avatar: payload.avatar,
    nickName: payload.nickName,
    createdAt: Date.now(),
  }

  const users = getMockUsers()
  users.push(user)
  saveMockUsers(users)

  return user
}

function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}
