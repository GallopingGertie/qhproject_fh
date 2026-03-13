CREATE DATABASE IF NOT EXISTS agri_platform DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE agri_platform;

CREATE TABLE `user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(20) NOT NULL COMMENT '手机号',
  `nickname` VARCHAR(50) DEFAULT NULL COMMENT '昵称',
  `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像',
  `password` VARCHAR(255) DEFAULT NULL COMMENT '密码',
  `status` TINYINT(1) DEFAULT 1 COMMENT '状态:1-正常,0-禁用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

CREATE TABLE `user_address` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
  `receiver_name` VARCHAR(50) NOT NULL COMMENT '收货人姓名',
  `receiver_phone` VARCHAR(20) NOT NULL COMMENT '收货人电话',
  `province` VARCHAR(50) NOT NULL COMMENT '省',
  `city` VARCHAR(50) NOT NULL COMMENT '市',
  `district` VARCHAR(50) NOT NULL COMMENT '区',
  `detail_address` VARCHAR(255) NOT NULL COMMENT '详细地址',
  `is_default` TINYINT(1) DEFAULT 0 COMMENT '是否默认:1-是,0-否',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收货地址表';

CREATE TABLE `merchant` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `account` VARCHAR(50) NOT NULL COMMENT '商户账号',
  `password` VARCHAR(255) NOT NULL COMMENT '密码',
  `merchant_name` VARCHAR(100) NOT NULL COMMENT '商户名称',
  `contact_person` VARCHAR(50) NOT NULL COMMENT '联系人',
  `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系电话',
  `business_license` VARCHAR(255) DEFAULT NULL COMMENT '营业执照',
  `legal_person_id` VARCHAR(255) DEFAULT NULL COMMENT '法人身份证',
  `shop_logo` VARCHAR(255) DEFAULT NULL COMMENT '店铺logo',
  `shop_description` VARCHAR(500) DEFAULT NULL COMMENT '店铺简介',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-待审核,1-审核通过,2-审核驳回,3-已停用',
  `reject_reason` VARCHAR(255) DEFAULT NULL COMMENT '驳回原因',
  `commission_rate` DECIMAL(5,2) DEFAULT 0.00 COMMENT '平台抽成比例',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户表';

CREATE TABLE `merchant_apply` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` BIGINT(20) DEFAULT NULL COMMENT '商户ID',
  `merchant_name` VARCHAR(100) NOT NULL COMMENT '商户名称',
  `contact_person` VARCHAR(50) NOT NULL COMMENT '联系人',
  `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系电话',
  `business_license` VARCHAR(255) DEFAULT NULL COMMENT '营业执照',
  `legal_person_id` VARCHAR(255) DEFAULT NULL COMMENT '法人身份证',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-待审核,1-审核通过,2-审核驳回',
  `reject_reason` VARCHAR(255) DEFAULT NULL COMMENT '驳回原因',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户入驻申请表';

CREATE TABLE `merchant_withdraw` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` BIGINT(20) NOT NULL COMMENT '商户ID',
  `amount` DECIMAL(10,2) NOT NULL COMMENT '提现金额',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-待审核,1-审核通过,2-审核驳回,3-已打款',
  `reject_reason` VARCHAR(255) DEFAULT NULL COMMENT '驳回原因',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户提现申请表';

CREATE TABLE `product_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `parent_id` BIGINT(20) DEFAULT 0 COMMENT '父分类ID,0表示一级分类',
  `sort_order` INT(11) DEFAULT 0 COMMENT '排序',
  `status` TINYINT(1) DEFAULT 1 COMMENT '状态:1-启用,0-禁用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

CREATE TABLE `product` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` BIGINT(20) NOT NULL COMMENT '商户ID',
  `category_id` BIGINT(20) NOT NULL COMMENT '分类ID',
  `product_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
  `main_image` VARCHAR(255) DEFAULT NULL COMMENT '商品主图',
  `images` TEXT COMMENT '商品图片(多张,逗号分隔)',
  `price` DECIMAL(10,2) NOT NULL COMMENT '销售价格',
  `original_price` DECIMAL(10,2) DEFAULT NULL COMMENT '原价',
  `stock` INT(11) DEFAULT 0 COMMENT '库存',
  `description` TEXT COMMENT '商品描述',
  `origin_place` VARCHAR(100) DEFAULT NULL COMMENT '产地',
  `ship_from` VARCHAR(100) DEFAULT NULL COMMENT '发货地',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-草稿,1-待审核,2-审核通过,3-审核驳回,4-已上架,5-已下架',
  `reject_reason` VARCHAR(255) DEFAULT NULL COMMENT '驳回原因',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

CREATE TABLE `product_sku` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT(20) NOT NULL COMMENT '商品ID',
  `sku_name` VARCHAR(100) NOT NULL COMMENT 'SKU名称',
  `price` DECIMAL(10,2) NOT NULL COMMENT '价格',
  `stock` INT(11) DEFAULT 0 COMMENT '库存',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品SKU表';

CREATE TABLE `product_audit_log` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT(20) NOT NULL COMMENT '商品ID',
  `before_status` TINYINT(1) DEFAULT NULL COMMENT '审核前状态',
  `after_status` TINYINT(1) DEFAULT NULL COMMENT '审核后状态',
  `audit_result` TINYINT(1) DEFAULT NULL COMMENT '审核结果:1-通过,2-驳回',
  `reject_reason` VARCHAR(255) DEFAULT NULL COMMENT '驳回原因',
  `auditor_id` BIGINT(20) DEFAULT NULL COMMENT '审核人ID',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品审核日志表';

CREATE TABLE `order_info` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `order_no` VARCHAR(64) NOT NULL COMMENT '订单号',
  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
  `merchant_id` BIGINT(20) NOT NULL COMMENT '商户ID',
  `total_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
  `actual_amount` DECIMAL(10,2) NOT NULL COMMENT '实付金额',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-待支付,1-待发货,2-待收货,3-已完成,4-已取消,5-退款中,6-已退款',
  `receiver_name` VARCHAR(50) DEFAULT NULL COMMENT '收货人姓名',
  `receiver_phone` VARCHAR(20) DEFAULT NULL COMMENT '收货人电话',
  `receiver_address` VARCHAR(500) DEFAULT NULL COMMENT '收货地址',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pay_time` DATETIME DEFAULT NULL COMMENT '支付时间',
  `ship_time` DATETIME DEFAULT NULL COMMENT '发货时间',
  `finish_time` DATETIME DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_merchant_id` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

