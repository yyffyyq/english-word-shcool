-- 系统配置与通知模块
-- 说明：存放后台基础配置，以及 WebSocket 通知可落库的数据。

CREATE TABLE IF NOT EXISTS system_config (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '配置ID',
  config_key VARCHAR(100) NOT NULL COMMENT '配置键，例如 default_daily_new_count',
  config_value VARCHAR(500) NOT NULL COMMENT '配置值',
  description VARCHAR(255) NULL COMMENT '配置说明',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_system_config_key (config_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统基础配置表';

CREATE TABLE IF NOT EXISTS notify_message (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '通知ID',
  receiver_id BIGINT NULL COMMENT '接收人ID，管理员通知可为空表示广播',
  title VARCHAR(100) NOT NULL COMMENT '通知标题',
  content VARCHAR(500) NOT NULL COMMENT '通知内容',
  type VARCHAR(30) NOT NULL COMMENT '通知类型，例如 TEACHER_APPROVAL 教师审批',
  is_read TINYINT NOT NULL DEFAULT 0 COMMENT '是否已读：0 未读，1 已读',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  read_at DATETIME NULL COMMENT '阅读时间',
  KEY idx_notify_receiver_read (receiver_id, is_read),
  KEY idx_notify_type (type),
  CONSTRAINT fk_notify_receiver
    FOREIGN KEY (receiver_id) REFERENCES user_account (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统通知表，配合 WebSocket 推送教师注册提醒';
