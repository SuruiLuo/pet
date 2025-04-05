/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80039
 Source Host           : localhost:3306
 Source Schema         : petshis

 Target Server Type    : MySQL
 Target Server Version : 80039
 File Encoding         : 65001

 Date: 01/04/2025 20:50:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appointments
-- ----------------------------
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments`  (
  `appointment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '预约ID',
  `pet_id` bigint NOT NULL COMMENT '关联宠物表(pets.pet_id)',
  `doctor_id` bigint NOT NULL COMMENT '关联系统用户表(sys_user.user_id)',
  `appointment_time` datetime NOT NULL COMMENT '预约时间',
  `status` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0待确认，1已确认，2已取消）',
  PRIMARY KEY (`appointment_id`) USING BTREE,
  INDEX `idx_doctor_time`(`doctor_id` ASC, `appointment_time` ASC) USING BTREE,
  INDEX `pet_id`(`pet_id` ASC) USING BTREE,
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '预约表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appointments
-- ----------------------------
INSERT INTO `appointments` VALUES (14, 17, 14, '2025-03-19 00:00:00', '0');

-- ----------------------------
-- Table structure for clients
-- ----------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients`  (
  `client_id` bigint NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `user_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`) USING BTREE,
  UNIQUE INDEX `idx_phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clients
-- ----------------------------
INSERT INTO `clients` VALUES (14, 'test2', '13111111111', NULL, 17);
INSERT INTO `clients` VALUES (15, 'test3', '13711111112', NULL, 18);

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company`  (
  `companyId` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`companyId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES (16, 'test1');