CREATE TABLE `order_item` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT(20) NOT NULL COMMENT '订单ID',
  `product_id` BIGINT(20) NOT NULL COMMENT '商品ID',
  `sku_id` BIGINT(20) DEFAULT NULL COMMENT 'SKU ID',
  `product_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
  `product_image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片',
  `sku_name` VARCHAR(100) DEFAULT NULL COMMENT 'SKU名称',
  `price` DECIMAL(10,2) NOT NULL COMMENT '购买价格',
  `quantity` INT(11) NOT NULL COMMENT '购买数量',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单商品表';

CREATE TABLE `payment_record` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT(20) NOT NULL COMMENT '订单ID',
  `payment_no` VARCHAR(64) NOT NULL COMMENT '支付流水号',
  `pay_type` TINYINT(1) DEFAULT 1 COMMENT '支付方式:1-微信,2-支付宝',
  `amount` DECIMAL(10,2) NOT NULL COMMENT '支付金额',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-待支付,1-支付成功,2-支付失败',
  `transaction_id` VARCHAR(128) DEFAULT NULL COMMENT '第三方交易号',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `pay_time` DATETIME DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_payment_no` (`payment_no`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付记录表';

CREATE TABLE `shipment_record` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT(20) NOT NULL COMMENT '订单ID',
  `logistics_company` VARCHAR(50) DEFAULT NULL COMMENT '物流公司',
  `logistics_no` VARCHAR(100) DEFAULT NULL COMMENT '物流单号',
  `ship_time` DATETIME DEFAULT NULL COMMENT '发货时间',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发货记录表';

CREATE TABLE `refund_record` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT(20) NOT NULL COMMENT '订单ID',
  `refund_no` VARCHAR(64) NOT NULL COMMENT '退款单号',
  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
  `refund_amount` DECIMAL(10,2) NOT NULL COMMENT '退款金额',
  `refund_reason` VARCHAR(500) DEFAULT NULL COMMENT '退款原因',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-待审核,1-审核通过,2-审核驳回,3-退款成功',
  `reject_reason` VARCHAR(255) DEFAULT NULL COMMENT '驳回原因',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_refund_no` (`refund_no`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款记录表';

CREATE TABLE `settlement_record` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` BIGINT(20) NOT NULL COMMENT '商户ID',
  `order_id` BIGINT(20) NOT NULL COMMENT '订单ID',
  `order_amount` DECIMAL(10,2) NOT NULL COMMENT '订单金额',
  `commission_amount` DECIMAL(10,2) NOT NULL COMMENT '平台抽成金额',
  `settlement_amount` DECIMAL(10,2) NOT NULL COMMENT '结算金额',
  `status` TINYINT(1) DEFAULT 0 COMMENT '状态:0-待结算,1-已结算',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='结算记录表';

CREATE TABLE `admin_user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL COMMENT '用户名',
  `password` VARCHAR(255) NOT NULL COMMENT '密码',
  `real_name` VARCHAR(50) DEFAULT NULL COMMENT '真实姓名',
  `role` TINYINT(1) DEFAULT 1 COMMENT '角色:1-平台管理员',
  `status` TINYINT(1) DEFAULT 1 COMMENT '状态:1-正常,0-禁用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台管理员表';

CREATE TABLE `system_config` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `config_key` VARCHAR(100) NOT NULL COMMENT '配置键',
  `config_value` TEXT COMMENT '配置值',
  `config_desc` VARCHAR(255) DEFAULT NULL COMMENT '配置描述',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

INSERT INTO `admin_user` (`username`, `password`, `real_name`, `role`, `status`) 
VALUES ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '系统管理员', 1, 1);

INSERT INTO `product_category` (`name`, `parent_id`, `sort_order`) VALUES
('新鲜水果', 0, 1),
('新鲜蔬菜', 0, 2),
('肉禽蛋品', 0, 3),
('海鲜水产', 0, 4);
