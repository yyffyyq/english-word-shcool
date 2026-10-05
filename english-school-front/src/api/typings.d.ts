declare namespace API {
  type BaseResponseBoolean = {
    code?: number;
    data?: boolean;
    message?: string;
  };

  type BaseResponseClassDailyAssignmentRunResultVO = {
    code?: number;
    data?: ClassDailyAssignmentRunResultVO;
    message?: string;
  };

  type BaseResponseClassInfoVO = {
    code?: number;
    data?: ClassInfoVO;
    message?: string;
  };

  type BaseResponseClassUnitPlanAssignResultVO = {
    code?: number;
    data?: ClassUnitPlanAssignResultVO;
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

  type BaseResponseStudentAnswerResultVO = {
    code?: number;
    data?: StudentAnswerResultVO;
    message?: string;
  };

  type BaseResponseStudentHomeworkCacheVO = {
    code?: number;
    data?: StudentHomeworkCacheVO;
    message?: string;
  };

  type BaseResponseStudentReviewCacheVO = {
    code?: number;
    data?: StudentReviewCacheVO;
    message?: string;
  };

  type BaseResponseStudentReviewPlanRunResultVO = {
    code?: number;
    data?: StudentReviewPlanRunResultVO;
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

  type ClassDailyAssignmentRunRequest = {
    assignDate?: string;
  };

  type ClassDailyAssignmentRunResultVO = {
    assignDate?: string;
    taskCount?: number;
    createdCount?: number;
    skippedExistCount?: number;
    skippedEmptyCount?: number;
    successCount?: number;
    partialCount?: number;
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

  type ClassUnitPlanAssignRequest = {
    classId?: number;
    bookId?: number;
    week?: number;
    unitName?: number;
  };

  type ClassUnitPlanAssignResultVO = {
    assignDate?: string;
    classId?: number;
    bookId?: number;
    week?: number;
    unitName?: number;
    wordCount?: number;
    classCount?: number;
    studentCount?: number;
    addedCount?: number;
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
    /** 词书ID */
    id: number;
  };

  type deleteWordParams = {
    /** 单词ID */
    id: number;
  };

  type getClassInfoParams = {
    /** 班级ID */
    id: number;
  };

  type importWordsParams = {
    /** 词书ID */
    bookId: number;
  };

  type listClassStudentsParams = {
    /** 班级ID */
    id: number;
  };

  type listWordsByBookPageParams = {
    /** 词书ID */
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
    /** 班级ID */
    id: number;
  };

  type StudentAnswerResultVO = {
    correct?: boolean;
    wordId?: number;
    correctAnswer?: string;
    progressStatus?: string;
  };

  type StudentChoiceAnswerRequest = {
    wordId?: number;
    optionId?: number;
  };

  type StudentHomeworkCacheVO = {
    studentId?: number;
    classId?: number;
    wordCount?: number;
    words?: StudentHomeworkWordVO[];
    progressSynced?: boolean;
  };

  type StudentHomeworkWordVO = {
    wordId?: number;
    wordText?: string;
    phonetic?: string;
    correctMeaning?: string;
    exampleSentence?: string;
    exampleTranslation?: string;
    progressStatus?: string;
    correctCount?: number;
    wrongCount?: number;
    options?: StudentStudyOptionVO[];
  };

  type StudentReviewCacheVO = {
    studentId?: number;
    classId?: number;
    wordCount?: number;
    words?: StudentReviewWordVO[];
  };

  type StudentReviewChoiceAnswerRequest = {
    wordId?: number;
    optionId?: number;
  };

  type StudentReviewPlanRunRequest = {
    reviewDate?: string;
  };

  type StudentReviewPlanRunResultVO = {
    reviewDate?: string;
    highWrongCount?: number;
    day1FollowupCount?: number;
    ebbinghausCount?: number;
    totalUpsertCount?: number;
  };

  type StudentReviewSpellAnswerRequest = {
    wordId?: number;
    spelledText?: string;
  };

  type StudentReviewWordVO = {
    wordId?: number;
    wordText?: string;
    phonetic?: string;
    correctMeaning?: string;
    exampleSentence?: string;
    exampleTranslation?: string;
    reason?: string;
    progressStatus?: string;
    options?: StudentStudyOptionVO[];
  };

  type StudentSpellAnswerRequest = {
    wordId?: number;
    spelledText?: string;
  };

  type StudentStudyOptionVO = {
    id?: number;
    optionText?: string;
    sortOrder?: number;
  };

  type StudentWordStatusUpdateRequest = {
    wordId?: number;
    status?: string;
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
    /** 班级学习任务ID */
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
    week?: number;
    unitName?: number;
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
    week?: number;
    unitName?: number;
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
    week?: number;
    unitName?: number;
    sortOrder?: number;
    options?: WordOptionVO[];
    createdAt?: string;
    updatedAt?: string;
  };
}