-- ----------------------------
-- Table structure for drug_inventory
-- ----------------------------
DROP TABLE IF EXISTS `drug_inventory`;
CREATE TABLE `drug_inventory`  (
  `drug_id` bigint NOT NULL AUTO_INCREMENT COMMENT '药品ID',
  `drug_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '药品名称',
  `specification` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '规格',
  `manufacturer` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '生产厂家',
  `stock_quantity` int NOT NULL DEFAULT 0 COMMENT '库存数量',
  `batch_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '批次号',
  `expiration_date` date NOT NULL COMMENT '有效期',
  `purchase_price` decimal(10, 2) NOT NULL COMMENT '进价',
  `retail_price` decimal(10, 2) NOT NULL COMMENT '零售价',
  `storage_location` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '药房货架A区' COMMENT '存放位置',
  `warning_threshold` int NULL DEFAULT 50 COMMENT '库存预警阈值',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志(0存在 2删除)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `unit_price` decimal(10, 3) NULL DEFAULT NULL COMMENT '单位价格（元/最小单位）',
  `unit_quantity` int NULL DEFAULT NULL COMMENT '每盒包含单位数量',
  `unit_type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位类型（粒/片/支等）',
  PRIMARY KEY (`drug_id`) USING BTREE,
  INDEX `idx_batch_expire`(`batch_number` ASC, `expiration_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '药品库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug_inventory
-- ----------------------------
INSERT INTO `drug_inventory` VALUES (1, '阿司匹林肠溶片', '100mg*30片', '拜耳医药保健有限公司', 219, '20240101', '2026-01-01', 15.00, 25.00, '药房货架A区1排', 30, '0', '0', '2024-01-01 10:00:00', '2025-02-24 22:13:39', 0.500, 30, '片');
INSERT INTO `drug_inventory` VALUES (2, '布洛芬缓释胶囊', '0.3g*20粒', '中美天津史克制药有限公司', 148, '20240201', '2026-02-01', 12.00, 20.00, '药房货架A区2排', 25, '0', '0', '2024-02-01 11:00:00', '2024-02-01 11:00:00', 0.600, 20, '粒');
INSERT INTO `drug_inventory` VALUES (3, '阿莫西林胶囊', '0.25g*24粒', '哈药集团制药总厂', 299, '20240301', '2026-03-01', 10.00, 18.00, '药房货架B区1排', 40, '0', '0', '2024-03-01 12:00:00', '2024-03-01 12:00:00', 0.417, 24, '粒');
INSERT INTO `drug_inventory` VALUES (4, '复方氨酚烷胺片', '100mg*12片', '仁和药业股份有限公司', 180, '20240401', '2026-04-01', 8.00, 15.00, '药房货架B区2排', 35, '0', '0', '2024-04-01 13:00:00', '2024-04-01 13:00:00', 0.667, 12, '片');
INSERT INTO `drug_inventory` VALUES (5, '奥美拉唑肠溶胶囊', '20mg*14粒', '悦康药业集团股份有限公司', 220, '20240501', '2026-05-01', 16.00, 28.00, '药房货架C区1排', 30, '0', '0', '2024-05-01 14:00:00', '2024-05-01 14:00:00', 1.143, 14, '粒');
INSERT INTO `drug_inventory` VALUES (6, '硝苯地平缓释片', '10mg*30片', '扬子江药业集团有限公司', 160, '20240601', '2026-06-01', 13.00, 23.00, '药房货架C区2排', 25, '0', '0', '2024-06-01 15:00:00', '2024-06-01 15:00:00', 0.433, 30, '片');
INSERT INTO `drug_inventory` VALUES (7, '盐酸氨溴索口服溶液', '100ml', '上海勃林格殷格翰药业有限公司', 250, '20240701', '2026-07-01', 18.00, 30.00, '药房货架D区1排', 40, '0', '0', '2024-07-01 16:00:00', '2024-07-01 16:00:00', 0.180, 100, 'ml');
INSERT INTO `drug_inventory` VALUES (8, '京都念慈庵蜜炼川贝枇杷膏', '300ml', '京都念慈庵总厂有限公司', 120, '20240801', '2026-08-01', 22.00, 38.00, '药房货架D区2排', 20, '0', '0', '2024-08-01 17:00:00', '2024-08-01 17:00:00', 0.073, 300, 'ml');
INSERT INTO `drug_inventory` VALUES (9, '风油精', '3ml', '福建太平洋制药有限公司', 400, '20240901', '2026-09-01', 3.00, 5.00, '药房货架E区1排', 50, '0', '0', '2024-09-01 18:00:00', '2024-09-01 18:00:00', 1.000, 3, 'ml');
INSERT INTO `drug_inventory` VALUES (10, '碘伏消毒液', '500ml', '利尔康股份有限公司', 350, '20241001', '2026-10-01', 8.00, 12.00, '药房货架E区2排', 35, '0', '0', '2024-10-01 19:00:00', '2024-10-01 19:00:00', 0.016, 500, 'ml');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作 sub主子表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'clients', '客户表', 'pets', 'client_id', 'Clients', 'crud', 'com.petHis.project.system', 'system', 'clients', '客户', 'petHis', 1, '0', '/', '{\"parentMenuId\":\"1\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"系统管理\",\"treeCode\":\"\"}', 'admin', '2025-02-16 15:28:32', '', '2025-02-16 20:32:39', '');
INSERT INTO `gen_table` VALUES (2, 'pets', '宠物表', 'clients', 'client_id', 'Pets', 'crud', 'com.petHis.project.system', 'system', 'pets', '宠物', 'petHis', 1, '0', '/', '{\"parentMenuId\":\"1\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"系统管理\",\"treeCode\":\"\"}', 'admin', '2025-02-16 15:30:26', '', '2025-02-17 19:17:08', '');
INSERT INTO `gen_table` VALUES (3, 'appointments', '预约表', '', NULL, 'Appointments', 'crud', 'com.petHis.project.system', 'system', 'appointments', '预约', 'petHis', 1, '0', '/', '{\"parentMenuId\":\"1\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"系统管理\",\"treeCode\":\"\"}', 'admin', '2025-02-16 15:32:12', '', '2025-02-16 15:34:29', '');
INSERT INTO `gen_table` VALUES (5, 'drug_inventory', '药品库存表', '', NULL, 'DrugInventory', 'crud', 'com.petHis.project.system', 'system', 'inventory', '药品库存', 'petHis', 1, '0', '/', '{\"parentMenuId\":\"2047\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"药品管理\",\"treeCode\":\"\"}', 'admin', '2025-02-23 13:51:18', '', '2025-02-23 14:04:19', '');
INSERT INTO `gen_table` VALUES (6, 'medication_record', '用药记录表', '', NULL, 'MedicationRecord', 'crud', 'com.petHis.project.system', 'system', 'record', '用药记录', 'petHis', 1, '0', '/', '{\"parentMenuId\":\"2050\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"用药记录管理\",\"treeCode\":\"\"}', 'admin', '2025-02-23 13:51:18', '', '2025-02-23 14:36:27', '');
INSERT INTO `gen_table` VALUES (8, 'sys_post', '岗位信息表', NULL, NULL, 'Post', 'crud', 'com.petHis.project.system', 'system', 'post', '岗位信息', 'petHis', 0, '0', '/', NULL, 'admin', '2025-02-24 12:41:18', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (9, 'company', '保险公司', '', NULL, 'Company', 'crud', 'com.petHis.project.system', 'system', 'company', 'company', 'petHis', 1, '0', '/', '{\"parentMenuId\":\"2073\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"合约公司\",\"treeCode\":\"\"}', 'admin', '2025-03-17 00:42:50', '', '2025-03-17 00:45:43', '');
INSERT INTO `gen_table` VALUES (11, 'insurance', '保险表', '', NULL, 'Insurance', 'crud', 'com.petHis.project.system', 'system', 'insurance', '保险', 'petHis', 1, '0', '/', '{\"parentMenuId\":\"2073\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"保险公司\",\"treeCode\":\"\"}', 'admin', '2025-03-17 01:26:38', '', '2025-03-17 01:28:20', '');

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'client_id', '客户ID', 'bigint(20)', 'Long', 'clientId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-16 15:28:32', NULL, '2025-02-16 20:32:39');
INSERT INTO `gen_table_column` VALUES (2, 1, 'name', '姓名', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-16 15:28:32', NULL, '2025-02-16 20:32:39');
INSERT INTO `gen_table_column` VALUES (3, 1, 'phone', '手机号', 'varchar(20)', 'String', 'phone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-16 15:28:32', NULL, '2025-02-16 20:32:39');
INSERT INTO `gen_table_column` VALUES (4, 1, 'address', '地址', 'varchar(200)', 'String', 'address', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-02-16 15:28:32', NULL, '2025-02-16 20:32:39');
INSERT INTO `gen_table_column` VALUES (5, 2, 'pet_id', '宠物ID', 'bigint(20)', 'Long', 'petId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-16 15:30:26', NULL, '2025-02-17 19:17:08');
INSERT INTO `gen_table_column` VALUES (6, 2, 'name', '宠物名', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-16 15:30:26', NULL, '2025-02-17 19:17:08');
INSERT INTO `gen_table_column` VALUES (7, 2, 'type', '品种', 'varchar(20)', 'String', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2025-02-16 15:30:26', NULL, '2025-02-17 19:17:08');
INSERT INTO `gen_table_column` VALUES (8, 2, 'birthday', '出生日期', 'date', 'Date', 'birthday', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2025-02-16 15:30:26', NULL, '2025-02-17 19:17:08');
INSERT INTO `gen_table_column` VALUES (9, 2, 'client_id', '关联客户ID', 'bigint(20)', 'Long', 'clientId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-02-16 15:30:26', NULL, '2025-02-17 19:17:08');
INSERT INTO `gen_table_column` VALUES (10, 2, 'health_status', '健康状况', 'varchar(50)', 'String', 'healthStatus', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 6, 'admin', '2025-02-16 15:30:26', NULL, '2025-02-17 19:17:08');
INSERT INTO `gen_table_column` VALUES (11, 3, 'appointment_id', '预约ID', 'bigint(20)', 'Long', 'appointmentId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-16 15:32:12', NULL, '2025-02-16 15:34:29');
INSERT INTO `gen_table_column` VALUES (12, 3, 'pet_id', '关联宠物ID', 'bigint(20)', 'Long', 'petId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-02-16 15:32:12', NULL, '2025-02-16 15:34:29');
INSERT INTO `gen_table_column` VALUES (13, 3, 'doctor_id', '关联医生ID（对应 sys_user 用户ID）', 'bigint(20)', 'Long', 'doctorId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-16 15:32:12', NULL, '2025-02-16 15:34:29');
INSERT INTO `gen_table_column` VALUES (14, 3, 'appointment_time', '预约时间', 'datetime', 'Date', 'appointmentTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2025-02-16 15:32:12', NULL, '2025-02-16 15:34:29');
INSERT INTO `gen_table_column` VALUES (15, 3, 'status', '状态（0待确认，1已确认，2已取消）', 'enum(\'0\',\'1\',\'2\')', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-02-16 15:32:12', NULL, '2025-02-16 15:34:29');
INSERT INTO `gen_table_column` VALUES (23, 5, 'drug_id', '药品ID', 'bigint(20)', 'Long', 'drugId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (24, 5, 'drug_name', '药品名称', 'varchar(100)', 'String', 'drugName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (25, 5, 'specification', '规格', 'varchar(100)', 'String', 'specification', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (26, 5, 'manufacturer', '生产厂家', 'varchar(100)', 'String', 'manufacturer', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (27, 5, 'stock_quantity', '库存数量', 'int(11)', 'Long', 'stockQuantity', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (28, 5, 'batch_number', '批次号', 'varchar(50)', 'String', 'batchNumber', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (29, 5, 'expiration_date', '有效期', 'date', 'Date', 'expirationDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (30, 5, 'purchase_price', '进价', 'decimal(10,2)', 'BigDecimal', 'purchasePrice', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (31, 5, 'retail_price', '零售价', 'decimal(10,2)', 'BigDecimal', 'retailPrice', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (32, 5, 'storage_location', '存放位置', 'varchar(100)', 'String', 'storageLocation', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (33, 5, 'warning_threshold', '库存预警阈值', 'int(11)', 'Long', 'warningThreshold', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (34, 5, 'status', '状态(0正常 1停用)', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 12, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (35, 5, 'del_flag', '删除标志(0存在 2删除)', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (36, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (37, 5, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:04:19');
INSERT INTO `gen_table_column` VALUES (38, 6, 'medication_id', '用药记录ID', 'bigint(20)', 'Long', 'medicationId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:36:27');
INSERT INTO `gen_table_column` VALUES (39, 6, 'record_id', '诊疗记录ID', 'bigint(20)', 'Long', 'recordId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:36:27');
INSERT INTO `gen_table_column` VALUES (40, 6, 'drug_id', '药品ID', 'bigint(20)', 'Long', 'drugId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:36:27');
INSERT INTO `gen_table_column` VALUES (41, 6, 'dosage', '用量（示例：2粒/次）', 'varchar(50)', 'String', 'dosage', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:36:27');
INSERT INTO `gen_table_column` VALUES (42, 6, 'usage_method', '用法', 'varchar(20)', 'String', 'usageMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:36:27');
INSERT INTO `gen_table_column` VALUES (43, 6, 'frequency', '频次', 'varchar(20)', 'String', 'frequency', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:36:27');
INSERT INTO `gen_table_column` VALUES (44, 6, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-02-23 13:51:18', NULL, '2025-02-23 14:36:27');
INSERT INTO `gen_table_column` VALUES (51, 8, 'post_id', '岗位ID', 'bigint(20)', 'Long', 'postId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (52, 8, 'post_code', '岗位编码', 'varchar(64)', 'String', 'postCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (53, 8, 'post_name', '岗位名称', 'varchar(50)', 'String', 'postName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (54, 8, 'post_sort', '显示顺序', 'int(4)', 'Integer', 'postSort', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (55, 8, 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (56, 8, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (57, 8, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (58, 8, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (59, 8, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (60, 8, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (61, 8, 'basic_salary', '基本工资', 'decimal(12,2)', 'BigDecimal', 'basicSalary', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (62, 8, 'bonus_coefficient', '奖金系数', 'decimal(3,2)', 'BigDecimal', 'bonusCoefficient', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-02-24 12:41:18', '', NULL);
INSERT INTO `gen_table_column` VALUES (63, 9, 'companyId', '', 'bigint', 'Long', 'companyId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-03-17 00:42:50', NULL, '2025-03-17 00:45:43');
INSERT INTO `gen_table_column` VALUES (64, 9, 'name', '', 'varchar(255)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-03-17 00:42:50', NULL, '2025-03-17 00:45:43');
INSERT INTO `gen_table_column` VALUES (71, 11, 'insurance_id', '保险ID', 'bigint', 'Long', 'insuranceId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-03-17 01:26:38', NULL, '2025-03-17 01:28:20');
INSERT INTO `gen_table_column` VALUES (72, 11, 'name', '保险名', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-03-17 01:26:38', NULL, '2025-03-17 01:28:20');
INSERT INTO `gen_table_column` VALUES (73, 11, 'level_1_num', '一级赔付额', 'decimal(10,4)', 'BigDecimal', 'level1Num', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2025-03-17 01:26:38', NULL, '2025-03-17 01:28:20');
INSERT INTO `gen_table_column` VALUES (74, 11, 'level_1_claim_ratio', '一级赔付比', 'decimal(5,2)', 'BigDecimal', 'level1ClaimRatio', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 4, 'admin', '2025-03-17 01:26:38', NULL, '2025-03-17 01:28:20');
INSERT INTO `gen_table_column` VALUES (75, 11, 'level_2_num', '二级赔付额', 'decimal(10,4)', 'BigDecimal', 'level2Num', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2025-03-17 01:26:38', NULL, '2025-03-17 01:28:20');
INSERT INTO `gen_table_column` VALUES (76, 11, 'level_2_claim_ratio', '二级赔付比', 'decimal(5,2)', 'BigDecimal', 'level2ClaimRatio', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 6, 'admin', '2025-03-17 01:26:38', NULL, '2025-03-17 01:28:20');

-- ----------------------------
-- Table structure for insurance
-- ----------------------------
DROP TABLE IF EXISTS `insurance`;
CREATE TABLE `insurance`  (
  `insurance_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `level_1_num` decimal(10, 4) NULL DEFAULT NULL,
  `level_1_claim_ratio` decimal(5, 2) NULL DEFAULT NULL,
  `level_2_num` decimal(10, 4) NULL DEFAULT NULL,
  `level_2_claim_ratio` decimal(5, 2) NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  `premium` decimal(10, 4) NULL DEFAULT NULL,
  PRIMARY KEY (`insurance_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of insurance
-- ----------------------------
INSERT INTO `insurance` VALUES (2, '测试保险', 100.0000, 10.00, 200.0000, 20.00, 16, 500.0000);

-- ----------------------------
-- Table structure for medication_record
-- ----------------------------
DROP TABLE IF EXISTS `medication_record`;
CREATE TABLE `medication_record`  (
  `medication_id` bigint NOT NULL AUTO_INCREMENT,
  `appointment_id` bigint NOT NULL COMMENT '预约记录ID',
  `drug_id` bigint NOT NULL COMMENT '药品ID',
  `dosage` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用量（示例：2粒/次）',
  `usage_method` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '口服' COMMENT '用法',
  `frequency` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '每日3次' COMMENT '频次',
  `create_time` datetime NULL DEFAULT NULL,
  `days` int NULL DEFAULT 0 COMMENT '吃几天药',
  PRIMARY KEY (`medication_id`) USING BTREE,
  UNIQUE INDEX `unique_medication_record`(`appointment_id` ASC, `drug_id` ASC) USING BTREE,
  INDEX `fk_appointment`(`appointment_id` ASC) USING BTREE,
  INDEX `fk_drug`(`drug_id` ASC) USING BTREE,
  CONSTRAINT `fk_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_drug` FOREIGN KEY (`drug_id`) REFERENCES `drug_inventory` (`drug_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用药记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medication_record
-- ----------------------------
INSERT INTO `medication_record` VALUES (20, 14, 1, '1', '5', '500', '2025-03-19 13:04:20', 2);

-- ----------------------------
-- Table structure for pets
-- ----------------------------
DROP TABLE IF EXISTS `pets`;
CREATE TABLE `pets`  (
  `pet_id` bigint NOT NULL AUTO_INCREMENT COMMENT '宠物ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '宠物名',
  `pet_pic` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '宠物图片路径',
  `type` bigint NOT NULL COMMENT '品种ID，关联字典表(sys_dict_data)',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `client_id` bigint NOT NULL COMMENT '关联客户表(clients.client_id)',
  `health_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '健康状况（0健康，1生病）',
  `insurance_id` bigint NULL DEFAULT NULL,
  `insurance_end_at` date NULL DEFAULT NULL,
  PRIMARY KEY (`pet_id`) USING BTREE,
  INDEX `idx_client_id`(`client_id` ASC) USING BTREE,
  INDEX `idx_insurance_id`(`insurance_id` ASC) USING BTREE,
  CONSTRAINT `pets_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `pets_ibfk_2` FOREIGN KEY (`insurance_id`) REFERENCES `insurance` (`insurance_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '宠物表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pets
-- ----------------------------
INSERT INTO `pets` VALUES (17, '测试猫1', '', 1, '2025-03-19', 15, '0', 2, NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '深黑主题theme-dark，浅色主题theme-light，深蓝主题theme-blue');
INSERT INTO `sys_config` VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-02-16 12:38:47', 'admin', '2025-02-21 14:50:01', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');
INSERT INTO `sys_config` VALUES (6, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (7, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '主框架页-菜单导航显示风格', 'sys.index.menuStyle', 'default', 'Y', 'admin', '2025-02-16 12:38:47', 'admin', '2025-02-21 10:36:44', '菜单导航显示风格（default为左侧导航菜单，topnav为顶部导航菜单）');
INSERT INTO `sys_config` VALUES (9, '主框架页-是否开启页脚', 'sys.index.footer', 'true', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '是否开启底部页脚显示（true显示，false隐藏）');
INSERT INTO `sys_config` VALUES (10, '主框架页-是否开启页签', 'sys.index.tagsView', 'true', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '是否开启菜单多页签显示（true显示，false隐藏）');
INSERT INTO `sys_config` VALUES (11, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-02-16 12:38:47', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '精灵爱宠医院', 0, 'ymd', '15888888888', 'ymd@qq.com', '0', '0', 'admin', '2025-02-16 12:38:47', 'admin', '2025-02-17 20:21:55');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '温州总公司', 1, 'ymd', '15888888888', 'ymd@qq.com', '0', '2', 'admin', '2025-02-16 12:38:47', 'admin', '2025-02-18 10:00:33');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '宠物医院', '15888888888', 'ry@qq.com', '1', '2', 'admin', '2025-02-16 12:38:47', 'admin', '2025-02-18 10:36:59');
INSERT INTO `sys_dept` VALUES (110, 101, '0,100,101', '诊疗服务部', 1, 'ymd', '15888888888', 'ymd@qq.com', '0', '2', 'admin', '2025-02-18 10:00:58', 'admin', '2025-02-18 10:04:40');
INSERT INTO `sys_dept` VALUES (111, 101, '0,100,101', '客户运营部', 1, 'ymd', '15888888888', 'ymd@163.com', '0', '2', 'admin', '2025-02-18 10:01:30', 'admin', '2025-02-18 10:04:50');
INSERT INTO `sys_dept` VALUES (112, 101, '0,100,101', '后勤部', 1, 'ymd', '15888888888', 'ymd@163.com', '0', '2', 'admin', '2025-02-18 10:20:57', '', NULL);
INSERT INTO `sys_dept` VALUES (113, 101, '0,100,101', '客户信息部', 1, 'ymd', '15888888888', 'ymd@163.com', '0', '2', 'admin', '2025-02-22 20:08:53', '', NULL);
INSERT INTO `sys_dept` VALUES (114, 101, '0,100,101', '财务部', 1, 'ymd', '15888888888', 'ymd@qq.com', '0', '2', 'admin', '2025-02-24 11:10:29', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE,
  INDEX `dict_value`(`dict_value` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (30, 1, '猫', '1', 'sys_pet_type', '', '', 'Y', '0', 'admin', '2025-02-20 16:42:36', 'admin', '2025-02-20 16:45:24', '类型：猫');
INSERT INTO `sys_dict_data` VALUES (31, 2, '狗', '2', 'sys_pet_type', '', '', 'N', '0', 'admin', '2025-02-20 16:42:59', 'admin', '2025-02-20 16:45:18', '类型：狗');
INSERT INTO `sys_dict_data` VALUES (32, 3, '仓鼠', '3', 'sys_pet_type', '', '', 'N', '0', 'admin', '2025-02-20 16:44:27', 'admin', '2025-02-20 16:45:13', '类型：仓鼠');
INSERT INTO `sys_dict_data` VALUES (33, 4, '未知', '0', 'sys_pet_type', NULL, NULL, 'N', '0', 'admin', '2025-02-20 16:45:50', '', NULL, '未知类型');
INSERT INTO `sys_dict_data` VALUES (34, 1, '员工工资支出', '1', 'sys_financial_record', '', '', 'Y', '0', 'admin', '2025-02-24 12:14:46', 'admin', '2025-02-24 12:15:35', '');
INSERT INTO `sys_dict_data` VALUES (35, 2, '药品采购支出', '2', 'sys_financial_record', NULL, NULL, 'Y', '0', 'admin', '2025-02-24 12:15:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (36, 3, '医疗服务收入', '3', 'sys_financial_record', NULL, NULL, 'Y', '0', 'admin', '2025-02-24 12:15:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (37, 1, '已预约', '0', 'sys_appointments_status', '', 'primary', 'Y', '0', 'admin', '2025-02-25 11:08:06', 'admin', '2025-02-25 11:33:08', '已预约状态');
INSERT INTO `sys_dict_data` VALUES (38, 2, '已确认', '1', 'sys_appointments_status', '', 'success', 'N', '0', 'admin', '2025-02-25 11:08:22', 'admin', '2025-02-25 11:33:16', '已确认状态');
INSERT INTO `sys_dict_data` VALUES (39, 3, '已取消', '2', 'sys_appointments_status', '', 'warning', 'N', '0', 'admin', '2025-02-25 11:08:33', 'admin', '2025-02-25 11:33:24', '已取消状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '宠物类别', 'sys_pet_type', '0', 'admin', '2025-02-20 16:40:50', '', NULL, '宠物种类');
INSERT INTO `sys_dict_type` VALUES (12, '财务记录类型', 'sys_financial_record', '0', 'admin', '2025-02-24 12:13:59', '', NULL, '记录目前有哪些财务收支类型');
INSERT INTO `sys_dict_type` VALUES (13, '预约状态', 'sys_appointments_status', '0', 'admin', '2025-02-25 11:07:42', 'admin', '2025-02-25 11:32:27', '预约状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-02-16 12:38:47', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 456 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-16 12:59:01');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-16 13:06:15');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-16 14:28:32');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-16 14:50:04');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-16 15:50:39');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-16 16:37:24');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-16 19:43:52');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-16 20:20:39');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 09:35:53');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 10:36:34');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 10:47:45');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 11:20:10');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 11:34:26');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 11:36:54');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 11:43:35');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 13:18:22');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 13:49:48');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 14:33:09');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 14:38:15');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 14:56:07');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 14:59:00');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:18:05');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:26:53');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:29:07');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:33:33');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:35:54');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:45:04');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:53:05');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 15:55:12');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 16:08:29');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 16:18:52');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 16:57:41');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:00:46');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:08:52');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:10:33');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:14:52');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:19:09');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:25:10');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:27:07');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 17:59:36');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 18:02:02');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 18:08:25');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 19:14:47');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 19:33:40');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 19:35:53');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 20:36:50');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:05:04');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:20:38');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:22:13');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:24:21');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:32:23');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:33:28');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:34:45');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:40:15');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:42:06');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:44:52');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:46:28');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-17 21:59:49');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 09:37:50');
INSERT INTO `sys_logininfor` VALUES (159, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误1次', '2025-02-18 10:39:23');
INSERT INTO `sys_logininfor` VALUES (160, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 10:39:54');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 12:29:48');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 12:38:14');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 12:41:28');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 12:59:11');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 13:00:48');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 13:02:10');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 13:03:53');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 13:08:00');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 13:09:40');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 14:26:57');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 14:48:48');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 14:51:07');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:05:22');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:05:49');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:17:23');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:25:34');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:28:12');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:42:45');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:54:37');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 15:56:32');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:06:15');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:08:31');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:12:24');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:16:27');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:18:43');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-18 16:26:51');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误1次', '2025-02-18 16:27:08');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误2次', '2025-02-18 16:27:09');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误3次', '2025-02-18 16:27:15');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误4次', '2025-02-18 16:27:21');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误5次', '2025-02-18 16:27:26');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-02-18 16:29:49');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-02-18 16:29:55');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-02-18 16:32:36');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-02-18 16:33:01');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:48:02');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-18 16:48:40');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '密码输入错误1次', '2025-02-18 16:48:52');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:49:04');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-18 16:49:07');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:49:15');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:52:04');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 16:52:33');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 17:01:17');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 17:03:07');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 17:08:06');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 17:09:54');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 17:35:05');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:03:21');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:04:07');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:04:51');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:08:16');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:18:34');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:22:03');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:23:38');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:24:39');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:27:53');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:28:44');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 18:30:31');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 19:03:53');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 19:04:45');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 19:07:22');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 19:11:44');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 19:13:47');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 19:14:40');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 19:59:15');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 20:01:25');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 20:03:14');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 20:05:31');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 20:16:46');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 20:54:23');
INSERT INTO `sys_logininfor` VALUES (232, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:02:16');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:03:39');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:07:33');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:09:12');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:11:16');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:16:05');
INSERT INTO `sys_logininfor` VALUES (238, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:20:19');
INSERT INTO `sys_logininfor` VALUES (239, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:23:57');
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:25:40');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:26:31');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:39:03');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 21:44:06');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 22:38:36');
INSERT INTO `sys_logininfor` VALUES (245, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-18 22:49:18');
INSERT INTO `sys_logininfor` VALUES (246, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-18 23:12:58');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-18 23:13:15');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 09:42:19');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-19 09:42:29');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 09:53:12');
INSERT INTO `sys_logininfor` VALUES (251, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:03:13');
INSERT INTO `sys_logininfor` VALUES (252, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-19 10:03:40');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:40:00');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:41:19');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:49:24');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:51:09');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:51:51');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:53:12');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:54:13');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 10:56:18');
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 11:09:26');
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-19 11:09:29');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 11:37:19');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 11:38:23');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 11:40:44');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 11:44:51');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 11:45:47');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:08:36');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:14:25');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:16:04');
INSERT INTO `sys_logininfor` VALUES (271, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:40:34');
INSERT INTO `sys_logininfor` VALUES (272, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:43:04');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:45:00');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:46:25');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:48:49');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:53:02');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:55:29');
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 12:57:50');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 13:42:27');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 13:44:08');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-19 13:47:59');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:15:44');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:17:08');
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:19:01');
INSERT INTO `sys_logininfor` VALUES (285, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-19 14:19:25');
INSERT INTO `sys_logininfor` VALUES (286, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:20:24');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:23:55');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:30:29');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:32:37');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:33:16');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:33:52');
INSERT INTO `sys_logininfor` VALUES (292, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 14:46:32');
INSERT INTO `sys_logininfor` VALUES (293, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:27:16');
INSERT INTO `sys_logininfor` VALUES (294, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:28:35');
INSERT INTO `sys_logininfor` VALUES (295, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:31:20');
INSERT INTO `sys_logininfor` VALUES (296, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:33:20');
INSERT INTO `sys_logininfor` VALUES (297, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:33:54');
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:34:51');
INSERT INTO `sys_logininfor` VALUES (299, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:37:24');
INSERT INTO `sys_logininfor` VALUES (300, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:42:20');
INSERT INTO `sys_logininfor` VALUES (301, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:43:00');
INSERT INTO `sys_logininfor` VALUES (302, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:43:27');
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:44:55');
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:47:30');
INSERT INTO `sys_logininfor` VALUES (305, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:48:18');
INSERT INTO `sys_logininfor` VALUES (306, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:50:54');
INSERT INTO `sys_logininfor` VALUES (307, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:53:25');
INSERT INTO `sys_logininfor` VALUES (308, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 15:57:00');
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:23:52');
INSERT INTO `sys_logininfor` VALUES (310, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:27:35');
INSERT INTO `sys_logininfor` VALUES (311, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:32:24');
INSERT INTO `sys_logininfor` VALUES (312, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:44:06');
INSERT INTO `sys_logininfor` VALUES (313, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:44:48');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:48:49');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:50:35');
INSERT INTO `sys_logininfor` VALUES (316, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:51:51');
INSERT INTO `sys_logininfor` VALUES (317, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:53:29');
INSERT INTO `sys_logininfor` VALUES (318, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 16:58:17');
INSERT INTO `sys_logininfor` VALUES (319, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-19 17:10:53');
INSERT INTO `sys_logininfor` VALUES (320, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 17:10:55');
INSERT INTO `sys_logininfor` VALUES (321, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-19 17:11:08');
INSERT INTO `sys_logininfor` VALUES (322, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 17:11:17');
INSERT INTO `sys_logininfor` VALUES (323, 'khyy1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-19 17:37:49');
INSERT INTO `sys_logininfor` VALUES (324, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 17:53:41');
INSERT INTO `sys_logininfor` VALUES (325, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:08:03');
INSERT INTO `sys_logininfor` VALUES (326, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:08:32');
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:09:36');
INSERT INTO `sys_logininfor` VALUES (328, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:09:51');
INSERT INTO `sys_logininfor` VALUES (329, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:13:35');
INSERT INTO `sys_logininfor` VALUES (330, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:13:52');
INSERT INTO `sys_logininfor` VALUES (331, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:17:03');
INSERT INTO `sys_logininfor` VALUES (332, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:20:04');
INSERT INTO `sys_logininfor` VALUES (333, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:20:55');
INSERT INTO `sys_logininfor` VALUES (334, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:21:51');
INSERT INTO `sys_logininfor` VALUES (335, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:22:36');
INSERT INTO `sys_logininfor` VALUES (336, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:23:53');
INSERT INTO `sys_logininfor` VALUES (337, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:24:29');
INSERT INTO `sys_logininfor` VALUES (338, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:25:52');
INSERT INTO `sys_logininfor` VALUES (339, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:26:27');
INSERT INTO `sys_logininfor` VALUES (340, 'khyy1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-19 18:27:21');
INSERT INTO `sys_logininfor` VALUES (341, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 18:29:13');
INSERT INTO `sys_logininfor` VALUES (342, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 19:18:03');
INSERT INTO `sys_logininfor` VALUES (343, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 19:28:43');
INSERT INTO `sys_logininfor` VALUES (344, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 19:29:57');
INSERT INTO `sys_logininfor` VALUES (345, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 19:30:53');
INSERT INTO `sys_logininfor` VALUES (346, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 19:32:19');
INSERT INTO `sys_logininfor` VALUES (347, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 19:33:06');
INSERT INTO `sys_logininfor` VALUES (348, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 19:43:58');
INSERT INTO `sys_logininfor` VALUES (349, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 20:05:06');
INSERT INTO `sys_logininfor` VALUES (350, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 20:07:43');
INSERT INTO `sys_logininfor` VALUES (351, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 20:11:58');
INSERT INTO `sys_logininfor` VALUES (352, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 20:12:55');
INSERT INTO `sys_logininfor` VALUES (353, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 20:19:25');
INSERT INTO `sys_logininfor` VALUES (354, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 20:20:29');
INSERT INTO `sys_logininfor` VALUES (355, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-19 20:22:56');
INSERT INTO `sys_logininfor` VALUES (356, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 16:39:25');
INSERT INTO `sys_logininfor` VALUES (357, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 17:38:14');
INSERT INTO `sys_logininfor` VALUES (358, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 17:49:17');
INSERT INTO `sys_logininfor` VALUES (359, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 17:51:30');
INSERT INTO `sys_logininfor` VALUES (360, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 17:53:42');
INSERT INTO `sys_logininfor` VALUES (361, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 17:59:49');
INSERT INTO `sys_logininfor` VALUES (362, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 18:01:54');
INSERT INTO `sys_logininfor` VALUES (363, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 18:04:24');
INSERT INTO `sys_logininfor` VALUES (364, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 18:19:09');
INSERT INTO `sys_logininfor` VALUES (365, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 19:04:07');
INSERT INTO `sys_logininfor` VALUES (366, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 19:24:32');
INSERT INTO `sys_logininfor` VALUES (367, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 19:27:07');
INSERT INTO `sys_logininfor` VALUES (368, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 19:47:32');
INSERT INTO `sys_logininfor` VALUES (369, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:13:39');
INSERT INTO `sys_logininfor` VALUES (370, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:16:43');
INSERT INTO `sys_logininfor` VALUES (371, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:18:35');
INSERT INTO `sys_logininfor` VALUES (372, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:20:23');
INSERT INTO `sys_logininfor` VALUES (373, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:25:10');
INSERT INTO `sys_logininfor` VALUES (374, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:27:03');
INSERT INTO `sys_logininfor` VALUES (375, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:29:00');
INSERT INTO `sys_logininfor` VALUES (376, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:35:21');
INSERT INTO `sys_logininfor` VALUES (377, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:37:15');
INSERT INTO `sys_logininfor` VALUES (378, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:38:54');
INSERT INTO `sys_logininfor` VALUES (379, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:41:35');
INSERT INTO `sys_logininfor` VALUES (380, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:44:18');
INSERT INTO `sys_logininfor` VALUES (381, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:57:30');
INSERT INTO `sys_logininfor` VALUES (382, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:58:19');
INSERT INTO `sys_logininfor` VALUES (383, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:58:50');
INSERT INTO `sys_logininfor` VALUES (384, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-20 20:59:01');
INSERT INTO `sys_logininfor` VALUES (385, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:59:08');
INSERT INTO `sys_logininfor` VALUES (386, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-20 20:59:12');
INSERT INTO `sys_logininfor` VALUES (387, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 20:59:21');
INSERT INTO `sys_logininfor` VALUES (388, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 21:12:31');
INSERT INTO `sys_logininfor` VALUES (389, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 21:24:18');
INSERT INTO `sys_logininfor` VALUES (390, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 21:27:23');
INSERT INTO `sys_logininfor` VALUES (391, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 21:30:25');
INSERT INTO `sys_logininfor` VALUES (392, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 21:31:29');
INSERT INTO `sys_logininfor` VALUES (393, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-20 21:47:42');
INSERT INTO `sys_logininfor` VALUES (394, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 09:49:37');
INSERT INTO `sys_logininfor` VALUES (395, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 10:01:03');
INSERT INTO `sys_logininfor` VALUES (396, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 10:01:31');
INSERT INTO `sys_logininfor` VALUES (397, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 10:01:49');
INSERT INTO `sys_logininfor` VALUES (398, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 10:02:06');
INSERT INTO `sys_logininfor` VALUES (399, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 10:02:50');
INSERT INTO `sys_logininfor` VALUES (400, 'ys1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 10:11:50');
INSERT INTO `sys_logininfor` VALUES (401, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 10:11:53');
INSERT INTO `sys_logininfor` VALUES (402, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 10:37:29');
INSERT INTO `sys_logininfor` VALUES (403, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 10:52:42');
INSERT INTO `sys_logininfor` VALUES (404, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 10:56:28');
INSERT INTO `sys_logininfor` VALUES (405, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 11:15:24');
INSERT INTO `sys_logininfor` VALUES (406, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 11:17:25');
INSERT INTO `sys_logininfor` VALUES (407, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 11:20:17');
INSERT INTO `sys_logininfor` VALUES (408, '测试1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '用户不存在/密码错误', '2025-02-21 11:20:35');
INSERT INTO `sys_logininfor` VALUES (409, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 11:20:47');
INSERT INTO `sys_logininfor` VALUES (410, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 11:21:46');
INSERT INTO `sys_logininfor` VALUES (411, 'ceshi', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 11:22:08');
INSERT INTO `sys_logininfor` VALUES (412, 'ceshi', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 11:23:21');
INSERT INTO `sys_logininfor` VALUES (413, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 11:23:26');
INSERT INTO `sys_logininfor` VALUES (414, '客户111', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '用户不存在/密码错误', '2025-02-21 11:24:52');
INSERT INTO `sys_logininfor` VALUES (415, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 11:25:09');
INSERT INTO `sys_logininfor` VALUES (416, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 12:14:57');
INSERT INTO `sys_logininfor` VALUES (417, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 12:19:11');
INSERT INTO `sys_logininfor` VALUES (418, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 13:08:28');
INSERT INTO `sys_logininfor` VALUES (419, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 13:24:39');
INSERT INTO `sys_logininfor` VALUES (420, '测试1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '用户不存在/密码错误', '2025-02-21 13:24:55');
INSERT INTO `sys_logininfor` VALUES (421, '测试1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '用户不存在/密码错误', '2025-02-21 13:24:59');
INSERT INTO `sys_logininfor` VALUES (422, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 13:25:15');
INSERT INTO `sys_logininfor` VALUES (423, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 13:57:32');
INSERT INTO `sys_logininfor` VALUES (424, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 14:49:25');
INSERT INTO `sys_logininfor` VALUES (425, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 14:50:06');
INSERT INTO `sys_logininfor` VALUES (426, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 15:13:17');
INSERT INTO `sys_logininfor` VALUES (427, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 15:13:49');
INSERT INTO `sys_logininfor` VALUES (428, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 15:14:13');
INSERT INTO `sys_logininfor` VALUES (429, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 18:36:21');
INSERT INTO `sys_logininfor` VALUES (430, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 18:42:07');
INSERT INTO `sys_logininfor` VALUES (431, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 19:06:59');
INSERT INTO `sys_logininfor` VALUES (432, 'yyy', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '注册成功', '2025-02-21 19:07:30');
INSERT INTO `sys_logininfor` VALUES (433, 'yyy', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 19:07:39');
INSERT INTO `sys_logininfor` VALUES (434, 'yyy', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 19:08:17');
INSERT INTO `sys_logininfor` VALUES (435, 'ceshi', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 19:08:23');
INSERT INTO `sys_logininfor` VALUES (436, 'ceshi', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 19:13:45');
INSERT INTO `sys_logininfor` VALUES (437, 'yyy', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 19:13:49');
INSERT INTO `sys_logininfor` VALUES (438, 'yyy', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 19:16:28');
INSERT INTO `sys_logininfor` VALUES (439, 'ys', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '用户不存在/密码错误', '2025-02-21 19:16:48');
INSERT INTO `sys_logininfor` VALUES (440, 'ys', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '用户不存在/密码错误', '2025-02-21 19:17:00');
INSERT INTO `sys_logininfor` VALUES (441, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 19:17:11');
INSERT INTO `sys_logininfor` VALUES (442, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-21 19:18:33');
INSERT INTO `sys_logininfor` VALUES (443, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 19:22:04');
INSERT INTO `sys_logininfor` VALUES (444, 'khyy1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 19:23:14');
INSERT INTO `sys_logininfor` VALUES (445, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 19:26:45');
INSERT INTO `sys_logininfor` VALUES (446, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 20:17:27');
INSERT INTO `sys_logininfor` VALUES (447, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 20:31:01');
INSERT INTO `sys_logininfor` VALUES (448, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 20:47:16');
INSERT INTO `sys_logininfor` VALUES (449, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-21 20:52:41');
INSERT INTO `sys_logininfor` VALUES (450, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-22 11:55:03');
INSERT INTO `sys_logininfor` VALUES (451, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-22 14:40:54');
INSERT INTO `sys_logininfor` VALUES (452, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-22 16:42:19');
INSERT INTO `sys_logininfor` VALUES (453, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-22 18:12:03');
INSERT INTO `sys_logininfor` VALUES (454, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-22 18:53:59');
INSERT INTO `sys_logininfor` VALUES (455, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-22 19:19:52');
INSERT INTO `sys_logininfor` VALUES (456, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-22 19:34:03');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `url` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '#' COMMENT '请求地址',
  `target` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '打开方式（menuItem页签 menuBlank新窗口）',
  `menu_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `is_refresh` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '是否刷新（0刷新 1不刷新）',
  `perms` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2090 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, '#', '', 'M', '0', '1', '', 'fa fa-gear', 'admin', '2025-02-16 12:38:47', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 9, '#', 'menuItem', 'M', '1', '1', '', 'fa fa-bars', 'admin', '2025-02-16 12:38:47', 'admin', '2025-04-01 20:48:58', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '宠物主人管理', 0, 2, '/system/clients', 'menuItem', 'C', '0', '0', 'system:clients:view', 'fa fa-address-card', 'admin', '2025-02-16 12:38:47', 'admin', '2025-03-15 21:30:18', '宠物医院官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 2, '/system/user', 'menuItem', 'C', '0', '1', 'system:user:view', 'fa fa-user-o', 'admin', '2025-02-16 12:38:47', 'admin', '2025-02-22 20:31:04', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, '/system/role', '', 'C', '0', '1', 'system:role:view', 'fa fa-user-secret', 'admin', '2025-02-16 12:38:47', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, '/system/menu', '', 'C', '0', '1', 'system:menu:view', 'fa fa-th-list', 'admin', '2025-02-16 12:38:47', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, '/system/dept', '', 'C', '0', '1', 'system:dept:view', 'fa fa-outdent', 'admin', '2025-02-16 12:38:47', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, '/system/post', '', 'C', '0', '1', 'system:post:view', 'fa fa-address-card-o', 'admin', '2025-02-16 12:38:47', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, '/system/dict', '', 'C', '0', '1', 'system:dict:view', 'fa fa-bookmark-o', 'admin', '2025-02-16 12:38:47', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, '/system/config', '', 'C', '0', '1', 'system:config:view', 'fa fa-sun-o', 'admin', '2025-02-16 12:38:47', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 1, '/system/notice', 'menuItem', 'C', '0', '1', 'system:notice:view', 'fa fa-bullhorn', 'admin', '2025-02-16 12:38:47', 'admin', '2025-02-22 20:30:52', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, '/tool/build', '', 'C', '0', '1', 'tool:build:view', 'fa fa-wpforms', 'admin', '2025-02-16 12:38:47', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, '/tool/gen', '', 'C', '0', '1', 'tool:gen:view', 'fa fa-code', 'admin', '2025-02-16 12:38:47', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, '/tool/swagger', '', 'C', '0', '1', 'tool:swagger:view', 'fa fa-gg', 'admin', '2025-02-16 12:38:47', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '#', '', 'F', '0', '1', 'system:user:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '#', '', 'F', '0', '1', 'system:user:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '#', '', 'F', '0', '1', 'system:user:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '#', '', 'F', '0', '1', 'system:user:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '#', '', 'F', '0', '1', 'system:user:export', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '#', '', 'F', '0', '1', 'system:user:import', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '#', '', 'F', '0', '1', 'system:user:resetPwd', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '#', '', 'F', '0', '1', 'system:role:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '#', '', 'F', '0', '1', 'system:role:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '#', '', 'F', '0', '1', 'system:role:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '#', '', 'F', '0', '1', 'system:role:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '#', '', 'F', '0', '1', 'system:role:export', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '#', '', 'F', '0', '1', 'system:menu:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '#', '', 'F', '0', '1', 'system:menu:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '#', '', 'F', '0', '1', 'system:menu:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '#', '', 'F', '0', '1', 'system:menu:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '#', '', 'F', '0', '1', 'system:dept:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '#', '', 'F', '0', '1', 'system:dept:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '#', '', 'F', '0', '1', 'system:dept:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '#', '', 'F', '0', '1', 'system:dept:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '#', '', 'F', '0', '1', 'system:post:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '#', '', 'F', '0', '1', 'system:post:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '#', '', 'F', '0', '1', 'system:post:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '#', '', 'F', '0', '1', 'system:post:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '#', '', 'F', '0', '1', 'system:post:export', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', 'F', '0', '1', 'system:dict:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', 'F', '0', '1', 'system:dict:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', 'F', '0', '1', 'system:dict:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', 'F', '0', '1', 'system:dict:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', 'F', '0', '1', 'system:dict:export', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', 'F', '0', '1', 'system:config:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', 'F', '0', '1', 'system:config:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', 'F', '0', '1', 'system:config:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', 'F', '0', '1', 'system:config:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', 'F', '0', '1', 'system:config:export', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', 'F', '0', '1', 'system:notice:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', 'F', '0', '1', 'system:notice:add', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', 'F', '0', '1', 'system:notice:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', 'F', '0', '1', 'system:notice:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成查询', 115, 1, '#', '', 'F', '0', '1', 'tool:gen:list', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '生成修改', 115, 2, '#', '', 'F', '0', '1', 'tool:gen:edit', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '生成删除', 115, 3, '#', '', 'F', '0', '1', 'tool:gen:remove', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '预览代码', 115, 4, '#', '', 'F', '0', '1', 'tool:gen:preview', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1061, '生成代码', 115, 5, '#', '', 'F', '0', '1', 'tool:gen:code', '#', 'admin', '2025-02-16 12:38:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '宠物管理', 0, 3, '/system/pets', 'menuItem', 'C', '0', '0', 'system:pets:view', 'fa fa-paw', 'admin', '2025-02-17 09:58:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '预约管理', 0, 4, '/system/appointments', 'menuItem', 'C', '0', '0', 'system:appointments:view', 'fa fa-calendar-plus-o', 'admin', '2025-02-17 10:00:10', 'admin', '2025-03-16 15:54:13', '');
INSERT INTO `sys_menu` VALUES (2027, '查询客户', 4, 1, '#', 'menuItem', 'F', '0', '1', 'system:clients:list', '#', 'admin', '2025-02-18 10:25:40', 'admin', '2025-02-18 10:42:55', '');
INSERT INTO `sys_menu` VALUES (2028, '导出客户', 4, 1, '#', 'menuItem', 'F', '0', '1', 'system:clients:export', '#', 'admin', '2025-02-18 10:42:31', 'admin', '2025-02-18 10:43:04', '');
INSERT INTO `sys_menu` VALUES (2029, '新增客户', 4, 1, '#', 'menuItem', 'F', '0', '1', 'system:clients:add', '#', 'admin', '2025-02-18 10:43:26', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '修改客户', 4, 1, '#', 'menuItem', 'F', '0', '1', 'system:clients:edit', '#', 'admin', '2025-02-18 10:44:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '删除客户', 4, 1, '#', 'menuItem', 'F', '0', '1', 'system:clients:remove', '#', 'admin', '2025-02-18 10:44:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '查询宠物', 2024, 1, '#', 'menuItem', 'F', '0', '1', 'system:pets:list', '#', 'admin', '2025-02-18 10:45:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '导出宠物', 2024, 1, '#', 'menuItem', 'F', '0', '1', 'system:pets:export', '#', 'admin', '2025-02-18 10:45:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '新增宠物', 2024, 1, '#', 'menuItem', 'F', '0', '1', 'system:pets:add', '#', 'admin', '2025-02-18 10:46:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '修改宠物', 2024, 1, '#', 'menuItem', 'F', '0', '1', 'system:pets:edit', '#', 'admin', '2025-02-18 10:46:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '删除宠物', 2024, 1, '#', 'menuItem', 'F', '0', '1', 'system:pets:remove', '#', 'admin', '2025-02-18 10:46:48', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '查询预约', 2025, 1, '#', 'menuItem', 'F', '0', '1', 'system:appointments:list', '#', 'admin', '2025-02-19 16:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '导出预约', 2025, 1, '#', 'menuItem', 'F', '0', '1', 'system:appointments:export', '#', 'admin', '2025-02-19 17:00:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '新增预约', 2025, 1, '#', 'menuItem', 'F', '0', '1', 'system:appointments:add', '#', 'admin', '2025-02-19 17:00:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '修改预约', 2025, 1, '#', 'menuItem', 'F', '0', '1', 'system:appointments:edit', '#', 'admin', '2025-02-19 17:01:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '删除预约', 2025, 1, '#', 'menuItem', 'F', '0', '1', 'system:appointments:remove', '#', 'admin', '2025-02-19 17:01:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '药品管理', 0, 7, 'system/inventory', 'menuItem', 'C', '0', '1', 'system:inventory:view', 'fa fa-briefcase', 'admin', '2025-02-23 14:03:48', 'admin', '2025-02-23 14:16:18', '');
INSERT INTO `sys_menu` VALUES (2050, '用药记录管理', 0, 5, 'system/record', 'menuItem', 'C', '0', '1', 'system:record:view', 'fa fa-sticky-note', 'admin', '2025-02-23 14:16:56', 'admin', '2025-03-16 16:16:21', '');
INSERT INTO `sys_menu` VALUES (2057, '药品库存查询', 2047, 1, '#', '', 'F', '0', '1', 'system:inventory:list', '#', 'admin', '2025-02-23 14:24:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '药品库存新增', 2047, 2, '#', '', 'F', '0', '1', 'system:inventory:add', '#', 'admin', '2025-02-23 14:24:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '药品库存修改', 2047, 3, '#', '', 'F', '0', '1', 'system:inventory:edit', '#', 'admin', '2025-02-23 14:24:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '药品库存删除', 2047, 4, '#', '', 'F', '0', '1', 'system:inventory:remove', '#', 'admin', '2025-02-23 14:24:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2061, '药品库存导出', 2047, 5, '#', '', 'F', '0', '1', 'system:inventory:export', '#', 'admin', '2025-02-23 14:24:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2062, '用药记录查询', 2050, 1, '#', '', 'F', '0', '1', 'system:record:list', '#', 'admin', '2025-02-23 14:26:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '用药记录新增', 2050, 2, '#', '', 'F', '0', '1', 'system:record:add', '#', 'admin', '2025-02-23 14:26:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '用药记录修改', 2050, 3, '#', '', 'F', '0', '1', 'system:record:edit', '#', 'admin', '2025-02-23 14:26:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '用药记录删除', 2050, 4, '#', '', 'F', '0', '1', 'system:record:remove', '#', 'admin', '2025-02-23 14:26:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '用药记录导出', 2050, 5, '#', '', 'F', '0', '1', 'system:record:export', '#', 'admin', '2025-02-23 14:26:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, '保险公司', 0, 8, '#', 'menuItem', 'M', '0', '1', '', '#', 'admin', '2025-03-17 00:45:35', 'admin', '2025-03-17 00:50:36', '');
INSERT INTO `sys_menu` VALUES (2074, '保险公司列表', 2073, 1, '/system/company', 'menuItem', 'C', '0', '1', 'system:company:view', '#', 'admin', '2025-03-17 00:47:24', 'admin', '2025-03-17 00:50:52', 'company菜单');
INSERT INTO `sys_menu` VALUES (2075, 'company查询', 2074, 1, '#', '', 'F', '0', '1', 'system:company:list', '#', 'admin', '2025-03-17 00:47:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2076, 'company新增', 2074, 2, '#', '', 'F', '0', '1', 'system:company:add', '#', 'admin', '2025-03-17 00:47:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2077, 'company修改', 2074, 3, '#', '', 'F', '0', '1', 'system:company:edit', '#', 'admin', '2025-03-17 00:47:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2078, 'company删除', 2074, 4, '#', '', 'F', '0', '1', 'system:company:remove', '#', 'admin', '2025-03-17 00:47:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2079, 'company导出', 2074, 5, '#', '', 'F', '0', '1', 'system:company:export', '#', 'admin', '2025-03-17 00:47:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2080, '保险', 2073, 1, '/system/insurance', '', 'C', '0', '1', 'system:insurance:view', '#', 'admin', '2025-03-17 01:29:17', '', NULL, '保险菜单');
INSERT INTO `sys_menu` VALUES (2081, '保险查询', 2080, 1, '#', '', 'F', '0', '1', 'system:insurance:list', '#', 'admin', '2025-03-17 01:29:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '保险新增', 2080, 2, '#', '', 'F', '0', '1', 'system:insurance:add', '#', 'admin', '2025-03-17 01:29:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '保险修改', 2080, 3, '#', '', 'F', '0', '1', 'system:insurance:edit', '#', 'admin', '2025-03-17 01:29:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2084, '保险删除', 2080, 4, '#', '', 'F', '0', '1', 'system:insurance:remove', '#', 'admin', '2025-03-17 01:29:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '保险导出', 2080, 5, '#', '', 'F', '0', '1', 'system:insurance:export', '#', 'admin', '2025-03-17 01:29:17', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 385 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.petHis.project.tool.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":[\"clients\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 15:28:32', 123);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"1\"],\"tableName\":[\"clients\"],\"tableComment\":[\"客户表\"],\"className\":[\"Clients\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"1\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"客户ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"clientId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"2\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"姓名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"3\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"手机号\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"phone\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].isRequired\":[\"1\"],\"columns[2].htmlType\":[\"input\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"4\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"地址\"],\"columns[3].javaType\":[\"String\"],\"columns[3].javaField\":[\"address\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"input\"],\"columns[3].dictType\":[\"\"],\"tplCategory\":[\"crud\"],\"packageName\":[\"com.petHis.project.system\"],\"moduleName\":[\"system\"],\"businessName\":[\"clients\"],\"functionName\":[\"客户\"],\"formColNum\":[\"1\"],\"genType\":[\"0\"],\"params[parentMenuId]\":[\"1\"],\"params[parentMenuName]\":[\"系统管理\"],\"genPath\":[\"/\"],\"subTableName\":[\"\"],\"params[treeCode]\":[\"\"],\"params[treeParentCode]\":[\"\"],\"params[treeName]\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 15:30:14', 13);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 6, 'com.petHis.project.tool.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":[\"pets\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 15:30:26', 30);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"2\"],\"tableName\":[\"pets\"],\"tableComment\":[\"宠物表\"],\"className\":[\"Pets\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"5\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"宠物ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"petId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"6\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"宠物名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"7\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"品种\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"type\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].htmlType\":[\"select\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"8\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"出生日期\"],\"columns[3].javaType\":[\"Date\"],\"columns[3].javaField\":[\"birthday\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"datetime\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"9\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"关联客户ID\"],\"columns[4].javaType\":[\"Long\"],\"columns[4].javaField\":[\"clientId\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].isRequired\":[\"1\"],\"columns[4].htmlType\":[\"input\"],\"columns[4].dictType\":[\"\"],\"columns[5].columnId\":[\"10\"],\"columns[5].sort\":[\"6\"],\"columns[5].columnComment\":[\"健康状况\"],\"columns[5].javaType\":[\"String\"],\"columns[5].javaFiel', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 15:31:12', 22);
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 6, 'com.petHis.project.tool.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":[\"appointments,medical_records\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 15:32:12', 57);
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"4\"],\"tableName\":[\"medical_records\"],\"tableComment\":[\"诊疗记录表\"],\"className\":[\"MedicalRecords\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"16\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"记录ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"recordId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"17\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"关联宠物ID\"],\"columns[1].javaType\":[\"Long\"],\"columns[1].javaField\":[\"petId\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"EQ\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"18\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"诊断结果\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"diagnosis\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].htmlType\":[\"textarea\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"19\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"治疗方案\"],\"columns[3].javaType\":[\"String\"],\"columns[3].javaField\":[\"treatment\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"textarea\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"20\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"费用\"],\"columns[4].javaType\":[\"BigDecimal\"],\"columns[4].javaField\":[\"cost\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].htmlType\":[\"input\"],\"columns[4].dictType\":[\"\"],\"columns[5].columnId\":[\"21\"],\"columns[5].sort\":[\"6\"],\"columns[5].columnComment\":[\"操作医生（关联 sys_user 用户名）\"],\"columns[5].javaType\":[\"S', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 15:34:14', 19);
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"3\"],\"tableName\":[\"appointments\"],\"tableComment\":[\"预约表\"],\"className\":[\"Appointments\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"11\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"预约ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"appointmentId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"12\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"关联宠物ID\"],\"columns[1].javaType\":[\"Long\"],\"columns[1].javaField\":[\"petId\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"EQ\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"13\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"关联医生ID（对应 sys_user 用户ID）\"],\"columns[2].javaType\":[\"Long\"],\"columns[2].javaField\":[\"doctorId\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].isRequired\":[\"1\"],\"columns[2].htmlType\":[\"input\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"14\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"预约时间\"],\"columns[3].javaType\":[\"Date\"],\"columns[3].javaField\":[\"appointmentTime\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].isRequired\":[\"1\"],\"columns[3].htmlType\":[\"datetime\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"15\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"状态（0待确认，1已确认，2已取消）\"],\"columns[4].javaType\":[\"String\"],\"columns[4].javaField\":[\"status\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].htmlType\":[\"radio\"],\"columns[4].dictType\":[\"\"],\"tplCategory\":[\"crud\"],\"packageName\":[\"co', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 15:34:29', 16);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 8, 'com.petHis.project.tool.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":[\"appointments,medical_records,pets,clients\"]}', NULL, 0, NULL, '2025-02-16 15:34:39', 275);
INSERT INTO `sys_oper_log` VALUES (108, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"测试1\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 16:38:03', 35);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"1\"],\"tableName\":[\"clients\"],\"tableComment\":[\"客户表\"],\"className\":[\"Clients\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"1\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"客户ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"clientId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"2\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"姓名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"3\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"手机号\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"phone\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].isRequired\":[\"1\"],\"columns[2].htmlType\":[\"input\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"4\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"地址\"],\"columns[3].javaType\":[\"String\"],\"columns[3].javaField\":[\"address\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"input\"],\"columns[3].dictType\":[\"\"],\"tplCategory\":[\"sub\"],\"packageName\":[\"com.petHis.project.system\"],\"moduleName\":[\"system\"],\"businessName\":[\"clients\"],\"functionName\":[\"客户\"],\"formColNum\":[\"1\"],\"genType\":[\"0\"],\"params[parentMenuId]\":[\"1\"],\"params[parentMenuName]\":[\"系统管理\"],\"genPath\":[\"/\"],\"subTableName\":[\"pets\"],\"subTableFkName\":[\"client_id\"],\"params[treeCode]\":[\"\"],\"params[treeParentCode]\":[\"\"],\"params[treeName]\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 20:31:58', 35);
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"1\"],\"tableName\":[\"clients\"],\"tableComment\":[\"客户表\"],\"className\":[\"Clients\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"1\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"客户ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"clientId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"2\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"姓名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"3\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"手机号\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"phone\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].isRequired\":[\"1\"],\"columns[2].htmlType\":[\"input\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"4\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"地址\"],\"columns[3].javaType\":[\"String\"],\"columns[3].javaField\":[\"address\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"input\"],\"columns[3].dictType\":[\"\"],\"tplCategory\":[\"crud\"],\"packageName\":[\"com.petHis.project.system\"],\"moduleName\":[\"system\"],\"businessName\":[\"clients\"],\"functionName\":[\"客户\"],\"formColNum\":[\"1\"],\"genType\":[\"0\"],\"params[parentMenuId]\":[\"1\"],\"params[parentMenuName]\":[\"系统管理\"],\"genPath\":[\"/\"],\"subTableName\":[\"pets\"],\"subTableFkName\":[\"client_id\"],\"params[treeCode]\":[\"\"],\"params[treeParentCode]\":[\"\"],\"params[treeName]\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 20:32:39', 14);
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"2\"],\"tableName\":[\"pets\"],\"tableComment\":[\"宠物表\"],\"className\":[\"Pets\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"5\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"宠物ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"petId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"6\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"宠物名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"7\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"品种\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"type\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].htmlType\":[\"select\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"8\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"出生日期\"],\"columns[3].javaType\":[\"Date\"],\"columns[3].javaField\":[\"birthday\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"datetime\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"9\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"关联客户ID\"],\"columns[4].javaType\":[\"Long\"],\"columns[4].javaField\":[\"clientId\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].isRequired\":[\"1\"],\"columns[4].htmlType\":[\"input\"],\"columns[4].dictType\":[\"\"],\"columns[5].columnId\":[\"10\"],\"columns[5].sort\":[\"6\"],\"columns[5].columnComment\":[\"健康状况\"],\"columns[5].javaType\":[\"String\"],\"columns[5].javaFiel', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 20:33:03', 18);
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"2\"],\"tableName\":[\"pets\"],\"tableComment\":[\"宠物表\"],\"className\":[\"Pets\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"5\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"宠物ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"petId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"6\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"宠物名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"7\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"品种\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"type\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].htmlType\":[\"select\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"8\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"出生日期\"],\"columns[3].javaType\":[\"Date\"],\"columns[3].javaField\":[\"birthday\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"datetime\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"9\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"关联客户ID\"],\"columns[4].javaType\":[\"Long\"],\"columns[4].javaField\":[\"clientId\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].isRequired\":[\"1\"],\"columns[4].htmlType\":[\"input\"],\"columns[4].dictType\":[\"\"],\"columns[5].columnId\":[\"10\"],\"columns[5].sort\":[\"6\"],\"columns[5].columnComment\":[\"健康状况\"],\"columns[5].javaType\":[\"String\"],\"columns[5].javaFiel', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-16 20:47:59', 19);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"4\"],\"parentId\":[\"0\"],\"menuType\":[\"C\"],\"menuName\":[\"客户管理\"],\"url\":[\"/system/clients\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:view\"],\"orderNum\":[\"4\"],\"icon\":[\"fa fa-user-circle\"],\"visible\":[\"0\"],\"isRefresh\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 09:54:13', 71);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统监控\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"5\"],\"icon\":[\"fa fa-video-camera\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 09:55:03', 7);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"4\"],\"parentId\":[\"0\"],\"menuType\":[\"C\"],\"menuName\":[\"客户管理\"],\"url\":[\"/system/clients\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:view\"],\"orderNum\":[\"2\"],\"icon\":[\"fa fa-user-circle\"],\"visible\":[\"0\"],\"isRefresh\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 09:55:12', 9);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"3\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统工具\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"7\"],\"icon\":[\"fa fa-bars\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 09:55:20', 8);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"0\"],\"menuType\":[\"C\"],\"menuName\":[\"宠物管理\"],\"url\":[\"/system/pets\"],\"target\":[\"menuItem\"],\"perms\":[\"system:pets:view\"],\"orderNum\":[\"3\"],\"icon\":[\"fa fa-paw\"],\"visible\":[\"0\"],\"isRefresh\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 09:58:29', 13);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统监控\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"8\"],\"icon\":[\"fa fa-video-camera\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 09:58:38', 6);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"0\"],\"menuType\":[\"C\"],\"menuName\":[\"预约管理\"],\"url\":[\"/system/appointments\"],\"target\":[\"menuItem\"],\"perms\":[\"system:appointments:view\"],\"orderNum\":[\"4\"],\"icon\":[\"fa fa-calendar-plus-o\"],\"visible\":[\"0\"],\"isRefresh\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:00:10', 12);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"4\"],\"parentId\":[\"0\"],\"menuType\":[\"C\"],\"menuName\":[\"客户管理\"],\"url\":[\"/system/clients\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:view\"],\"orderNum\":[\"2\"],\"icon\":[\"fa fa-address-card\"],\"visible\":[\"0\"],\"isRefresh\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:00:27', 6);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"0\"],\"menuType\":[\"C\"],\"menuName\":[\"诊疗记录管理\"],\"url\":[\"/system/records\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:view\"],\"orderNum\":[\"5\"],\"icon\":[\"fa fa-calendar\"],\"visible\":[\"0\"],\"isRefresh\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:01:33', 14);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2000', '127.0.0.1', '内网IP', '2000', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":301}', 0, NULL, '2025-02-17 10:02:21', 3);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2001', '127.0.0.1', '内网IP', '2001', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:02:48', 18);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2002', '127.0.0.1', '内网IP', '2002', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:03:12', 12);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2003', '127.0.0.1', '内网IP', '2003', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:03:17', 5);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2004', '127.0.0.1', '内网IP', '2004', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:03:25', 7);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2005', '127.0.0.1', '内网IP', '2005', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:03:43', 18);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2000', '127.0.0.1', '内网IP', '2000', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:03:55', 12);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2007', '127.0.0.1', '内网IP', '2007', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:06', 11);
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2008', '127.0.0.1', '内网IP', '2008', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:12', 5);
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2009', '127.0.0.1', '内网IP', '2009', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:17', 12);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2010', '127.0.0.1', '内网IP', '2010', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:21', 11);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2011', '127.0.0.1', '内网IP', '2011', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:26', 6);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2006', '127.0.0.1', '内网IP', '2006', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:29', 7);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2013', '127.0.0.1', '内网IP', '2013', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:34', 5);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2014', '127.0.0.1', '内网IP', '2014', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:39', 6);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2015', '127.0.0.1', '内网IP', '2015', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:45', 20);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2016', '127.0.0.1', '内网IP', '2016', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:51', 11);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2017', '127.0.0.1', '内网IP', '2017', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:04:56', 6);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2012', '127.0.0.1', '内网IP', '2012', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:05:01', 11);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2019', '127.0.0.1', '内网IP', '2019', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:05:06', 11);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2020', '127.0.0.1', '内网IP', '2020', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:05:11', 4);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2021', '127.0.0.1', '内网IP', '2021', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:05:17', 11);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2022', '127.0.0.1', '内网IP', '2022', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:05:22', 13);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2023', '127.0.0.1', '内网IP', '2023', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:05:26', 12);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 3, 'com.petHis.project.system.menu.controller.MenuController.remove()', 'GET', 1, 'admin', '研发部门', '/system/menu/remove/2018', '127.0.0.1', '内网IP', '2018', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:05:30', 12);
INSERT INTO `sys_oper_log` VALUES (147, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"2\"],\"tableName\":[\"pets\"],\"tableComment\":[\"宠物表\"],\"className\":[\"Pets\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"5\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"宠物ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"petId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"6\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"宠物名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"7\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"品种\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"type\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].htmlType\":[\"select\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"8\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"出生日期\"],\"columns[3].javaType\":[\"Date\"],\"columns[3].javaField\":[\"birthday\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"datetime\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"9\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"关联客户ID\"],\"columns[4].javaType\":[\"Long\"],\"columns[4].javaField\":[\"clientId\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].isRequired\":[\"1\"],\"columns[4].htmlType\":[\"input\"],\"columns[4].dictType\":[\"\"],\"columns[5].columnId\":[\"10\"],\"columns[5].sort\":[\"6\"],\"columns[5].columnComment\":[\"健康状况\"],\"columns[5].javaType\":[\"String\"],\"columns[5].javaFiel', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:06:28', 31);
INSERT INTO `sys_oper_log` VALUES (148, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"2\"],\"tableName\":[\"pets\"],\"tableComment\":[\"宠物表\"],\"className\":[\"Pets\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"5\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"宠物ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"petId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"6\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"宠物名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"7\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"品种\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"type\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].htmlType\":[\"select\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"8\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"出生日期\"],\"columns[3].javaType\":[\"Date\"],\"columns[3].javaField\":[\"birthday\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"datetime\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"9\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"关联客户ID\"],\"columns[4].javaType\":[\"Long\"],\"columns[4].javaField\":[\"clientId\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].isRequired\":[\"1\"],\"columns[4].htmlType\":[\"input\"],\"columns[4].dictType\":[\"\"],\"columns[5].columnId\":[\"10\"],\"columns[5].sort\":[\"6\"],\"columns[5].columnComment\":[\"健康状况\"],\"columns[5].javaType\":[\"String\"],\"columns[5].javaFiel', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 10:19:55', 23);
INSERT INTO `sys_oper_log` VALUES (149, '代码生成', 8, 'com.petHis.project.tool.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":[\"pets\"]}', NULL, 0, NULL, '2025-02-17 10:20:24', 55);
INSERT INTO `sys_oper_log` VALUES (150, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"2\"],\"name\":[\"测试1\"],\"phone\":[\"15888888887\"],\"address\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 14:33:18', 64);
INSERT INTO `sys_oper_log` VALUES (151, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 16:19:05', 31);
INSERT INTO `sys_oper_log` VALUES (152, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 16:40:05', 1);
INSERT INTO `sys_oper_log` VALUES (153, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 16:57:50', 30);
INSERT INTO `sys_oper_log` VALUES (154, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:01:03', 29);
INSERT INTO `sys_oper_log` VALUES (155, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:09:06', 48);
INSERT INTO `sys_oper_log` VALUES (156, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:10:45', 48);
INSERT INTO `sys_oper_log` VALUES (157, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"\\\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\\\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:15:03', 37);
INSERT INTO `sys_oper_log` VALUES (158, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:19:19', 39);
INSERT INTO `sys_oper_log` VALUES (159, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:25:20', 35);
INSERT INTO `sys_oper_log` VALUES (160, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:27:19', 35);
INSERT INTO `sys_oper_log` VALUES (161, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15565654333\"],\"clientName\":[\"通过\"],\"clientId\":[\"\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:27:39', 4);
INSERT INTO `sys_oper_log` VALUES (162, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 17:59:46', 38);
INSERT INTO `sys_oper_log` VALUES (163, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 18:02:15', 47);
INSERT INTO `sys_oper_log` VALUES (164, '代码生成', 2, 'com.petHis.project.tool.gen.controller.GenController.editSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/edit', '127.0.0.1', '内网IP', '{\"tableId\":[\"2\"],\"tableName\":[\"pets\"],\"tableComment\":[\"宠物表\"],\"className\":[\"Pets\"],\"functionAuthor\":[\"petHis\"],\"remark\":[\"\"],\"columns[0].columnId\":[\"5\"],\"columns[0].sort\":[\"1\"],\"columns[0].columnComment\":[\"宠物ID\"],\"columns[0].javaType\":[\"Long\"],\"columns[0].javaField\":[\"petId\"],\"columns[0].isInsert\":[\"1\"],\"columns[0].queryType\":[\"EQ\"],\"columns[0].htmlType\":[\"input\"],\"columns[0].dictType\":[\"\"],\"columns[1].columnId\":[\"6\"],\"columns[1].sort\":[\"2\"],\"columns[1].columnComment\":[\"宠物名\"],\"columns[1].javaType\":[\"String\"],\"columns[1].javaField\":[\"name\"],\"columns[1].isInsert\":[\"1\"],\"columns[1].isEdit\":[\"1\"],\"columns[1].isList\":[\"1\"],\"columns[1].isQuery\":[\"1\"],\"columns[1].queryType\":[\"LIKE\"],\"columns[1].isRequired\":[\"1\"],\"columns[1].htmlType\":[\"input\"],\"columns[1].dictType\":[\"\"],\"columns[2].columnId\":[\"7\"],\"columns[2].sort\":[\"3\"],\"columns[2].columnComment\":[\"品种\"],\"columns[2].javaType\":[\"String\"],\"columns[2].javaField\":[\"type\"],\"columns[2].isInsert\":[\"1\"],\"columns[2].isEdit\":[\"1\"],\"columns[2].isList\":[\"1\"],\"columns[2].isQuery\":[\"1\"],\"columns[2].queryType\":[\"EQ\"],\"columns[2].htmlType\":[\"select\"],\"columns[2].dictType\":[\"\"],\"columns[3].columnId\":[\"8\"],\"columns[3].sort\":[\"4\"],\"columns[3].columnComment\":[\"出生日期\"],\"columns[3].javaType\":[\"Date\"],\"columns[3].javaField\":[\"birthday\"],\"columns[3].isInsert\":[\"1\"],\"columns[3].isEdit\":[\"1\"],\"columns[3].isList\":[\"1\"],\"columns[3].isQuery\":[\"1\"],\"columns[3].queryType\":[\"EQ\"],\"columns[3].htmlType\":[\"datetime\"],\"columns[3].dictType\":[\"\"],\"columns[4].columnId\":[\"9\"],\"columns[4].sort\":[\"5\"],\"columns[4].columnComment\":[\"关联客户ID\"],\"columns[4].javaType\":[\"Long\"],\"columns[4].javaField\":[\"clientId\"],\"columns[4].isInsert\":[\"1\"],\"columns[4].isEdit\":[\"1\"],\"columns[4].isList\":[\"1\"],\"columns[4].isQuery\":[\"1\"],\"columns[4].queryType\":[\"EQ\"],\"columns[4].isRequired\":[\"1\"],\"columns[4].htmlType\":[\"input\"],\"columns[4].dictType\":[\"\"],\"columns[5].columnId\":[\"10\"],\"columns[5].sort\":[\"6\"],\"columns[5].columnComment\":[\"健康状况\"],\"columns[5].javaType\":[\"String\"],\"columns[5].javaFiel', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 19:17:08', 44);
INSERT INTO `sys_oper_log` VALUES (165, '通知公告', 2, 'com.petHis.project.system.notice.controller.NoticeController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/notice/edit', '127.0.0.1', '内网IP', '{\"noticeId\":[\"3\"],\"noticeTitle\":[\"宠物医院开源框架介绍\"],\"noticeType\":[\"1\"],\"noticeContent\":[\"<p><span style=\\\"color: rgb(230, 0, 0);\\\">项目介绍</span></p><p><font color=\\\"#333333\\\">petHis开源项目是为企业用户定制的后台脚手架框架，为企业打造的一站式解决方案，降低企业开发成本，提升开发效率。主要包括用户管理、角色管理、部门管理、菜单管理、参数管理、字典管理、</font><span style=\\\"color: rgb(51, 51, 51);\\\">岗位管理</span><span style=\\\"color: rgb(51, 51, 51);\\\">、定时任务</span><span style=\\\"color: rgb(51, 51, 51);\\\">、</span><span style=\\\"color: rgb(51, 51, 51);\\\">服务监控、登录日志、操作日志、代码生成等功能。其中，还支持多数据源、数据权限、国际化、Redis缓存、Docker部署、滑动验证码、第三方认证登录、分布式事务、</span><font color=\\\"#333333\\\">分布式文件存储</font><span style=\\\"color: rgb(51, 51, 51);\\\">、分库分表处理等技术特点。</span></p><p><br style=\\\"color: rgb(48, 49, 51); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px;\\\"></p>\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 20:17:54', 55);
INSERT INTO `sys_oper_log` VALUES (166, '通知公告', 2, 'com.petHis.project.system.notice.controller.NoticeController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/notice/edit', '127.0.0.1', '内网IP', '{\"noticeId\":[\"1\"],\"noticeTitle\":[\"温馨提醒：2025-02-01 宠物医院新版本发布啦\"],\"noticeType\":[\"2\"],\"noticeContent\":[\"新版本内容\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 20:18:17', 9);
INSERT INTO `sys_oper_log` VALUES (167, '通知公告', 2, 'com.petHis.project.system.notice.controller.NoticeController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/notice/edit', '127.0.0.1', '内网IP', '{\"noticeId\":[\"2\"],\"noticeTitle\":[\"维护通知：2024-07-01 宠物医院系统凌晨维护\"],\"noticeType\":[\"1\"],\"noticeContent\":[\"维护内容\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 20:18:34', 5);
INSERT INTO `sys_oper_log` VALUES (168, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"100\"],\"parentId\":[\"0\"],\"parentName\":[\"无\"],\"deptName\":[\"精灵爱宠医院\"],\"orderNum\":[\"0\"],\"leader\":[\"ymd\"],\"phone\":[\"15888888888\"],\"email\":[\"ymd@qq.com\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 20:21:55', 25);
INSERT INTO `sys_oper_log` VALUES (169, '个人信息', 2, 'com.petHis.project.system.user.controller.ProfileController.update()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/update', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"userName\":[\"ymd\"],\"phonenumber\":[\"15888888888\"],\"email\":[\"ymd@163.com\"],\"sex\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 20:22:22', 32);
INSERT INTO `sys_oper_log` VALUES (170, '用户管理', 2, 'com.petHis.project.system.user.controller.UserController.changeStatus()', 'POST', 1, 'admin', '研发部门', '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"userId\":[\"2\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 20:22:46', 11);
INSERT INTO `sys_oper_log` VALUES (171, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15565654333\"],\"clientName\":[\"测试2\"],\"clientId\":[\"\"],\"name\":[\"测试猫\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'client_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\PetsMapper.xml]\r\n### The error may involve com.petHis.project.system.pets.mapper.PetsMapper.insertPets-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into pets          ( name,             type,             birthday )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'client_id\' doesn\'t have a default value\n; Field \'client_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'client_id\' doesn\'t have a default value', '2025-02-17 20:31:35', 108);
INSERT INTO `sys_oper_log` VALUES (172, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15565654333\"],\"clientName\":[\"测试2\"],\"clientId\":[\"\"],\"name\":[\"测试猫\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 20:37:19', 66);
INSERT INTO `sys_oper_log` VALUES (173, '宠物', 2, 'com.petHis.project.system.pets.controller.PetsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/edit', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"name\":[\"修改测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"],\"healthStatus\":[\"健康\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 21:05:36', 52);
INSERT INTO `sys_oper_log` VALUES (174, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888881\"],\"clientName\":[\"删除用\"],\"clientId\":[\"2\"],\"name\":[\"删除狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 21:06:28', 12);
INSERT INTO `sys_oper_log` VALUES (175, '宠物', 2, 'com.petHis.project.system.pets.controller.PetsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/edit', '127.0.0.1', '内网IP', '{\"petId\":[\"3\"],\"name\":[\"修改删除狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"],\"healthStatus\":[\"健康\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 21:07:36', 11);
INSERT INTO `sys_oper_log` VALUES (176, '宠物', 3, 'com.petHis.project.system.pets.controller.PetsController.remove()', 'POST', 1, 'admin', '研发部门', '/system/pets/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"3\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 21:07:46', 13);
INSERT INTO `sys_oper_log` VALUES (177, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"3\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统工具\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"7\"],\"icon\":[\"fa fa-bars\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 21:08:40', 17);
INSERT INTO `sys_oper_log` VALUES (178, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统监控\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"8\"],\"icon\":[\"fa fa-video-camera\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 21:08:45', 12);
INSERT INTO `sys_oper_log` VALUES (179, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"查询猫\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-27\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'client_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\PetsMapper.xml]\r\n### The error may involve com.petHis.project.system.pets.mapper.PetsMapper.insertPets-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into pets          ( name,             type,             birthday )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'client_id\' doesn\'t have a default value\n; Field \'client_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'client_id\' doesn\'t have a default value', '2025-02-17 21:42:47', 96);
INSERT INTO `sys_oper_log` VALUES (180, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"查询猫\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'client_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\PetsMapper.xml]\r\n### The error may involve com.petHis.project.system.pets.mapper.PetsMapper.insertPets-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into pets          ( name,             type,             birthday )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'client_id\' doesn\'t have a default value\n; Field \'client_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'client_id\' doesn\'t have a default value', '2025-02-17 21:45:12', 87);
INSERT INTO `sys_oper_log` VALUES (181, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"测试1\"],\"clientId\":[\"2\"],\"name\":[\"查询猫\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 21:46:40', 54);
INSERT INTO `sys_oper_log` VALUES (182, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888881\"],\"clientName\":[\"删除用\"],\"clientId\":[\"4\"],\"name\":[\"查询狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-27\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-17 22:01:06', 51);
INSERT INTO `sys_oper_log` VALUES (183, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"普通角色\"],\"roleKey\":[\"common\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"普通角色\"],\"menuIds\":[\"4,2024,2025,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:41:23', 69);
INSERT INTO `sys_oper_log` VALUES (184, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"普通角色\"],\"roleKey\":[\"common\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"普通角色\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:42:30', 18);
INSERT INTO `sys_oper_log` VALUES (185, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"普通角色\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"普通角色\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:42:59', 20);
INSERT INTO `sys_oper_log` VALUES (186, '角色管理', 1, 'com.petHis.project.system.role.controller.RoleController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/role/add', '127.0.0.1', '内网IP', '{\"roleName\":[\"护士\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"护士\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:44:07', 18);
INSERT INTO `sys_oper_log` VALUES (187, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"102\"],\"parentId\":[\"100\"],\"parentName\":[\"精灵爱宠医院\"],\"deptName\":[\"长沙分公司\"],\"orderNum\":[\"2\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"该部门包含未停用的子部门！\",\"code\":500}', 0, NULL, '2025-02-18 09:51:20', 6);
INSERT INTO `sys_oper_log` VALUES (188, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"109\"],\"parentId\":[\"102\"],\"parentName\":[\"长沙分公司\"],\"deptName\":[\"财务部门\"],\"orderNum\":[\"2\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:51:33', 17);
INSERT INTO `sys_oper_log` VALUES (189, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"108\"],\"parentId\":[\"102\"],\"parentName\":[\"长沙分公司\"],\"deptName\":[\"市场部门\"],\"orderNum\":[\"1\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:51:37', 16);
INSERT INTO `sys_oper_log` VALUES (190, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"102\"],\"parentId\":[\"100\"],\"parentName\":[\"精灵爱宠医院\"],\"deptName\":[\"长沙分公司\"],\"orderNum\":[\"2\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:51:41', 18);
INSERT INTO `sys_oper_log` VALUES (191, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"107\"],\"parentId\":[\"101\"],\"parentName\":[\"深圳总公司\"],\"deptName\":[\"运维部门\"],\"orderNum\":[\"5\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:52:14', 18);
INSERT INTO `sys_oper_log` VALUES (192, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"106\"],\"parentId\":[\"101\"],\"parentName\":[\"深圳总公司\"],\"deptName\":[\"财务部门\"],\"orderNum\":[\"4\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:52:22', 9);
INSERT INTO `sys_oper_log` VALUES (193, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"105\"],\"parentId\":[\"101\"],\"parentName\":[\"深圳总公司\"],\"deptName\":[\"测试部门\"],\"orderNum\":[\"3\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:52:27', 10);
INSERT INTO `sys_oper_log` VALUES (194, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"104\"],\"parentId\":[\"101\"],\"parentName\":[\"深圳总公司\"],\"deptName\":[\"市场部门\"],\"orderNum\":[\"2\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 09:52:44', 13);
INSERT INTO `sys_oper_log` VALUES (195, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"101\"],\"parentId\":[\"100\"],\"parentName\":[\"精灵爱宠医院\"],\"deptName\":[\"温州总公司\"],\"orderNum\":[\"1\"],\"leader\":[\"ymd\"],\"phone\":[\"15888888888\"],\"email\":[\"ymd@qq.com\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:00:33', 13);
INSERT INTO `sys_oper_log` VALUES (196, '部门管理', 1, 'com.petHis.project.system.dept.controller.DeptController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"101\"],\"deptName\":[\"宠物诊疗部\"],\"orderNum\":[\"1\"],\"leader\":[\"ymd\"],\"phone\":[\"15888888888\"],\"email\":[\"ymd@qq.com\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:00:58', 15);
INSERT INTO `sys_oper_log` VALUES (197, '部门管理', 1, 'com.petHis.project.system.dept.controller.DeptController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"101\"],\"deptName\":[\"客户服务部\"],\"orderNum\":[\"1\"],\"leader\":[\"ymd\"],\"phone\":[\"15888888888\"],\"email\":[\"ymd@163.com\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:01:30', 13);
INSERT INTO `sys_oper_log` VALUES (198, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"110\"],\"parentId\":[\"101\"],\"parentName\":[\"温州总公司\"],\"deptName\":[\"诊疗服务部\"],\"orderNum\":[\"1\"],\"leader\":[\"ymd\"],\"phone\":[\"15888888888\"],\"email\":[\"ymd@qq.com\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:04:40', 15);
INSERT INTO `sys_oper_log` VALUES (199, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"111\"],\"parentId\":[\"101\"],\"parentName\":[\"温州总公司\"],\"deptName\":[\"客户运营部\"],\"orderNum\":[\"1\"],\"leader\":[\"ymd\"],\"phone\":[\"15888888888\"],\"email\":[\"ymd@163.com\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:04:50', 18);
INSERT INTO `sys_oper_log` VALUES (200, '岗位管理', 2, 'com.petHis.project.system.post.controller.PostController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/post/edit', '127.0.0.1', '内网IP', '{\"postId\":[\"1\"],\"postName\":[\"老板\"],\"postCode\":[\"boss\"],\"postSort\":[\"1\"],\"status\":[\"0\"],\"remark\":[\"医院老板，超级管理员\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:05:43', 15);
INSERT INTO `sys_oper_log` VALUES (201, '岗位管理', 2, 'com.petHis.project.system.post.controller.PostController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/post/edit', '127.0.0.1', '内网IP', '{\"postId\":[\"2\"],\"postName\":[\"初级兽医\"],\"postCode\":[\"vet\"],\"postSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"归属诊疗服务部，负责宠物的日常检查、基础疾病诊断以及基础治疗操作，如测量体温、简单疾病诊断、打针输液、伤口处理等。同时，协助资深兽医（若有）完成复杂病例的诊疗工作。\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:07:04', 9);
INSERT INTO `sys_oper_log` VALUES (202, '岗位管理', 2, 'com.petHis.project.system.post.controller.PostController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/post/edit', '127.0.0.1', '内网IP', '{\"postId\":[\"3\"],\"postName\":[\"客户专员\"],\"postCode\":[\"clientExecutive\"],\"postSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"就职于客户运营部，承担客户咨询、预约安排、客户投诉处理等工作，还要负责收集客户反馈，为医院服务改进提供依据。\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:08:24', 12);
INSERT INTO `sys_oper_log` VALUES (203, '岗位管理', 2, 'com.petHis.project.system.post.controller.PostController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/post/edit', '127.0.0.1', '内网IP', '{\"postId\":[\"4\"],\"postName\":[\"后勤兼护理员\"],\"postCode\":[\"logistics\"],\"postSort\":[\"4\"],\"status\":[\"0\"],\"remark\":[\"负责医院的日常后勤保障，如卫生清洁、物资采购与管理等。同时，在宠物住院期间，承担简单的护理工作，如喂食、遛宠等。\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:09:12', 14);
INSERT INTO `sys_oper_log` VALUES (204, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"护士\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"护士\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:10:13', 13);
INSERT INTO `sys_oper_log` VALUES (205, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医生\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"普通角色\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:10:46', 13);
INSERT INTO `sys_oper_log` VALUES (206, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医生\"],\"roleKey\":[\"doctor\"],\"dataScope\":[\"2\"],\"deptIds\":[\"100,101,110\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:11:55', 22);
INSERT INTO `sys_oper_log` VALUES (207, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"护士\"],\"roleKey\":[\"nurse\"],\"dataScope\":[\"2\"],\"deptIds\":[\"100,101,111\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:12:08', 6);
INSERT INTO `sys_oper_log` VALUES (208, '角色管理', 1, 'com.petHis.project.system.role.controller.RoleController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/role/add', '127.0.0.1', '内网IP', '{\"roleName\":[\"后勤\"],\"roleKey\":[\"common\"],\"roleSort\":[\"4\"],\"status\":[\"0\"],\"remark\":[\"后勤及其他工作人员\"],\"menuIds\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:14:26', 6);
INSERT INTO `sys_oper_log` VALUES (209, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"4\"],\"roleName\":[\"后勤\"],\"roleKey\":[\"common\"],\"dataScope\":[\"2\"],\"deptIds\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:14:38', 11);
INSERT INTO `sys_oper_log` VALUES (210, '用户管理', 1, 'com.petHis.project.system.user.controller.UserController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\"deptId\":[\"110\"],\"userName\":[\"医生1\"],\"deptName\":[\"诊疗服务部\"],\"phonenumber\":[\"15666666667\"],\"email\":[\"ys1@163.com\"],\"loginName\":[\"ys1\"],\"sex\":[\"1\"],\"role\":[\"2\"],\"remark\":[\"\"],\"status\":[\"0\"],\"roleIds\":[\"2\"],\"postIds\":[\"2\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:16:21', 18);
INSERT INTO `sys_oper_log` VALUES (211, '用户管理', 1, 'com.petHis.project.system.user.controller.UserController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\"deptId\":[\"111\"],\"userName\":[\"客户运营1\"],\"deptName\":[\"客户运营部\"],\"phonenumber\":[\"15666666668\"],\"email\":[\"khyy1@163.com\"],\"loginName\":[\"khyy1\"],\"sex\":[\"1\"],\"role\":[\"3\"],\"remark\":[\"\"],\"status\":[\"0\"],\"roleIds\":[\"3\"],\"postIds\":[\"3\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:18:03', 11);
INSERT INTO `sys_oper_log` VALUES (212, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:18:30', 12);
INSERT INTO `sys_oper_log` VALUES (213, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"客户专员\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"客户专员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:19:08', 12);
INSERT INTO `sys_oper_log` VALUES (214, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"4\"],\"roleName\":[\"后勤人员\"],\"roleKey\":[\"common\"],\"roleSort\":[\"4\"],\"status\":[\"0\"],\"remark\":[\"后勤及其他工作人员\"],\"menuIds\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:19:18', 5);
INSERT INTO `sys_oper_log` VALUES (215, '用户管理', 2, 'com.petHis.project.system.user.controller.UserController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\"userId\":[\"4\"],\"deptId\":[\"111\"],\"userName\":[\"客户运营1\"],\"dept.deptName\":[\"客户运营部\"],\"phonenumber\":[\"15666666668\"],\"email\":[\"khyy1@163.com\"],\"loginName\":[\"khyy1\"],\"sex\":[\"1\"],\"role\":[\"3\"],\"remark\":[\"\"],\"status\":[\"0\"],\"roleIds\":[\"3\"],\"postIds\":[\"3\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:20:33', 11);
INSERT INTO `sys_oper_log` VALUES (216, '部门管理', 1, 'com.petHis.project.system.dept.controller.DeptController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"101\"],\"deptName\":[\"后勤部\"],\"orderNum\":[\"1\"],\"leader\":[\"ymd\"],\"phone\":[\"15888888888\"],\"email\":[\"ymd@163.com\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:20:57', 12);
INSERT INTO `sys_oper_log` VALUES (217, '用户管理', 1, 'com.petHis.project.system.user.controller.UserController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\"deptId\":[\"112\"],\"userName\":[\"后勤1\"],\"deptName\":[\"后勤部\"],\"phonenumber\":[\"15666666669\"],\"email\":[\"hq1@163.com\"],\"loginName\":[\"hq1\"],\"sex\":[\"1\"],\"role\":[\"4\"],\"remark\":[\"\"],\"status\":[\"0\"],\"roleIds\":[\"4\"],\"postIds\":[\"4\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:21:37', 9);
INSERT INTO `sys_oper_log` VALUES (218, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:23:00', 10);
INSERT INTO `sys_oper_log` VALUES (219, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"客户专员\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"客户专员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2024,2025\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:23:17', 7);
INSERT INTO `sys_oper_log` VALUES (220, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"4\"],\"roleName\":[\"后勤人员\"],\"roleKey\":[\"common\"],\"roleSort\":[\"4\"],\"status\":[\"0\"],\"remark\":[\"后勤及其他工作人员\"],\"menuIds\":[\"1,107,1035\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:23:54', 12);
INSERT INTO `sys_oper_log` VALUES (221, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"4\"],\"menuType\":[\"F\"],\"menuName\":[\"客户查询\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:list\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:25:40', 4);
INSERT INTO `sys_oper_log` VALUES (222, '部门管理', 2, 'com.petHis.project.system.dept.controller.DeptController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dept/edit', '127.0.0.1', '内网IP', '{\"deptId\":[\"103\"],\"parentId\":[\"101\"],\"parentName\":[\"温州总公司\"],\"deptName\":[\"研发部门\"],\"orderNum\":[\"1\"],\"leader\":[\"宠物医院\"],\"phone\":[\"15888888888\"],\"email\":[\"ry@qq.com\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:37:00', 13);
INSERT INTO `sys_oper_log` VALUES (223, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"dataScope\":[\"2\"],\"deptIds\":[\"100,101,110\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:40:41', 10);
INSERT INTO `sys_oper_log` VALUES (224, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:40:54', 6);
INSERT INTO `sys_oper_log` VALUES (225, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"4\"],\"menuType\":[\"F\"],\"menuName\":[\"客户导出\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:export\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:42:32', 10);
INSERT INTO `sys_oper_log` VALUES (226, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2027\"],\"parentId\":[\"4\"],\"menuType\":[\"F\"],\"menuName\":[\"查询客户\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:list\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:42:55', 9);
INSERT INTO `sys_oper_log` VALUES (227, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2028\"],\"parentId\":[\"4\"],\"menuType\":[\"F\"],\"menuName\":[\"导出客户\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:export\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:43:04', 5);
INSERT INTO `sys_oper_log` VALUES (228, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"4\"],\"menuType\":[\"F\"],\"menuName\":[\"新增客户\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:add\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:43:26', 11);
INSERT INTO `sys_oper_log` VALUES (229, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"4\"],\"menuType\":[\"F\"],\"menuName\":[\"修改客户\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:edit\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:44:23', 4);
INSERT INTO `sys_oper_log` VALUES (230, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"4\"],\"menuType\":[\"F\"],\"menuName\":[\"删除客户\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:clients:remove\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:44:42', 11);
INSERT INTO `sys_oper_log` VALUES (231, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2024\"],\"menuType\":[\"F\"],\"menuName\":[\"查询宠物\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:pets:list\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:45:22', 8);
INSERT INTO `sys_oper_log` VALUES (232, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2024\"],\"menuType\":[\"F\"],\"menuName\":[\"导出宠物\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:pets:export\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:45:47', 10);
INSERT INTO `sys_oper_log` VALUES (233, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2024\"],\"menuType\":[\"F\"],\"menuName\":[\"新增宠物\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:pets:add\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:46:10', 10);
INSERT INTO `sys_oper_log` VALUES (234, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2024\"],\"menuType\":[\"F\"],\"menuName\":[\"修改宠物\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:pets:edit\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:46:30', 4);
INSERT INTO `sys_oper_log` VALUES (235, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2024\"],\"menuType\":[\"F\"],\"menuName\":[\"删除宠物\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:pets:remove\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 10:46:48', 10);
INSERT INTO `sys_oper_log` VALUES (236, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-18\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 12:31:09', 11);
INSERT INTO `sys_oper_log` VALUES (237, '个人信息', 2, 'com.petHis.project.system.user.controller.ProfileController.update()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/update', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"userName\":[\"姚梦蝶\"],\"phonenumber\":[\"15888888888\"],\"email\":[\"ymd@163.com\"],\"sex\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 12:32:16', 28);
INSERT INTO `sys_oper_log` VALUES (238, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"4\"],\"roleName\":[\"后勤人员\"],\"roleKey\":[\"common\"],\"roleSort\":[\"4\"],\"status\":[\"1\"],\"remark\":[\"后勤及其他工作人员\"],\"menuIds\":[\"1,107,1035\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 14:40:15', 65);
INSERT INTO `sys_oper_log` VALUES (239, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.changeStatus()', 'POST', 1, 'admin', '研发部门', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"roleId\":[\"4\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 14:40:24', 3);
INSERT INTO `sys_oper_log` VALUES (240, '宠物', 2, 'com.petHis.project.system.pets.controller.PetsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/edit', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"name\":[\"修改测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"],\"healthStatus\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 15:06:14', 44);
INSERT INTO `sys_oper_log` VALUES (241, '重置密码', 2, 'com.petHis.project.system.user.controller.ProfileController.resetPwd()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/resetPwd', '127.0.0.1', '内网IP', '{\"userId\":[\"1\"],\"loginName\":[\"admin\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 16:48:34', 50);
INSERT INTO `sys_oper_log` VALUES (242, '重置密码', 2, 'com.petHis.project.system.user.controller.ProfileController.resetPwd()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/resetPwd', '127.0.0.1', '内网IP', '{\"userId\":[\"1\"],\"loginName\":[\"admin\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 16:49:38', 14);
INSERT INTO `sys_oper_log` VALUES (243, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"3\"],\"appointmentTime\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 19:14:53', 41);
INSERT INTO `sys_oper_log` VALUES (244, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"doctorId\":[\"3\"],\"appointmentTime\":[\"2025-01-28\"],\"status\":[\"待确认\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Data truncated for column \'status\' at row 1\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\AppointmentsMapper.xml]\r\n### The error may involve com.petHis.project.system.appointments.mapper.AppointmentsMapper.updateAppointments-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update appointments          SET pet_id = ?,             doctor_id = ?,             appointment_time = ?,             status = ?          where appointment_id = ?\r\n### Cause: java.sql.SQLException: Data truncated for column \'status\' at row 1\n; Data truncated for column \'status\' at row 1; nested exception is java.sql.SQLException: Data truncated for column \'status\' at row 1', '2025-02-18 20:00:03', 88);
INSERT INTO `sys_oper_log` VALUES (245, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-18\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 20:01:39', 38);
INSERT INTO `sys_oper_log` VALUES (246, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-18\"]}', NULL, 1, '该预约数据已存在，请勿重复添加。', '2025-02-18 20:03:25', 31);
INSERT INTO `sys_oper_log` VALUES (247, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-04\"]}', NULL, 0, NULL, '2025-02-18 20:03:59', 14);
INSERT INTO `sys_oper_log` VALUES (248, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-18\"]}', '{\"msg\":\"该预约数据已存在，请勿重复添加。\",\"code\":500}', 0, NULL, '2025-02-18 20:05:39', 30);
INSERT INTO `sys_oper_log` VALUES (249, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-04\"]}', '{\"msg\":\"该预约数据已存在，请勿重复添加。\",\"code\":500}', 0, NULL, '2025-02-18 20:05:45', 3);
INSERT INTO `sys_oper_log` VALUES (250, '预约', 1, 'com.petHis.project.system.appointments.controller.AppointmentsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-01\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 20:06:25', 14);
INSERT INTO `sys_oper_log` VALUES (251, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"1\"],\"petId\":[\"1\"],\"doctorId\":[\"1\"],\"appointmentTime\":[\"2025-02-19\"],\"status\":[\"待确认\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Data truncated for column \'status\' at row 1\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\AppointmentsMapper.xml]\r\n### The error may involve com.petHis.project.system.appointments.mapper.AppointmentsMapper.updateAppointments-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update appointments          SET pet_id = ?,             doctor_id = ?,             appointment_time = ?,             status = ?          where appointment_id = ?\r\n### Cause: java.sql.SQLException: Data truncated for column \'status\' at row 1\n; Data truncated for column \'status\' at row 1; nested exception is java.sql.SQLException: Data truncated for column \'status\' at row 1', '2025-02-18 20:07:13', 82);
INSERT INTO `sys_oper_log` VALUES (252, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"1\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"1\"],\"userName\":[\"姚梦蝶\"],\"appointmentTime\":[\"2025-02-18\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 20:16:54', 39);
INSERT INTO `sys_oper_log` VALUES (253, '预约', 3, 'com.petHis.project.system.appointments.controller.AppointmentsController.remove()', 'POST', 1, 'admin', '研发部门', '/system/appointments/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 20:17:01', 12);
INSERT INTO `sys_oper_log` VALUES (254, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"吃多了\"],\"treatment\":[\"饿两天\"],\"cost\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 20:20:14', 19);
INSERT INTO `sys_oper_log` VALUES (255, '诊疗记录', 2, 'com.petHis.project.system.records.controller.MedicalRecordsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/records/edit', '127.0.0.1', '内网IP', '{\"recordId\":[\"1\"],\"petId\":[\"1\"],\"diagnosis\":[\"吃多了\"],\"treatment\":[\"饿三天\"],\"cost\":[\"0.00\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-18 20:20:23', 11);
INSERT INTO `sys_oper_log` VALUES (256, '诊疗记录', 5, 'com.petHis.project.system.records.controller.MedicalRecordsController.export()', 'POST', 1, 'admin', '研发部门', '/system/records/export', '127.0.0.1', '内网IP', '{\"petId\":[\"\"],\"cost\":[\"\"],\"orderByColumn\":[\"\"],\"isAsc\":[\"asc\"]}', '{\"msg\":\"f499c176-731e-4839-9f03-f46a24fff35e_诊疗记录数据.xlsx\",\"code\":0}', 0, NULL, '2025-02-18 20:25:10', 564);
INSERT INTO `sys_oper_log` VALUES (257, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"1\"],\"treatment\":[\"1\"],\"cost\":[\"1\"]}', NULL, 1, 'Cannot invoke \"com.petHis.project.monitor.online.domain.OnlineSession.getLoginName()\" because \"this.onlineSession\" is null', '2025-02-19 10:41:27', 50);
INSERT INTO `sys_oper_log` VALUES (258, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"\"],\"treatment\":[\"\"],\"cost\":[\"\"]}', NULL, 1, 'Cannot invoke \"com.petHis.project.monitor.online.domain.OnlineSession.getLoginName()\" because \"this.onlineSession\" is null', '2025-02-19 11:37:24', 29);
INSERT INTO `sys_oper_log` VALUES (259, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"diagnosis\":[\"\"],\"treatment\":[\"\"],\"cost\":[\"\"]}', NULL, 1, 'Cannot invoke \"javax.servlet.http.HttpServletRequest.getCookies()\" because \"request\" is null', '2025-02-19 11:38:27', 31);
INSERT INTO `sys_oper_log` VALUES (260, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"diagnosis\":[\"\"],\"treatment\":[\"\"],\"cost\":[\"\"]}', NULL, 1, 'Cannot invoke \"javax.servlet.http.HttpServletRequest.getCookies()\" because \"request\" is null', '2025-02-19 11:40:48', 27);
INSERT INTO `sys_oper_log` VALUES (261, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"\"],\"treatment\":[\"\"],\"cost\":[\"\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 12:08:42', 35);
INSERT INTO `sys_oper_log` VALUES (262, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"4\"],\"diagnosis\":[\"\"],\"treatment\":[\"\"],\"cost\":[\"\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 12:14:31', 41);
INSERT INTO `sys_oper_log` VALUES (263, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"\"],\"treatment\":[\"\"],\"cost\":[\"\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 12:16:09', 37);
INSERT INTO `sys_oper_log` VALUES (264, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"1\"],\"treatment\":[\"1\"],\"cost\":[\"1\"]}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'doctor_id\' in \'class com.petHis.project.system.records.domain.MedicalRecords\'', '2025-02-19 12:43:13', 31);
INSERT INTO `sys_oper_log` VALUES (265, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"1\"],\"treatment\":[\"1\"],\"cost\":[\"1\"]}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'create_by\' in \'class com.petHis.project.system.records.domain.MedicalRecords\'', '2025-02-19 12:45:10', 32);
INSERT INTO `sys_oper_log` VALUES (266, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"1\"],\"treatment\":[\"1\"],\"cost\":[\"1\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_by\' doesn\'t have a default value\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\MedicalRecordsMapper.xml]\r\n### The error may involve com.petHis.project.system.records.mapper.MedicalRecordsMapper.insertMedicalRecords-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into medical_records          ( pet_id,             diagnosis,             treatment,             cost,                          create_time )           values ( ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'create_by\' doesn\'t have a default value\n; Field \'create_by\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_by\' doesn\'t have a default value', '2025-02-19 12:46:33', 89);
INSERT INTO `sys_oper_log` VALUES (267, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"1\"],\"treatment\":[\"1\"],\"cost\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 12:47:51', 12);
INSERT INTO `sys_oper_log` VALUES (268, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/109', '127.0.0.1', '内网IP', '109', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:35:27', 53);
INSERT INTO `sys_oper_log` VALUES (269, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/108', '127.0.0.1', '内网IP', '108', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:35:29', 12);
INSERT INTO `sys_oper_log` VALUES (270, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/102', '127.0.0.1', '内网IP', '102', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:35:31', 6);
INSERT INTO `sys_oper_log` VALUES (271, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"3\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统工具\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"7\"],\"icon\":[\"fa fa-bars\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:38:27', 19);
INSERT INTO `sys_oper_log` VALUES (272, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统监控\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"8\"],\"icon\":[\"fa fa-video-camera\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:38:30', 19);
INSERT INTO `sys_oper_log` VALUES (273, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/107', '127.0.0.1', '内网IP', '107', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:46:49', 41);
INSERT INTO `sys_oper_log` VALUES (274, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/106', '127.0.0.1', '内网IP', '106', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:46:52', 13);
INSERT INTO `sys_oper_log` VALUES (275, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/105', '127.0.0.1', '内网IP', '105', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":301}', 0, NULL, '2025-02-19 14:46:56', 5);
INSERT INTO `sys_oper_log` VALUES (276, '用户管理', 3, 'com.petHis.project.system.user.controller.UserController.remove()', 'POST', 1, 'admin', '研发部门', '/system/user/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"2\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:47:06', 20);
INSERT INTO `sys_oper_log` VALUES (277, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/105', '127.0.0.1', '内网IP', '105', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:47:14', 12);
INSERT INTO `sys_oper_log` VALUES (278, '部门管理', 3, 'com.petHis.project.system.dept.controller.DeptController.remove()', 'GET', 1, 'admin', '研发部门', '/system/dept/remove/104', '127.0.0.1', '内网IP', '104', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:47:17', 14);
INSERT INTO `sys_oper_log` VALUES (279, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 14:55:39', 22);
INSERT INTO `sys_oper_log` VALUES (280, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\ClientsMapper.xml]\r\n### The error may involve com.petHis.project.system.clients.mapper.ClientsMapper.insertClients-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into clients          ( name,             phone,             address )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'\n; Duplicate entry \'15888888888\' for key \'idx_phone\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'', '2025-02-19 14:56:01', 85);
INSERT INTO `sys_oper_log` VALUES (281, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 15:27:25', 34);
INSERT INTO `sys_oper_log` VALUES (282, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:28:46', 31);
INSERT INTO `sys_oper_log` VALUES (283, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:31:28', 33);
INSERT INTO `sys_oper_log` VALUES (284, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:37:32', 33);
INSERT INTO `sys_oper_log` VALUES (285, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:37:38', 4);
INSERT INTO `sys_oper_log` VALUES (286, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:43:07', 33);
INSERT INTO `sys_oper_log` VALUES (287, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:43:34', 29);
INSERT INTO `sys_oper_log` VALUES (288, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:45:02', 31);
INSERT INTO `sys_oper_log` VALUES (289, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:47:39', 41);
INSERT INTO `sys_oper_log` VALUES (290, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:47:52', 4);
INSERT INTO `sys_oper_log` VALUES (291, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:48:26', 54);
INSERT INTO `sys_oper_log` VALUES (292, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:51:06', 36);
INSERT INTO `sys_oper_log` VALUES (293, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:53:32', 40);
INSERT INTO `sys_oper_log` VALUES (294, '客户', 1, 'com.petHis.project.system.clients.controller.ClientsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/add', '127.0.0.1', '内网IP', '{\"name\":[\"姚梦蝶\"],\"phone\":[\"15888888888\"],\"address\":[\"1\"]}', NULL, 1, '该手机号码已存在，不能重复插入！', '2025-02-19 15:57:07', 46);
INSERT INTO `sys_oper_log` VALUES (295, '用户管理', 1, 'com.petHis.project.system.user.controller.UserController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\"deptId\":[\"112\"],\"userName\":[\"测试\"],\"deptName\":[\"后勤部\"],\"phonenumber\":[\"15666666678\"],\"email\":[\"ceshi@163.com\"],\"loginName\":[\"ceshi\"],\"sex\":[\"2\"],\"role\":[\"4\"],\"remark\":[\"\"],\"status\":[\"0\"],\"roleIds\":[\"4\"],\"postIds\":[\"4\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 16:24:47', 62);
INSERT INTO `sys_oper_log` VALUES (296, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"4\"],\"diagnosis\":[\"q\"],\"treatment\":[\"q\"],\"cost\":[\"1\"]}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'create_by\' in \'class com.petHis.project.system.records.domain.MedicalRecords\'', '2025-02-19 16:28:07', 34);
INSERT INTO `sys_oper_log` VALUES (297, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"2\"],\"diagnosis\":[\"1\"],\"treatment\":[\"1\"],\"cost\":[\"1\"]}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'create_by\' in \'class com.petHis.project.system.records.domain.MedicalRecords\'', '2025-02-19 16:32:35', 33);
INSERT INTO `sys_oper_log` VALUES (298, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"1\"],\"diagnosis\":[\"s\"],\"treatment\":[\"ss\"],\"cost\":[\"1\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 16:44:17', 29);
INSERT INTO `sys_oper_log` VALUES (299, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"5\"],\"diagnosis\":[\"s\"],\"treatment\":[\"ss\"],\"cost\":[\"1\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 16:46:06', 1);
INSERT INTO `sys_oper_log` VALUES (300, '诊疗记录', 1, 'com.petHis.project.system.records.controller.MedicalRecordsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/records/add', '127.0.0.1', '内网IP', '{\"petId\":[\"2\"],\"diagnosis\":[\"c\"],\"treatment\":[\"c\"],\"cost\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 16:49:02', 58);
INSERT INTO `sys_oper_log` VALUES (301, '诊疗记录', 2, 'com.petHis.project.system.records.controller.MedicalRecordsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/records/edit', '127.0.0.1', '内网IP', '{\"recordId\":[\"3\"],\"diagnosis\":[\"修改\"],\"treatment\":[\"c\"],\"cost\":[\"1.00\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 16:53:39', 38);
INSERT INTO `sys_oper_log` VALUES (302, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"dataScope\":[\"4\"],\"deptIds\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 16:57:58', 29);
INSERT INTO `sys_oper_log` VALUES (303, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2025\"],\"menuType\":[\"F\"],\"menuName\":[\"查询预约\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:appointments:list\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 16:59:54', 15);
INSERT INTO `sys_oper_log` VALUES (304, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2025\"],\"menuType\":[\"F\"],\"menuName\":[\"导出预约\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:appointments:export\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:00:24', 12);
INSERT INTO `sys_oper_log` VALUES (305, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2025\"],\"menuType\":[\"F\"],\"menuName\":[\"新增预约\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:appointments:add\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:00:43', 11);
INSERT INTO `sys_oper_log` VALUES (306, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2025\"],\"menuType\":[\"F\"],\"menuName\":[\"修改预约\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:appointments:edit\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:01:22', 20);
INSERT INTO `sys_oper_log` VALUES (307, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2025\"],\"menuType\":[\"F\"],\"menuName\":[\"删除预约\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:appointments:remove\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:01:45', 20);
INSERT INTO `sys_oper_log` VALUES (308, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2026\"],\"menuType\":[\"F\"],\"menuName\":[\"查询诊疗记录\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:list\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:02:59', 10);
INSERT INTO `sys_oper_log` VALUES (309, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2026\"],\"menuType\":[\"F\"],\"menuName\":[\"导出诊疗记录\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:export\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:03:37', 11);
INSERT INTO `sys_oper_log` VALUES (310, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2026\"],\"menuType\":[\"F\"],\"menuName\":[\"新增诊疗记录\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:add\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:04:00', 12);
INSERT INTO `sys_oper_log` VALUES (311, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2026\"],\"menuType\":[\"F\"],\"menuName\":[\"修改诊疗记录\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:edit\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:04:24', 10);
INSERT INTO `sys_oper_log` VALUES (312, '菜单管理', 1, 'com.petHis.project.system.menu.controller.MenuController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2026\"],\"menuType\":[\"F\"],\"menuName\":[\"删除诊疗记录\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:remove\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:04:48', 5);
INSERT INTO `sys_oper_log` VALUES (313, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"dataScope\":[\"1\"],\"deptIds\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:05:34', 22);
INSERT INTO `sys_oper_log` VALUES (314, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"system:records:view\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,2026\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:07:46', 15);
INSERT INTO `sys_oper_log` VALUES (315, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"system:records:view\"],\"dataScope\":[\"2\"],\"deptIds\":[\"100,101,110\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:08:37', 22);
INSERT INTO `sys_oper_log` VALUES (316, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"system:records:view\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,2026,2042,2043,2044,2045,2046\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:14:06', 13);
INSERT INTO `sys_oper_log` VALUES (317, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2027,2028,2024,2032,2033,2025,2037,2038,2040,2026,2042,2043,2044,2045,2046\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:33:17', 12);
INSERT INTO `sys_oper_log` VALUES (318, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.authDataScopeSave()', 'POST', 1, 'admin', '研发部门', '/system/role/authDataScope', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"dataScope\":[\"2\"],\"deptIds\":[\"100,101,110\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:33:32', 24);
INSERT INTO `sys_oper_log` VALUES (319, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"客户专员\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"客户专员\"],\"menuIds\":[\"1,107,1035,1036,1037,1038,4,2027,2028,2029,2030,2024,2032,2033,2034,2035,2025,2037,2038,2039,2040\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:35:44', 12);
INSERT INTO `sys_oper_log` VALUES (320, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,4,2027,2028,2024,2032,2033,2025,2037,2038,2040,2026,2042,2043,2044,2045,2046\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:38:40', 6);
INSERT INTO `sys_oper_log` VALUES (321, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"客户专员\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"客户专员\"],\"menuIds\":[\"1,107,1035,1036,1037,4,2027,2028,2029,2030,2024,2032,2033,2034,2035,2025,2037,2038,2039,2040\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:38:50', 7);
INSERT INTO `sys_oper_log` VALUES (322, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"4\"],\"roleName\":[\"后勤人员\"],\"roleKey\":[\"common\"],\"roleSort\":[\"4\"],\"status\":[\"0\"],\"remark\":[\"后勤及其他工作人员\"],\"menuIds\":[\"1,107,1035\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:39:03', 13);
INSERT INTO `sys_oper_log` VALUES (323, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"客户专员\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"客户专员\"],\"menuIds\":[\"1,107,1035,1036,1037,4,2027,2028,2029,2030,2024,2032,2033,2034,2035,2025,2037,2038,2039,2040\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 17:39:13', 8);
INSERT INTO `sys_oper_log` VALUES (324, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'ys1', '诊疗服务部', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 18:14:25', 39);
INSERT INTO `sys_oper_log` VALUES (325, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"客户专员\"],\"roleKey\":[\"nurse\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"客户专员\"],\"menuIds\":[\"1,107,1035,1036,1037,4,2027,2028,2029,2030,2024,2032,2033,2034,2035,2025,2037,2038,2039,2040,2026,2042\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 18:28:13', 49);
INSERT INTO `sys_oper_log` VALUES (326, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'ys1', '诊疗服务部', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 18:29:51', 9);
INSERT INTO `sys_oper_log` VALUES (327, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"4\"],\"name\":[\"测试1\"],\"phone\":[\"15888888881\"],\"address\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 19:23:44', 12);
INSERT INTO `sys_oper_log` VALUES (328, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"4\"],\"name\":[\"测试1\"],\"phone\":[\"15888888888\"],\"address\":[\"\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\ClientsMapper.xml]\r\n### The error may involve com.petHis.project.system.clients.mapper.ClientsMapper.updateClients-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update clients          SET name = ?,             phone = ?,             address = ?          where client_id = ?\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'\n; Duplicate entry \'15888888888\' for key \'idx_phone\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'', '2025-02-19 19:23:54', 95);
INSERT INTO `sys_oper_log` VALUES (329, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"4\"],\"name\":[\"测试1\"],\"phone\":[\"15888888888\"],\"address\":[\"\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\ClientsMapper.xml]\r\n### The error may involve com.petHis.project.system.clients.mapper.ClientsMapper.updateClients-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update clients          SET name = ?,             phone = ?,             address = ?          where client_id = ?\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'\n; Duplicate entry \'15888888888\' for key \'idx_phone\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888888\' for key \'idx_phone\'', '2025-02-19 19:28:55', 86);
INSERT INTO `sys_oper_log` VALUES (330, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"4\"],\"name\":[\"测试1\"],\"phone\":[\"15888888888\"],\"address\":[\"\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 19:30:05', 40);
INSERT INTO `sys_oper_log` VALUES (331, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"4\"],\"name\":[\"测试1\"],\"phone\":[\"15888888888\"],\"address\":[\"\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 19:31:00', 31);
INSERT INTO `sys_oper_log` VALUES (332, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"4\"],\"name\":[\"测试1\"],\"phone\":[\"15888888888\"],\"address\":[\"\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-02-19 19:32:26', 42);
INSERT INTO `sys_oper_log` VALUES (333, '客户', 2, 'com.petHis.project.system.clients.controller.ClientsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/clients/edit', '127.0.0.1', '内网IP', '{\"clientId\":[\"4\"],\"name\":[\"测试1\"],\"phone\":[\"15888888888\"],\"address\":[\"\"]}', NULL, 1, '该手机号已存在，请勿重复添加。', '2025-02-19 19:33:13', 39);
INSERT INTO `sys_oper_log` VALUES (334, '客户', 3, 'com.petHis.project.system.clients.controller.ClientsController.remove()', 'POST', 1, 'admin', '研发部门', '/system/clients/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"4\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 19:33:32', 7);
INSERT INTO `sys_oper_log` VALUES (335, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientName\":[\"添加宠物信息页面修改\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-02-19\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888887\' for key \'idx_phone\'\r\n### The error may exist in file [D:\\study\\petsHis\\target\\classes\\mybatis\\system\\ClientsMapper.xml]\r\n### The error may involve com.petHis.project.system.clients.mapper.ClientsMapper.insertClients-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into clients          ( name,             phone )           values ( ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888887\' for key \'idx_phone\'\n; Duplicate entry \'15888888887\' for key \'idx_phone\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15888888887\' for key \'idx_phone\'', '2025-02-19 19:34:46', 68);
INSERT INTO `sys_oper_log` VALUES (336, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 19:44:58', 42);
INSERT INTO `sys_oper_log` VALUES (337, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', NULL, 1, '该宠物已存在，请勿重复添加。', '2025-02-19 20:20:04', 39);
INSERT INTO `sys_oper_log` VALUES (338, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"狗\"],\"birthday\":[\"2025-01-26\"]}', NULL, 1, '该宠物已存在，请勿重复添加。', '2025-02-19 20:20:43', 40);
INSERT INTO `sys_oper_log` VALUES (339, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientId\":[\"2\"],\"name\":[\"测试狗\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"]}', NULL, 1, '该宠物已存在，请勿重复添加。', '2025-02-19 20:20:48', 5);
INSERT INTO `sys_oper_log` VALUES (340, '宠物', 1, 'com.petHis.project.system.pets.controller.PetsController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/add', '127.0.0.1', '内网IP', '{\"clientPhone\":[\"15888888887\"],\"clientId\":[\"2\"],\"name\":[\"测试狗1\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-19 20:20:53', 17);
INSERT INTO `sys_oper_log` VALUES (341, '宠物', 2, 'com.petHis.project.system.pets.controller.PetsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/edit', '127.0.0.1', '内网IP', '{\"petId\":[\"7\"],\"name\":[\"测试狗\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"],\"healthStatus\":[\"0\"]}', NULL, 1, '该宠物名已存在，请换一个名字。', '2025-02-19 20:23:08', 47);
INSERT INTO `sys_oper_log` VALUES (342, '宠物', 2, 'com.petHis.project.system.pets.controller.PetsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/pets/edit', '127.0.0.1', '内网IP', '{\"petId\":[\"7\"],\"name\":[\"测试狗1\"],\"type\":[\"猫\"],\"birthday\":[\"2025-01-26\"],\"healthStatus\":[\"0\"]}', NULL, 1, '该宠物名已存在，请换一个名字。', '2025-02-19 20:23:13', 4);
INSERT INTO `sys_oper_log` VALUES (343, '字典类型', 1, 'com.petHis.project.system.dict.controller.DictTypeController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/add', '127.0.0.1', '内网IP', '{\"dictName\":[\"宠物类别\"],\"dictType\":[\"sys_pet_type\"],\"status\":[\"0\"],\"remark\":[\"宠物种类\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:40:50', 52);
INSERT INTO `sys_oper_log` VALUES (344, '字典数据', 1, 'com.petHis.project.system.dict.controller.DictDataController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/add', '127.0.0.1', '内网IP', '{\"dictLabel\":[\"猫\"],\"dictValue\":[\"0\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"1\"],\"listClass\":[\"\"],\"isDefault\":[\"Y\"],\"status\":[\"0\"],\"remark\":[\"类型：猫\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:42:37', 14);
INSERT INTO `sys_oper_log` VALUES (345, '字典数据', 1, 'com.petHis.project.system.dict.controller.DictDataController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/add', '127.0.0.1', '内网IP', '{\"dictLabel\":[\"狗\"],\"dictValue\":[\"1\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"2\"],\"listClass\":[\"\"],\"isDefault\":[\"N\"],\"status\":[\"0\"],\"remark\":[\"类型：狗\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:42:59', 19);
INSERT INTO `sys_oper_log` VALUES (346, '字典数据', 1, 'com.petHis.project.system.dict.controller.DictDataController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/add', '127.0.0.1', '内网IP', '{\"dictLabel\":[\"仓鼠\"],\"dictValue\":[\"3\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"3\"],\"listClass\":[\"\"],\"isDefault\":[\"N\"],\"status\":[\"0\"],\"remark\":[\"类型：仓鼠\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:44:27', 13);
INSERT INTO `sys_oper_log` VALUES (347, '字典数据', 2, 'com.petHis.project.system.dict.controller.DictDataController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/edit', '127.0.0.1', '内网IP', '{\"dictCode\":[\"32\"],\"dictLabel\":[\"仓鼠\"],\"dictValue\":[\"4\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"3\"],\"listClass\":[\"\"],\"isDefault\":[\"N\"],\"status\":[\"0\"],\"remark\":[\"类型：仓鼠\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:44:55', 15);
INSERT INTO `sys_oper_log` VALUES (348, '字典数据', 2, 'com.petHis.project.system.dict.controller.DictDataController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/edit', '127.0.0.1', '内网IP', '{\"dictCode\":[\"32\"],\"dictLabel\":[\"仓鼠\"],\"dictValue\":[\"3\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"3\"],\"listClass\":[\"\"],\"isDefault\":[\"N\"],\"status\":[\"0\"],\"remark\":[\"类型：仓鼠\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:45:13', 12);
INSERT INTO `sys_oper_log` VALUES (349, '字典数据', 2, 'com.petHis.project.system.dict.controller.DictDataController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/edit', '127.0.0.1', '内网IP', '{\"dictCode\":[\"31\"],\"dictLabel\":[\"狗\"],\"dictValue\":[\"2\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"2\"],\"listClass\":[\"\"],\"isDefault\":[\"N\"],\"status\":[\"0\"],\"remark\":[\"类型：狗\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:45:18', 14);
INSERT INTO `sys_oper_log` VALUES (350, '字典数据', 2, 'com.petHis.project.system.dict.controller.DictDataController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/edit', '127.0.0.1', '内网IP', '{\"dictCode\":[\"30\"],\"dictLabel\":[\"猫\"],\"dictValue\":[\"1\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"1\"],\"listClass\":[\"\"],\"isDefault\":[\"Y\"],\"status\":[\"0\"],\"remark\":[\"类型：猫\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:45:24', 13);
INSERT INTO `sys_oper_log` VALUES (351, '字典数据', 1, 'com.petHis.project.system.dict.controller.DictDataController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/dict/data/add', '127.0.0.1', '内网IP', '{\"dictLabel\":[\"未知\"],\"dictValue\":[\"0\"],\"dictType\":[\"sys_pet_type\"],\"cssClass\":[\"\"],\"dictSort\":[\"4\"],\"listClass\":[\"\"],\"isDefault\":[\"N\"],\"status\":[\"0\"],\"remark\":[\"未知类型\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 16:45:50', 10);
INSERT INTO `sys_oper_log` VALUES (352, '用户管理', 1, 'com.petHis.project.system.user.controller.UserController.addSave()', 'POST', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\"deptId\":[\"110\"],\"userName\":[\"医生2\"],\"deptName\":[\"诊疗服务部\"],\"phonenumber\":[\"15666666679\"],\"email\":[\"ys2@163.com\"],\"loginName\":[\"ys2\"],\"sex\":[\"0\"],\"role\":[\"2\"],\"remark\":[\"\"],\"status\":[\"0\"],\"roleIds\":[\"2\"],\"postIds\":[\"2\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 18:14:22', 54);
INSERT INTO `sys_oper_log` VALUES (353, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 19:27:15', 31);
INSERT INTO `sys_oper_log` VALUES (354, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2044\"],\"parentId\":[\"2026\"],\"menuType\":[\"F\"],\"menuName\":[\"新增诊疗记录\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:add\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 19:45:47', 21);
INSERT INTO `sys_oper_log` VALUES (355, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2044\"],\"parentId\":[\"2026\"],\"menuType\":[\"F\"],\"menuName\":[\"新增诊疗记录\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"system:records:add\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 19:46:19', 5);
INSERT INTO `sys_oper_log` VALUES (356, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"2\"],\"roleName\":[\"医护人员\"],\"roleKey\":[\"doctor\"],\"roleSort\":[\"2\"],\"status\":[\"0\"],\"remark\":[\"医护人员\"],\"menuIds\":[\"1,107,1035,1036,1037,4,2027,2028,2024,2032,2033,2025,2037,2038,2040,2026,2042,2043,2045,2046\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 19:47:08', 26);
INSERT INTO `sys_oper_log` VALUES (357, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'ys1', '诊疗服务部', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"0\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 19:47:42', 3);
INSERT INTO `sys_oper_log` VALUES (358, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:13:52', 27);
INSERT INTO `sys_oper_log` VALUES (359, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:20:43', 37);
INSERT INTO `sys_oper_log` VALUES (360, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:25:18', 37);
INSERT INTO `sys_oper_log` VALUES (361, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"2\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:26:00', 9);
INSERT INTO `sys_oper_log` VALUES (362, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:26:13', 3);
INSERT INTO `sys_oper_log` VALUES (363, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:27:07', 54);
INSERT INTO `sys_oper_log` VALUES (364, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:29:04', 47);
INSERT INTO `sys_oper_log` VALUES (365, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:35:25', 31);
INSERT INTO `sys_oper_log` VALUES (366, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'appointment_id\' in \'class com.petHis.project.system.records.domain.MedicalRecords\'', '2025-02-20 20:37:23', 53);
INSERT INTO `sys_oper_log` VALUES (367, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:38:59', 36);
INSERT INTO `sys_oper_log` VALUES (368, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:39:12', 7);
INSERT INTO `sys_oper_log` VALUES (369, '诊疗记录', 3, 'com.petHis.project.system.records.controller.MedicalRecordsController.remove()', 'POST', 1, 'admin', '研发部门', '/system/records/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"5\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:39:29', 12);
INSERT INTO `sys_oper_log` VALUES (370, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:41:41', 43);
INSERT INTO `sys_oper_log` VALUES (371, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:44:26', 39);
INSERT INTO `sys_oper_log` VALUES (372, '诊疗记录', 2, 'com.petHis.project.system.records.controller.MedicalRecordsController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/records/edit', '127.0.0.1', '内网IP', '{\"recordId\":[\"4\"],\"diagnosis\":[\"测试\"],\"treatment\":[\"测试\"],\"cost\":[\"0.00\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:44:40', 12);
INSERT INTO `sys_oper_log` VALUES (373, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统监控\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"8\"],\"icon\":[\"fa fa-video-camera\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:48:05', 20);
INSERT INTO `sys_oper_log` VALUES (374, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统监控\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"8\"],\"icon\":[\"fa fa-video-camera\"],\"visible\":[\"0\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:48:37', 12);
INSERT INTO `sys_oper_log` VALUES (375, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"3\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统工具\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"7\"],\"icon\":[\"fa fa-bars\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 20:48:41', 12);
INSERT INTO `sys_oper_log` VALUES (376, '预约', 2, 'com.petHis.project.system.appointments.controller.AppointmentsController.editSave()', 'POST', 1, 'ys1', '诊疗服务部', '/system/appointments/edit', '127.0.0.1', '内网IP', '{\"appointmentId\":[\"2\"],\"petId\":[\"1\"],\"petName\":[\"修改测试狗\"],\"doctorId\":[\"3\"],\"userName\":[\"医生1\"],\"appointmentTime\":[\"2025-01-26\"],\"status\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 21:00:07', 56);
INSERT INTO `sys_oper_log` VALUES (377, '诊疗记录', 3, 'com.petHis.project.system.records.controller.MedicalRecordsController.remove()', 'POST', 1, 'admin', '研发部门', '/system/records/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"4\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 21:00:32', 12);
INSERT INTO `sys_oper_log` VALUES (378, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"108\"],\"parentId\":[\"1\"],\"menuType\":[\"M\"],\"menuName\":[\"日志管理\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"9\"],\"icon\":[\"fa fa-pencil-square-o\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 21:22:33', 47);
INSERT INTO `sys_oper_log` VALUES (379, '菜单管理', 2, 'com.petHis.project.system.menu.controller.MenuController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2\"],\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"系统监控\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"8\"],\"icon\":[\"fa fa-video-camera\"],\"visible\":[\"1\"],\"isRefresh\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-20 21:22:44', 12);
INSERT INTO `sys_oper_log` VALUES (380, '个人信息', 2, 'com.petHis.project.system.user.controller.ProfileController.updateAvatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/updateAvatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-21 09:51:11', 235);
INSERT INTO `sys_oper_log` VALUES (381, '参数管理', 2, 'com.petHis.project.system.config.controller.ConfigController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/config/edit', '127.0.0.1', '内网IP', '{\"configId\":[\"8\"],\"configName\":[\"主框架页-菜单导航显示风格\"],\"configKey\":[\"sys.index.menuStyle\"],\"configValue\":[\"default\"],\"configType\":[\"N\"],\"remark\":[\"菜单导航显示风格（default为左侧导航菜单，topnav为顶部导航菜单）\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-21 10:36:21', 31);
INSERT INTO `sys_oper_log` VALUES (382, '参数管理', 2, 'com.petHis.project.system.config.controller.ConfigController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/config/edit', '127.0.0.1', '内网IP', '{\"configId\":[\"8\"],\"configName\":[\"主框架页-菜单导航显示风格\"],\"configKey\":[\"sys.index.menuStyle\"],\"configValue\":[\"default\"],\"configType\":[\"Y\"],\"remark\":[\"菜单导航显示风格（default为左侧导航菜单，topnav为顶部导航菜单）\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-21 10:36:44', 24);
INSERT INTO `sys_oper_log` VALUES (383, '参数管理', 9, 'com.petHis.project.system.config.controller.ConfigController.refreshCache()', 'GET', 1, 'admin', '研发部门', '/system/config/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-21 10:36:53', 27);
INSERT INTO `sys_oper_log` VALUES (384, '角色管理', 2, 'com.petHis.project.system.role.controller.RoleController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\"roleId\":[\"3\"],\"roleName\":[\"客户专员\"],\"roleKey\":[\"Customer Specialist\"],\"roleSort\":[\"3\"],\"status\":[\"0\"],\"remark\":[\"客户专员\"],\"menuIds\":[\"1,107,1035,1036,1037,4,2027,2028,2029,2030,2024,2032,2033,2034,2035,2025,2037,2038,2039,2040,2026,2042\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-21 13:24:04', 172);
INSERT INTO `sys_oper_log` VALUES (385, '参数管理', 2, 'com.petHis.project.system.config.controller.ConfigController.editSave()', 'POST', 1, 'admin', '研发部门', '/system/config/edit', '127.0.0.1', '内网IP', '{\"configId\":[\"4\"],\"configName\":[\"账号自助-是否开启用户注册功能\"],\"configKey\":[\"sys.account.registerUser\"],\"configValue\":[\"true\"],\"configType\":[\"Y\"],\"remark\":[\"是否开启注册用户功能（true开启，false关闭）\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2025-02-21 14:50:01', 9);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位名称',
  `basic_salary` decimal(12, 2) NOT NULL COMMENT '基本工资',
  `bonus_coefficient` decimal(3, 2) NULL DEFAULT 0.00 COMMENT '奖金系数',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `effect_date` date NOT NULL DEFAULT '2025-01-01' COMMENT '薪资生效日期',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'system', '系统用户', 0.00, 0.00, 1, '0', 'admin', '2025-02-16 12:38:47', 'admin', '2025-03-15 20:16:23', 'system', '2025-01-01');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', '0', '0', 'admin', '2025-02-16 12:38:47', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '医护人员', 'doctor', 2, '1', '0', '0', 'admin', '2025-02-16 12:38:47', 'admin', '2025-03-17 23:58:25', '医护人员');
INSERT INTO `sys_role` VALUES (3, '客户专员', 'Customer Specialist', 3, '2', '0', '2', 'admin', '2025-02-18 09:44:07', 'admin', '2025-02-26 17:05:07', '客户专员');
INSERT INTO `sys_role` VALUES (4, '后勤人员', 'common', 4, '5', '0', '2', 'admin', '2025-02-18 10:14:26', 'admin', '2025-02-25 10:40:44', '后勤及其他工作人员');
INSERT INTO `sys_role` VALUES (5, 'vip用户', 'user', 5, '5', '0', '2', 'admin', '2025-02-24 11:05:23', 'admin', '2025-02-25 10:39:12', 'vip用户');
INSERT INTO `sys_role` VALUES (6, '财务人员', 'finance', 6, '2', '0', '2', 'admin', '2025-02-24 11:07:32', 'admin', '2025-02-25 10:42:51', '');
INSERT INTO `sys_role` VALUES (7, '宠物主人', 'petUser', 2, '4', '0', '0', 'admin', '2025-03-15 20:23:03', 'admin', '2025-03-19 02:03:43', '');
INSERT INTO `sys_role` VALUES (8, '保险公司', 'company', 10, '5', '0', '0', 'admin', '2025-03-17 00:50:05', 'admin', '2025-03-17 23:57:57', '');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 2024);
INSERT INTO `sys_role_menu` VALUES (2, 2025);
INSERT INTO `sys_role_menu` VALUES (2, 2027);
INSERT INTO `sys_role_menu` VALUES (2, 2028);
INSERT INTO `sys_role_menu` VALUES (2, 2032);
INSERT INTO `sys_role_menu` VALUES (2, 2033);
INSERT INTO `sys_role_menu` VALUES (2, 2037);
INSERT INTO `sys_role_menu` VALUES (2, 2038);
INSERT INTO `sys_role_menu` VALUES (2, 2040);
INSERT INTO `sys_role_menu` VALUES (2, 2047);
INSERT INTO `sys_role_menu` VALUES (2, 2050);
INSERT INTO `sys_role_menu` VALUES (2, 2057);
INSERT INTO `sys_role_menu` VALUES (2, 2059);
INSERT INTO `sys_role_menu` VALUES (2, 2061);
INSERT INTO `sys_role_menu` VALUES (2, 2062);
INSERT INTO `sys_role_menu` VALUES (2, 2063);
INSERT INTO `sys_role_menu` VALUES (2, 2064);
INSERT INTO `sys_role_menu` VALUES (2, 2065);
INSERT INTO `sys_role_menu` VALUES (2, 2066);
INSERT INTO `sys_role_menu` VALUES (2, 2073);
INSERT INTO `sys_role_menu` VALUES (2, 2074);
INSERT INTO `sys_role_menu` VALUES (2, 2075);
INSERT INTO `sys_role_menu` VALUES (2, 2076);
INSERT INTO `sys_role_menu` VALUES (2, 2077);
INSERT INTO `sys_role_menu` VALUES (2, 2078);
INSERT INTO `sys_role_menu` VALUES (2, 2079);
INSERT INTO `sys_role_menu` VALUES (2, 2080);
INSERT INTO `sys_role_menu` VALUES (2, 2081);
INSERT INTO `sys_role_menu` VALUES (2, 2082);
INSERT INTO `sys_role_menu` VALUES (2, 2083);
INSERT INTO `sys_role_menu` VALUES (2, 2084);
INSERT INTO `sys_role_menu` VALUES (2, 2085);
INSERT INTO `sys_role_menu` VALUES (7, 1);
INSERT INTO `sys_role_menu` VALUES (7, 4);
INSERT INTO `sys_role_menu` VALUES (7, 100);
INSERT INTO `sys_role_menu` VALUES (7, 101);
INSERT INTO `sys_role_menu` VALUES (7, 102);
INSERT INTO `sys_role_menu` VALUES (7, 103);
INSERT INTO `sys_role_menu` VALUES (7, 104);
INSERT INTO `sys_role_menu` VALUES (7, 105);
INSERT INTO `sys_role_menu` VALUES (7, 106);
INSERT INTO `sys_role_menu` VALUES (7, 107);
INSERT INTO `sys_role_menu` VALUES (7, 1000);
INSERT INTO `sys_role_menu` VALUES (7, 1001);
INSERT INTO `sys_role_menu` VALUES (7, 1002);
INSERT INTO `sys_role_menu` VALUES (7, 1003);
INSERT INTO `sys_role_menu` VALUES (7, 1004);
INSERT INTO `sys_role_menu` VALUES (7, 1005);
INSERT INTO `sys_role_menu` VALUES (7, 1006);
INSERT INTO `sys_role_menu` VALUES (7, 1007);
INSERT INTO `sys_role_menu` VALUES (7, 1008);
INSERT INTO `sys_role_menu` VALUES (7, 1009);
INSERT INTO `sys_role_menu` VALUES (7, 1010);
INSERT INTO `sys_role_menu` VALUES (7, 1011);
INSERT INTO `sys_role_menu` VALUES (7, 1012);
INSERT INTO `sys_role_menu` VALUES (7, 1013);
INSERT INTO `sys_role_menu` VALUES (7, 1014);
INSERT INTO `sys_role_menu` VALUES (7, 1015);
INSERT INTO `sys_role_menu` VALUES (7, 1016);
INSERT INTO `sys_role_menu` VALUES (7, 1017);
INSERT INTO `sys_role_menu` VALUES (7, 1018);
INSERT INTO `sys_role_menu` VALUES (7, 1019);
INSERT INTO `sys_role_menu` VALUES (7, 1020);
INSERT INTO `sys_role_menu` VALUES (7, 1021);
INSERT INTO `sys_role_menu` VALUES (7, 1022);
INSERT INTO `sys_role_menu` VALUES (7, 1023);
INSERT INTO `sys_role_menu` VALUES (7, 1024);
INSERT INTO `sys_role_menu` VALUES (7, 1025);
INSERT INTO `sys_role_menu` VALUES (7, 1026);
INSERT INTO `sys_role_menu` VALUES (7, 1027);
INSERT INTO `sys_role_menu` VALUES (7, 1028);
INSERT INTO `sys_role_menu` VALUES (7, 1029);
INSERT INTO `sys_role_menu` VALUES (7, 1030);
INSERT INTO `sys_role_menu` VALUES (7, 1031);
INSERT INTO `sys_role_menu` VALUES (7, 1032);
INSERT INTO `sys_role_menu` VALUES (7, 1033);
INSERT INTO `sys_role_menu` VALUES (7, 1034);
INSERT INTO `sys_role_menu` VALUES (7, 1035);
INSERT INTO `sys_role_menu` VALUES (7, 1036);
INSERT INTO `sys_role_menu` VALUES (7, 1037);
INSERT INTO `sys_role_menu` VALUES (7, 1038);
INSERT INTO `sys_role_menu` VALUES (7, 2024);
INSERT INTO `sys_role_menu` VALUES (7, 2025);
INSERT INTO `sys_role_menu` VALUES (7, 2027);
INSERT INTO `sys_role_menu` VALUES (7, 2032);
INSERT INTO `sys_role_menu` VALUES (7, 2033);
INSERT INTO `sys_role_menu` VALUES (7, 2034);
INSERT INTO `sys_role_menu` VALUES (7, 2035);
INSERT INTO `sys_role_menu` VALUES (7, 2036);
INSERT INTO `sys_role_menu` VALUES (7, 2037);
INSERT INTO `sys_role_menu` VALUES (7, 2038);
INSERT INTO `sys_role_menu` VALUES (7, 2039);
INSERT INTO `sys_role_menu` VALUES (7, 2040);
INSERT INTO `sys_role_menu` VALUES (7, 2041);
INSERT INTO `sys_role_menu` VALUES (7, 2073);
INSERT INTO `sys_role_menu` VALUES (7, 2080);
INSERT INTO `sys_role_menu` VALUES (7, 2081);
INSERT INTO `sys_role_menu` VALUES (7, 2082);
INSERT INTO `sys_role_menu` VALUES (7, 2083);
INSERT INTO `sys_role_menu` VALUES (7, 2084);
INSERT INTO `sys_role_menu` VALUES (7, 2085);
INSERT INTO `sys_role_menu` VALUES (8, 2073);
INSERT INTO `sys_role_menu` VALUES (8, 2074);
INSERT INTO `sys_role_menu` VALUES (8, 2075);
INSERT INTO `sys_role_menu` VALUES (8, 2076);
INSERT INTO `sys_role_menu` VALUES (8, 2077);
INSERT INTO `sys_role_menu` VALUES (8, 2078);
INSERT INTO `sys_role_menu` VALUES (8, 2079);
INSERT INTO `sys_role_menu` VALUES (8, 2080);
INSERT INTO `sys_role_menu` VALUES (8, 2081);
INSERT INTO `sys_role_menu` VALUES (8, 2082);
INSERT INTO `sys_role_menu` VALUES (8, 2083);
INSERT INTO `sys_role_menu` VALUES (8, 2084);
INSERT INTO `sys_role_menu` VALUES (8, 2085);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `login_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '登录账号',
  `user_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户 01注册用户）',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '头像路径',
  `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '盐加密',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `secretkey` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `amount` decimal(10, 2) NULL DEFAULT 0.00,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 100, 'admin', '姚梦蝶', '00', 'ymd@163.com', '15888888888', '1', '/profile/avatar/2025/02/21/blob_20250221095111A001.png', 'd8cf376f00c6c62a77693ca3c6590f8d', 'a37929', '0', '0', '0:0:0:0:0:0:0:1', '2025-04-01 20:48:35', '2025-02-18 16:49:38', 'admin', '2025-02-16 12:38:47', '', '2025-04-01 20:48:34', '管理员', NULL, NULL);
INSERT INTO `sys_user` VALUES (14, 100, 'ys1', 'ys1', '00', '985989248@qq.com', '13200132099', '2', '', '8dde358371f3ece59652fba338236d9f', '4a0dee', '0', '0', '0:0:0:0:0:0:0:1', '2025-03-16 15:41:21', '2025-03-16 15:41:02', 'admin', '2025-03-16 15:41:02', '', '2025-03-16 15:41:21', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (15, NULL, 'test', 'test', '01', '', '', '0', '', 'd008d8e85b1207a74b810c8435f88f12', 'ebbc62', '0', '2', '0:0:0:0:0:0:0:1', '2025-03-17 01:01:05', '2025-03-17 01:00:56', '', '2025-03-17 01:00:56', '', '2025-03-17 01:01:04', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (16, NULL, 'test1', 'test1', '01', '', '', '0', '', '4359b9a9917ceb5409a61a2b111dba70', '09a762', '0', '0', '0:0:0:0:0:0:0:1', '2025-03-19 01:45:19', '2025-03-19 01:44:13', '', '2025-03-19 01:44:13', '', '2025-03-19 01:45:19', NULL, NULL, 0.00);
INSERT INTO `sys_user` VALUES (17, NULL, 'test2', 'test2', '01', '', '13111111111', '0', '', 'cec677615d4c1ff6b56a941af71307fa', '7c3f71', '0', '0', '0:0:0:0:0:0:0:1', '2025-03-19 01:48:05', '2025-03-19 01:47:57', '', '2025-03-19 01:47:57', 'admin', '2025-03-19 01:49:35', '', NULL, 0.00);
INSERT INTO `sys_user` VALUES (18, NULL, 'test3', 'test3', '01', '', '13711111112', '0', '', '29dc2e48fe31964d93d772f8e9fe7b84', '7fbfac', '0', '0', '0:0:0:0:0:0:0:1', '2025-03-19 13:03:45', '2025-03-19 01:56:12', '', '2025-03-19 01:56:12', 'admin', '2025-03-19 13:03:44', '', NULL, 0.00);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (3, 1);
INSERT INTO `sys_user_post` VALUES (7, 1);
INSERT INTO `sys_user_post` VALUES (14, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (3, 2);
INSERT INTO `sys_user_role` VALUES (7, 2);
INSERT INTO `sys_user_role` VALUES (12, 7);
INSERT INTO `sys_user_role` VALUES (14, 2);
INSERT INTO `sys_user_role` VALUES (16, 8);
INSERT INTO `sys_user_role` VALUES (17, 7);
INSERT INTO `sys_user_role` VALUES (18, 7);

-- ----------------------------
-- View structure for current_salary_view
-- ----------------------------
DROP VIEW IF EXISTS `current_salary_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `current_salary_view` AS select `up`.`user_id` AS `user_id`,`p`.`post_id` AS `post_id`,(`p`.`basic_salary` * (1 + `p`.`bonus_coefficient`)) AS `post_salary`,concat(`p`.`post_name`,': ',convert(format(`p`.`basic_salary`,2) using utf8mb3),' + ',convert(format((`p`.`basic_salary` * `p`.`bonus_coefficient`),2) using utf8mb3)) AS `formula` from (`sys_user_post` `up` join `sys_post` `p` on((`up`.`post_id` = `p`.`post_id`))) where (`p`.`effect_date` = (select max(`sys_post`.`effect_date`) from `sys_post` where ((`sys_post`.`post_id` = `p`.`post_id`) and (`sys_post`.`effect_date` <= curdate()))));

-- ----------------------------
-- View structure for drug_unit_check
-- ----------------------------
DROP VIEW IF EXISTS `drug_unit_check`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `drug_unit_check` AS select `drug_inventory`.`drug_id` AS `drug_id`,`drug_inventory`.`drug_name` AS `drug_name` from `drug_inventory` where ((`drug_inventory`.`unit_type` is null) or (`drug_inventory`.`unit_quantity` is null));

-- ----------------------------
-- Procedure structure for GenerateLastMonthSalary
-- ----------------------------
DROP PROCEDURE IF EXISTS `GenerateLastMonthSalary`;
delimiter ;;
CREATE PROCEDURE `GenerateLastMonthSalary`()
BEGIN
  -- 定义变量：记录日期为上月最后一天
  DECLARE last_month_end DATE;
  SET last_month_end = LAST_DAY(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH));

  -- 开启事务
  START TRANSACTION;

  -- 插入财务记录
  INSERT INTO financial_record (
    dict_code, 
    amount, 
    record_date,
    related_id, 
    remark
  )
  SELECT 
    1,
    SUM(csv.post_salary),
    last_month_end,  -- 使用计算好的日期
    csv.user_id,
    GROUP_CONCAT(CONCAT('岗位：', csv.formula) SEPARATOR ', ')
  FROM current_salary_view csv
  JOIN sys_user su ON csv.user_id = su.user_id
  WHERE su.login_name != 'admin' AND su.user_type = '00'
  GROUP BY csv.user_id;

  -- 提交事务
  COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for UpdateExpiredAppointments
-- ----------------------------
DROP PROCEDURE IF EXISTS `UpdateExpiredAppointments`;
delimiter ;;
CREATE PROCEDURE `UpdateExpiredAppointments`()
BEGIN
  -- 开启事务（可选，确保原子性）
  START TRANSACTION;

  -- 更新过期预约状态为“已取消”
  UPDATE appointments
  SET status = 2
  WHERE status = 0  -- 仅处理状态为“已预约”的记录
    AND CONVERT_TZ(appointment_time, '+08:00', 'UTC') < UTC_TIMESTAMP();  -- 过期条件：预约时间早于当前时间

  -- 提交事务
  COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for AutoGenerateSalaryRecord
-- ----------------------------
DROP EVENT IF EXISTS `AutoGenerateSalaryRecord`;
delimiter ;;
CREATE EVENT `AutoGenerateSalaryRecord`
ON SCHEDULE
EVERY '1' MONTH STARTS '2025-03-05 00:00:00'
DO CALL GenerateLastMonthSalary()
;;
delimiter ;

-- ----------------------------
-- Event structure for AutoUpdateAppointmentStatus
-- ----------------------------
DROP EVENT IF EXISTS `AutoUpdateAppointmentStatus`;
delimiter ;;
CREATE EVENT `AutoUpdateAppointmentStatus`
ON SCHEDULE
EVERY '1' DAY STARTS '2025-02-25 00:00:00'
DO CALL UpdateExpiredAppointments()
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
