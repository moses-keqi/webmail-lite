/*

 Source Server         : 127.0.0.1-learning
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : 127.0.0.1:3306
 Source Schema         : learning

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 25/05/2024 19:26:43
*/
CREATE DATABASE IF NOT EXISTS  learning charset=utf8mb4 collate=utf8mb4_general_ci;

use learning;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for i_aliases
-- ----------------------------
DROP TABLE IF EXISTS `i_aliases`;
CREATE TABLE `i_aliases` (
                             `id` int NOT NULL AUTO_INCREMENT,
                             `source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `destination` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             PRIMARY KEY (`id`) USING BTREE,
                             KEY `source` (`source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮箱别名转发';

-- ----------------------------
-- Records of i_aliases
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for i_bcc_user
-- ----------------------------
DROP TABLE IF EXISTS `i_bcc_user`;
CREATE TABLE `i_bcc_user` (
                              `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接收邮件的email',
                              `to_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '目标用户的邮件',
                              KEY `source` (`source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮件转发';

-- ----------------------------
-- Records of i_bcc_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for i_domains
-- ----------------------------
DROP TABLE IF EXISTS `i_domains`;
CREATE TABLE `i_domains` (
                             `id` int NOT NULL AUTO_INCREMENT,
                             `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `active` int NOT NULL DEFAULT '0',
                             `s_num` int NOT NULL DEFAULT '0' COMMENT '邮件每天的发送量，0不受限制',
                             `c_num` int NOT NULL DEFAULT '0' COMMENT '邮件每天的接收量，0不受限制',
                             `c_ip` int NOT NULL DEFAULT '0' COMMENT '限制IP每天发送到邮件的数量，0不受限制',
                             `g` int NOT NULL DEFAULT '0' COMMENT '容量限制，单位G',
                             `g_boundary` int NOT NULL DEFAULT '0' COMMENT '容量达到边界发送通知(百分比)',
                             `ctime` datetime NOT NULL,
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE KEY `name` (`name`) USING BTREE,
                             KEY `active` (`active`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of i_domains
-- ----------------------------
BEGIN;
INSERT INTO `i_domains` (`id`, `name`, `active`, `s_num`, `c_num`, `c_ip`, `g`, `g_boundary`, `ctime`) VALUES (1, 'learning.com', 1, 0, 0, 0, 0, 0, '2024-04-29 15:25:49');
COMMIT;

-- ----------------------------
-- Table structure for i_quota
-- ----------------------------
DROP TABLE IF EXISTS `i_quota`;
CREATE TABLE `i_quota` (
                           `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `bytes` bigint NOT NULL DEFAULT '0',
                           `messages` int NOT NULL DEFAULT '0',
                           PRIMARY KEY (`email`) USING BTREE,
                           UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of i_quota
-- ----------------------------
BEGIN;
INSERT INTO `i_quota` (`email`, `bytes`, `messages`) VALUES ('admin@learning.com', 1449597, 16);
INSERT INTO `i_quota` (`email`, `bytes`, `messages`) VALUES ('zhangsan@learning.com', 18991, 13);
COMMIT;

-- ----------------------------
-- Table structure for i_users
-- ----------------------------
DROP TABLE IF EXISTS `i_users`;
CREATE TABLE `i_users` (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `domain_id` int NOT NULL,
                           `password` varchar(106) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `maildir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `uname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '姓名',
                           `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
                           `active` int NOT NULL DEFAULT '1' COMMENT '是否正常：1是，0否',
                           `limits` int NOT NULL DEFAULT '1' COMMENT '收发限制',
                           `limitg` int NOT NULL DEFAULT '1' COMMENT '容量限制',
                           `ctime` datetime NOT NULL,
                           PRIMARY KEY (`id`) USING BTREE,
                           UNIQUE KEY `email` (`email`) USING BTREE,
                           KEY `domain_id` (`domain_id`) USING BTREE,
                           KEY `active` (`active`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='邮箱用户表';

-- ----------------------------
-- Records of i_users
-- ----------------------------
BEGIN;
INSERT INTO `i_users` (`id`, `domain_id`, `password`, `email`, `maildir`, `uname`, `tel`, `active`, `limits`, `limitg`, `ctime`) VALUES (1, 1, '0192023a7bbd73250516f069df18b500', 'admin@learning.com', '/data/mail/vmail/learning.com/a/d/m/admin.20240429', 'admin', NULL, 1, 0, 0, '2024-04-29 16:36:23');
INSERT INTO `i_users` (`id`, `domain_id`, `password`, `email`, `maildir`, `uname`, `tel`, `active`, `limits`, `limitg`, `ctime`) VALUES (4, 1, '0192023a7bbd73250516f069df18b500', 'zhangsan@learning.com', '/data/mail/vmail/learning.com/z/h/a/zhangsan.20240429', '张三', '13052253109', 1, 0, 0, '2024-04-29 16:36:23');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
