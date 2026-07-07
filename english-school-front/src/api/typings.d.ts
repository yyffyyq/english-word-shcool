declare namespace API {
  type BaseResponseUserAccountVO = {
    code?: number;
    data?: UserAccountVO;
    message?: string;
  };

  type UserAccountLoginRequest = {
    code?: string;
    loginRole?: string;
  };

  type UserAccountVO = {
    id?: number;
    role?: string;
    realName?: string;
    schoolName?: string;
    studentNo?: string;
    avatarUrl?: string;
    status?: string;
  };
}
