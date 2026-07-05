-- 用户与教师审批模块
-- 说明：存放管理员、教师、学生账号，以及教师注册审批流程。
use englishworddb;

CREATE TABLE IF NOT EXISTS user_account (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID，系统内部唯一标识',
  openid VARCHAR(64) NULL COMMENT '微信小程序 openid，教师和学生微信登录使用',
  username VARCHAR(50) NULL COMMENT '管理员账号登录名，普通小程序用户可为空',
  password_hash VARCHAR(255) NULL COMMENT '管理员密码加密值，小程序用户可为空',
  role VARCHAR(20) NOT NULL COMMENT '用户角色：ADMIN 管理员，TEACHER 教师，STUDENT 学生',
  real_name VARCHAR(50) NOT NULL COMMENT '真实姓名，用于教师、学生资料展示',
  school_name VARCHAR(100) NULL COMMENT '所属学校名称，当前 MVP 可直接存学校文本',
  student_no VARCHAR(50) NULL COMMENT '学生学号，学生可选填写',
  avatar_url VARCHAR(500) NULL COMMENT '微信头像地址或用户头像地址',
  status VARCHAR(20) NOT NULL DEFAULT 'NORMAL' COMMENT '账号状态：NORMAL 正常，DISABLED 禁用',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_user_openid (openid),
  UNIQUE KEY uk_user_username (username),
  KEY idx_user_role (role),
  KEY idx_user_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户账号表，统一存管理员、教师、学生基础信息';

CREATE TABLE IF NOT EXISTS teacher_approval (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '审批记录ID',
  teacher_id BIGINT NOT NULL COMMENT '教师用户ID，关联 user_account.id',
  status VARCHAR(20) NOT NULL COMMENT '审批状态：PENDING 待审批，APPROVED 已通过，REJECTED 已拒绝',
  reject_reason VARCHAR(255) NULL COMMENT '拒绝原因，只有审批拒绝时填写',
  approved_by BIGINT NULL COMMENT '审批管理员ID，关联 user_account.id',
  approved_at DATETIME NULL COMMENT '审批时间',
  created_at DATETIME NOT NULL COMMENT '提交审批时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  KEY idx_teacher_approval_teacher (teacher_id),
  KEY idx_teacher_approval_status (status),
  CONSTRAINT fk_teacher_approval_teacher
    FOREIGN KEY (teacher_id) REFERENCES user_account (id),
  CONSTRAINT fk_teacher_approval_admin
    FOREIGN KEY (approved_by) REFERENCES user_account (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师注册审批表';
