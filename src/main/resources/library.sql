/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 10/09/2021 09:29:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理者姓名',
  `stuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录账号名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录密码',
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (3, '王五', 'wangwu', '96e79218965eb72c92a549dd5a330112');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '书的类型  武侠、言情等',
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `publicationdate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出版时间',
  `price` int(11) NULL DEFAULT NULL COMMENT '发行价格',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发行状态',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '斗破苍穹', '脑残土豆', '玄幻', '起点', '2012-04-06', 20, '2', '无');
INSERT INTO `book` VALUES (2, '武动乾坤', '脑残土豆', '玄幻', '起点', '2012-04-06', 20, '2', '无');
INSERT INTO `book` VALUES (3, '元尊', '脑残土豆', '玄幻', '起点', '2012-04-06', 20, '2', '无');
INSERT INTO `book` VALUES (4, '斗罗大陆', '唐三', '玄幻', '起点', '2012-04-06', 20, '2', '无');
INSERT INTO `book` VALUES (6, '绝世唐门', '唐三', '玄幻', '起点', '2012-04-06', 20, '2', '无');
INSERT INTO `book` VALUES (7, '龙王传说', '唐三', '玄幻', '起点', '2012-04-06', 20, '1', '无');
INSERT INTO `book` VALUES (9, '神墓', '辰东', '玄幻', '起点', '2019-08-14', 23, '1', '无');
INSERT INTO `book` VALUES (10, '盗墓笔记', '南派三叔', '悬疑', '起点', '2019-08-07', 45, '1', '无');
INSERT INTO `book` VALUES (11, '鬼吹灯', '霸唱天下', '悬疑', '起点', '2019-08-07', 45, '1', '无');
INSERT INTO `book` VALUES (13, '庆余年', '猫腻', '古装', '北京出版社', '2021-09-09', 30, '1', '赶快买');

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `borrower` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '借阅者',
  `borrowtime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '借阅时间',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '借阅的书名',
  `bid` int(11) NULL DEFAULT NULL COMMENT '关联的书id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES (21, 'jack', '2019-08-19', '斗破苍穹', 1);
INSERT INTO `borrow` VALUES (22, 'jack', '2019-08-19', '武动乾坤', 2);
INSERT INTO `borrow` VALUES (23, 'rose', '2019-08-19', '元尊', 3);
INSERT INTO `borrow` VALUES (24, 'rose', '2019-08-19', '斗罗大陆', 4);
INSERT INTO `borrow` VALUES (25, 'javaniu', '2019-09-21', '绝世唐门', 6);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别',
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `institute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学生所在学院',
  `profession` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学生的专业',
  `classname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '班级名称',
  `stuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '使用的账户（学生的登录id）',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '使用的密码',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, 'rick', '男', '18090093154', '能源学院', '石油工程', '3班', '1198495155', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `user` VALUES (4, 'jack', '男', '18090093154', '能源学院', '石油工程', '3班', '123', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `user` VALUES (5, 'javaniu', '女', '18090093154', '能源学院', '石油工程', '3班', 'javaniu', '96e79218965eb72c92a549dd5a330112');

SET FOREIGN_KEY_CHECKS = 1;
