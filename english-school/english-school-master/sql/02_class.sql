-- 班级模块
-- 说明：存放教师创建的班级，以及学生加入、退出班级关系。

CREATE TABLE IF NOT EXISTS class_info (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '班级ID',
  teacher_id BIGINT NOT NULL COMMENT '创建班级的教师ID，关联 user_account.id',
  class_name VARCHAR(100) NOT NULL COMMENT '班级名称，例如 三年级一班',
  grade VARCHAR(50) NULL COMMENT '年级名称，用于学生按年级筛选班级',
  school_name VARCHAR(100) NULL COMMENT '学校名称，用于班级筛选',
  invite_code CHAR(6) NOT NULL COMMENT '6位班级邀请码，用于学生快速加入',
  status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '班级状态：ACTIVE 正常，DISABLED 停用',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_class_invite_code (invite_code),
  KEY idx_class_teacher (teacher_id),
  KEY idx_class_school_grade (school_name, grade),
  CONSTRAINT fk_class_teacher
    FOREIGN KEY (teacher_id) REFERENCES user_account (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级信息表';

CREATE TABLE IF NOT EXISTS class_student (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '班级学生关系ID',
  class_id BIGINT NOT NULL COMMENT '班级ID，关联 class_info.id',
  student_id BIGINT NOT NULL COMMENT '学生ID，关联 user_account.id',
  joined_at DATETIME NOT NULL COMMENT '加入班级时间',
  status VARCHAR(20) NOT NULL DEFAULT 'IN_CLASS' COMMENT '关系状态：IN_CLASS 在班，EXITED 已退出',
  exited_at DATETIME NULL COMMENT '退出班级时间',
  active_student_id BIGINT GENERATED ALWAYS AS (
    CASE WHEN status = 'IN_CLASS' THEN student_id ELSE NULL END
  ) STORED COMMENT '有效在班学生ID，用于限制一个学生只能加入一个当前班级',
  UNIQUE KEY uk_class_student_active_student (active_student_id),
  KEY idx_class_student_class (class_id),
  KEY idx_class_student_student (student_id),
  CONSTRAINT fk_class_student_class
    FOREIGN KEY (class_id) REFERENCES class_info (id),
  CONSTRAINT fk_class_student_student
    FOREIGN KEY (student_id) REFERENCES user_account (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生入班关系表，MVP 阶段学生只允许加入一个有效班级';
