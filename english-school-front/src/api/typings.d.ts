declare namespace API {
  type BaseResponseClassInfoVO = {
    code?: number;
    data?: ClassInfoVO;
    message?: string;
  };

  type BaseResponsePageClassInfoVO = {
    code?: number;
    data?: PageClassInfoVO;
    message?: string;
  };

  type BaseResponsePageTeacherApprovalVO = {
    code?: number;
    data?: PageTeacherApprovalVO;
    message?: string;
  };

  type BaseResponseTeacherApprovalVO = {
    code?: number;
    data?: TeacherApprovalVO;
    message?: string;
  };

  type BaseResponseUserAccountVO = {
    code?: number;
    data?: UserAccountVO;
    message?: string;
  };

  type ClassInfoAddRequest = {
    className?: string;
    grade?: string;
    schoolName?: string;
  };

  type ClassInfoQueryRequest = {
    pageNum?: number;
    pageSize?: number;
    sortField?: string;
    sortOrder?: string;
    className?: string;
    grade?: string;
    schoolName?: string;
    status?: string;
    teacherId?: number;
  };

  type ClassInfoVO = {
    id?: number;
    teacherId?: number;
    className?: string;
    grade?: string;
    schoolName?: string;
    inviteCode?: string;
    status?: string;
    createdAt?: string;
    updatedAt?: string;
  };

  type PageClassInfoVO = {
    records?: ClassInfoVO[];
    pageNumber?: number;
    pageSize?: number;
    totalPage?: number;
    totalRow?: number;
    optimizeCountQuery?: boolean;
  };

  type PageTeacherApprovalVO = {
    records?: TeacherApprovalVO[];
    pageNumber?: number;
    pageSize?: number;
    totalPage?: number;
    totalRow?: number;
    optimizeCountQuery?: boolean;
  };

  type SystemLoginRequest = {
    username?: string;
    password?: string;
  };

  type SystemRegisterRequest = {
    username?: string;
    password?: string;
    realName?: string;
    schoolName?: string;
  };

  type TeacherApprovalAuditRequest = {
    id?: number;
    status?: string;
    rejectReason?: string;
    approvedBy?: number;
  };

  type TeacherApprovalQueryRequest = {
    pageNum?: number;
    pageSize?: number;
    sortField?: string;
    sortOrder?: string;
    status?: string;
    realName?: string;
    schoolName?: string;
  };

  type TeacherApprovalVO = {
    id?: number;
    realName?: string;
    schoolName?: string;
    status?: string;
    rejectReason?: string;
    createdAt?: string;
    approvedAt?: string;
  };

  type UserAccountLoginRequest = {
    code?: string;
    loginRole?: string;
  };

  type UserAccountStudentRegisterRequest = {
    openid?: string;
    realName?: string;
    studentNo?: string;
  };

  type UserAccountTeacherRegisterRequest = {
    openid?: string;
    realName?: string;
    schoolName?: string;
  };

  type UserAccountVO = {
    id?: number;
    role?: string;
    realName?: string;
    schoolName?: string;
    studentNo?: string;
    avatarUrl?: string;
    status?: string;
    openid?: string;
  };
}
