declare namespace API {
  type BaseResponseBoolean = {
    code?: number;
    data?: boolean;
    message?: string;
  };

  type BaseResponseClassInfoVO = {
    code?: number;
    data?: ClassInfoVO;
    message?: string;
  };

  type BaseResponseClassWordTaskVO = {
    code?: number;
    data?: ClassWordTaskVO;
    message?: string;
  };

  type BaseResponseListClassStudentVO = {
    code?: number;
    data?: ClassStudentVO[];
    message?: string;
  };

  type BaseResponsePageClassInfoVO = {
    code?: number;
    data?: PageClassInfoVO;
    message?: string;
  };

  type BaseResponsePageClassWordTaskVO = {
    code?: number;
    data?: PageClassWordTaskVO;
    message?: string;
  };

  type BaseResponsePageTeacherApprovalVO = {
    code?: number;
    data?: PageTeacherApprovalVO;
    message?: string;
  };

  type BaseResponsePageWordBookVO = {
    code?: number;
    data?: PageWordBookVO;
    message?: string;
  };

  type BaseResponsePageWordVO = {
    code?: number;
    data?: PageWordVO;
    message?: string;
  };

  type BaseResponseString = {
    code?: number;
    data?: string;
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

  type BaseResponseWordBookImportResultVO = {
    code?: number;
    data?: WordBookImportResultVO;
    message?: string;
  };

  type BaseResponseWordBookVO = {
    code?: number;
    data?: WordBookVO;
    message?: string;
  };

  type BaseResponseWordVO = {
    code?: number;
    data?: WordVO;
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
    studentCount?: number;
  };

  type ClassStudentAddStudentRequest = {
    studentId?: number;
    inviteCode?: string;
  };

  type ClassStudentVO = {
    id?: number;
    classId?: number;
    studentId?: number;
    realName?: string;
    studentNo?: string;
    avatarUrl?: string;
    joinedAt?: string;
    status?: string;
  };

  type ClassWordTaskBindRequest = {
    classId?: number;
    bookId?: number;
    dailyNewCount?: number;
    startDate?: string;
    endDate?: string;
  };

  type ClassWordTaskQueryRequest = {
    pageNum?: number;
    pageSize?: number;
    sortField?: string;
    sortOrder?: string;
    classId?: number;
    bookId?: number;
    status?: string;
    createdBy?: number;
  };

  type ClassWordTaskVO = {
    id?: number;
    classId?: number;
    bookId?: number;
    dailyNewCount?: number;
    startDate?: string;
    endDate?: string;
    status?: string;
    createdBy?: number;
    createdAt?: string;
    updatedAt?: string;
  };

  type deleteWordBookParams = {
    id: number;
  };

  type deleteWordParams = {
    id: number;
  };

  type getClassInfoParams = {
    id: number;
  };

  type importWordsParams = {
    bookId: number;
  };

  type listClassStudentsParams = {
    id: number;
  };

  type listWordsByBookPageParams = {
    bookId: number;
  };

  type PageClassInfoVO = {
    records?: ClassInfoVO[];
    pageNumber?: number;
    pageSize?: number;
    totalPage?: number;
    totalRow?: number;
    optimizeCountQuery?: boolean;
  };

  type PageClassWordTaskVO = {
    records?: ClassWordTaskVO[];
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

  type PageWordBookVO = {
    records?: WordBookVO[];
    pageNumber?: number;
    pageSize?: number;
    totalPage?: number;
    totalRow?: number;
    optimizeCountQuery?: boolean;
  };

  type PageWordVO = {
    records?: WordVO[];
    pageNumber?: number;
    pageSize?: number;
    totalPage?: number;
    totalRow?: number;
    optimizeCountQuery?: boolean;
  };

  type refreshInviteCodeParams = {
    id: number;
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

  type unbindClassWordBookParams = {
    id: number;
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

  type WordBookAddRequest = {
    bookName?: string;
    description?: string;
    coverUrl?: string;
  };

  type WordBookImportRequest = {
    unitName?: string;
    words?: WordImportItem[];
  };

  type WordBookImportResultVO = {
    successCount?: number;
    failCount?: number;
    wordCount?: number;
    failList?: WordImportFailVO[];
  };

  type WordBookQueryRequest = {
    pageNum?: number;
    pageSize?: number;
    sortField?: string;
    sortOrder?: string;
    bookName?: string;
    status?: string;
  };

  type WordBookUpdateRequest = {
    id?: number;
    bookName?: string;
    description?: string;
    coverUrl?: string;
    status?: string;
  };

  type WordBookVO = {
    id?: number;
    bookName?: string;
    description?: string;
    coverUrl?: string;
    wordCount?: number;
    status?: string;
    createdAt?: string;
    updatedAt?: string;
  };

  type WordBookWordQueryRequest = {
    pageNum?: number;
    pageSize?: number;
    sortField?: string;
    sortOrder?: string;
    wordText?: string;
    unitName?: string;
  };

  type WordImportFailVO = {
    wordText?: string;
    reason?: string;
  };

  type WordImportItem = {
    wordText?: string;
    phonetic?: string;
    correctMeaning?: string;
    wrongMeanings?: string[];
    exampleSentence?: string;
    exampleTranslation?: string;
  };

  type WordOptionVO = {
    id?: number;
    optionText?: string;
    isCorrect?: number;
    sortOrder?: number;
  };

  type WordUpdateRequest = {
    id?: number;
    wordText?: string;
    phonetic?: string;
    correctMeaning?: string;
    wrongMeanings?: string[];
    exampleSentence?: string;
    exampleTranslation?: string;
  };

  type WordVO = {
    id?: number;
    wordText?: string;
    phonetic?: string;
    correctMeaning?: string;
    exampleSentence?: string;
    exampleTranslation?: string;
    unitName?: string;
    sortOrder?: number;
    options?: WordOptionVO[];
    createdAt?: string;
    updatedAt?: string;
  };
}
