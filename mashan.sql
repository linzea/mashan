/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : mashan

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-01-28 19:39:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for c_category
-- ----------------------------
DROP TABLE IF EXISTS `c_category`;
CREATE TABLE `c_category` (
  `id` varchar(36) NOT NULL,
  `sort_id` int(11) NOT NULL DEFAULT '0' COMMENT '排序ID',
  `parent_id` varchar(36) NOT NULL COMMENT '父级ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `status` int(11) NOT NULL DEFAULT '0',
  `icon_url` varchar(200) DEFAULT NULL COMMENT 'url',
  `descriotion` varchar(200) DEFAULT NULL COMMENT '描述',
  `create_id` varchar(36) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_category
-- ----------------------------

-- ----------------------------
-- Table structure for c_comment
-- ----------------------------
DROP TABLE IF EXISTS `c_comment`;
CREATE TABLE `c_comment` (
  `id` varchar(36) NOT NULL,
  `commodity_id` varchar(36) NOT NULL,
  `ooid` varchar(36) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `user_content` varchar(500) DEFAULT NULL,
  `user_id` varchar(36) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `source` int(11) DEFAULT '0',
  `com_status` int(11) NOT NULL DEFAULT '0',
  `com_star` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_comment
-- ----------------------------

-- ----------------------------
-- Table structure for c_finished
-- ----------------------------
DROP TABLE IF EXISTS `c_finished`;
CREATE TABLE `c_finished` (
  `id` varchar(36) NOT NULL,
  `harvest_batch_id` varchar(36) NOT NULL COMMENT '鲜叶批次',
  `priduct_id` varchar(36) NOT NULL COMMENT '产品编号',
  `packaing_id` varchar(36) NOT NULL COMMENT '包材ID',
  `tag_id` varchar(300) NOT NULL COMMENT '质检人',
  `finished_type` varchar(36) NOT NULL COMMENT '成茶，副茶类型',
  `last_quantity` double(7,2) NOT NULL DEFAULT '0.00' COMMENT '剩余茶叶，未包装完的',
  `finished_name` varchar(30) NOT NULL COMMENT '名称',
  `finished_quantity` int(1) NOT NULL DEFAULT '0' COMMENT '库存数量',
  `finished_low` int(1) NOT NULL DEFAULT '0' COMMENT '预警数量',
  `finished_out` int(1) NOT NULL DEFAULT '0' COMMENT '出库数量',
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种',
  `principal` varchar(36) NOT NULL COMMENT '负责人',
  `status` int(1) NOT NULL DEFAULT '0',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_finished
-- ----------------------------
INSERT INTO `c_finished` VALUES ('2ed45948-b24d-42e9-b0ec-9fbdd00dbc58', 'c344edaa-68c1-4c29-a777-f16a023da768', '713f0bf7-bebd-4b49-9281-4ed3ae67f169', '082b4c45-4c38-44a5-8920-bc0e6e566aab', 'a7423d6a-c29b-4429-8e86-039709264dc9', '80aa9101-7258-4608-9ed6-ad66a28438ea', '280.00', '马山经典乌龙茶', '120', '0', '0', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '波波', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:21:06');
INSERT INTO `c_finished` VALUES ('b8b62f30-5f25-4e7e-b5d6-222cda4d2a3a', 'c344edaa-68c1-4c29-a777-f16a023da768', '6de774d9-279b-47e0-8fb0-5cf2a094603b', '55acffdf-da7c-45a3-b88d-a32c8336931b', 'a7423d6a-c29b-4429-8e86-039709264dc9', '140da388-96d7-4a66-82e0-59e061f5d3d8', '20.00', '细叶乌龙副茶', '113', '0', '0', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '波波', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:21:06');
INSERT INTO `c_finished` VALUES ('d81cfc02-cb4f-418f-818f-62f0c42d4543', 'c344edaa-68c1-4c29-a777-f16a023da768', '55f3fb20-407a-447f-9aef-10f30b788d7f', '55acffdf-da7c-45a3-b88d-a32c8336931b', 'a7423d6a-c29b-4429-8e86-039709264dc9', '07aaa0e1-4704-4ba5-9816-cda4cf965f0d', '75.00', 'df', '18', '0', '0', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '波波', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:21:06');

-- ----------------------------
-- Table structure for c_finished_out
-- ----------------------------
DROP TABLE IF EXISTS `c_finished_out`;
CREATE TABLE `c_finished_out` (
  `id` varchar(36) NOT NULL,
  `harvest_batch_id` varchar(36) NOT NULL COMMENT '鲜叶批次',
  `finished_id` varchar(36) NOT NULL COMMENT '成品ID',
  `out_quantity` int(1) NOT NULL DEFAULT '0' COMMENT '出库数量',
  `out_user` varchar(36) NOT NULL DEFAULT '0' COMMENT '出库去向-门店',
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种',
  `principal` varchar(36) NOT NULL COMMENT '负责人',
  `quality_report` int(1) NOT NULL COMMENT '质检报告',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL COMMENT '审批人',
  `modify_time` datetime DEFAULT NULL COMMENT '审批时间',
  PRIMARY KEY (`id`),
  KEY `out_user` (`out_user`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_finished_out
-- ----------------------------

-- ----------------------------
-- Table structure for c_information
-- ----------------------------
DROP TABLE IF EXISTS `c_information`;
CREATE TABLE `c_information` (
  `id` varchar(36) NOT NULL,
  `sort_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(200) NOT NULL,
  `type_id` varchar(36) DEFAULT NULL,
  `editer_id` varchar(36) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `content` varchar(20000) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_id` varchar(36) NOT NULL,
  `modify_time` datetime DEFAULT NULL,
  `modify_id` varchar(36) NOT NULL,
  `thumbnail` varchar(200) DEFAULT NULL,
  `commodity_id` varchar(36) DEFAULT NULL,
  `source` int(11) DEFAULT '0',
  `info_mode` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `i18n` int(11) DEFAULT '1',
  `click_count` int(11) DEFAULT NULL,
  `lable_item` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_information
-- ----------------------------

-- ----------------------------
-- Table structure for c_package
-- ----------------------------
DROP TABLE IF EXISTS `c_package`;
CREATE TABLE `c_package` (
  `id` varchar(36) NOT NULL,
  `package_name` varchar(30) NOT NULL COMMENT '包装名称',
  `package_quantity` int(1) NOT NULL DEFAULT '0' COMMENT '包装数量',
  `package_low` int(1) NOT NULL DEFAULT '0' COMMENT '预警数量',
  `package_use` int(1) NOT NULL DEFAULT '0' COMMENT '包装使用数量',
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种',
  `img_url` varchar(200) NOT NULL COMMENT '图片',
  `spe_one` int(1) NOT NULL DEFAULT '1' COMMENT '规格1',
  `spe_two` int(1) NOT NULL DEFAULT '1' COMMENT '规格2',
  `spe_there` int(1) NOT NULL DEFAULT '1' COMMENT '规格3',
  `spe_four` int(1) NOT NULL DEFAULT '1' COMMENT '规格4',
  `status` int(1) NOT NULL DEFAULT '0',
  `principal` varchar(36) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_package
-- ----------------------------
INSERT INTO `c_package` VALUES ('082b4c45-4c38-44a5-8920-bc0e6e566aab', '细叶乌龙包材', '6000', '200', '482', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/7/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', '200', '1', '3', '6', '1', '凯德拉', '凯德拉', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:41:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:41:02');
INSERT INTO `c_package` VALUES ('306aa8df-29c1-43df-be86-f7117b6dc914', '红茶抹茶', '6000', '300', '6', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'cc32f7fc-24d6-471a-a5d5-05962737468a', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/6/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', '30', '1', '30', '1', '1', '我', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:24:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:24:04');
INSERT INTO `c_package` VALUES ('35b94857-353d-414d-99be-00d63b6ddc3b', '红茶副茶', '6000', '100', '92', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'cc32f7fc-24d6-471a-a5d5-05962737468a', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/6/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', '200', '1', '3', '1', '1', '厂长', '红茶副茶', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:22:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:22:45');
INSERT INTO `c_package` VALUES ('55acffdf-da7c-45a3-b88d-a32c8336931b', '细叶乌龙包材2', '6000', '300', '362', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/7/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', '320', '1', '1', '1', '1', '德克萨斯', '德克萨斯', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:42:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:42:32');
INSERT INTO `c_package` VALUES ('764a2451-d32e-46fe-955b-523b000376dd', '红茶包材', '6000', '200', '1137', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/19/haderImg.png', '300', '1', '1', '1', '1', '我', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:26:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:26:39');
INSERT INTO `c_package` VALUES ('f8ec8972-3674-4c28-841b-6cb25c747268', '马山红', '6000', '100', '5555', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'cc32f7fc-24d6-471a-a5d5-05962737468a', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/1/product11.jpg', '300', '1', '2', '1', '1', '我', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 18:16:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 18:16:16');

-- ----------------------------
-- Table structure for c_products
-- ----------------------------
DROP TABLE IF EXISTS `c_products`;
CREATE TABLE `c_products` (
  `id` varchar(36) NOT NULL,
  `product_name` varchar(50) NOT NULL COMMENT '商品名称',
  `product_type` varchar(36) NOT NULL COMMENT '产品类型',
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '字典，茶系ID',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种',
  `img_url` varchar(200) NOT NULL COMMENT '产品图片',
  `tea_grade` varchar(36) NOT NULL COMMENT '等级',
  `package_id` varchar(36) NOT NULL COMMENT '包材ID',
  `tags_id` varchar(36) DEFAULT NULL COMMENT '产品标签',
  `licence_id` varchar(36) NOT NULL COMMENT '许可证编号',
  `standard_id` varchar(36) NOT NULL COMMENT '产品生产标准',
  `status` int(1) NOT NULL DEFAULT '0',
  `spe_one` int(1) NOT NULL DEFAULT '1' COMMENT '规格1',
  `spe_two` int(1) NOT NULL DEFAULT '1',
  `spe_there` int(1) NOT NULL DEFAULT '1',
  `descriptin` varchar(200) DEFAULT NULL,
  `principal` varchar(36) NOT NULL COMMENT '负责人',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_products
-- ----------------------------
INSERT INTO `c_products` VALUES ('19e9a6f8-06f2-4027-a058-2fa3ba9d73ae', '客家经典红茶，马山红', '80aa9101-7258-4608-9ed6-ad66a28438ea', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'de639eec-dd97-497a-953d-7246247aec95', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/6/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', 'b1c94b1c-67e4-4e45-a516-0976fb142a81', 'f8ec8972-3674-4c28-841b-6cb25c747268', 'cc32f7fc-24d6-471a-a5d5-05962737468a', 'SC11444142300266', 'GB/T13738.2-2008', '1', '1', '1', '1', '销售总监', '销售总监', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:11:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:11:17');
INSERT INTO `c_products` VALUES ('55f3fb20-407a-447f-9aef-10f30b788d7f', 'df', '07aaa0e1-4704-4ba5-9816-cda4cf965f0d', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/15/微信截图_20180114181212.png', 'b1c94b1c-67e4-4e45-a516-0976fb142a81', '55acffdf-da7c-45a3-b88d-a32c8336931b', null, 'df', 'df', '1', '1', '1', '1', 'df', 'df', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 18:58:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 18:58:00');
INSERT INTO `c_products` VALUES ('6de774d9-279b-47e0-8fb0-5cf2a094603b', '细叶乌龙副茶', '140da388-96d7-4a66-82e0-59e061f5d3d8', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/7/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', 'b1c94b1c-67e4-4e45-a516-0976fb142a81', '55acffdf-da7c-45a3-b88d-a32c8336931b', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'MS-true-6543154', 'MS-true-6543154', '1', '1', '1', '1', 'MS-true-6543154', '德斯莱特', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:48:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:48:18');
INSERT INTO `c_products` VALUES ('6f553904-cf72-4fbd-b8f7-c4d574486345', '红茶细叶乌龙', '80aa9101-7258-4608-9ed6-ad66a28438ea', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/19/haderImg.png', 'b1c94b1c-67e4-4e45-a516-0976fb142a81', '764a2451-d32e-46fe-955b-523b000376dd', null, 'SGY43234234', 'SGY43234234', '1', '1', '1', '1', 'SGY43234234', 'SGY43234234', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:28:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:28:23');
INSERT INTO `c_products` VALUES ('713f0bf7-bebd-4b49-9281-4ed3ae67f169', '马山经典乌龙茶', '80aa9101-7258-4608-9ed6-ad66a28438ea', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/7/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', 'b1c94b1c-67e4-4e45-a516-0976fb142a81', '082b4c45-4c38-44a5-8920-bc0e6e566aab', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'MSQS-2010.3658', 'MSQS-2010.3658', '1', '1', '1', '1', '魏成东', '魏成东', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:45:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:45:30');
INSERT INTO `c_products` VALUES ('9fa10198-2953-4d6f-a80f-24a1fa102355', '红茶-抹茶', '07aaa0e1-4704-4ba5-9816-cda4cf965f0d', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'de639eec-dd97-497a-953d-7246247aec95', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/6/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', 'b1c94b1c-67e4-4e45-a516-0976fb142a81', '306aa8df-29c1-43df-be86-f7117b6dc914', 'cc32f7fc-24d6-471a-a5d5-05962737468a', 'SC11444142300266', 'GB/T13738.2-2008', '1', '1', '1', '1', 'SC11444142300266', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:20:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:20:24');
INSERT INTO `c_products` VALUES ('cf5653bf-0945-405e-b77e-757b067a8444', '红茶-副茶-马山茶', '140da388-96d7-4a66-82e0-59e061f5d3d8', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'de639eec-dd97-497a-953d-7246247aec95', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/6/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', 'b1c94b1c-67e4-4e45-a516-0976fb142a81', '35b94857-353d-414d-99be-00d63b6ddc3b', 'cc32f7fc-24d6-471a-a5d5-05962737468a', 'SC11444142300266', 'GB/T13738.2-2008', '1', '1', '1', '1', 'GB/T13738.2-2008', '销售', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:19:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:19:37');
INSERT INTO `c_products` VALUES ('d116cdba-6893-45ca-af3a-6f39ab4c83be', '细叶乌龙红茶副茶', '140da388-96d7-4a66-82e0-59e061f5d3d8', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/19/haderImg.png', '74125ba6-0ec1-4286-b9c2-f56d95fe4ac4', '764a2451-d32e-46fe-955b-523b000376dd', null, 'SGY43234234', 'SGY43234234', '1', '1', '1', '1', '的', 'SGY43234234', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:29:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:29:01');

-- ----------------------------
-- Table structure for c_property
-- ----------------------------
DROP TABLE IF EXISTS `c_property`;
CREATE TABLE `c_property` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `property_type` int(11) DEFAULT NULL,
  `sort_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_id` varchar(36) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of c_property
-- ----------------------------

-- ----------------------------
-- Table structure for c_provalue
-- ----------------------------
DROP TABLE IF EXISTS `c_provalue`;
CREATE TABLE `c_provalue` (
  `id` varchar(36) NOT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `property_id` varchar(36) DEFAULT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `sort_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_id` varchar(36) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `icon_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of c_provalue
-- ----------------------------

-- ----------------------------
-- Table structure for c_semi_finished
-- ----------------------------
DROP TABLE IF EXISTS `c_semi_finished`;
CREATE TABLE `c_semi_finished` (
  `id` varchar(36) NOT NULL,
  `harvest_batch_id` varchar(36) NOT NULL COMMENT '鲜叶批次号',
  `machin_tea_id` varchar(36) NOT NULL,
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种',
  `rec_quantity` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '鲜叶重量',
  `tea_grade_one` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '筛选工序后，一级茶叶数量(成茶)',
  `tea_grade_two` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '筛选工序后，二级茶叶数量(副茶)',
  `tea_grade_three` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '茶末数量',
  `semi_one_out` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '半成品一级茶出库数量',
  `semi_two_out` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '半成品二级茶出库数量',
  `semi_three_out` double(9,2) NOT NULL DEFAULT '0.00' COMMENT '茶末出库',
  `principal` varchar(36) NOT NULL COMMENT '负责人',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '默认为1 ，生存复炒后为2',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_semi_finished
-- ----------------------------
INSERT INTO `c_semi_finished` VALUES ('9db875e7-4faa-410b-9f9e-0c6b7e5d0f4b', 'c344edaa-68c1-4c29-a777-f16a023da768', 'bb9e33ea-b1fd-4b2a-aeaa-e9f31e98f050', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '0.00', '866.00', '72.33', '12.00', '866.00', '72.33', '12.00', '波波', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:19:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:19:23');

-- ----------------------------
-- Table structure for c_sku
-- ----------------------------
DROP TABLE IF EXISTS `c_sku`;
CREATE TABLE `c_sku` (
  `id` varchar(36) NOT NULL,
  `commodity_id` varchar(36) DEFAULT NULL,
  `counts` int(11) DEFAULT NULL,
  `price` double(15,2) DEFAULT NULL,
  `original_price` double(15,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `provalue_str` varchar(500) DEFAULT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_price` (`price`),
  KEY `index_modify_time` (`modify_time`),
  KEY `index_sku_category_status` (`status`,`category_id`,`id`),
  KEY `index_provalue_str` (`provalue_str`(255)),
  KEY `index_customerId_categoryId` (`category_id`) USING BTREE,
  KEY `Index_category_id` (`category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of c_sku
-- ----------------------------

-- ----------------------------
-- Table structure for c_skuvalue
-- ----------------------------
DROP TABLE IF EXISTS `c_skuvalue`;
CREATE TABLE `c_skuvalue` (
  `id` varchar(36) NOT NULL,
  `skuid` varchar(36) DEFAULT NULL,
  `property_id` varchar(36) DEFAULT NULL,
  `provalue_id` varchar(36) DEFAULT NULL,
  `provalue_name` varchar(36) DEFAULT NULL,
  `property_type` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_skuId` (`skuid`),
  KEY `index_propertyId` (`property_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_skuvalue
-- ----------------------------

-- ----------------------------
-- Table structure for c_tags
-- ----------------------------
DROP TABLE IF EXISTS `c_tags`;
CREATE TABLE `c_tags` (
  `id` varchar(36) NOT NULL,
  `tag_name` varchar(30) NOT NULL COMMENT '标签名称',
  `tag_number` varchar(30) NOT NULL COMMENT '标签编号',
  `tag_quantity` int(1) NOT NULL DEFAULT '0' COMMENT '标签数量',
  `tag_low` int(1) NOT NULL DEFAULT '0' COMMENT '预警数量',
  `tag_use` int(1) NOT NULL DEFAULT '0' COMMENT '标签使用数量',
  `img_url` varchar(200) DEFAULT NULL,
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种',
  `description` varchar(300) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `principal` varchar(30) NOT NULL COMMENT '负责人',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_tags
-- ----------------------------
INSERT INTO `c_tags` VALUES ('30571164-f3fb-431a-a7b3-49467b835001', '红茶标签B', 'MS-R-1973', '3000', '200', '2826', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/8/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'de639eec-dd97-497a-953d-7246247aec95', '德玛西亚', '1', '加西亚', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-08 00:55:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-08 00:55:51');
INSERT INTO `c_tags` VALUES ('37e77ddb-4a59-4a71-91b5-59d3f55afbc5', '标签A', '10000', '5001', '200', '2827', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/6/product4.jpg', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'de639eec-dd97-497a-953d-7246247aec95', '大多数', '1', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:07:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 21:07:06');
INSERT INTO `c_tags` VALUES ('a7423d6a-c29b-4429-8e86-039709264dc9', '细叶乌龙质检标签', 'MS-dkss-101', '5000', '200', '844', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/7/TB2RX9.Xv_HK1JjSsziXXagrVXa_!!2102234370.jpg_430x430q90.jpg', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '德克萨斯', '1', '德克萨斯', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:43:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 20:43:29');
INSERT INTO `c_tags` VALUES ('d9103e5d-458f-43ea-b55c-24f20dee6fff', '红茶细叶乌龙', 'SGY43234234', '5000', '200', '1137', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/19/haderImg.png', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', 'd', '1', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:29:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 23:29:59');

-- ----------------------------
-- Table structure for e_assembly_set
-- ----------------------------
DROP TABLE IF EXISTS `e_assembly_set`;
CREATE TABLE `e_assembly_set` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `name` varchar(36) DEFAULT NULL COMMENT '生产线名称',
  `parent_id` varchar(36) NOT NULL COMMENT '父级ID',
  `machine_id` varchar(36) DEFAULT NULL COMMENT '设备id',
  `maintain_cycle` int(1) DEFAULT NULL COMMENT '保养周期',
  `maintain_clear` int(1) DEFAULT NULL COMMENT '清洁周期',
  `run_num` int(1) DEFAULT '0' COMMENT '运行周期，满运行周期清0',
  `all_run_num` int(1) DEFAULT '0' COMMENT '总运行次数',
  `sort_id` int(1) NOT NULL,
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态 1，启用，2禁用',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_assembly_set
-- ----------------------------
INSERT INTO `e_assembly_set` VALUES ('1571ddff-e88c-11e7-a642-6045cb7f62f1', '绿茶生产线A', '10000000-0000-0000-0000-000000000000', '', '1', '1', '3', '2', '1', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '1', '法国风格bb', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-24 17:24:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-24 17:24:29');
INSERT INTO `e_assembly_set` VALUES ('178c3648-a4d2-4606-924e-beb5531bd778', null, 'a59a9b95-280c-4ee0-bd8d-77d0573d9dfc', '8aa2bacc-813f-4e90-a54c-203afb11bdaa', null, null, '0', '0', '4', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '1', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 11:33:41', null, null);
INSERT INTO `e_assembly_set` VALUES ('1cfb8c16-5134-4c90-894f-834895c846b3', null, 'a59a9b95-280c-4ee0-bd8d-77d0573d9dfc', '42fb5eb8-a802-4688-8d8b-161df9d7a17b', null, null, '0', '0', '1', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '1', '萎调设备', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-14 19:12:24', null, null);
INSERT INTO `e_assembly_set` VALUES ('23f867b8-e93d-11e7-8c32-38d547b81379', null, 'a59a9b95-280c-4ee0-bd8d-77d0573d9dfc', '0ff0d8b3-a30b-4838-8ae4-645d62066d4e', null, null, '0', '0', '1', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '1', '红茶生产线A，发酵设备', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 10:18:02', null, null);
INSERT INTO `e_assembly_set` VALUES ('a59a9b95-280c-4ee0-bd8d-77d0573d9dfc', '红茶生产线A', '10000000-0000-0000-0000-000000000000', null, '2', '2', '2', '1', '2', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '1', '短短的', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-24 23:12:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-24 23:12:55');
INSERT INTO `e_assembly_set` VALUES ('b5e06ba8-4b84-497e-ba23-5896bf7fd082', null, 'a59a9b95-280c-4ee0-bd8d-77d0573d9dfc', '395a1c75-e7ee-11e7-8011-6045cb7f62f1', null, null, '0', '0', '3', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '1', '炒茶设备', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-14 19:12:41', null, null);

-- ----------------------------
-- Table structure for e_equipment
-- ----------------------------
DROP TABLE IF EXISTS `e_equipment`;
CREATE TABLE `e_equipment` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `unit_name` varchar(36) NOT NULL COMMENT '设备名称',
  `unit_no` varchar(36) NOT NULL COMMENT '资产编号',
  `unit_usage` varchar(36) NOT NULL COMMENT '设备用途',
  `unit_type` varchar(36) NOT NULL COMMENT '设备型号',
  `unit_cycle` int(1) NOT NULL COMMENT '保养周期',
  `unit_status` int(1) NOT NULL DEFAULT '0' COMMENT '是否绑定生产线,1绑定，2未绑定',
  `unit_clear` int(1) NOT NULL DEFAULT '0' COMMENT '清洁周期',
  `img_url` varchar(200) DEFAULT NULL COMMENT '设备图片',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `dic_tea_attr` varchar(36) NOT NULL,
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_equipment
-- ----------------------------
INSERT INTO `e_equipment` VALUES ('0ff0d8b3-a30b-4838-8ae4-645d62066d4e', '发酵设备', 'unit-2', 'c307d686-7dce-4b2f-9efb-16fbeb348de6', '这70-1', '12', '1', '1', 'http://of8rkrh1w.bkt.clouddn.com/2017/12/24/blog4.jpg', '1', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-24 11:10:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-24 11:10:38');
INSERT INTO `e_equipment` VALUES ('395a1c75-e7ee-11e7-8011-6045cb7f62f1', '炒茶设备', 'unt-123', '9fd1943d-b955-4921-a1cd-76d60126e114', 'Z270-AR', '50', '1', '1', 'http://of8rkrh1w.bkt.clouddn.com/2017/12/24/blog5.jpg', '1', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '炒茶设备Z270-AR', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 22:35:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 22:35:26');
INSERT INTO `e_equipment` VALUES ('42fb5eb8-a802-4688-8d8b-161df9d7a17b', '设备S', 'MS-1000', '16595d6b-b5f0-4b49-970d-2c26c691e66a', 'MS-UITL-1000', '10', '1', '1', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/14/微信截图_20180114181212.png', '1', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '-UITL', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-14 18:12:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-14 18:12:23');
INSERT INTO `e_equipment` VALUES ('8aa2bacc-813f-4e90-a54c-203afb11bdaa', '揉捻设备', 'MS-10002', '8aa97837-a152-49be-98b8-47a11c3b1de4', 'SN-2356', '10', '1', '1', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/15/微信截图_20180114181212.png', '1', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 11:28:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 11:28:56');

-- ----------------------------
-- Table structure for e_equipment_maintain
-- ----------------------------
DROP TABLE IF EXISTS `e_equipment_maintain`;
CREATE TABLE `e_equipment_maintain` (
  `id` varchar(36) NOT NULL,
  `assembly_id` varchar(36) NOT NULL COMMENT '生产线ID',
  `equipment_id` varchar(36) NOT NULL COMMENT '设备ID',
  `maintain_type` varchar(36) NOT NULL COMMENT '保养/维修/清洁/类型',
  `maintain_time` datetime DEFAULT NULL COMMENT '保养/维修/清洁时间',
  `maintain_status` int(1) NOT NULL COMMENT '1,待检修。2.完成检修',
  `repair_content` varchar(200) DEFAULT NULL COMMENT '维修内容',
  `replace_parts` varchar(200) DEFAULT NULL COMMENT '更换零件',
  `operator` varchar(36) DEFAULT NULL,
  `img_url` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_id` varchar(36) NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_equipment_maintain
-- ----------------------------
INSERT INTO `e_equipment_maintain` VALUES ('001143b5-0ffb-4b59-8163-9a748af578b8', '', '0ff0d8b3-a30b-4838-8ae4-645d62066d4e', '2d655158-9d5b-4cba-a9b7-39a6d814903c', null, '2', '清洁设备', '无', '阿利拉德', 'http://of8rkrh1w.bkt.clouddn.com/2017/12/28/blog1.jpg', '阿利拉德,清洁发酵池', '2017-12-28 23:08:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-28 23:08:37');
INSERT INTO `e_equipment_maintain` VALUES ('0633e46b-0b31-4ad3-867c-039df4d6528f', '', '42fb5eb8-a802-4688-8d8b-161df9d7a17b', '8d25bae7-44c6-4813-a227-8e735df61047', null, '2', '无', '无', 'ds', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/15/微信截图_20180114181212.png', 'sd', '2018-01-15 00:26:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 00:26:14');
INSERT INTO `e_equipment_maintain` VALUES ('288e30c9-8262-4136-919e-0c2f8cc39ed9', '', '42fb5eb8-a802-4688-8d8b-161df9d7a17b', '92096f29-97c8-4491-b10e-99daaba76cf4', null, '2', '无', '无', '无我', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/15/微信截图_20180114181212.png', 'zxcv', '2018-01-15 00:25:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 00:25:27');
INSERT INTO `e_equipment_maintain` VALUES ('4a42a54c-e934-11e7-8c32-38d547b81379', '', '0ff0d8b3-a30b-4838-8ae4-645d62066d4e', '92096f29-97c8-4491-b10e-99daaba76cf4', '2017-12-25 13:27:35', '1', '机油较少', '换机油', '我', 'http://of8rkrh1w.bkt.clouddn.com/2017/12/25/12.jpg', '手动', '2017-12-25 13:27:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:27:56');
INSERT INTO `e_equipment_maintain` VALUES ('5c709e70-ca54-42b4-a04e-0cc01a11a538', '', '42fb5eb8-a802-4688-8d8b-161df9d7a17b', '2d655158-9d5b-4cba-a9b7-39a6d814903c', null, '2', '无', '无', '无我去', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/15/微信截图_20180114181212.png', '无', '2018-01-15 00:25:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-15 00:25:49');
INSERT INTO `e_equipment_maintain` VALUES ('a5f0f38d-2411-4196-85e7-86650bd3a021', '', '0ff0d8b3-a30b-4838-8ae4-645d62066d4e', '8d25bae7-44c6-4813-a227-8e735df61047', null, '1', '机油较少', '换齿轮', '莎拉', 'http://of8rkrh1w.bkt.clouddn.com/2017/12/25/12.jpg', '撒大声地', '2017-12-25 16:08:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 16:08:53');

-- ----------------------------
-- Table structure for e_finished
-- ----------------------------
DROP TABLE IF EXISTS `e_finished`;
CREATE TABLE `e_finished` (
  `id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_finished
-- ----------------------------

-- ----------------------------
-- Table structure for e_harvest_records
-- ----------------------------
DROP TABLE IF EXISTS `e_harvest_records`;
CREATE TABLE `e_harvest_records` (
  `id` varchar(36) NOT NULL,
  `tea_garden_id` varchar(36) NOT NULL COMMENT '茶园ID',
  `dic_standard` varchar(36) NOT NULL COMMENT '字典采摘标准',
  `rec_quantity` double(9,2) NOT NULL COMMENT '采摘数量',
  `pick_number` varchar(36) NOT NULL COMMENT '(管理批次)',
  `pick_batch_no` varchar(36) NOT NULL COMMENT '采摘批次',
  `pick_area` varchar(200) NOT NULL COMMENT '采摘区域',
  `pick_time` int(1) DEFAULT '0' COMMENT '采摘时间,1上午,2下午',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '操作人',
  `description` varchar(200) DEFAULT NULL COMMENT '备注',
  `principal` varchar(36) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '是否已经加工(生成加工批次号后为1默认为2，加工完成为3)',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_harvest_records
-- ----------------------------
INSERT INTO `e_harvest_records` VALUES ('c344edaa-68c1-4c29-a777-f16a023da768', '8893e29b-d37b-11e7-b5d6-24fd52935962', '445159a9-665f-49fb-9505-d68f7a02685e', '1299.00', '6c2b6c8e-7d40-406e-a1ec-632da9548d48', ' B4SOG-8198708', 'eastward,southward,westward', '2', '司马', '司马', '司马', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:13:45');

-- ----------------------------
-- Table structure for e_machin_set
-- ----------------------------
DROP TABLE IF EXISTS `e_machin_set`;
CREATE TABLE `e_machin_set` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `dic_mac_type` varchar(36) NOT NULL COMMENT '加工类型',
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系ID',
  `dic_mac_pro` varchar(36) NOT NULL COMMENT '工序ID',
  `dic_roll_type` varchar(36) DEFAULT NULL COMMENT '揉捻工序类型',
  `temperature` int(3) DEFAULT '0' COMMENT '温度',
  `humidity` int(2) DEFAULT '0' COMMENT '湿度',
  `mac_loss` int(2) DEFAULT '0' COMMENT '损耗',
  `begin_duration` int(2) DEFAULT '0' COMMENT '所需时长开始',
  `end_duration` int(2) DEFAULT '0' COMMENT '所需时长结束',
  `duration_type` int(1) DEFAULT '0' COMMENT '1m分,2h时,3d天',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态 1，启用，2禁用',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  `roll_status` int(1) NOT NULL DEFAULT '0' COMMENT '加工工序排期',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_machin_set
-- ----------------------------
INSERT INTO `e_machin_set` VALUES ('0c8ef491-3ee0-421b-84aa-746cd401663d', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'c307d686-7dce-4b2f-9efb-16fbeb348de6', '', '90', '0', null, '0', '90', '1', '1', '红茶半成品加工第七道工序', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:39:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:39:06');
INSERT INTO `e_machin_set` VALUES ('186f2227-fb01-4cfc-aefc-0ad9e16f902b', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '8aa97837-a152-49be-98b8-47a11c3b1de4', 'f0b5d672-b743-44ce-954d-2eefaf95b11a', '0', '0', null, '0', '35', '1', '1', '红茶半成品加工第三道工序', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:22:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:22:05');
INSERT INTO `e_machin_set` VALUES ('1b0e362b-4006-4d7a-8a53-3055a8f4d322', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'c307d686-7dce-4b2f-9efb-16fbeb348de6', '', '150', '0', null, '0', '90', '1', '1', '绿茶加工第八道工序，二次炒干', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:36:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:36:26');
INSERT INTO `e_machin_set` VALUES ('21abfad1-734c-4a41-8b40-78e1cf696c7c', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '01b33909-73b8-45d9-af2e-5f57a22895c1', '', '100', '1', null, '0', '0', '1', '1', '第八道工序，一次质检', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:03:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:03:14');
INSERT INTO `e_machin_set` VALUES ('312f3670-b5a6-4370-9c73-b058d8f49512', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'c307d686-7dce-4b2f-9efb-16fbeb348de6', '', '180', '0', null, '0', '8', '1', '1', '绿茶加工第七道工序，一次炒干', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:33:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:33:29');
INSERT INTO `e_machin_set` VALUES ('35ed4386-98da-49f1-b15f-60e1b6b3ecbb', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '590b26ce-356c-4a4f-82f3-b02aca313238', '', '0', '0', null, '0', '0', '1', '1', '绿茶加工第九道工序，筛选确定茶叶等级', '11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:41:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:41:32');
INSERT INTO `e_machin_set` VALUES ('37202115-6e12-48a7-8e8e-aff3827a2719', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '8aa97837-a152-49be-98b8-47a11c3b1de4', 'da517c36-6812-4a9d-a4d4-38f633254656', '0', '0', null, '0', '35', '1', '1', '红茶半成品加工第四道工序', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:22:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:22:36');
INSERT INTO `e_machin_set` VALUES ('55601ed9-d4c4-11e7-89ed-38d547b81379', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '16595d6b-b5f0-4b49-970d-2c26c691e66a', '', '0', '0', '8', '9', '10', '2', '1', '绿茶第一道工序萎凋', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 13:15:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 13:15:37');
INSERT INTO `e_machin_set` VALUES ('5a6a2b09-4f7a-42a1-b58a-dce787ac1928', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'f9e96bed-6103-4a14-9135-e69b7392dc78', '', '85', '0', null, '0', '1', '2', '1', '红茶复炒第十道工序', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:41:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:41:25');
INSERT INTO `e_machin_set` VALUES ('62c7e137-c9ee-4ad4-86db-6f685527164b', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', 'aaf83ae9-8e7e-4b55-be3d-d36f822d0b6a', '', '0', '0', '0', '0', '0', '1', '1', '产品包装阶段', '13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:38:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:38:27');
INSERT INTO `e_machin_set` VALUES ('68b1f56c-82df-4afe-bc06-d26017c891a1', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '9ea19fba-8765-48f7-8a8a-b5ea412bda2e', '', '300', '0', null, '0', '3', '1', '1', '绿茶第二道工序', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:18:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:18:35');
INSERT INTO `e_machin_set` VALUES ('7fdcf6f1-61eb-4fc1-ae40-e1cafb0b7196', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '8aa97837-a152-49be-98b8-47a11c3b1de4', 'f0b5d672-b743-44ce-954d-2eefaf95b11a', '0', '0', null, '0', '5', '1', '1', '绿茶加工第四道工序，二次揉捻', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:23:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:23:25');
INSERT INTO `e_machin_set` VALUES ('81259a38-f688-4267-bc46-9aea08c7d1bb', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '9d9438d9-7746-4b14-adb7-d29136b1778a', '', '0', '0', null, '0', '0', '1', '1', '绿茶成品加工第十三道工序，提香', '13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:06:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:06:44');
INSERT INTO `e_machin_set` VALUES ('81849634-bf60-46d0-9c7e-d6760126d263', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '01b33909-73b8-45d9-af2e-5f57a22895c1', '', '200', '1', null, '0', '0', '1', '1', '红茶成品第九道抽检工序', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:39:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:39:59');
INSERT INTO `e_machin_set` VALUES ('8281c645-17fb-41f7-97b4-17f60385b874', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '8aa97837-a152-49be-98b8-47a11c3b1de4', 'da517c36-6812-4a9d-a4d4-38f633254656', '0', '0', null, '0', '5', '1', '1', '绿茶加工第5道工序，3次揉捻', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:23:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:23:51');
INSERT INTO `e_machin_set` VALUES ('9be20092-4ad1-4fdd-b2ae-c57a3ad48af3', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '8aa97837-a152-49be-98b8-47a11c3b1de4', '28dd1122-1981-4035-a57a-47edc20884b8', '0', '0', null, '0', '20', '1', '1', '红茶半成品加工第二道工序', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:20:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:20:59');
INSERT INTO `e_machin_set` VALUES ('a284f3b7-9045-42a1-997a-45ec1ea57b44', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '01b33909-73b8-45d9-af2e-5f57a22895c1', '', '200', '1', null, '0', '0', '1', '1', '红茶成品十一次抽检', '11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:42:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:42:07');
INSERT INTO `e_machin_set` VALUES ('a5e00610-11dc-44a7-b9dd-53429949531e', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '16595d6b-b5f0-4b49-970d-2c26c691e66a', '', '30', '0', null, '0', '12', '2', '1', '红茶半成品加工第一道工序', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:19:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:19:49');
INSERT INTO `e_machin_set` VALUES ('a92ee26d-02e7-4566-ba06-579eba874e0f', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '01b33909-73b8-45d9-af2e-5f57a22895c1', '', '100', '1', null, '0', '0', '1', '1', '绿茶加工第十道工序，质检', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:45:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:45:14');
INSERT INTO `e_machin_set` VALUES ('ba401d63-2994-45cc-bbf1-9b979cb02236', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '9d9438d9-7746-4b14-adb7-d29136b1778a', '', '0', '0', null, '0', '0', '1', '1', '红茶第十二道工序，提香', '12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:42:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:42:39');
INSERT INTO `e_machin_set` VALUES ('c84620d6-6b17-40a6-8cc1-36db852b5228', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '8aa97837-a152-49be-98b8-47a11c3b1de4', '28dd1122-1981-4035-a57a-47edc20884b8', '0', '0', null, '0', '25', '1', '1', '红茶半成品加工第五道工序', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:23:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:23:22');
INSERT INTO `e_machin_set` VALUES ('d671f6cc-8b0b-4349-884a-8f525c0b90fc', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '8aa97837-a152-49be-98b8-47a11c3b1de4', '28dd1122-1981-4035-a57a-47edc20884b8', '0', '0', null, '0', '8', '1', '1', '绿茶第三道工序一次揉捻', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:22:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:22:36');
INSERT INTO `e_machin_set` VALUES ('e6349ed8-5ca8-4814-a975-e33919038278', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '8aa97837-a152-49be-98b8-47a11c3b1de4', '28dd1122-1981-4035-a57a-47edc20884b8', '0', '0', null, '0', '5', '1', '1', '绿茶加工第6道工序，4次揉捻', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:24:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:24:22');
INSERT INTO `e_machin_set` VALUES ('e9482682-3d79-4a0b-9cba-9aa3e1acf124', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '9fd1943d-b955-4921-a1cd-76d60126e114', '', '40', '90', null, '8', '10', '2', '1', '红茶半成品加工，第六道工序。发酵', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:37:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:37:43');
INSERT INTO `e_machin_set` VALUES ('efadcfc9-59da-4057-b28d-fc8e51fc85b3', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'f9e96bed-6103-4a14-9135-e69b7392dc78', '', '100', '0', null, '0', '3', '2', '1', '绿茶加工第十一道工序，成品复炒。', '12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:46:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:46:29');
INSERT INTO `e_machin_set` VALUES ('f8e224ed-2143-45eb-9578-b6fa35ba93ab', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'aaf83ae9-8e7e-4b55-be3d-d36f822d0b6a', '', '0', '0', '0', '0', '0', '1', '1', '绿茶成品包装', '14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:06');
INSERT INTO `e_machin_set` VALUES ('fb1cee81-2f60-435c-9ed9-ba08f283cf8e', '5382c8cc-27ad-4b2e-8842-b1d194403753', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '590b26ce-356c-4a4f-82f3-b02aca313238', '', '0', '0', '0', '0', '0', '1', '1', '红茶筛选第八道工序', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 12:22:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 12:22:50');

-- ----------------------------
-- Table structure for e_machin_tea
-- ----------------------------
DROP TABLE IF EXISTS `e_machin_tea`;
CREATE TABLE `e_machin_tea` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `dic_mac_type` varchar(36) NOT NULL COMMENT '加工类型',
  `dic_tea_attr` varchar(36) NOT NULL COMMENT '茶系ID',
  `machin_set_id` varchar(36) NOT NULL COMMENT '加工设置步骤ID',
  `dic_mac_value` varchar(36) NOT NULL DEFAULT '0' COMMENT '加工工序的VALUE 属性，用于查询数据',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种（茶叶）',
  `product_id` varchar(36) DEFAULT NULL COMMENT '产品ID(此处仅在成品加工时才有值)',
  `harvest_batch_id` varchar(36) NOT NULL COMMENT '鲜叶批次ID',
  `assembly_set_id` varchar(36) NOT NULL COMMENT '生产线ID',
  `dic_roll_type` varchar(36) DEFAULT NULL COMMENT '揉捻工序ID',
  `roll_status` int(1) NOT NULL DEFAULT '0' COMMENT '工序步骤',
  `temperature` int(3) DEFAULT '0' COMMENT '温度',
  `humidity` int(2) DEFAULT '0' COMMENT '湿度',
  `mac_loss` int(2) DEFAULT '0' COMMENT '损耗',
  `tea_grade_one` double(9,2) DEFAULT '0.00' COMMENT '筛选工序后，一级茶叶数量',
  `tea_grade_two` double(9,2) DEFAULT '0.00' COMMENT '筛选工序后，二级茶叶数量',
  `tea_grade_three` double(9,2) DEFAULT '0.00' COMMENT '筛选工序后，三级茶叶数量(预留项)',
  `begin_time` datetime DEFAULT NULL COMMENT '所需时长',
  `end_time` datetime DEFAULT NULL COMMENT '所需时长',
  `machin_status` int(1) DEFAULT '0' COMMENT '1进行中，2完成，3终止',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '1未生成，2已经生成下一步数据',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  `principal` varchar(36) NOT NULL COMMENT '负责人',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `machin_set_id` (`machin_set_id`,`dic_mac_value`,`dic_tea_type`,`harvest_batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_machin_tea
-- ----------------------------
INSERT INTO `e_machin_tea` VALUES ('0f52c4b5-dbca-4ccb-a708-0e24a11c607a', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'd671f6cc-8b0b-4349-884a-8f525c0b90fc', 'rolling', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', '28dd1122-1981-4035-a57a-47edc20884b8', '3', '0', '0', '0', '0.00', '0.00', '0.00', '2018-01-28 19:17:43', '2018-01-28 19:25:43', '2', '2', '绿茶第三道工序一次揉捻', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:58');
INSERT INTO `e_machin_tea` VALUES ('0ffb7488-1436-47d4-a73b-2442f667d0ad', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '1b0e362b-4006-4d7a-8a53-3055a8f4d322', 'dryTea', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '9', '150', '12', '0', '0.00', '0.00', '0.00', '2018-01-28 19:17:58', '2018-01-28 20:47:58', '2', '2', '绿茶加工第八道工序，二次炒干', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:18:38');
INSERT INTO `e_machin_tea` VALUES ('1c66be78-8265-4c2f-8160-b279e1aa8270', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '7fdcf6f1-61eb-4fc1-ae40-e1cafb0b7196', 'rolling', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', 'f0b5d672-b743-44ce-954d-2eefaf95b11a', '4', '0', '0', '0', '0.00', '0.00', '0.00', '2018-01-28 19:17:43', '2018-01-28 19:22:43', '2', '2', '绿茶加工第四道工序，二次揉捻', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:58');
INSERT INTO `e_machin_tea` VALUES ('2a4b5944-69e6-4e91-b447-675420c935cc', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '68b1f56c-82df-4afe-bc06-d26017c891a1', 'killOut', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '2', '300', '0', '0', '0.00', '0.00', '0.00', '2018-01-28 19:17:16', '2018-01-28 19:20:16', '2', '2', '绿茶第一道工序萎凋', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:43');
INSERT INTO `e_machin_tea` VALUES ('42319344-c4fb-4388-8042-94044af0a110', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '312f3670-b5a6-4370-9c73-b058d8f49512', 'dryTea', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '7', '180', '0', '0', '0.00', '0.00', '0.00', '2018-01-28 19:17:58', '2018-01-28 19:25:58', '2', '2', '绿茶加工第七道工序，一次炒干', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:18:27');
INSERT INTO `e_machin_tea` VALUES ('4466edca-379c-4dc0-8fe4-cedee4e2dddb', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'f8e224ed-2143-45eb-9578-b6fa35ba93ab', 'packaing', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '14', '0', '0', '0', '866.00', '72.33', '12.00', '2018-01-28 19:20:37', '2018-01-28 19:20:37', '2', '2', '绿茶成品包装', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:20:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:21:06');
INSERT INTO `e_machin_tea` VALUES ('4c66cc07-2a25-47fb-bdda-9984cc91226b', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e6349ed8-5ca8-4814-a975-e33919038278', 'rolling', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', '28dd1122-1981-4035-a57a-47edc20884b8', '6', '0', '0', '0', '0.00', '0.00', '0.00', '2018-01-28 19:17:43', '2018-01-28 19:22:43', '2', '2', '绿茶加工第6道工序，4次揉捻', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:58');
INSERT INTO `e_machin_tea` VALUES ('5396039c-ef4f-410d-b955-fb647dd9d048', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '81259a38-f688-4267-bc46-9aea08c7d1bb', 'titian', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '13', '55', '0', '0', '866.00', '72.33', '12.00', '2018-01-28 19:19:47', '2018-01-28 20:01:47', '2', '2', '绿茶成品加工第十三道工序，提香', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:19:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:20:37');
INSERT INTO `e_machin_tea` VALUES ('99540801-2b67-4285-b2ba-27441475084a', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '55601ed9-d4c4-11e7-89ed-38d547b81379', 'wither', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '1', '19', '23', '0', '0.00', '0.00', '0.00', '2018-01-28 20:14:30', '2018-01-29 05:14:30', '2', '2', '绿茶第一道工序萎凋', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:14:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:16');
INSERT INTO `e_machin_tea` VALUES ('bb9e33ea-b1fd-4b2a-aeaa-e9f31e98f050', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '35ed4386-98da-49f1-b15f-60e1b6b3ecbb', 'filtrate', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '11', '0', '0', '0', '866.00', '72.33', '12.00', '2018-01-28 19:18:27', '2018-01-28 19:18:27', '2', '2', '绿茶加工第九道工序，筛选确定茶叶等级', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:18:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:19:12');
INSERT INTO `e_machin_tea` VALUES ('ec292a51-4a94-494e-bbdb-12debf13ef2b', '4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'efadcfc9-59da-4057-b28d-fc8e51fc85b3', 'roasting', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', null, '12', '100', '0', '0', '866.00', '72.33', '12.00', '2018-01-28 19:19:23', '2018-01-28 20:01:23', '2', '2', '绿茶加工第十一道工序，成品复炒。', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:19:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:20:06');
INSERT INTO `e_machin_tea` VALUES ('fc91cb5a-e696-4312-8662-babcd6b8c9b2', '5382c8cc-27ad-4b2e-8842-b1d194403753', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '8281c645-17fb-41f7-97b4-17f60385b874', 'rolling', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', null, 'c344edaa-68c1-4c29-a777-f16a023da768', '1571ddff-e88c-11e7-a642-6045cb7f62f1', 'da517c36-6812-4a9d-a4d4-38f633254656', '5', '0', '0', '0', '0.00', '0.00', '0.00', '2018-01-28 19:17:43', '2018-01-28 19:22:43', '2', '2', '绿茶加工第5道工序，3次揉捻', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:17:58');

-- ----------------------------
-- Table structure for e_manage_batch
-- ----------------------------
DROP TABLE IF EXISTS `e_manage_batch`;
CREATE TABLE `e_manage_batch` (
  `id` varchar(36) NOT NULL,
  `batch_number` varchar(50) NOT NULL COMMENT '批次号',
  `tea_garden_id` varchar(36) NOT NULL COMMENT '茶园ID',
  `create_id` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_manage_batch
-- ----------------------------
INSERT INTO `e_manage_batch` VALUES ('6c2b6c8e-7d40-406e-a1ec-632da9548d48', 'B4-SOG-8185216', '8893e29b-d37b-11e7-b5d6-24fd52935962', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 18:58:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 18:58:43', '1');

-- ----------------------------
-- Table structure for e_origin_batch
-- ----------------------------
DROP TABLE IF EXISTS `e_origin_batch`;
CREATE TABLE `e_origin_batch` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `harvest_batch_id` varchar(36) NOT NULL COMMENT '鲜叶批次',
  `batch_num` varchar(50) NOT NULL COMMENT '溯源批次',
  `product_id` varchar(36) NOT NULL COMMENT '产品ID',
  `tea_garden_id` varchar(36) NOT NULL COMMENT '茶园ID',
  `quality_id` varchar(36) NOT NULL COMMENT '质检ID',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态 默认0,1已生成溯源码，2.产品销售完，溯源停止',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `batch_num` (`batch_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_origin_batch
-- ----------------------------

-- ----------------------------
-- Table structure for e_origin_code
-- ----------------------------
DROP TABLE IF EXISTS `e_origin_code`;
CREATE TABLE `e_origin_code` (
  `id` varchar(36) NOT NULL,
  `origin_batch_id` varchar(36) NOT NULL COMMENT '溯源批次',
  `prefix_val` varchar(50) NOT NULL COMMENT '前缀',
  `origin_code` varchar(36) NOT NULL COMMENT '溯源编码(明文编码类型)',
  `create_status` int(1) NOT NULL DEFAULT '0' COMMENT '是否已生成过(包装盒上的二维码)',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_origin_code
-- ----------------------------

-- ----------------------------
-- Table structure for e_origin_img
-- ----------------------------
DROP TABLE IF EXISTS `e_origin_img`;
CREATE TABLE `e_origin_img` (
  `id` varchar(36) NOT NULL,
  `relation_id` varchar(36) NOT NULL COMMENT '关联的ID',
  `relation_type` varchar(36) DEFAULT NULL,
  `sort_id` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(50) NOT NULL COMMENT '原始名称',
  `img_type` varchar(30) NOT NULL COMMENT '图片类型(格式)',
  `img_url` varchar(200) NOT NULL COMMENT '路径',
  `resolution` varchar(50) NOT NULL COMMENT '分辨率',
  `show_type` int(11) NOT NULL DEFAULT '0' COMMENT '类型-竖屏1,横屏2,无0',
  `size` varchar(50) NOT NULL COMMENT '尺寸',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `source` varchar(50) DEFAULT NULL COMMENT '来源',
  `description` varchar(300) DEFAULT NULL COMMENT '描述',
  `create_id` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_commodity_id` (`relation_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_origin_img
-- ----------------------------

-- ----------------------------
-- Table structure for e_origin_info
-- ----------------------------
DROP TABLE IF EXISTS `e_origin_info`;
CREATE TABLE `e_origin_info` (
  `id` varchar(36) NOT NULL,
  `title` varchar(200) NOT NULL COMMENT '标题',
  `dic_origin_type` varchar(36) NOT NULL COMMENT '溯源类型',
  `content` text NOT NULL COMMENT '内容',
  `img_url` varchar(200) NOT NULL COMMENT '图片',
  `status` int(1) NOT NULL COMMENT '状态',
  `sort_id` int(1) NOT NULL COMMENT '排序ID',
  `description` varchar(200) NOT NULL COMMENT '简介',
  `origin_batch` varchar(36) NOT NULL COMMENT '溯源批次号',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) NOT NULL,
  `modify_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_origin_info
-- ----------------------------

-- ----------------------------
-- Table structure for e_origin_set
-- ----------------------------
DROP TABLE IF EXISTS `e_origin_set`;
CREATE TABLE `e_origin_set` (
  `id` varchar(36) NOT NULL,
  `origin_set_name` varchar(50) DEFAULT NULL COMMENT '名称',
  `process_batch` varchar(36) DEFAULT NULL COMMENT '加工批次号',
  `sampling_id` varchar(36) DEFAULT NULL COMMENT '取样单号',
  `manage_batch_id` varchar(36) DEFAULT NULL COMMENT '茶园管理批次号',
  `status` int(1) DEFAULT NULL,
  `create_id` varchar(36) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_origin_set
-- ----------------------------
INSERT INTO `e_origin_set` VALUES ('d2bf46ba-db20-11e7-8488-24fd52935962', '关联溯源设置', '无关联', '无关联', '无关联', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:38:53', '暂时不启用的功能项', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:40:11');

-- ----------------------------
-- Table structure for e_quality
-- ----------------------------
DROP TABLE IF EXISTS `e_quality`;
CREATE TABLE `e_quality` (
  `id` varchar(36) NOT NULL COMMENT '自增id',
  `harvest_batch_id` varchar(36) NOT NULL COMMENT '鲜叶批次ID',
  `quality_stage` varchar(36) NOT NULL DEFAULT '' COMMENT '质检阶段-加工步骤-machin_set_id',
  `sampling_base` double(5,2) NOT NULL DEFAULT '0.00' COMMENT '取样基数/单份克重',
  `sample_number` int(1) NOT NULL DEFAULT '0' COMMENT '取样数量/份数',
  `sample_tea` varchar(36) NOT NULL DEFAULT '0' COMMENT '留样编号',
  `dic_tea_attr` varchar(36) NOT NULL DEFAULT '0' COMMENT '茶系',
  `dic_tea_type` varchar(36) NOT NULL COMMENT '品种',
  `dic_quality_type` varchar(36) NOT NULL COMMENT '质检类型(字典)',
  `verify_quality` int(1) DEFAULT '0' COMMENT '质检审核(复检)0未复检， 1,合格，2不合格',
  `verify_user` varchar(36) DEFAULT NULL COMMENT '复检员',
  `verify_time` datetime DEFAULT NULL COMMENT '复检时间',
  `quality_status` int(1) NOT NULL DEFAULT '0' COMMENT '质检状态,0未检， 1合格，2不合格',
  `quality_user` varchar(36) DEFAULT NULL COMMENT '质检员',
  `quality_time` datetime DEFAULT NULL COMMENT '质检时间',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT '0' COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_quality
-- ----------------------------
INSERT INTO `e_quality` VALUES ('0ee2931b-ad83-4c01-a51f-cb475f254ee2', 'c344edaa-68c1-4c29-a777-f16a023da768', '312f3670-b5a6-4370-9c73-b058d8f49512', '100.00', '1', 'b4sog-8198708', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '1301e136-8d75-4e05-9fa3-06cbdcad1eea', '0', null, null, '1', '熊', '2018-01-28 19:18:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:18:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:27:43');
INSERT INTO `e_quality` VALUES ('0fc51f4f-808d-4f7d-82bf-f57e1b8b7ad6', 'c344edaa-68c1-4c29-a777-f16a023da768', '1b0e362b-4006-4d7a-8a53-3055a8f4d322', '100.00', '1', 'B4SOG-180127', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '1301e136-8d75-4e05-9fa3-06cbdcad1eea', '0', null, null, '1', '熊滔滔', '2018-01-28 19:18:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:18:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:28:34');

-- ----------------------------
-- Table structure for e_quality_info
-- ----------------------------
DROP TABLE IF EXISTS `e_quality_info`;
CREATE TABLE `e_quality_info` (
  `id` varchar(36) NOT NULL COMMENT '自增id',
  `quality_id` varchar(36) NOT NULL COMMENT '质检ID',
  `net_content` double(7,2) NOT NULL DEFAULT '0.00' COMMENT '净重（净含量）',
  `tea_crumble` double(4,2) NOT NULL DEFAULT '0.00' COMMENT '碎末(茶叶灰)',
  `water_content` double(4,2) NOT NULL DEFAULT '0.00' COMMENT '水份量(含水量)',
  `set_tea_soup` varchar(36) DEFAULT NULL COMMENT '汤色',
  `set_tenderness` varchar(36) DEFAULT NULL COMMENT '嫩度',
  `set_balance_degree` varchar(36) DEFAULT NULL COMMENT '平衡度',
  `set_incense` varchar(36) DEFAULT NULL COMMENT '香度',
  `set_sweetness` varchar(36) DEFAULT NULL COMMENT '甜度',
  `set_concentration` varchar(36) DEFAULT NULL COMMENT '浓度',
  `set_depth` varchar(36) DEFAULT NULL COMMENT '深度',
  `set_purity` varchar(36) DEFAULT NULL COMMENT '纯净度',
  `set_the_fresh` varchar(36) DEFAULT NULL COMMENT '鲜度',
  `img_url` varchar(200) DEFAULT NULL COMMENT '质检报告图片',
  `description` varchar(200) DEFAULT '' COMMENT '备注',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT '0' COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_quality_info
-- ----------------------------
INSERT INTO `e_quality_info` VALUES ('d2ffa0e9-4733-4065-b5a6-f58c8381318b', '0fc51f4f-808d-4f7d-82bf-f57e1b8b7ad6', '100.00', '1.30', '0.90', '53af6db2-b240-40cc-8609-b6c562e3f560', '5715d869-281e-4a8d-b0d9-543e2bd837c9', 'c1ae7231-4c11-4cf8-be69-adfbfdb42dd3', 'f3323119-9e72-4248-be44-f9113269341c', 'b678c805-957f-44aa-8926-e38e4088b4e3', '5bcf5824-d005-481a-bac2-8e08c209c1af', '7a5d8b98-978d-4f04-a99a-5b408139bd51', 'fdf42081-2bbf-4efa-8b80-55beed53edec', '32e8ed07-8b21-478f-b77b-c94d8c16fa33', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/28/583945d5a2e51.jpg', '熊滔滔', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:28:34', '0', null);
INSERT INTO `e_quality_info` VALUES ('fe2507da-7a2c-4f26-8951-e55fa8c51e06', '0ee2931b-ad83-4c01-a51f-cb475f254ee2', '100.00', '1.10', '1.60', 'e753e4d2-8abb-4829-8448-ab901bc5e33d', '85beca40-267c-4589-946c-14859c19414c', '48a9f9f0-77dd-4277-a55c-e7af50d7c7e7', 'e3a30ee8-d26f-4e03-90ab-910a27a1fb99', '1db411f7-7033-44e5-b454-47ebe8faf844', '191f4217-9025-4122-b956-dc3aaae2d1ad', '69fb5b13-e5da-4a10-9041-724f875aee40', 'f4f093e0-ac2d-4aae-911c-7fabac9dce17', '9556ca28-09d8-4aa3-b8f7-3c98f029307c', 'http://of8rkrh1w.bkt.clouddn.com/2018/1/28/583945d5a2f47.jpg', '熊滔滔', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:27:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:27:43');

-- ----------------------------
-- Table structure for e_quality_set
-- ----------------------------
DROP TABLE IF EXISTS `e_quality_set`;
CREATE TABLE `e_quality_set` (
  `id` varchar(36) NOT NULL COMMENT '自增id',
  `sort_id` int(11) NOT NULL DEFAULT '0' COMMENT '排序id',
  `parent_id` varchar(36) NOT NULL COMMENT '父级id',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `value` varchar(50) NOT NULL COMMENT '属性值',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_quality_set
-- ----------------------------
INSERT INTO `e_quality_set` VALUES ('06eba632-1ea4-44a5-86ba-caccd1da54d0', '6', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '一芽四叶', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:11:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:11:00', '1', '一芽四叶');
INSERT INTO `e_quality_set` VALUES ('0786fd00-bfae-41e5-8947-0535b7491f43', '5', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '较浓', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:56', '1', '较浓');
INSERT INTO `e_quality_set` VALUES ('07a6f5df-0b66-4bf0-aa8f-ddd54ce450ef', '9', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '闷', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:58', '1', '闷');
INSERT INTO `e_quality_set` VALUES ('08597d62-d17b-43cd-8138-2f09c868ce80', '9', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '火甜', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:30:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:30:44', '1', '火甜');
INSERT INTO `e_quality_set` VALUES ('0de3cc81-f82e-4167-b8a9-9e60ec0aba39', '7', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '暗红', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:01:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:03:28', '1', '暗红');
INSERT INTO `e_quality_set` VALUES ('1050b046-db73-4653-a998-5163f3b19a71', '8', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '舌前留香', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:39:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:39:12', '1', '舌前留香');
INSERT INTO `e_quality_set` VALUES ('127039e3-61b9-4e65-8d5f-2a637c9d400c', '6', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '麻涩', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:42:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:42:32', '1', '麻涩');
INSERT INTO `e_quality_set` VALUES ('15e0cdc6-6ec7-48f0-9353-1abd24e5db70', '10', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '舌尖留香', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:40:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:40:09', '1', '舌尖留香');
INSERT INTO `e_quality_set` VALUES ('167756ca-80b9-43bd-95f2-207343f4f07b', '1', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '单牙', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:08:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:08:39', '1', '单牙');
INSERT INTO `e_quality_set` VALUES ('1691a504-c151-4954-8c61-09c87a779bbb', '4', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '褐色较亮', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:00:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:00:32', '1', '褐色较亮');
INSERT INTO `e_quality_set` VALUES ('191f4217-9025-4122-b956-dc3aaae2d1ad', '4', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '浓醇', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:35', '1', '浓醇');
INSERT INTO `e_quality_set` VALUES ('19666fb8-fb68-4790-9948-5f76410419ed', '8', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '霉咸', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:43:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:43:33', '1', '霉咸');
INSERT INTO `e_quality_set` VALUES ('1cf018e2-bbe9-467b-afbb-9586602698f0', '3', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '一芽二叶(叶初展)', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:09:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:09:57', '1', '一芽二叶(叶初展)');
INSERT INTO `e_quality_set` VALUES ('1db411f7-7033-44e5-b454-47ebe8faf844', '5', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '果甜', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:27:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:27:16', '1', '果甜');
INSERT INTO `e_quality_set` VALUES ('24437b93-efa0-43bf-b964-98bdc83d1fbc', '2', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '嫩绿亮', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:05:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:05:31', '1', '嫩绿亮');
INSERT INTO `e_quality_set` VALUES ('24a2ec4e-577c-4c21-86f1-5e5cf9ffb4e7', '5', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '干涩', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:42:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:42:08', '1', '干涩');
INSERT INTO `e_quality_set` VALUES ('2a37c741-a806-4ec3-9e9b-7d6b9d0eff37', '1', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '鲜銳振奋', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:44:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:44:55', '1', '鲜銳振奋');
INSERT INTO `e_quality_set` VALUES ('2b652d32-1b89-4921-ae61-94c9e57aed7a', '9', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '梗片', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:12:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:12:09', '1', '梗片');
INSERT INTO `e_quality_set` VALUES ('2da4f45f-94e9-41f1-95bd-31d4237501d3', '5', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '清长尚久', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:21:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:21:16', '1', '清长尚久');
INSERT INTO `e_quality_set` VALUES ('2de13dec-815f-418a-9a4f-38c249cc7434', '3', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '喉头回甘舌面生津', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:37:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:37:06', '1', '喉头回甘舌面生津');
INSERT INTO `e_quality_set` VALUES ('2f468c4e-f2b9-459b-a29e-aad3f14c7e78', '8', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '粗微香', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:22:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:22:25', '1', '粗微香');
INSERT INTO `e_quality_set` VALUES ('3091780e-759d-4826-bad9-60a998b59b05', '1', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '丰富协调/绵厚含芳/余香久净', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:13:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:17:46', '1', '丰富协调/绵厚含芳/余香久净');
INSERT INTO `e_quality_set` VALUES ('325e22cd-8fe8-4126-a3e8-cb09bb25122f', '1', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '嫩绿/晶亮', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:05:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:05:10', '1', '嫩绿/晶亮');
INSERT INTO `e_quality_set` VALUES ('32991de0-f702-46d9-a9f8-8c1288c975aa', '2', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '一芽一叶(叶初展)', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:09:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:09:32', '1', '一芽一叶(叶初展)');
INSERT INTO `e_quality_set` VALUES ('32e8ed07-8b21-478f-b77b-c94d8c16fa33', '2', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '鲜灵', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:12', '1', '鲜灵');
INSERT INTO `e_quality_set` VALUES ('36dd73c7-693c-4fb2-8710-edd75c2e8443', '6', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '不协调/欠适口', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:16:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:16:14', '1', '不协调/欠适口');
INSERT INTO `e_quality_set` VALUES ('3aa8c6d9-fbaf-4334-a180-eaa6bb7b35ef', '7', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '香味单一/余味尚净', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:16:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:16:46', '1', '香味单一/余味尚净');
INSERT INTO `e_quality_set` VALUES ('3ab2e4df-4ed1-4b00-9f18-f28191256a7d', '2', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '红亮/铜亮', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 20:59:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 20:59:25', '1', '红亮/铜亮');
INSERT INTO `e_quality_set` VALUES ('3fb67561-fb6d-4201-b9ec-85bc6bd52eaa', '5', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '欠协调/尚适口', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:15:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:15:52', '1', '欠协调/尚适口');
INSERT INTO `e_quality_set` VALUES ('4472892a-efb1-4b92-96ca-3deed3ba112d', '10', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '僬甜', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:31:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:31:16', '1', '僬甜');
INSERT INTO `e_quality_set` VALUES ('484226a2-875d-4db2-9455-0d6ac427d16b', '8', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '多梗片', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:11:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:11:52', '1', '多梗片');
INSERT INTO `e_quality_set` VALUES ('48a9f9f0-77dd-4277-a55c-e7af50d7c7e7', '3', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '丰富协调/硬尚绵净', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:14:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:18:04', '1', '硬尚绵净');
INSERT INTO `e_quality_set` VALUES ('4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '2', '10000000-0000-0000-0000-000000000000', '绿茶汤色', 'setTeaSoup', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:12', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-28 16:52:17', '1', '用户类型');
INSERT INTO `e_quality_set` VALUES ('4c4c0b82-926c-4231-a0aa-65f42acd13fe', '8', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '薯甜', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:30:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:30:25', '1', '薯甜');
INSERT INTO `e_quality_set` VALUES ('4eb956cc-c036-4d8d-b9a8-781114580628', '1', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '红艳/金亮', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 20:58:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:55:10', '1', '红艳/金亮');
INSERT INTO `e_quality_set` VALUES ('53af6db2-b240-40cc-8609-b6c562e3f560', '4', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '浅绿亮', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:06:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:06:16', '1', '浅绿亮');
INSERT INTO `e_quality_set` VALUES ('53b3f9f0-38b5-4add-a773-2d3668d00754', '2', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '绵厚含芳/丰富协调', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:14:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:14:09', '1', '绵厚含芳/丰富协调');
INSERT INTO `e_quality_set` VALUES ('562e2ea0-a561-42ae-88bf-374834befcae', '10', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '水', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:34:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:34:21', '1', '水');
INSERT INTO `e_quality_set` VALUES ('5715d869-281e-4a8d-b0d9-543e2bd837c9', '5', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '一芽三叶', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:10:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:10:45', '1', '一芽三叶');
INSERT INTO `e_quality_set` VALUES ('57e945a0-5488-4e2b-994e-076d0e48cc50', '6', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '较鲜爽', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:14', '1', '较鲜爽');
INSERT INTO `e_quality_set` VALUES ('58949557-877d-45d0-b4c0-68933a32d398', '5', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '褐欠亮', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:01:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:01:01', '1', '褐欠亮');
INSERT INTO `e_quality_set` VALUES ('5bcf5824-d005-481a-bac2-8e08c209c1af', '3', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '浓厚', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:21', '1', '浓厚');
INSERT INTO `e_quality_set` VALUES ('66644d4c-050f-41fa-9a90-957b9a7ce6ca', '10', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '钝浊', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:47:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:47:19', '1', '钝浊');
INSERT INTO `e_quality_set` VALUES ('67d777ac-b191-47ea-9a71-9739db6aeabe', '3', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '深红亮/橙红亮', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:00:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:00:02', '1', '深红亮/橙红亮');
INSERT INTO `e_quality_set` VALUES ('69fb5b13-e5da-4a10-9041-724f875aee40', '5', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '两颊留香', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:38:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:38:01', '1', '两颊留香');
INSERT INTO `e_quality_set` VALUES ('72546f8e-3672-453b-9066-e7fe1256c41c', '5', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '鲜爽', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:54', '1', '鲜爽');
INSERT INTO `e_quality_set` VALUES ('752eed0c-1665-4adf-85dd-f93d9a7b5f80', '3', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '冬蜜甜', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:26:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:26:29', '1', '冬蜜甜');
INSERT INTO `e_quality_set` VALUES ('76f19b92-476f-4b4b-929f-277db8fc51d2', '1', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '浓烈', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:31:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:31:37', '1', '浓烈');
INSERT INTO `e_quality_set` VALUES ('777b2aa8-2aa1-4d3f-8734-ff550ab145c8', '8', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '闷熟', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:44', '1', '闷熟');
INSERT INTO `e_quality_set` VALUES ('782b0b60-60b9-4fc8-a4e0-f575b7955283', '9', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '黑', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:02:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:03:45', '1', '黑');
INSERT INTO `e_quality_set` VALUES ('7a5d8b98-978d-4f04-a99a-5b408139bd51', '4', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '两腮留香', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:37:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:37:39', '1', '两腮留香');
INSERT INTO `e_quality_set` VALUES ('7b2f5024-27d0-4c50-b4e9-1252fbceae41', '7', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '黄欠亮', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:07:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:07:32', '1', '黄欠亮');
INSERT INTO `e_quality_set` VALUES ('7e574063-4404-455d-97b4-3fd822eb28b7', '10', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '酸馊', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:44:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:44:16', '1', '酸馊');
INSERT INTO `e_quality_set` VALUES ('81613b85-5e8f-4ee6-9a7b-ebda2ac7a0e6', '4', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '鲜活', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:41', '1', '鲜活');
INSERT INTO `e_quality_set` VALUES ('85beca40-267c-4589-946c-14859c19414c', '4', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '一芽二三叶(叶初展)', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:10:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:10:22', '1', '一芽二三叶(叶初展)');
INSERT INTO `e_quality_set` VALUES ('891805db-a20b-4d0a-9e89-032aaa647d52', '8', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '平和', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:33:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:33:47', '1', '平和');
INSERT INTO `e_quality_set` VALUES ('8a3e0d08-ca66-48b7-9924-b98d98fd193d', '1', '10000000-0000-0000-0000-000000000000', '红茶汤色', 'setTeaSoup', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:12', 'fd8b9374-2134-4eb2-b7c7-0019d65d94b2', '2017-12-28 13:59:53', '1', 'qwe');
INSERT INTO `e_quality_set` VALUES ('8dad6f5d-9fcc-443f-9d7c-82cf1256c9c2', '6', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '熟蜜甜', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:27:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:27:55', '1', '熟蜜甜');
INSERT INTO `e_quality_set` VALUES ('8dd6cc83-0610-409e-9864-3272fd8983e9', '9', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '暗浊', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:08:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:08:13', '1', '暗浊');
INSERT INTO `e_quality_set` VALUES ('8f3660ee-d1a0-4e8c-9e09-ac842c913fdf', '8', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '口感不悦', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:17:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:17:06', '1', '口感不悦');
INSERT INTO `e_quality_set` VALUES ('91b3ada1-295a-47b2-83c3-3bf4a121c003', '6', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '醇', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:33:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:33:12', '1', '醇');
INSERT INTO `e_quality_set` VALUES ('9312908c-c4e6-4115-a6bf-1067bf2b6838', '2', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '馥郁持久', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:19:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:19:32', '1', '馥郁持久');
INSERT INTO `e_quality_set` VALUES ('9556ca28-09d8-4aa3-b8f7-3c98f029307c', '3', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '鲜润', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:45:26', '1', '鲜润');
INSERT INTO `e_quality_set` VALUES ('98b43401-e45f-4787-bbb0-9ff29a04f7ff', '9', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '平淡', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:34:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:34:06', '1', '平淡');
INSERT INTO `e_quality_set` VALUES ('9ac3b256-6851-4a8d-b489-0c0a4e0e459b', '1', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '花蜜甜', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:25:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:25:50', '1', '花蜜甜');
INSERT INTO `e_quality_set` VALUES ('9f10d5ad-fe71-4cb5-8ccd-0975c4915490', '7', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '闷杂', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:42:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:42:53', '1', '闷杂');
INSERT INTO `e_quality_set` VALUES ('a2c5bacf-c871-4710-82bc-7f4ed9885b6a', '9', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '前齿留香', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:39:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:39:49', '1', '前齿留香');
INSERT INTO `e_quality_set` VALUES ('a4757f5b-b86d-4508-a236-64470756578b', '8', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '黄浊', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:07:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:07:54', '1', '黄浊');
INSERT INTO `e_quality_set` VALUES ('a57cd61d-05c8-481d-b249-102c64d2d8d6', '9', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '纯和', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:23:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:23:07', '1', '纯和');
INSERT INTO `e_quality_set` VALUES ('a82837a9-776d-4498-a919-5095a2c801c6', '7', 'eae4072c-eaf0-11e7-9f0f-38d547b81379', '尚爽', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:46:31', '1', '尚爽');
INSERT INTO `e_quality_set` VALUES ('a961f58b-369d-44b3-9994-04b8b0ea0fdf', '8', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '红黑', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:02:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:03:38', '1', '红黑');
INSERT INTO `e_quality_set` VALUES ('ae3b207b-b4ae-4365-847e-3dede64d0bae', '2', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '喉节留香舌底鸣泉', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:36:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:36:30', '1', '喉节留香舌底鸣泉');
INSERT INTO `e_quality_set` VALUES ('b0637cde-7bb6-4772-b57d-02a88f387715', '7', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '舌中留香', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:38:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:38:47', '1', '舌中留香');
INSERT INTO `e_quality_set` VALUES ('b2632d64-25c5-49f0-9d50-843b4a83b5fd', '6', '8a3e0d08-ca66-48b7-9924-b98d98fd193d', '青红', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:01:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:01:16', '1', '青红');
INSERT INTO `e_quality_set` VALUES ('b30395a5-80ad-494d-9724-f44fa20a433a', '5', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '浅黄亮', '6', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:06:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:06:32', '1', '浅黄亮');
INSERT INTO `e_quality_set` VALUES ('b678c805-957f-44aa-8926-e38e4088b4e3', '4', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '冰蜜甜', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:26:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:26:47', '1', '冰蜜甜');
INSERT INTO `e_quality_set` VALUES ('bcccd03e-def2-4514-80ef-2ca6f17ecfa7', '9', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '抗拒/不接受', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:17:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:17:30', '1', '抗拒/不接受');
INSERT INTO `e_quality_set` VALUES ('c05ecb11-0425-4ab9-a66d-42734ef190a6', '7', 'ead2cd32-eaf0-11e7-9f0f-38d547b81379', '一芽五叶', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:11:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:11:25', '1', '一芽五叶');
INSERT INTO `e_quality_set` VALUES ('c1ae7231-4c11-4cf8-be69-adfbfdb42dd3', '4', 'ead51e57-eaf0-11e7-9f0f-38d547b81379', '较协调/尚适口', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:15:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:15:22', '1', '较协调/尚适口');
INSERT INTO `e_quality_set` VALUES ('c5479f0d-97e8-4317-8b8a-27b81e7f4970', '6', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '黄尚亮', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:07:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:07:03', '1', '黄尚亮');
INSERT INTO `e_quality_set` VALUES ('c8e6c14d-9430-4ec4-adcf-a48951bd28f9', '1', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '清纯/余味干净', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:40:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:40:48', '1', '清纯/余味干净');
INSERT INTO `e_quality_set` VALUES ('cd93c073-1996-4c74-a739-ca12d8d10cce', '6', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '纯正尚香', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:21:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:21:36', '1', '纯正尚香');
INSERT INTO `e_quality_set` VALUES ('d048b578-a2b2-425f-957a-997fe0a30e43', '2', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '果蜜甜', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:26:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:26:10', '1', '果蜜甜');
INSERT INTO `e_quality_set` VALUES ('d51810b0-024b-4d72-8ded-7e9225db6470', '1', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '喉根留香舌底鸣泉', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:36:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:36:14', '1', '喉根留香舌底鸣泉');
INSERT INTO `e_quality_set` VALUES ('d86f9bf8-f5ca-464f-880f-2054108cc80e', '1', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '细銳持久', '10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:18:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:18:57', '1', '细銳持久');
INSERT INTO `e_quality_set` VALUES ('dba4cb11-0b1a-4cbb-bdd8-a0df41aa77b6', '2', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '浓强化涩', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:32:04', '1', '浓强化涩');
INSERT INTO `e_quality_set` VALUES ('dbb5ac3d-e03b-42c6-9e97-bae5e6b67269', '2', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '较纯/余味较净', '9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:41:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:41:15', '1', '较纯/余味较净');
INSERT INTO `e_quality_set` VALUES ('e3a30ee8-d26f-4e03-90ab-910a27a1fb99', '3', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '幽长持久', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:20:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:20:00', '1', '幽长持久');
INSERT INTO `e_quality_set` VALUES ('e753e4d2-8abb-4829-8448-ab901bc5e33d', '3', '4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '绿(碧)亮', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:06:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:06:00', '1', '绿(碧)亮');
INSERT INTO `e_quality_set` VALUES ('ea3a6da9-f6ec-4da3-a855-39f1e40bda4b', '9', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '焦烟', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:43:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:43:54', '1', '焦烟');
INSERT INTO `e_quality_set` VALUES ('eacc950f-a442-4625-91ed-f40a33c6076c', '7', 'ead9ec31-eaf0-11e7-9f0f-38d547b81379', '糖甜', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:29:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:29:53', '1', '糖甜');
INSERT INTO `e_quality_set` VALUES ('ead2cd32-eaf0-11e7-9f0f-38d547b81379', '3', '10000000-0000-0000-0000-000000000000', '嫩度', 'setTenderness', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:30:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-28 13:59:49', '1', '系统通用的唯一状态');
INSERT INTO `e_quality_set` VALUES ('ead51e57-eaf0-11e7-9f0f-38d547b81379', '4', '10000000-0000-0000-0000-000000000000', '平衡度', 'setBalanceDegree', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:12', 'fd8b9374-2134-4eb2-b7c7-0019d65d94b2', '2017-12-27 18:30:12', '1', '茶园状态');
INSERT INTO `e_quality_set` VALUES ('ead79e81-eaf0-11e7-9f0f-38d547b81379', '5', '10000000-0000-0000-0000-000000000000', '香度', 'setIncense', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:12', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:12', '1', '茶园种植的茶树品种');
INSERT INTO `e_quality_set` VALUES ('ead9ec31-eaf0-11e7-9f0f-38d547b81379', '6', '10000000-0000-0000-0000-000000000000', '甜度', 'setSweetness', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:30:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:30:12', '1', '除草方式');
INSERT INTO `e_quality_set` VALUES ('eadc60ef-eaf0-11e7-9f0f-38d547b81379', '7', '10000000-0000-0000-0000-000000000000', '浓度', 'setConcentration', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:30:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:30:12', '1', '茶系字典');
INSERT INTO `e_quality_set` VALUES ('eadf0a15-eaf0-11e7-9f0f-38d547b81379', '8', '10000000-0000-0000-0000-000000000000', '深度', 'setDepth', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:13', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:13', '1', '等级，用于品级产品或对应的商品');
INSERT INTO `e_quality_set` VALUES ('eae17959-eaf0-11e7-9f0f-38d547b81379', '9', '10000000-0000-0000-0000-000000000000', '纯净度', 'setPurity', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:13', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:13', '1', '加工类型 -machiningType');
INSERT INTO `e_quality_set` VALUES ('eae4072c-eaf0-11e7-9f0f-38d547b81379', '10', '10000000-0000-0000-0000-000000000000', '鲜度', 'setTheFresh', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:13', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-27 18:30:13', '1', '质检类型');
INSERT INTO `e_quality_set` VALUES ('ed19348a-0027-4d84-90c1-c8fff79038b7', '7', 'eadc60ef-eaf0-11e7-9f0f-38d547b81379', '醇和', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:33:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:33:28', '1', '醇和');
INSERT INTO `e_quality_set` VALUES ('ef34ca80-b382-4e72-8ef6-9481f795fe16', '10', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '无香', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:25:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:25:28', '1', '无香');
INSERT INTO `e_quality_set` VALUES ('efaf6183-a902-4484-994d-83b67641320e', '7', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '粗香气短', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:22:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:22:00', '1', '粗香气短');
INSERT INTO `e_quality_set` VALUES ('f3323119-9e72-4248-be44-f9113269341c', '4', 'ead79e81-eaf0-11e7-9f0f-38d547b81379', '高长持久', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:20:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:20:36', '1', '高长持久');
INSERT INTO `e_quality_set` VALUES ('f4f093e0-ac2d-4aae-911c-7fabac9dce17', '4', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '青涩', '7', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:41:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:41:57', '1', '青涩');
INSERT INTO `e_quality_set` VALUES ('f7591709-1614-4631-86b6-c19f7c15ff53', '6', 'eadf0a15-eaf0-11e7-9f0f-38d547b81379', '舌后留香', '5', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:38:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:38:21', '1', '舌后留香');
INSERT INTO `e_quality_set` VALUES ('fdf42081-2bbf-4efa-8b80-55beed53edec', '3', 'eae17959-eaf0-11e7-9f0f-38d547b81379', '较纯/微青涩', '8', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:41:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 21:41:43', '1', '较纯/微青涩');

-- ----------------------------
-- Table structure for e_tea_garden
-- ----------------------------
DROP TABLE IF EXISTS `e_tea_garden`;
CREATE TABLE `e_tea_garden` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `name_area` varchar(50) NOT NULL COMMENT '茶园区域',
  `area_code` varchar(100) NOT NULL COMMENT '区域编号',
  `orientation` varchar(36) DEFAULT NULL COMMENT '方位-字典ID',
  `plant_year` int(4) NOT NULL COMMENT '种植年份',
  `age_limit` int(5) NOT NULL COMMENT '茶园年龄',
  `acreage` double(8,2) NOT NULL COMMENT '面积',
  `dic_cultivar_id` varchar(36) NOT NULL COMMENT '栽培品种',
  `elevation` varchar(36) DEFAULT NULL COMMENT '海拔高度',
  `latitude` decimal(20,17) DEFAULT NULL COMMENT '纬度',
  `longitude` decimal(20,17) DEFAULT NULL COMMENT '经度',
  `direction` varchar(36) DEFAULT NULL COMMENT '风向',
  `illumination` varchar(36) DEFAULT NULL COMMENT '光照',
  `status` int(1) NOT NULL,
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  `principal` varchar(36) NOT NULL COMMENT '负责人',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_tea_garden
-- ----------------------------
INSERT INTO `e_tea_garden` VALUES ('7bfc7d1b-3852-47df-a4ea-7b10bcad47af', '茶园Bt5', 'B5', '6767343c-2716-4dd6-a82b-dd028009711b', '2009', '9', '55.00', 'cc32f7fc-24d6-471a-a5d5-05962737468a', null, null, null, '5eaea1eb-3718-4316-bf63-d34ca1ae75e5', '', '1', '我', '我', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-22 15:32:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-22 15:32:01');
INSERT INTO `e_tea_garden` VALUES ('8893e29b-d37b-11e7-b5d6-24fd52935962', 'B3细叶乌龙', 'B4', '5eaea1eb-3718-4316-bf63-d34ca1ae75e5', '2010', '1', '19.16', 'e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '1500', '1.12300000000000000', null, '5eaea1eb-3718-4316-bf63-d34ca1ae75e5', '', '1', '细叶乌龙123', '我', '8893e29b-d37b-11e7-b5d6-24fd52935962', '2017-11-27 22:02:45', '8893e29b-d37b-11e7-b5d6-24fd52935962', '2017-11-27 22:02:49');
INSERT INTO `e_tea_garden` VALUES ('d038c43b-b1d1-4d2c-9435-aa4ab2267e79', 'B3梅占', 'B3', '5eaea1eb-3718-4316-bf63-d34ca1ae75e5', '2009', '7', '12.00', 'de639eec-dd97-497a-953d-7246247aec95', null, '12.12000000000000000', '123.12312300000000000', '5eaea1eb-3718-4316-bf63-d34ca1ae75e5', '12', '1', '123', '马化腾', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 15:56:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 15:56:45');

-- ----------------------------
-- Table structure for e_tea_garden_log
-- ----------------------------
DROP TABLE IF EXISTS `e_tea_garden_log`;
CREATE TABLE `e_tea_garden_log` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `tea_garden_id` varchar(36) DEFAULT NULL COMMENT '茶园',
  `farm_type_id` varchar(36) NOT NULL COMMENT '农事ID',
  `farm_quantity` double(7,2) DEFAULT NULL COMMENT '施肥/除草使用的药剂或其他数量/垦荒面积',
  `farm_time` datetime DEFAULT NULL COMMENT '农事操作时间',
  `farm_pattern` varchar(36) DEFAULT NULL COMMENT '农事操作方式/措施',
  `fert_variety` varchar(36) DEFAULT NULL COMMENT '种子来源/施肥品种/病虫害对象',
  `cultivar_id` varchar(36) DEFAULT NULL COMMENT '种子品种',
  `batch_num` varchar(36) DEFAULT NULL COMMENT '管理批次',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '操作人ID(目前不关联用户使用手动输入)',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '1进行中，2完成',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  `end_time` datetime DEFAULT NULL,
  `principal` varchar(36) DEFAULT NULL,
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_id` varchar(36) NOT NULL COMMENT '修改人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_tea_garden_log
-- ----------------------------
INSERT INTO `e_tea_garden_log` VALUES ('163f1630-7964-4324-a38a-6c8b9ebfff21', '8893e29b-d37b-11e7-b5d6-24fd52935962', '5fe37095-7d9a-4235-914f-cf0c6f1e592a', '10.00', '2018-01-29 06:01:30', '094cac42-096c-47e1-96bd-3608b58703c7', null, null, '6c2b6c8e-7d40-406e-a1ec-632da9548d48', '司马', '2', '司马', '2018-01-28 19:13:08', '司马', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:12:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:12:59');
INSERT INTO `e_tea_garden_log` VALUES ('3e7403c0-c4f0-424f-a4f0-b19f189dd41b', '8893e29b-d37b-11e7-b5d6-24fd52935962', 'd5bbd9b5-91c4-48c2-b5f8-0c7328f8902f', '300.00', '2018-01-29 09:01:08', '102b6d54-94f9-4ae4-a8a4-427978096e19', null, null, '6c2b6c8e-7d40-406e-a1ec-632da9548d48', '刘', '2', '是', '2018-01-28 19:08:55', '刘', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:08:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:08:45');
INSERT INTO `e_tea_garden_log` VALUES ('50434453-25d8-486c-a588-b1801f062fe8', '8893e29b-d37b-11e7-b5d6-24fd52935962', 'd687763c-2a2e-41a7-b57d-71e9caebf579', '69.00', '2018-01-28 19:01:04', '6fbd9b32-81bd-45f8-9906-5c219354e2cb', 'fb283fdc-fe15-4134-9df0-78082cf7451c', null, '6c2b6c8e-7d40-406e-a1ec-632da9548d48', '张', '2', '我', '2018-01-28 19:07:47', '吴', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:07:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:07:36');
INSERT INTO `e_tea_garden_log` VALUES ('6707a060-6760-4ef0-8d78-f8a922770b5d', null, '43512930-9822-48b4-b577-e900c4a12504', '59.00', '2018-01-29 07:01:52', null, 'MS-L-0123', null, null, '赵', '2', '哦', '2018-01-28 19:00:46', '厂长', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:00:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:00:38');
INSERT INTO `e_tea_garden_log` VALUES ('92658de1-380f-4928-a38e-f47f4d9f7b03', '8893e29b-d37b-11e7-b5d6-24fd52935962', '4b2946d6-ec92-403f-ae59-6a2d6311e6cd', '19.16', '2018-05-16 19:05:51', null, '0.6', null, '6c2b6c8e-7d40-406e-a1ec-632da9548d48', '孙', '2', '我', '2018-01-28 19:01:47', '厂长', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:01:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:01:40');
INSERT INTO `e_tea_garden_log` VALUES ('b5d1700c-45c8-4b8f-aed6-60791f40cbb0', '8893e29b-d37b-11e7-b5d6-24fd52935962', '1689fac5-4b03-4d4b-94c1-d1bbbe8d06ee', '1962.00', '2018-01-28 19:01:52', null, '4e1644d7-4997-4304-931e-08b03a477f39', 'cc32f7fc-24d6-471a-a5d5-05962737468a', '6c2b6c8e-7d40-406e-a1ec-632da9548d48', '魏', '2', '我', '2018-01-28 19:07:56', '李', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:03:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:03:22');
INSERT INTO `e_tea_garden_log` VALUES ('e2a9c9e1-40b1-4ff2-85c7-e4b11ff0d5c8', '8893e29b-d37b-11e7-b5d6-24fd52935962', 'e1f3e464-31c2-46b5-8e20-20d7ea12fb3f', '500.00', '2018-01-29 09:01:52', '152a5745-3cac-4beb-8d31-f4670e7ccf08', '甲虫A', null, '6c2b6c8e-7d40-406e-a1ec-632da9548d48', '蜀', '2', '蜀', '2018-01-28 19:12:10', '蜀', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:11:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-28 19:11:57');

-- ----------------------------
-- Table structure for s_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `s_dictionary`;
CREATE TABLE `s_dictionary` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '自增id',
  `sort_id` int(11) NOT NULL DEFAULT '0' COMMENT '排序id',
  `parent_id` varchar(36) NOT NULL COMMENT '父级id',
  `name` varchar(50) NOT NULL COMMENT '字典名称',
  `value` varchar(50) NOT NULL COMMENT '属性值',
  `create_id` varchar(36) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_dictionary
-- ----------------------------
INSERT INTO `s_dictionary` VALUES ('01980df1-e742-4891-b449-a6ae4be190cc', '1', '7dcd4ffe-3041-4ce7-ae5f-ac3ba811ff71', '茶园类', 'teaGardenInfo', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:47:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:47:55', '1', '茶园信息类型');
INSERT INTO `s_dictionary` VALUES ('01b33909-73b8-45d9-af2e-5f57a22895c1', '8', '1e12732d-246e-11e5-965c-000c29d7a3a0', '抽检', 'qualityTest', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:43:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:43:49', '1', '内部质检-');
INSERT INTO `s_dictionary` VALUES ('02e71242-9fea-11e5-a07b-000c29d29d54', '11', '10000000-0000-0000-0000-000000000000', '设备类型', 'customerType', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-11 17:16:00', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-19 13:52:55', '1', '设备类型');
INSERT INTO `s_dictionary` VALUES ('07aaa0e1-4704-4ba5-9816-cda4cf965f0d', '3', 'deb3affb-5a50-428d-ade8-3abf4ef967c2', '茶末', 'matcha', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:15:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:15:35', '1', '茶叶加工筛选茶灰');
INSERT INTO `s_dictionary` VALUES ('094cac42-096c-47e1-96bd-3608b58703c7', '2', '67c57cec-8621-40cc-ab3e-2bc3fd487c58', '喷灌', 'sprayIrrigation', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 15:00:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 15:00:27', '1', '喷灌');
INSERT INTO `s_dictionary` VALUES ('0b9ed538-29d6-11e5-965c-000c29d7a3a0', '9', '10000000-0000-0000-0000-000000000000', '加工类型', 'machinType', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:48:21', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-19 13:52:49', '1', '加工类型 -machiningType');
INSERT INTO `s_dictionary` VALUES ('0fb92203-be20-4705-87e8-ae6862a91743', '3', 'f63fe4f8-27ab-11e5-965c-000c29d7a3a0', '二等', '3', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:11:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:29:08', '1', '二等');
INSERT INTO `s_dictionary` VALUES ('102b6d54-94f9-4ae4-a8a4-427978096e19', '2', 'bc9b6739-d94f-4fb4-a54d-c88255cf0f22', '化学', 'chemicalWeeding', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:22:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:22:08', '1', '化学除草');
INSERT INTO `s_dictionary` VALUES ('1301e136-8d75-4e05-9fa3-06cbdcad1eea', '1', '68d6888f-2b91-11e5-965c-000c29d7a3a0', '自检', 'incheck', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:02:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:03:01', '1', '公司内部QC质检');
INSERT INTO `s_dictionary` VALUES ('140da388-96d7-4a66-82e0-59e061f5d3d8', '2', 'deb3affb-5a50-428d-ade8-3abf4ef967c2', '副茶', 'byproduct', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:14:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:14:52', '1', '茶叶加工复茶类型');
INSERT INTO `s_dictionary` VALUES ('152a5745-3cac-4beb-8d31-f4670e7ccf08', '1', 'bc9b6739-d94f-4fb4-a54d-c88255cf0f22', '物理', 'physicalWeeding', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:21:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:21:30', '1', '物理除草');
INSERT INTO `s_dictionary` VALUES ('153a683d-f7da-4853-ad65-4438ff0af8c3', '6', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '东南', 'southeast', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:02:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:02:29', '1', '东南');
INSERT INTO `s_dictionary` VALUES ('155a1b9b-5fbb-11e7-8697-38d547b81379', '2', '10000000-0000-0000-0000-000000000000', '用户类型', 'userType', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:46:27', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:46:27', '1', '用户类型');
INSERT INTO `s_dictionary` VALUES ('16595d6b-b5f0-4b49-970d-2c26c691e66a', '2', '1e12732d-246e-11e5-965c-000c29d7a3a0', '萎凋', 'wither', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:49:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:49:19', '1', '萎凋');
INSERT INTO `s_dictionary` VALUES ('1689fac5-4b03-4d4b-94c1-d1bbbe8d06ee', '3', '92253cc8-2128-11e5-965c-000c29d7a3a0', '种植', 'seed', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-16 22:30:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 17:14:14', '1', '茶园属性播种');
INSERT INTO `s_dictionary` VALUES ('1699d859-66af-4ea6-8913-0a1e0899f5de', '1', '02e71242-9fea-11e5-a07b-000c29d29d54', '烘烤设备', 'bakefacility', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:05:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:05:40', '1', '此处为示例内容');
INSERT INTO `s_dictionary` VALUES ('19c89bde-0a44-405e-b09e-a7220a8e627c', '2', '963c5d6c-7015-4f92-9b9c-80b274ab10d4', '一芽二叶', 'obt', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:57:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:57:46', '1', '一芽二叶');
INSERT INTO `s_dictionary` VALUES ('1e12732d-246e-11e5-965c-000c29d7a3a0', '6', '10000000-0000-0000-0000-000000000000', '加工工序', 'machinProcess', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:48:28', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-16 22:46:34', '1', 'machiningType');
INSERT INTO `s_dictionary` VALUES ('1fc53559-ed54-4897-95a1-9af0c99c6c05', '3', '67c57cec-8621-40cc-ab3e-2bc3fd487c58', '漫灌', 'flooding', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 15:00:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 15:00:55', '1', '漫灌');
INSERT INTO `s_dictionary` VALUES ('203ebb76-6a7a-4710-a234-7750c8d5358d', '1', 'ba259a75-f5a7-4897-949f-1c90b7958b35', '未激活', '0', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:52:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:57:52', '1', '未开启的状态');
INSERT INTO `s_dictionary` VALUES ('241f8263-5e9e-4479-8463-4b902f54e736', '1', '155a1b9b-5fbb-11e7-8697-38d547b81379', '系统用户', 'systemUser', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-16 22:51:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-17 14:26:36', '1', '管理员类型');
INSERT INTO `s_dictionary` VALUES ('26b273b3-a49b-4910-a68c-23a1fde3ece0', '3', '68d6888f-2b91-11e5-965c-000c29d7a3a0', '送检', 'inspect', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:04:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:04:05', '1', '第三方机构送检');
INSERT INTO `s_dictionary` VALUES ('28dd1122-1981-4035-a57a-47edc20884b8', '1', '6d493a67-1545-4022-b7d4-2854c5b70abd', '轻压', 'pressureo', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:01:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:01:30', '1', '第一次揉捻');
INSERT INTO `s_dictionary` VALUES ('2d655158-9d5b-4cba-a9b7-39a6d814903c', '2', '5530f9e2-869f-407e-b67b-ce56688e50ca', '设备清洁', 'cleanEquipment', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:31:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:31:13', '1', '茶叶加工设备清洁');
INSERT INTO `s_dictionary` VALUES ('31783870-956f-469f-b43e-9fefd905afca', '7', '10000000-0000-0000-0000-000000000000', '所属茶系', 'teaAttr', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:53:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:53:47', '1', '茶系字典');
INSERT INTO `s_dictionary` VALUES ('336dd879-f833-4eee-ad08-fc5f60953f20', '3', '7dcd4ffe-3041-4ce7-ae5f-ac3ba811ff71', '质检', 'quality', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:49:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:49:05', '1', '质检类型消息');
INSERT INTO `s_dictionary` VALUES ('3b7dc807-11d0-4884-b63c-78c929e28bec', '5', '10000000-0000-0000-0000-000000000000', '种子来源', 'seedOrigin', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:07:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:07:41', '1', '种子来源');
INSERT INTO `s_dictionary` VALUES ('43512930-9822-48b4-b577-e900c4a12504', '1', '92253cc8-2128-11e5-965c-000c29d7a3a0', '垦荒', 'reclaim', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:40:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:40:58', '1', 'reclaim');
INSERT INTO `s_dictionary` VALUES ('445159a9-665f-49fb-9505-d68f7a02685e', '1', '963c5d6c-7015-4f92-9b9c-80b274ab10d4', '一芽一叶', 'obo', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:57:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:57:29', '1', '一芽一叶');
INSERT INTO `s_dictionary` VALUES ('4b0cedd9-13be-4759-9e00-2f705d7770d6', '4', '7dcd4ffe-3041-4ce7-ae5f-ac3ba811ff71', '产品', 'product', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:49:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:49:32', '1', '产品消息');
INSERT INTO `s_dictionary` VALUES ('4b2946d6-ec92-403f-ae59-6a2d6311e6cd', '2', '92253cc8-2128-11e5-965c-000c29d7a3a0', '耕地', 'plough', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-16 22:30:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:41:52', '1', '茶园当前操作为耕地');
INSERT INTO `s_dictionary` VALUES ('4c23ef06-e0b5-49ae-947b-bb1ff3af9118', '1', '31783870-956f-469f-b43e-9fefd905afca', '绿茶', 'GREENTEA', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:55:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:00:20', '1', 'CXLC （茶系-绿茶）首字母大写');
INSERT INTO `s_dictionary` VALUES ('4c387b0a-5c56-43fc-8e5a-9050df95b2c0', '2', 'ba259a75-f5a7-4897-949f-1c90b7958b35', '激活', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:52:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:53:37', '1', '使用中的状态');
INSERT INTO `s_dictionary` VALUES ('4dc6f1b2-5bbb-4324-9d74-b318dab9e8a3', '2', '0b9ed538-29d6-11e5-965c-000c29d7a3a0', '成品', 'finished', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 20:50:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 20:50:48', '1', '加工完成的类型');
INSERT INTO `s_dictionary` VALUES ('4e1644d7-4997-4304-931e-08b03a477f39', '1', '3b7dc807-11d0-4884-b63c-78c929e28bec', '培育基地A', 'baseA', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:08:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:08:38', '1', '培育基地A');
INSERT INTO `s_dictionary` VALUES ('50e0fd8b-573c-4e3d-aee6-73582467b852', '4', '963c5d6c-7015-4f92-9b9c-80b274ab10d4', '单叶', 'cutForm', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:58:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:58:42', '1', '单叶');
INSERT INTO `s_dictionary` VALUES ('53389185-9001-44cc-8c53-83c862b6dc64', '4', 'be0ba01c-23ad-11e5-965c-000c29d7a3a0', '马山4号', 'MS4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:46:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 12:02:23', '1', 'MS4');
INSERT INTO `s_dictionary` VALUES ('5382c8cc-27ad-4b2e-8842-b1d194403753', '1', '0b9ed538-29d6-11e5-965c-000c29d7a3a0', '半成品', 'halfProducts', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 20:49:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 20:49:40', '1', '粗加工的产品');
INSERT INTO `s_dictionary` VALUES ('5530f9e2-869f-407e-b67b-ce56688e50ca', '12', '10000000-0000-0000-0000-000000000000', '维护类型', 'maintainType', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:29:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:29:42', '1', '设备维护和保养类型');
INSERT INTO `s_dictionary` VALUES ('56a4a63d-2cb8-474d-8da4-9bc9bce662e7', '1', '1e12732d-246e-11e5-965c-000c29d7a3a0', '鲜叶', 'harvest', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:48:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-22 15:21:45', '2', '鲜叶');
INSERT INTO `s_dictionary` VALUES ('590b26ce-356c-4a4f-82f3-b02aca313238', '7', '1e12732d-246e-11e5-965c-000c29d7a3a0', '筛选', 'filtrate', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:40:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:40:24', '1', '筛选工序');
INSERT INTO `s_dictionary` VALUES ('5eaea1eb-3718-4316-bf63-d34ca1ae75e5', '1', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '向东', 'eastward', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 13:59:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 13:59:13', '1', '方向');
INSERT INTO `s_dictionary` VALUES ('5fe37095-7d9a-4235-914f-cf0c6f1e592a', '7', '92253cc8-2128-11e5-965c-000c29d7a3a0', '灌溉', 'irrigate', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:16:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:41:34', '1', '茶园灌溉');
INSERT INTO `s_dictionary` VALUES ('65bac923-24d4-4a61-b933-ca3bd1fae8ae', '4', 'f63fe4f8-27ab-11e5-965c-000c29d7a3a0', '三等', '4', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:11:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:29:14', '1', '三等');
INSERT INTO `s_dictionary` VALUES ('6767343c-2716-4dd6-a82b-dd028009711b', '3', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '向西', 'westward', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:00:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:00:17', '1', '向西');
INSERT INTO `s_dictionary` VALUES ('67c57cec-8621-40cc-ab3e-2bc3fd487c58', '6', '10000000-0000-0000-0000-000000000000', '灌溉方式', 'irrigationRegime', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:59:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:59:15', '1', '灌溉方式');
INSERT INTO `s_dictionary` VALUES ('68d6888f-2b91-11e5-965c-000c29d7a3a0', '10', '10000000-0000-0000-0000-000000000000', '质检类型', 'attestation', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:52:05', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-19 13:52:52', '1', '质检类型');
INSERT INTO `s_dictionary` VALUES ('6b0548af-ebdb-4ea8-ab58-0031c6a46994', '8', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '西南', 'southwest', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:03:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:03:21', '1', '西南');
INSERT INTO `s_dictionary` VALUES ('6d173896-2c89-4f7b-9827-fbe0fc9b407b', '4', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '向北', 'northerliness', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:00:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:00:50', '1', '向北');
INSERT INTO `s_dictionary` VALUES ('6d493a67-1545-4022-b7d4-2854c5b70abd', '6', '10000000-0000-0000-0000-000000000000', '揉捻工序', 'rollingType', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:00:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:00:24', '1', '揉捻工序分类');
INSERT INTO `s_dictionary` VALUES ('6fbd9b32-81bd-45f8-9906-5c219354e2cb', '2', 'c0de59f4-63a7-11e7-b264-000c29b92c50', '茎叶施肥', 'leafFertilizer', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:48:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:48:47', '1', '茎叶施肥');
INSERT INTO `s_dictionary` VALUES ('74125ba6-0ec1-4286-b9c2-f56d95fe4ac4', '2', 'f63fe4f8-27ab-11e5-965c-000c29d7a3a0', '一等', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:10:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:29:05', '1', '一等品级');
INSERT INTO `s_dictionary` VALUES ('7dcd4ffe-3041-4ce7-ae5f-ac3ba811ff71', '12', '10000000-0000-0000-0000-000000000000', '溯源类型', 'originType', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:46:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 13:54:23', '1', '溯源信息类型设置');
INSERT INTO `s_dictionary` VALUES ('80aa9101-7258-4608-9ed6-ad66a28438ea', '1', 'deb3affb-5a50-428d-ade8-3abf4ef967c2', '成品茶', 'finishedpro', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:13:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:13:57', '1', '茶叶加工，筛选茶类型');
INSERT INTO `s_dictionary` VALUES ('8978edce-c9c6-11e7-8126-38d547b81379', '2', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '删除', 'delete', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-15 13:33:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-26 10:16:25', '1', '删除');
INSERT INTO `s_dictionary` VALUES ('8a3e0d08-ca66-48b7-9924-b98d98fd193d', '2', '31783870-956f-469f-b43e-9fefd905afca', '红茶', 'REDTEA', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:55:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:01:03', '1', '红茶典范');
INSERT INTO `s_dictionary` VALUES ('8a71952c-9278-4882-b9bd-e8267f50aefa', '7', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '西北', 'northwest', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:02:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:02:50', '1', '西北');
INSERT INTO `s_dictionary` VALUES ('8aa97837-a152-49be-98b8-47a11c3b1de4', '4', '1e12732d-246e-11e5-965c-000c29d7a3a0', '揉捻', 'rolling', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:49:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:49:35', '1', '揉捻');
INSERT INTO `s_dictionary` VALUES ('8d25bae7-44c6-4813-a227-8e735df61047', '3', '5530f9e2-869f-407e-b67b-ce56688e50ca', '设备维修', 'repair', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:32:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:32:17', '1', '加工设备维修，发生故障时使用');
INSERT INTO `s_dictionary` VALUES ('909b76dd-b521-4255-b2e6-1b2f4767f65a', '2', '7dcd4ffe-3041-4ce7-ae5f-ac3ba811ff71', '加工', 'machinType', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:48:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 15:48:23', '1', '加工类型');
INSERT INTO `s_dictionary` VALUES ('92096f29-97c8-4491-b10e-99daaba76cf4', '1', '5530f9e2-869f-407e-b67b-ce56688e50ca', '设备保养', 'overhaul', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:30:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 13:32:33', '1', '加工设备检查');
INSERT INTO `s_dictionary` VALUES ('92253cc8-2128-11e5-965c-000c29d7a3a0', '4', '10000000-0000-0000-0000-000000000000', '农事类型', 'teaStatus', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-10 13:16:08', 'fd8b9374-2134-4eb2-b7c7-0019d65d94b2', '2017-11-28 09:52:39', '1', '茶园状态');
INSERT INTO `s_dictionary` VALUES ('963c5d6c-7015-4f92-9b9c-80b274ab10d4', '10', '10000000-0000-0000-0000-000000000000', '采摘标准', 'pickStandard', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:56:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:56:45', '1', '采摘标准');
INSERT INTO `s_dictionary` VALUES ('9bda9313-c9c6-11e7-8126-38d547b81379', '3', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '编辑', 'edit', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-15 13:34:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-26 10:16:25', '1', '编辑');
INSERT INTO `s_dictionary` VALUES ('9d590186-c9c6-11e7-8126-38d547b81379', '4', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '导出', 'export', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-15 13:34:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-26 10:16:25', '1', '导出');
INSERT INTO `s_dictionary` VALUES ('9d9438d9-7746-4b14-adb7-d29136b1778a', '10', '1e12732d-246e-11e5-965c-000c29d7a3a0', '提香', 'titian', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 18:59:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:12:52', '1', '成品加工提香工序');
INSERT INTO `s_dictionary` VALUES ('9e15db46-c9c6-11e7-8126-38d547b81379', '5', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '提交', 'submit', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-15 13:34:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-26 10:16:25', '1', '提交');
INSERT INTO `s_dictionary` VALUES ('9ea19fba-8765-48f7-8a8a-b5ea412bda2e', '3', '1e12732d-246e-11e5-965c-000c29d7a3a0', '杀青', 'killOut', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:47:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:48:42', '1', '杀青');
INSERT INTO `s_dictionary` VALUES ('9eed0607-9fe9-4f3f-9afb-997a93eeaef4', '1', 'c0de59f4-63a7-11e7-b264-000c29b92c50', '土壤施肥', 'soilFertilization', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:48:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:48:13', '1', '土壤施肥');
INSERT INTO `s_dictionary` VALUES ('9fd1943d-b955-4921-a1cd-76d60126e114', '5', '1e12732d-246e-11e5-965c-000c29d7a3a0', '发酵', 'fermentation', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:49:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:49:55', '1', '发酵');
INSERT INTO `s_dictionary` VALUES ('a9ce6951-b3ae-4529-90fa-4cfa42afcaad', '2', 'e597a18d-9e8a-4194-b413-54d2d8694f51', '生物肥料', 'biofertilizer', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:58:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:58:06', '1', '生物肥料');
INSERT INTO `s_dictionary` VALUES ('aaf83ae9-8e7e-4b55-be3d-d36f822d0b6a', '11', '1e12732d-246e-11e5-965c-000c29d7a3a0', '包装', 'packaing', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:37:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:37:40', '1', '产品包装');
INSERT INTO `s_dictionary` VALUES ('ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '20', '10000000-0000-0000-0000-000000000000', '方位区域', 'areaDirection', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 13:51:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:55:35', '1', '方位区域信息集合');
INSERT INTO `s_dictionary` VALUES ('ac3d7fa7-d887-440e-9a41-a5cde1c00ac6', '3', 'c0de59f4-63a7-11e7-b264-000c29b92c50', '灌溉施肥', 'fertigation', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:49:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:49:17', '1', '灌溉施肥');
INSERT INTO `s_dictionary` VALUES ('ac60b692-deb4-426a-a1a5-414e7919449e', '2', '3b7dc807-11d0-4884-b63c-78c929e28bec', '培育基地B', 'baseB', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:09:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:09:02', '1', '培育基地B');
INSERT INTO `s_dictionary` VALUES ('ae0576d3-d31c-48fd-9c13-b1b709a4cece', '2', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '向南', 'southward', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 13:59:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 13:59:41', '1', '向南');
INSERT INTO `s_dictionary` VALUES ('b1c94b1c-67e4-4e45-a516-0976fb142a81', '1', 'f63fe4f8-27ab-11e5-965c-000c29d7a3a0', '特等', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:11:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:29:01', '1', '特等');
INSERT INTO `s_dictionary` VALUES ('b361f510-501e-4072-aa23-525e4efdf564', '3', '963c5d6c-7015-4f92-9b9c-80b274ab10d4', '一芽多叶', 'obn', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:58:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 17:58:05', '1', '一芽多叶');
INSERT INTO `s_dictionary` VALUES ('b6315b3a-1587-11e5-a9de-000c29d7a3a0', '1', '10000000-0000-0000-0000-000000000000', '按钮权限', 'roleButtn', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-10 13:16:18', 'fd8b9374-2134-4eb2-b7c7-0019d65d94b2', '2017-11-16 22:35:22', '1', '按钮权限组，以实现分区控制功能');
INSERT INTO `s_dictionary` VALUES ('ba259a75-f5a7-4897-949f-1c90b7958b35', '3', '10000000-0000-0000-0000-000000000000', '状态类型', 'statusType', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:49:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:49:55', '1', '系统通用的唯一状态');
INSERT INTO `s_dictionary` VALUES ('bc9b6739-d94f-4fb4-a54d-c88255cf0f22', '6', '10000000-0000-0000-0000-000000000000', '除草方式', 'methods', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:20:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:20:46', '1', '除草方式');
INSERT INTO `s_dictionary` VALUES ('be0ba01c-23ad-11e5-965c-000c29d7a3a0', '5', '10000000-0000-0000-0000-000000000000', '茶树品种', 'treeType', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:51:24', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-14 17:50:28', '1', '茶园种植的茶树品种');
INSERT INTO `s_dictionary` VALUES ('c0de59f4-63a7-11e7-b264-000c29b92c50', '13', '10000000-0000-0000-0000-000000000000', '施肥方式', 'patternType', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:44:46', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-21 13:47:16', '1', '施肥方式');
INSERT INTO `s_dictionary` VALUES ('c307d686-7dce-4b2f-9efb-16fbeb348de6', '6', '1e12732d-246e-11e5-965c-000c29d7a3a0', '炒干', 'dryTea', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:50:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 20:31:45', '1', '干燥');
INSERT INTO `s_dictionary` VALUES ('c4aa9993-e8d6-4512-9608-16df191879ed', '5', 'ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac', '东北', 'northeast', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:01:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 14:01:43', '1', 'northeast');
INSERT INTO `s_dictionary` VALUES ('c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '新增', 'add', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-16 23:08:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-16 23:08:25', '1', '测试组建唯一');
INSERT INTO `s_dictionary` VALUES ('cc32f7fc-24d6-471a-a5d5-05962737468a', '1', 'be0ba01c-23ad-11e5-965c-000c29d7a3a0', '马山9号', 'MS9', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:44:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 12:01:22', '1', '茶园种植的茶树品种');
INSERT INTO `s_dictionary` VALUES ('ce84f35c-2d8b-4a72-981d-dcbb8150a8c7', '2', '68d6888f-2b91-11e5-965c-000c29d7a3a0', '抽检', 'spotcheck', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:03:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:03:33', '1', '抽检');
INSERT INTO `s_dictionary` VALUES ('d556160f-91d4-4316-bf11-7035e863a102', '1', '67c57cec-8621-40cc-ab3e-2bc3fd487c58', '滴灌', 'dropIrrigation', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:59:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 14:59:55', '1', '滴灌');
INSERT INTO `s_dictionary` VALUES ('d5bbd9b5-91c4-48c2-b5f8-0c7328f8902f', '5', '92253cc8-2128-11e5-965c-000c29d7a3a0', '除草', 'weeding', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:14:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:42:12', '1', '茶园除草');
INSERT INTO `s_dictionary` VALUES ('d687763c-2a2e-41a7-b57d-71e9caebf579', '4', '92253cc8-2128-11e5-965c-000c29d7a3a0', '施肥', 'fertilizer', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:14:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:42:05', '1', '茶园操作-施肥');
INSERT INTO `s_dictionary` VALUES ('d7bd09c0-4114-4445-a2b3-6e17bcb04f09', '3', 'ba259a75-f5a7-4897-949f-1c90b7958b35', '禁用', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:53:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-25 15:53:31', '1', '禁止使用的状态');
INSERT INTO `s_dictionary` VALUES ('da517c36-6812-4a9d-a4d4-38f633254656', '3', '6d493a67-1545-4022-b7d4-2854c5b70abd', '重压', 'pressurer', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:02:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:02:11', '1', '第三次揉捻');
INSERT INTO `s_dictionary` VALUES ('de46c408-c9c6-11e7-8126-38d547b81379', '6', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '上传', 'upload', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-15 13:36:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-26 10:16:25', '1', '上传');
INSERT INTO `s_dictionary` VALUES ('de639eec-dd97-497a-953d-7246247aec95', '2', 'be0ba01c-23ad-11e5-965c-000c29d7a3a0', '梅占', 'MZ', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:45:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 17:49:20', '1', 'MZ');
INSERT INTO `s_dictionary` VALUES ('deb3affb-5a50-428d-ade8-3abf4ef967c2', '17', '10000000-0000-0000-0000-000000000000', '产品类型', 'productType', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:01:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-06 20:01:01', '1', '产品类型');
INSERT INTO `s_dictionary` VALUES ('deed64de-c9c6-11e7-8126-38d547b81379', '7', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '审核', 'verify', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-15 13:36:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-26 10:16:25', '1', '审核');
INSERT INTO `s_dictionary` VALUES ('e1f3e464-31c2-46b5-8e20-20d7ea12fb3f', '6', '92253cc8-2128-11e5-965c-000c29d7a3a0', '治虫', 'insecticide', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 18:15:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:41:24', '1', '茶园治虫');
INSERT INTO `s_dictionary` VALUES ('e597a18d-9e8a-4194-b413-54d2d8694f51', '14', '10000000-0000-0000-0000-000000000000', '肥料品种', 'manureType', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:56:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:56:33', '1', '肥料品种');
INSERT INTO `s_dictionary` VALUES ('e7fbdea9-82a8-47d9-bbe0-82fd66f7bd27', '2', '155a1b9b-5fbb-11e7-8697-38d547b81379', '门店用户', 'storeUser', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-07 16:39:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-17 14:25:44', '1', '11');
INSERT INTO `s_dictionary` VALUES ('e9ce4ae0-2c4e-4563-9292-ee7fe182fe4e', '3', 'be0ba01c-23ad-11e5-965c-000c29d7a3a0', '细叶乌龙', 'SOG', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-27 17:46:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 17:50:09', '1', '马山3号');
INSERT INTO `s_dictionary` VALUES ('f0b5d672-b743-44ce-954d-2eefaf95b11a', '2', '6d493a67-1545-4022-b7d4-2854c5b70abd', '中压', 'pressuret', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:01:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 19:01:50', '1', '第二次揉捻');
INSERT INTO `s_dictionary` VALUES ('f63fe4f8-27ab-11e5-965c-000c29d7a3a0', '8', '10000000-0000-0000-0000-000000000000', '质量等级', 'grade', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-08 14:50:43', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-12-19 13:52:45', '1', '等级，用于品级产品或对应的商品');
INSERT INTO `s_dictionary` VALUES ('f9e96bed-6103-4a14-9135-e69b7392dc78', '9', '1e12732d-246e-11e5-965c-000c29d7a3a0', '复炒(烤)', 'roasting', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:14:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 12:21:03', '1', '加工第九道工序');
INSERT INTO `s_dictionary` VALUES ('fb283fdc-fe15-4134-9df0-78082cf7451c', '1', 'e597a18d-9e8a-4194-b413-54d2d8694f51', '有机肥料', 'organicManure', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:57:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-21 13:57:15', '1', '有机肥料');
INSERT INTO `s_dictionary` VALUES ('fea1871b-c9c6-11e7-8126-38d547b81379', '8', 'b6315b3a-1587-11e5-a9de-000c29d7a3a0', '查看', 'view', 'c6830623-3988-11e5-993d-000c29d7a3a0', '2017-11-15 13:36:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-26 10:16:25', '1', '查看');
INSERT INTO `s_dictionary` VALUES ('ff873baa-b089-481c-8696-52f25b487ef4', '3', '155a1b9b-5fbb-11e7-8697-38d547b81379', '普通用户', 'webUser', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-17 14:27:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-17 14:27:08', '1', '普通用户');

-- ----------------------------
-- Table structure for s_menu
-- ----------------------------
DROP TABLE IF EXISTS `s_menu`;
CREATE TABLE `s_menu` (
  `id` varchar(36) NOT NULL COMMENT '菜单的主键ID',
  `sort_id` int(11) DEFAULT NULL COMMENT '排序ID',
  `parent_id` varchar(36) DEFAULT NULL COMMENT '父级ID',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `type` int(11) DEFAULT NULL,
  `icon_class` varchar(100) DEFAULT NULL COMMENT '菜单Class属性对应菜单的图标样式',
  `status` int(1) NOT NULL DEFAULT '1',
  `create_id` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `description` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_menu
-- ----------------------------
INSERT INTO `s_menu` VALUES ('0277b5ce-acca-4f31-a43c-20585768c596', '1', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '垦荒', '/system/teaLog/reclaim', null, 'flaticon-reclaim', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:47:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 17:54:56', '茶园管理工序');
INSERT INTO `s_menu` VALUES ('02886d5a-211c-4e58-800c-90cf79640ef5', '2', '21136dca-a230-4902-b370-73cedbfd37d1', '生产线', '/system/assembly/list', null, 'flaticon-Assembly', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:52:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:52:57', '生产线管理');
INSERT INTO `s_menu` VALUES ('04c21bbc-f0c1-4981-bbe7-17627cce0664', '2', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '用户管理', '/system/user/getUserList', null, 'flaticon-users', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:30:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 09:48:17', '用户信息管理');
INSERT INTO `s_menu` VALUES ('095c96ce-07e5-4c24-aebb-c743adc3562f', '3', '4bcab523-1174-11e5-a9de-000c29d7a3a0', '测试菜单添加时间', '/system/menu/add', '1', 'flaticon-xxx-1', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-14 11:25:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-14 11:25:08', '测试菜单添加时间');
INSERT INTO `s_menu` VALUES ('0a1e90f6-cc25-11e7-843e-24fd52935962', '5', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '角色权限', '/system/pageRole/list', '1', 'flaticon-menu', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-18 13:55:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-18 13:55:11', '角色权限设置');
INSERT INTO `s_menu` VALUES ('0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '1', '10000000-0000-0000-0000-100000000000', '系统管理', '/system/index/main', '1', 'flaticon-settings', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '管理');
INSERT INTO `s_menu` VALUES ('0bc54201-f2e3-4585-a9c7-bb5d9b44e26d', '8', '10000000-0000-0000-0000-100000000000', '溯源管理', '/system/originRecord/list', '1', 'flaticon-folder-1', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:32:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:44:45', '溯源信息管理');
INSERT INTO `s_menu` VALUES ('0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '7', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '灌溉', '/system/teaLog/irrigate', null, 'flaticon-irrigate', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:54:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 17:55:49', '灌溉');
INSERT INTO `s_menu` VALUES ('10000000-0000-0000-0000-100000000000', '1', '10000000-0000-0000-0000-000000000000', '后台菜单', '/system/index/index', '1', 'flaticon-folder', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-01 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-01 17:38:06', '销售数据分销');
INSERT INTO `s_menu` VALUES ('10000000-0000-0000-0000-200000000000', '2', '10000000-0000-0000-0000-000000000000', '前台菜单', '/home/index', '1', 'flaticon-folder', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-01 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:42:34', '销售数据分销');
INSERT INTO `s_menu` VALUES ('10000000-0000-0000-0000-300000000000', '3', '10000000-0000-0000-0000-000000000000', '微信菜单', '/wechat/index/main', '1', 'flaticon-folder', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-01 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-01 17:38:06', '销售数据分销');
INSERT INTO `s_menu` VALUES ('162e38d7-5b27-488b-9776-e60d7aa07b68', '2', '0bc54201-f2e3-4585-a9c7-bb5d9b44e26d', '溯源设置', '/system/originSet/list', null, 'flaticon-set', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:35:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 11:06:09', '溯源相关信息设置');
INSERT INTO `s_menu` VALUES ('1dfa1ebf-5e50-4976-90b8-290bcea2e057', '10', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '包装', '/system/packaing/list', null, 'flaticon-package', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:36:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 19:06:25', '加工工序-包装');
INSERT INTO `s_menu` VALUES ('20692517-9187-41df-920b-7c7342a93d37', '3', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '字典管理', '/system/dictionary/list', '1', 'flaticon-xxx', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-06 16:50:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-14 17:26:14', '字典信息管理');
INSERT INTO `s_menu` VALUES ('21136dca-a230-4902-b370-73cedbfd37d1', '9', '10000000-0000-0000-0000-100000000000', '设备管理', '/system/equipment/list', '1', 'flaticon-profile-1', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:19:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:44:10', '生产设备管理');
INSERT INTO `s_menu` VALUES ('2bb748c6-224b-4fff-a3c2-82b684faf56d', '4', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '揉捻', '/system/rolling/list', null, 'flaticon-rolling', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 17:12:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 16:00:17', '');
INSERT INTO `s_menu` VALUES ('2c68aa86-891b-4661-ba76-327e8a2a6215', '3', '0bc54201-f2e3-4585-a9c7-bb5d9b44e26d', '溯源信息', '/system/originInfo/list', null, 'flaticon-info', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:33:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-08 14:22:33', '溯源信息记录');
INSERT INTO `s_menu` VALUES ('2dc7b0aa-e46e-4583-9738-72e71de1426c', '2', 'b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '管理批次', '/system/manageBatch/list', null, 'flaticon-batch', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 21:52:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 00:23:00', '茶园批次号生成');
INSERT INTO `s_menu` VALUES ('2fe964ba-f060-47cf-8c81-fcd0ba615d63', '1', '10000000-0000-0000-0000-200000000000', '首页', '/index/main', null, 'flaticon-home', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:43:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 15:59:18', '前台菜单啊');
INSERT INTO `s_menu` VALUES ('33fb6e82-2b8b-48fb-af3c-fb886049ca77', '5', '10000000-0000-0000-0000-100000000000', '加工管理', '/system/teaMachin/list', '1', 'flaticon-network', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 23:48:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 22:13:01', '茶叶加工流程管理');
INSERT INTO `s_menu` VALUES ('3631e59e-1175-11e5-a9de-000c29d7a3a0', '3', '10000000-0000-0000-0000-100000000000', '客户管理', '/system/ucenter/index', '1', 'flaticon-users', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:25:39', '供应链管理');
INSERT INTO `s_menu` VALUES ('37a082cd-0e38-49f8-b6f1-fc26e05383cc', '4', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '施肥', '/system/teaLog/fertilizer', null, 'flaticon-fertilizer', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:51:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 17:55:21', '');
INSERT INTO `s_menu` VALUES ('3dacb910-a325-4939-aec5-f1e05218513c', '3', '91d81894-dca3-4738-a408-77d23108a710', '产品标签', '/system/tags/list', null, 'flaticon-tags', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 22:31:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-30 23:29:44', '商品标签管理-折扣-优惠-降价-等');
INSERT INTO `s_menu` VALUES ('41220884-50a6-4204-8168-f8e3eb5ad2ce', '2', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '萎凋', '/system/wither/list', null, 'flaticon-wither', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 17:10:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 09:36:55', '加工步骤2');
INSERT INTO `s_menu` VALUES ('43d5b520-eafe-4f7f-a846-4fba12c9ffab', '4', '10000000-0000-0000-0000-200000000000', '溯源查询', '/index/traceQuery', null, 'flaticon-trace', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:47:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-09 19:07:38', '溯源');
INSERT INTO `s_menu` VALUES ('514111b1-1e3d-472f-8f47-02ae0bae13e9', '2', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', '出库记录', '/system/finishedOut/list', null, 'flaticon-finishedOut', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:22:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-08 16:48:34', '成品出库记录');
INSERT INTO `s_menu` VALUES ('55638077-269d-41fc-981e-d6f8eeaee8f3', '6', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '炒干', '/system/dryTea/list', null, 'flaticon-dry', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 17:13:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 16:00:40', '炒干');
INSERT INTO `s_menu` VALUES ('55f9ecb5-b899-4321-952f-64a1f579d2c2', '2', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '耕地', '/system/teaLog/plough', null, 'flaticon-plough', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:48:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 17:55:05', '耕地');
INSERT INTO `s_menu` VALUES ('5863e4f5-927d-4c96-8bda-2294703bc909', '1', '91d81894-dca3-4738-a408-77d23108a710', '产品设置', '/system/productSet/list', null, 'flaticon-inven', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:10:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-31 11:50:35', '商品类别管理');
INSERT INTO `s_menu` VALUES ('5903d97e-84bc-4a0b-b45b-0b61acd2d238', '5', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '发酵', '/system/fermentation/list', null, 'flaticon-fermentation', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 17:13:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 16:00:28', '');
INSERT INTO `s_menu` VALUES ('5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '1', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '鲜叶', '/system/harvest/list', null, 'flaticon-pick', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 16:11:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-22 09:34:40', '鲜叶采摘');
INSERT INTO `s_menu` VALUES ('5af24cc1-0a73-4f28-8972-dae2f138c1a8', '3', 'b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '茶园日志', '/system/teaLog/list', '1', 'flaticon-app-1', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 23:44:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 21:54:27', '记录茶园操作日志');
INSERT INTO `s_menu` VALUES ('66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '9', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '提香', '/system/titian/list', null, 'flaticon-titian', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:41:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 16:01:11', '提香');
INSERT INTO `s_menu` VALUES ('682cc88a-5424-4f14-8298-bf19a8c1a726', '3', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '杀青', '/system/killOut/list', null, 'flaticon-killOut', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 17:11:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 10:52:49', '加工步骤3');
INSERT INTO `s_menu` VALUES ('68522995-30dc-4fb0-97d8-7468e6af4853', '2', '10000000-0000-0000-0000-200000000000', '产品库', '/index/products', null, 'flaticon-products', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:44:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 15:48:04', '商品展示产品库');
INSERT INTO `s_menu` VALUES ('6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '1', 'f5baa02f-7e39-421f-a7dd-c8ee4773966b', '质检记录', '/system/quality/list', null, 'flaticon-process', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:17:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-04 11:40:34', '质检记录管理');
INSERT INTO `s_menu` VALUES ('76849bfe-dfd4-476c-b2f8-11072c25ceb8', '1', 'b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '茶园信息', '/system/origin/teaGarden', '1', 'flaticon-list-3', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:41:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 23:40:03', '茶园信息管理');
INSERT INTO `s_menu` VALUES ('86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '6', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '治虫', '/system/teaLog/insecticide', null, 'flaticon-insecticide', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:53:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 17:55:42', '病虫害防治');
INSERT INTO `s_menu` VALUES ('8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '5', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '除草', '/system/teaLog/weeding', null, 'flaticon-weeding', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:52:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 17:55:34', '');
INSERT INTO `s_menu` VALUES ('90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '8', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '复炒', '/system/roasting/list', null, 'flaticon-roasting', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:40:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 16:01:00', '复火');
INSERT INTO `s_menu` VALUES ('91d81894-dca3-4738-a408-77d23108a710', '2', 'dd6448d3-ade1-40c3-9043-a77c3036f829', '产品管理', '/system/products/list', null, 'flaticon-products', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 22:34:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-28 23:25:06', '产品管理');
INSERT INTO `s_menu` VALUES ('97ea6edb-1178-11e5-a9de-000c29d7a3a0', '7', '10000000-0000-0000-0000-100000000000', '财务管理', '/system/demand/index', '1', 'flaticon-coins', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '财务结算中心');
INSERT INTO `s_menu` VALUES ('9d377b71-bd84-47b6-a4f3-c08a24703b08', '2', 'f5baa02f-7e39-421f-a7dd-c8ee4773966b', '质检设置', '/system/qualitySet/list', null, 'flaticon-qualitySet', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 17:45:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:23:48', '质检设置');
INSERT INTO `s_menu` VALUES ('9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '1', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', '成品出库', '/system/finishedIn/list', null, 'flaticon-finIn', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:22:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-08 16:48:24', '包装好的产品入库记录');
INSERT INTO `s_menu` VALUES ('b17105b9-8da9-47b7-a4b1-7dbcfa60d250', '1', '68522995-30dc-4fb0-97d8-7468e6af4853', '产品二级', '/index/products/list', null, 'flaticon-location', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:37:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 15:48:13', '产品二级');
INSERT INTO `s_menu` VALUES ('b246e414-5c86-468e-81e0-0edf77710e3f', '3', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '种植', '/system/teaLog/seed', null, 'flaticon-seed', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-14 13:50:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-19 17:55:14', '播种');
INSERT INTO `s_menu` VALUES ('b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '4', '10000000-0000-0000-0000-100000000000', '茶园管理', '/system/origin/teaGarden', '1', 'flaticon-tea-cup', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:31:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 23:40:26', '茶园管理模块');
INSERT INTO `s_menu` VALUES ('baf74d02-a7fa-41cf-a7c6-d1e5da805701', '1', '0bc54201-f2e3-4585-a9c7-bb5d9b44e26d', '溯源批次', '/system/originBatch/list', null, 'flaticon-orginb', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-06 17:45:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-08 14:22:24', '按批次生成溯源编号,提供溯源使用');
INSERT INTO `s_menu` VALUES ('bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '7', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '筛选', '/system/filtrate/list', null, 'flaticon-filtrate', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:39:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-26 16:00:49', '茶叶加工工序，筛选茶叶');
INSERT INTO `s_menu` VALUES ('c3538d54-8e09-11e6-b311-005056812bf6', '10', '10000000-0000-0000-0000-100000000000', '订单管理', '/system/operation/index', '1', 'flaticon-truck', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '跨境物流管理');
INSERT INTO `s_menu` VALUES ('caa095d9-c2b9-45d9-89b1-3b75315c9940', '0', 'dd6448d3-ade1-40c3-9043-a77c3036f829', '半成品库', '/system/semiFinished/list', null, 'flaticon-semi', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-28 23:17:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:28', '半成品管理');
INSERT INTO `s_menu` VALUES ('caf65c04-beed-11e7-959c-38d547b81379', '1', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '菜单管理', '/system/menu/list', '1', 'flaticon-app', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '菜单信息管理');
INSERT INTO `s_menu` VALUES ('ce43305b-a658-4e8c-b864-10b6ee797429', '2', '91d81894-dca3-4738-a408-77d23108a710', '包材管理', '/system/package/list', null, 'flaticon-mate', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:13:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 17:15:44', '包材材料管理');
INSERT INTO `s_menu` VALUES ('d07687ef-2798-11e5-965c-000c29d7a3a0', '1', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '门店管理', '/system/store/list', '1', 'flaticon-map', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:40:48', '个人中心、会员中心');
INSERT INTO `s_menu` VALUES ('d2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '4', '21136dca-a230-4902-b370-73cedbfd37d1', '维护清洁', '/system/maintain/list', null, 'flaticon-main', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:22:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 09:51:09', '设备保养记录');
INSERT INTO `s_menu` VALUES ('d6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '3', '33fb6e82-2b8b-48fb-af3c-fb886049ca77', '茶叶加工', '/system/machinTea/list', null, 'flaticon-machin-tea', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 21:19:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 21:54:31', '茶叶加工工序');
INSERT INTO `s_menu` VALUES ('d942abc1-b177-452e-8c53-1914ac448c7d', '4', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '角色菜单', '/system/roleMenu/list', '1', 'flaticon-menu', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-08 17:50:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-08 17:53:27', '角色菜单设置');
INSERT INTO `s_menu` VALUES ('dd6448d3-ade1-40c3-9043-a77c3036f829', '2', '10000000-0000-0000-0000-100000000000', '库存管理', '/system/stockManager/list', '1', 'flaticon-open-box', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:04:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 22:14:32', '库存信息管理');
INSERT INTO `s_menu` VALUES ('ded1d6eb-2c41-407e-9a3e-bf3615ced9ff', '3', '10000000-0000-0000-0000-200000000000', '关于我们', '/index/about', null, 'flaticon-aboutus', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:46:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 16:01:44', '企业介绍');
INSERT INTO `s_menu` VALUES ('df1a659b-180f-4fd2-abb0-b42c7db62714', '1', '33fb6e82-2b8b-48fb-af3c-fb886049ca77', '加工设置', '/system/machinSet/list', null, 'flaticon-machin', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:03:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 21:17:26', '加工的事情');
INSERT INTO `s_menu` VALUES ('e38ab74b-bf14-11e7-a301-24fd52935962', '2', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '角色管理', '/system/roles/list', '1', 'flaticon-profile', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-21 17:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-01 22:56:49', '角色信息管理');
INSERT INTO `s_menu` VALUES ('f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', '1', 'dd6448d3-ade1-40c3-9043-a77c3036f829', '成品仓库', '/system/finished/list', null, 'flaticon-comm', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-29 22:36:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-28 23:24:59', '成品仓库');
INSERT INTO `s_menu` VALUES ('f5baa02f-7e39-421f-a7dd-c8ee4773966b', '6', '10000000-0000-0000-0000-100000000000', '质检管理', '/system/quality/list', '1', 'flaticon-notes', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:15:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:43:25', '产品质量管理');
INSERT INTO `s_menu` VALUES ('fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '1', '21136dca-a230-4902-b370-73cedbfd37d1', '设备信息', '/system/equipment/list', null, 'flaticon-equipment', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:51:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 21:51:30', '设备信息管理');

-- ----------------------------
-- Table structure for s_page_role
-- ----------------------------
DROP TABLE IF EXISTS `s_page_role`;
CREATE TABLE `s_page_role` (
  `id` varchar(36) NOT NULL,
  `menu_id` varchar(36) DEFAULT NULL COMMENT '菜单编号',
  `role_id` varchar(36) DEFAULT NULL COMMENT '角色编号',
  `dict_id` varchar(36) DEFAULT NULL COMMENT '字典编号',
  `status` int(1) NOT NULL DEFAULT '1',
  `create_id` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '最后一次修改ID',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_page_role
-- ----------------------------
INSERT INTO `s_page_role` VALUES ('000c3753-3445-4b1f-947c-f063bb3cab83', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:39');
INSERT INTO `s_page_role` VALUES ('00170715-3203-4453-b2b8-701796e92b0b', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:43');
INSERT INTO `s_page_role` VALUES ('00b8596c-480e-4325-ae5b-9d934e0ffb69', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:08');
INSERT INTO `s_page_role` VALUES ('00ef57ba-cc4f-462b-bbd7-7e228817d350', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:33');
INSERT INTO `s_page_role` VALUES ('018d80b7-75b8-49a7-accd-0a9d4c939991', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:09');
INSERT INTO `s_page_role` VALUES ('018f092d-f147-44cc-af41-06f687e79d58', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:13');
INSERT INTO `s_page_role` VALUES ('01a2b657-d61e-43dd-8fd7-594f315add45', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:50');
INSERT INTO `s_page_role` VALUES ('01d6af40-b865-4bba-8fca-c0d3090f2338', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:07');
INSERT INTO `s_page_role` VALUES ('020e0cea-5869-480e-b77d-c20980e679ab', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:49');
INSERT INTO `s_page_role` VALUES ('021b1a8e-808b-4786-8a67-e9962d861c72', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:06');
INSERT INTO `s_page_role` VALUES ('0262f391-99ed-4392-ae0b-01b029f31776', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:52');
INSERT INTO `s_page_role` VALUES ('0267c15c-7187-4b70-9a64-8964c146439a', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:53');
INSERT INTO `s_page_role` VALUES ('02a6beac-c132-4c68-8618-0a3602803cb0', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:29');
INSERT INTO `s_page_role` VALUES ('031e42f9-a682-45f4-a3c8-40b2174e1458', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:27');
INSERT INTO `s_page_role` VALUES ('03e64459-27ad-47eb-ac06-260e5a5f109a', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:11');
INSERT INTO `s_page_role` VALUES ('03f72f42-ce60-4bdc-9c33-9a25827d8eb4', '20692517-9187-41df-920b-7c7342a93d37', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:47');
INSERT INTO `s_page_role` VALUES ('046db5f9-9fcc-4bf3-b18c-8f2dfbeb3e92', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:16');
INSERT INTO `s_page_role` VALUES ('04f7dbe2-75fe-4e14-b267-c7ae859c5987', 'e38ab74b-bf14-11e7-a301-24fd52935962', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:54');
INSERT INTO `s_page_role` VALUES ('050f980e-6673-4476-9073-a29b5298100a', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:30');
INSERT INTO `s_page_role` VALUES ('05154a53-c1bf-437b-a7ed-a354b46cc48f', '3dacb910-a325-4939-aec5-f1e05218513c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:43');
INSERT INTO `s_page_role` VALUES ('051c7747-7236-444e-8bfa-d1885be4d86f', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:30');
INSERT INTO `s_page_role` VALUES ('05405f97-b1de-456f-89c3-c6126a629c71', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:32');
INSERT INTO `s_page_role` VALUES ('05b81bd7-f77b-47e0-953b-94f4fdb97d7c', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:28');
INSERT INTO `s_page_role` VALUES ('05c35d50-cf2a-42e2-8f38-ec0f26d0f20f', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:42');
INSERT INTO `s_page_role` VALUES ('05d22852-2840-4157-8ca5-c781bf963b2f', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:54');
INSERT INTO `s_page_role` VALUES ('05dcc6dd-e3c4-43b8-9e48-4519ee5b1535', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:09');
INSERT INTO `s_page_role` VALUES ('05decbae-95d0-49a8-9547-1685c4b3b789', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:30');
INSERT INTO `s_page_role` VALUES ('05dfa761-8ff9-4f0c-b47f-4574e9327ebb', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:41');
INSERT INTO `s_page_role` VALUES ('05e0ef0a-bf82-4fa7-af9a-ca6ba4362a98', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:15');
INSERT INTO `s_page_role` VALUES ('0671c676-ab4e-416a-a5fa-dcb70a3844dd', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:42');
INSERT INTO `s_page_role` VALUES ('0681f4e8-c32d-43cb-8f77-dfb73af5a1bd', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:51');
INSERT INTO `s_page_role` VALUES ('06a3a4aa-f199-4ea3-9b7d-3aa12a4834ba', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:11');
INSERT INTO `s_page_role` VALUES ('070a3ae2-c29a-4a60-976e-89915c498bad', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:41');
INSERT INTO `s_page_role` VALUES ('079bb545-ab4b-4ccc-a5cf-6029ccc35b11', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:03');
INSERT INTO `s_page_role` VALUES ('07b89c9a-69ab-46f1-ae91-60eb6c0c71b4', 'e38ab74b-bf14-11e7-a301-24fd52935962', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:42');
INSERT INTO `s_page_role` VALUES ('07f116c6-0264-48b7-b55c-f90aeba41f13', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:32');
INSERT INTO `s_page_role` VALUES ('08082911-41da-4483-8708-3a78c37ca5a7', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:07');
INSERT INTO `s_page_role` VALUES ('08560792-242f-419e-886b-ef54f741d4c6', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:10');
INSERT INTO `s_page_role` VALUES ('086e7116-22ca-4a52-88cf-1d63f6b12c99', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:40:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:40:00');
INSERT INTO `s_page_role` VALUES ('0884e847-bac3-4fe0-8196-f8da4e0e23cb', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:22');
INSERT INTO `s_page_role` VALUES ('0886faee-a9b6-43c7-82b3-d9db17339733', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:08');
INSERT INTO `s_page_role` VALUES ('089aa77d-0666-4b0d-90d1-6e3061d248f6', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:56');
INSERT INTO `s_page_role` VALUES ('08c34ee1-d730-4620-8d87-9a73c78d4015', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:47');
INSERT INTO `s_page_role` VALUES ('08c75f2e-9c36-4852-88fc-07d95567f2da', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:21');
INSERT INTO `s_page_role` VALUES ('0900f05e-c23c-4ee8-9da4-2af42430c14d', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:46');
INSERT INTO `s_page_role` VALUES ('0910489b-1e70-4b89-bc86-aaf1e514e201', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:21');
INSERT INTO `s_page_role` VALUES ('0966f289-2a77-432b-ac4d-2693e8664c29', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:33');
INSERT INTO `s_page_role` VALUES ('09a734d0-aaf2-4069-a7aa-8b89cfbb2b45', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:17');
INSERT INTO `s_page_role` VALUES ('09f2075c-cf89-435a-8410-a3c0b510f040', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:10');
INSERT INTO `s_page_role` VALUES ('0a933c6d-8306-4aa6-ac2e-ff81a5b93384', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:27');
INSERT INTO `s_page_role` VALUES ('0b18242d-3d55-4106-89fe-837df798c566', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:40');
INSERT INTO `s_page_role` VALUES ('0b40e336-3cf0-409c-a9f8-2a21f1ff066b', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:37');
INSERT INTO `s_page_role` VALUES ('0b4fd787-7953-4c28-9ffc-dbf36f9e6aaa', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:14');
INSERT INTO `s_page_role` VALUES ('0b96df13-0b3f-4ee2-8525-d6cb33c9cf18', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:58');
INSERT INTO `s_page_role` VALUES ('0bc8599c-109c-4dfb-8ae8-5d5bf75af0f8', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:50');
INSERT INTO `s_page_role` VALUES ('0bdd164f-3a72-47d7-be92-3ef6b52e1965', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:20');
INSERT INTO `s_page_role` VALUES ('0bfa53f6-f542-4612-8370-f1497f1f83c7', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:14');
INSERT INTO `s_page_role` VALUES ('0c16130d-c208-4098-9a5e-b701f3faf3ed', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:06');
INSERT INTO `s_page_role` VALUES ('0d6925a7-dce4-4b22-b982-6d7e1172b5cb', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:37');
INSERT INTO `s_page_role` VALUES ('0d76899a-bb82-4a78-9e42-006f0af8e5f8', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:15');
INSERT INTO `s_page_role` VALUES ('0f2a0bf0-2c97-487f-bdfb-ec04f90231f9', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:44');
INSERT INTO `s_page_role` VALUES ('0f38495b-c1c8-45f5-9d7b-0de05ac4c1a8', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:21');
INSERT INTO `s_page_role` VALUES ('0f59692e-6a36-4d79-8e57-9f4aeb1211a7', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:15');
INSERT INTO `s_page_role` VALUES ('0f598a96-20bf-4a1c-9446-5ff24346233b', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:42');
INSERT INTO `s_page_role` VALUES ('0f93d0c3-01aa-4d73-af44-dcf67415148e', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:04');
INSERT INTO `s_page_role` VALUES ('0fc60874-4391-401a-ae11-0dd8c1991a40', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:59');
INSERT INTO `s_page_role` VALUES ('0ffdc442-2544-4fe5-bbd4-5245f1f88394', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:31');
INSERT INTO `s_page_role` VALUES ('104c0e47-5b5f-4882-a8ca-617daa602259', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:35');
INSERT INTO `s_page_role` VALUES ('10580e68-9c91-4361-aa47-a566abd97054', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:16');
INSERT INTO `s_page_role` VALUES ('108beb2d-5753-418c-8af4-dea3a5da1fa9', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:57');
INSERT INTO `s_page_role` VALUES ('10970df2-24fd-4c14-b6b7-3d2f1a0fde16', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:00');
INSERT INTO `s_page_role` VALUES ('10d07dc3-f608-4a98-a566-619956b99397', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:28');
INSERT INTO `s_page_role` VALUES ('114ff618-a9dd-43d7-a231-360fd433251a', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:55');
INSERT INTO `s_page_role` VALUES ('11563fae-e17e-4d8a-9437-0f8731f18f90', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:28');
INSERT INTO `s_page_role` VALUES ('11aca6e2-509a-48db-bfdf-97db57c164ed', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:43');
INSERT INTO `s_page_role` VALUES ('11dda1a0-e145-44c3-9209-bb4994ba58d7', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:10');
INSERT INTO `s_page_role` VALUES ('1258e783-7541-4376-8474-398a1cbbd09c', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:20');
INSERT INTO `s_page_role` VALUES ('125cd21d-8b42-4852-977a-8edf9d185793', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:11');
INSERT INTO `s_page_role` VALUES ('137583f9-cb0e-4724-b583-7888b0e4b800', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:33');
INSERT INTO `s_page_role` VALUES ('13d133cc-6a17-4986-8613-dcd3b25b31bf', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:16');
INSERT INTO `s_page_role` VALUES ('13d15112-19f3-423f-b932-ed1d57da1057', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:45');
INSERT INTO `s_page_role` VALUES ('1450b9c0-5e41-41ae-9861-66d60043dd10', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:43');
INSERT INTO `s_page_role` VALUES ('149b1050-da5d-466b-bee8-fd97a1b5d4ff', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:43');
INSERT INTO `s_page_role` VALUES ('14a2a083-74be-4d82-a881-93494f686092', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:31');
INSERT INTO `s_page_role` VALUES ('14e35dda-54f3-4e70-801f-205f0985664e', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:22');
INSERT INTO `s_page_role` VALUES ('14fe8a7b-95e1-4a3b-89a3-a6e355f2d923', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:18');
INSERT INTO `s_page_role` VALUES ('15499398-6087-43ba-9dea-e358d85382ce', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:24');
INSERT INTO `s_page_role` VALUES ('15952912-9ed9-4e14-b15d-7121559b6ff6', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:25');
INSERT INTO `s_page_role` VALUES ('15e4ed05-e4be-4591-86da-8c3b76551ccc', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:19');
INSERT INTO `s_page_role` VALUES ('15ff7864-cf8f-4240-b3d0-7e3acfa62bee', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:12');
INSERT INTO `s_page_role` VALUES ('160420cb-4596-49be-a232-bb4bacfd4ca9', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:07');
INSERT INTO `s_page_role` VALUES ('169a290d-0b83-4fef-bc3c-21ff0c2f58ed', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:39');
INSERT INTO `s_page_role` VALUES ('16cd41ca-a527-4b52-9c75-ca3b9c0d0b11', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:48');
INSERT INTO `s_page_role` VALUES ('1700443e-81b5-4552-b236-09f4f2f67778', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:17');
INSERT INTO `s_page_role` VALUES ('172bd959-07dc-4745-bed7-43c35f67e388', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:27');
INSERT INTO `s_page_role` VALUES ('17f2a41e-4a78-454e-b2ee-021ab8b3cdeb', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:26');
INSERT INTO `s_page_role` VALUES ('187efd35-7f55-4982-99f1-45d3d62df08a', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:00');
INSERT INTO `s_page_role` VALUES ('1889d39c-a7f3-42e4-b407-f3d38523b71c', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:49');
INSERT INTO `s_page_role` VALUES ('18b73917-592f-421e-80eb-277715ac405b', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:39');
INSERT INTO `s_page_role` VALUES ('18e92188-b33e-4f97-99cf-70b299bfd21d', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:38');
INSERT INTO `s_page_role` VALUES ('18f669b3-5645-42c1-a958-2fd0b06fdfdd', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:36');
INSERT INTO `s_page_role` VALUES ('19003c8f-4770-4819-8d4a-655ecee41fac', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:19');
INSERT INTO `s_page_role` VALUES ('190e1727-c2f0-4e17-9898-64264c2efac3', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:24');
INSERT INTO `s_page_role` VALUES ('1951a365-820c-44bc-8c6e-bb2a0042310b', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:28');
INSERT INTO `s_page_role` VALUES ('1966f8fd-41e9-4bfe-9d04-815b03f8fe8b', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:54');
INSERT INTO `s_page_role` VALUES ('1998ec45-da35-430a-b51d-49833b8d8554', '96e55b56-ab35-4774-a248-14a683a932e7', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:31');
INSERT INTO `s_page_role` VALUES ('19da2c7e-1755-4b92-b9aa-8cf812c44f31', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:26');
INSERT INTO `s_page_role` VALUES ('1a042f42-52bc-428a-9c82-8b89b10158e2', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:42');
INSERT INTO `s_page_role` VALUES ('1a424e01-afd2-41f7-b4a9-e4255d1ab5d2', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:20');
INSERT INTO `s_page_role` VALUES ('1a773f13-6816-4723-b4ca-ed2711b9c94c', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:44');
INSERT INTO `s_page_role` VALUES ('1acc1713-4cd9-447f-8baf-66b0b085ef56', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:29');
INSERT INTO `s_page_role` VALUES ('1b29a6cc-abb3-471f-a97b-646289e801c2', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:18:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:18:59');
INSERT INTO `s_page_role` VALUES ('1b953e40-3743-4c1d-9288-10a3fe2b187b', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:42');
INSERT INTO `s_page_role` VALUES ('1c044901-49e8-4742-b573-331e4a185f8f', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:33');
INSERT INTO `s_page_role` VALUES ('1c28bd4a-9a3d-469b-ad40-4825bc9d9406', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:43');
INSERT INTO `s_page_role` VALUES ('1c409ff6-6e7f-410c-ac5c-e14c9221cc08', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:53');
INSERT INTO `s_page_role` VALUES ('1c4ce6a2-7451-41fa-9601-47b11e54632c', '2fe964ba-f060-47cf-8c81-fcd0ba615d63', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:13');
INSERT INTO `s_page_role` VALUES ('1c991fe6-82aa-47ce-96d9-24cbbb3c719a', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:56');
INSERT INTO `s_page_role` VALUES ('1cbee5de-b6ea-4205-83a5-640b96c51df0', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:35');
INSERT INTO `s_page_role` VALUES ('1d0afc74-718d-41fe-98c1-244584504f23', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:17');
INSERT INTO `s_page_role` VALUES ('1dc171eb-8be9-4fe7-bcf7-49d60ee548f1', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:39');
INSERT INTO `s_page_role` VALUES ('1dc9564c-1704-4d4a-a1e8-51781220fca9', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:58');
INSERT INTO `s_page_role` VALUES ('1f39bcb6-0eb2-438a-9a03-44381444131f', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:11');
INSERT INTO `s_page_role` VALUES ('1f704ca2-0c0f-4505-accc-560ad90d7f30', 'e38ab74b-bf14-11e7-a301-24fd52935962', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:52');
INSERT INTO `s_page_role` VALUES ('20059880-b540-48bf-9817-7522aeb52da0', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:28');
INSERT INTO `s_page_role` VALUES ('205cc0d5-92c6-4b80-a9b4-b6cfa77d9097', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:27');
INSERT INTO `s_page_role` VALUES ('20e6816d-bb56-4ef1-a38a-cf447067a109', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:18');
INSERT INTO `s_page_role` VALUES ('20f52423-ac16-4667-b496-5f86c311fca2', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:57');
INSERT INTO `s_page_role` VALUES ('21135d89-fd12-4ae1-891d-d8bfa5531a20', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:28');
INSERT INTO `s_page_role` VALUES ('21b3a6af-8f8b-48bc-b26c-be7af9068569', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:45');
INSERT INTO `s_page_role` VALUES ('21dfce96-3de1-4abe-8e6d-c2496b2b2a75', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:57');
INSERT INTO `s_page_role` VALUES ('22763968-69ab-4e76-9cbb-f2ed9a99381f', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:45');
INSERT INTO `s_page_role` VALUES ('228bae69-57f5-42ef-b01d-b45a67a250ef', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:38');
INSERT INTO `s_page_role` VALUES ('22b5837d-166f-4492-b08a-95dcab49285d', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:35');
INSERT INTO `s_page_role` VALUES ('23225876-695c-485d-b5de-c795f18fb2bd', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:49');
INSERT INTO `s_page_role` VALUES ('23471436-c039-451c-9917-4ff01d3f362e', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:10');
INSERT INTO `s_page_role` VALUES ('234c618e-706e-4c71-bf0a-c48d3fb49ed8', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:41');
INSERT INTO `s_page_role` VALUES ('2361473b-1880-43a5-85f8-463f4725c1ee', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:18');
INSERT INTO `s_page_role` VALUES ('236f9592-e818-483c-a2f1-eefe78c71e09', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:28');
INSERT INTO `s_page_role` VALUES ('2373c355-3aa6-4152-9f10-c8659c643ae9', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:56');
INSERT INTO `s_page_role` VALUES ('23869671-d585-4737-b327-5020dc4cf4b0', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:11');
INSERT INTO `s_page_role` VALUES ('239ce705-b2e6-48ee-af7a-2ce948c2037b', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:01');
INSERT INTO `s_page_role` VALUES ('23d5a8b9-fddb-47c1-9209-ab1d90fb3614', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:35');
INSERT INTO `s_page_role` VALUES ('23d7357c-93ad-4922-84e8-3409d9c9cd89', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:20');
INSERT INTO `s_page_role` VALUES ('23d77148-cca0-41bc-bdf5-242b5a0a0ec2', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:04');
INSERT INTO `s_page_role` VALUES ('23eeb913-5577-4559-b40f-32be21fede66', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:47');
INSERT INTO `s_page_role` VALUES ('23f4f3f6-1e18-4fe6-acd4-f5a61daa0739', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:58');
INSERT INTO `s_page_role` VALUES ('241c44a4-6703-4de6-972f-4eebbfd8c066', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:04');
INSERT INTO `s_page_role` VALUES ('2435ceec-0b60-4b7d-bb0f-af0d3f43267e', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:25');
INSERT INTO `s_page_role` VALUES ('24479de4-b8ed-4145-813b-b51194f2c4ef', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:27');
INSERT INTO `s_page_role` VALUES ('24724370-ffce-4f15-bde9-17d35aeb5028', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:12');
INSERT INTO `s_page_role` VALUES ('24f0c721-7a9e-4724-a95f-e80920648a12', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:06');
INSERT INTO `s_page_role` VALUES ('253630cd-15e8-4fbd-928c-75d1912a9f15', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:46');
INSERT INTO `s_page_role` VALUES ('255226d3-4859-4a4f-b418-6ccf45b7ee85', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:18');
INSERT INTO `s_page_role` VALUES ('256be1ce-820e-4bf3-8598-e508a2d47654', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:41');
INSERT INTO `s_page_role` VALUES ('25c185dc-ef94-46b2-9070-1df4b5467ce0', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:15');
INSERT INTO `s_page_role` VALUES ('2617269c-61df-4ac8-856d-0f5f3fe84145', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:15');
INSERT INTO `s_page_role` VALUES ('261977f2-c999-4a49-9030-1de757d6d6b7', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:42');
INSERT INTO `s_page_role` VALUES ('26d5d2cf-9651-4e28-bbb1-5aae8b6c2330', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:00');
INSERT INTO `s_page_role` VALUES ('274feb91-84f1-4b15-85cb-b697140f0469', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:53');
INSERT INTO `s_page_role` VALUES ('278bf696-beab-47d1-b22e-b95493436093', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:30');
INSERT INTO `s_page_role` VALUES ('27e07c7c-cabc-48d7-9252-d0872966d9dd', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:16');
INSERT INTO `s_page_role` VALUES ('288ab00e-1a18-4f74-8fec-350643d2a4f3', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:20');
INSERT INTO `s_page_role` VALUES ('28ad7e26-09c2-4c51-b22d-c2cdfd8708ec', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:10');
INSERT INTO `s_page_role` VALUES ('28c0154c-a2f8-41fe-9a54-688ca6575a16', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:27');
INSERT INTO `s_page_role` VALUES ('2902fc4a-e5fc-4cd4-bfa4-c583262430d0', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:25');
INSERT INTO `s_page_role` VALUES ('29480c54-0ad9-4b90-920d-9747b1e247f7', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:19');
INSERT INTO `s_page_role` VALUES ('29641d15-b587-438e-978e-2852c676964c', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:47');
INSERT INTO `s_page_role` VALUES ('2a13d74b-6712-4629-b225-6112c3374543', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:03');
INSERT INTO `s_page_role` VALUES ('2a380c44-d691-4f40-b2c5-ed569a8bfbba', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:13');
INSERT INTO `s_page_role` VALUES ('2a457139-8e97-4790-a731-be1e42496176', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:24');
INSERT INTO `s_page_role` VALUES ('2aa3d062-45b6-48fd-89a1-1357645862d3', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:29');
INSERT INTO `s_page_role` VALUES ('2ac18b3a-5838-40af-a876-b555d850ea75', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:24');
INSERT INTO `s_page_role` VALUES ('2ad5f1d1-8753-45f8-8b62-0b0590ba16d8', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:45');
INSERT INTO `s_page_role` VALUES ('2b2c03a5-cdb2-47d3-886e-1b64caf3c4b0', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:26');
INSERT INTO `s_page_role` VALUES ('2b3c1b46-db14-4205-b461-aa17c3560042', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:24');
INSERT INTO `s_page_role` VALUES ('2b6ff9de-a177-4ddc-a979-cc4407423c12', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:35');
INSERT INTO `s_page_role` VALUES ('2bdc16a0-fc52-434f-bf7c-e673fd1f1e52', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:03');
INSERT INTO `s_page_role` VALUES ('2bdec621-27ff-4094-b11a-a730b81d3abc', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:23');
INSERT INTO `s_page_role` VALUES ('2bf004d7-198d-4a35-88fa-82789149762f', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:44');
INSERT INTO `s_page_role` VALUES ('2bfa24dc-bd20-4da2-86ec-dca0818e954a', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:42');
INSERT INTO `s_page_role` VALUES ('2c7d7d8c-cda1-4840-9923-12977383f6ee', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:47');
INSERT INTO `s_page_role` VALUES ('2d39df8b-d63e-4612-9597-03fc83724bba', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:59');
INSERT INTO `s_page_role` VALUES ('2d609da5-91b6-4b8d-91af-8ef199b308ae', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:23');
INSERT INTO `s_page_role` VALUES ('2d750745-dc4d-403b-9563-8483778c7fbe', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:06');
INSERT INTO `s_page_role` VALUES ('2dba0b41-3ca1-402d-985c-e74328987517', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:26');
INSERT INTO `s_page_role` VALUES ('2dde30f7-63df-4c97-9d92-ab38819b802c', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:14');
INSERT INTO `s_page_role` VALUES ('2e0abeac-9a82-4db3-ad03-4e58b54a3a0b', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:00');
INSERT INTO `s_page_role` VALUES ('2e3623cf-7230-4cbc-b890-9dfae91f737e', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:08');
INSERT INTO `s_page_role` VALUES ('2e6efe4e-bff2-4c3e-ad5c-b9f0e515f45f', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:25');
INSERT INTO `s_page_role` VALUES ('2e8e8a7a-6979-49e7-b45e-a0905b254bec', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:45');
INSERT INTO `s_page_role` VALUES ('2e92839d-a676-49a3-b682-7a50c0781e91', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:03');
INSERT INTO `s_page_role` VALUES ('2f7875de-f016-49a4-9eb1-a1f46cf8e9be', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:07');
INSERT INTO `s_page_role` VALUES ('2fcadb4d-0cdb-4204-87cc-c2de00e403d5', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:35');
INSERT INTO `s_page_role` VALUES ('2fda3824-de97-4311-8829-074d790b8cfd', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:06');
INSERT INTO `s_page_role` VALUES ('301bf8a1-ac75-45f7-907c-15c735b67bd6', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:19');
INSERT INTO `s_page_role` VALUES ('30a385ac-f097-4326-a8f1-d05b7cdddcef', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:41');
INSERT INTO `s_page_role` VALUES ('31406f17-feb2-468a-9bfe-65fd26dcc432', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:50');
INSERT INTO `s_page_role` VALUES ('31fdf877-90c4-4599-8549-a85ac0479a24', 'caf65c04-beed-11e7-959c-38d547b81379', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:46');
INSERT INTO `s_page_role` VALUES ('32119401-0c36-4982-9bdf-e0af1c5467a0', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:19');
INSERT INTO `s_page_role` VALUES ('32e3195c-1a97-42a0-b0cc-e366efc8ab50', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:57');
INSERT INTO `s_page_role` VALUES ('32e683dc-2024-4b8e-804f-c2c98011e823', '5863e4f5-927d-4c96-8bda-2294703bc909', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:24');
INSERT INTO `s_page_role` VALUES ('32f3be37-e32f-490d-9f8c-70b49a229dc8', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:36');
INSERT INTO `s_page_role` VALUES ('331ecac1-e555-4ecb-8995-d51fff0445b4', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:19');
INSERT INTO `s_page_role` VALUES ('33734c49-46c6-4a04-a8c1-c2b58ecbd7ce', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:32');
INSERT INTO `s_page_role` VALUES ('34055e61-0f6a-4bc4-ba25-c785649389e0', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:30');
INSERT INTO `s_page_role` VALUES ('3495162c-8792-46fa-abbc-4cc7d0e1b1ad', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:36');
INSERT INTO `s_page_role` VALUES ('355efc0f-a08f-443e-96a4-02278e248424', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:16');
INSERT INTO `s_page_role` VALUES ('35a16f9f-665a-4988-9626-0827ee9886f1', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:15');
INSERT INTO `s_page_role` VALUES ('3651514f-4366-48e7-b28f-6e805fb929a9', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:30');
INSERT INTO `s_page_role` VALUES ('3734c391-5bc1-4ddb-a148-e5637b7766a4', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:45');
INSERT INTO `s_page_role` VALUES ('37470b66-ffa8-4695-b8a7-9a78f262cf45', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:21');
INSERT INTO `s_page_role` VALUES ('37aa4ed8-53af-4db2-9ccb-103f76f282cb', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:24');
INSERT INTO `s_page_role` VALUES ('37b4844b-88a5-4b5d-833a-2a1afe1b4f9f', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:09');
INSERT INTO `s_page_role` VALUES ('37b528c7-0484-4867-9278-ca110aa0c2f4', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:55');
INSERT INTO `s_page_role` VALUES ('38458ab3-cfa8-495a-8a76-290763e854af', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:05');
INSERT INTO `s_page_role` VALUES ('392faa66-314b-4c3a-b156-76128f42ac68', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:29');
INSERT INTO `s_page_role` VALUES ('3947f8b4-dee3-4088-a89f-d4eaae93a62a', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:43');
INSERT INTO `s_page_role` VALUES ('399df380-45da-4c41-9d75-786619976847', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:19');
INSERT INTO `s_page_role` VALUES ('39d3ce3a-6da5-4dd1-a1e2-b80d8a78a511', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:40:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:40:00');
INSERT INTO `s_page_role` VALUES ('3a01a28b-d07b-45cc-8de6-872c08c2e8fb', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:46');
INSERT INTO `s_page_role` VALUES ('3a19e8f4-99db-4ecc-89b3-a5012fcf857a', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:02');
INSERT INTO `s_page_role` VALUES ('3a1ec16c-f6c7-49e0-9882-e0338d544a14', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:26');
INSERT INTO `s_page_role` VALUES ('3a4a5c65-7b4a-43c9-bf39-4db4d613b40d', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:08');
INSERT INTO `s_page_role` VALUES ('3a6d6175-bcf4-457d-98e2-8082a72727a8', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:19');
INSERT INTO `s_page_role` VALUES ('3adbaf60-0261-441c-ab14-7084dc8e7aa4', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:12');
INSERT INTO `s_page_role` VALUES ('3b1e2541-b46b-4a8e-b2ad-3174823444ce', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:59');
INSERT INTO `s_page_role` VALUES ('3b7197d6-b7fe-49d6-a1ee-efa9a04aefce', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:05');
INSERT INTO `s_page_role` VALUES ('3bcc5051-33e4-4665-bc38-2a85988f5535', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:10');
INSERT INTO `s_page_role` VALUES ('3c2b087c-e8dd-4267-b9af-dd0de8444a25', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:09');
INSERT INTO `s_page_role` VALUES ('3c3fbb37-295b-43a7-afda-30be7d84caa0', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:43:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:43:18');
INSERT INTO `s_page_role` VALUES ('3c6f0783-e7eb-4cee-95c3-c30aa5f97994', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:54');
INSERT INTO `s_page_role` VALUES ('3c95e2c2-0b90-441c-98f1-33c421a1bd02', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:42');
INSERT INTO `s_page_role` VALUES ('3cb6a38d-69fa-49ab-91e9-0ec2aa43904a', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:47');
INSERT INTO `s_page_role` VALUES ('3cd0a350-87c4-4d39-82c2-220d370080ca', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:01');
INSERT INTO `s_page_role` VALUES ('3cf31f10-533f-4ada-95a3-113d42484949', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:13');
INSERT INTO `s_page_role` VALUES ('3d320af4-6b93-4578-b67a-c625825f5d16', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:03');
INSERT INTO `s_page_role` VALUES ('3d4fe85f-c9aa-4bf1-b8ea-1d1c12f26050', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:36');
INSERT INTO `s_page_role` VALUES ('3dac4381-7320-41ed-b1e2-e06be3ed3fb7', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:30');
INSERT INTO `s_page_role` VALUES ('3e4e38e0-86e0-4970-a023-1e2848061986', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:47');
INSERT INTO `s_page_role` VALUES ('3e6f0e26-bbf2-47fb-a4fd-accb5799e3c4', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:12');
INSERT INTO `s_page_role` VALUES ('3e886e92-39ae-4be2-a4ba-0e23c6876e38', '5863e4f5-927d-4c96-8bda-2294703bc909', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:19');
INSERT INTO `s_page_role` VALUES ('3ea537db-e7db-4f34-9503-f6da04910a41', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:33');
INSERT INTO `s_page_role` VALUES ('3ee4cc14-e369-4e44-bbf5-719d7388faa4', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:05');
INSERT INTO `s_page_role` VALUES ('3f9f5817-213f-4066-b200-a1da86cce2ca', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:54');
INSERT INTO `s_page_role` VALUES ('3fe0b3f5-57b4-423b-870b-e46ae09c28e1', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:18');
INSERT INTO `s_page_role` VALUES ('3fe73a27-dd67-4744-aea5-2662cddefbb9', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:34');
INSERT INTO `s_page_role` VALUES ('401d4983-756d-426a-9f78-08394d570906', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:23');
INSERT INTO `s_page_role` VALUES ('410bdf5c-fde7-4f90-8215-706f658ed106', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:29');
INSERT INTO `s_page_role` VALUES ('412666e8-9e76-4663-a5b5-9ba5579d19ba', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:55');
INSERT INTO `s_page_role` VALUES ('4132ebef-3031-4f54-88e8-8fcf81d01c16', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:37');
INSERT INTO `s_page_role` VALUES ('41a22638-9790-452d-bed2-7fac63e5c20c', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:24');
INSERT INTO `s_page_role` VALUES ('41f7fd35-9c23-4ee5-b637-633ddcc82686', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:25');
INSERT INTO `s_page_role` VALUES ('41fef48c-288b-4bcf-8709-feaf78bbe29f', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:31');
INSERT INTO `s_page_role` VALUES ('4260dfce-6cc7-46e4-a78e-b822c8dada51', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:41');
INSERT INTO `s_page_role` VALUES ('42689e20-54eb-4e55-b831-dfd14aa2fbca', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:27');
INSERT INTO `s_page_role` VALUES ('42ecb7d8-8c5f-4326-b3c4-15cabf5e62d2', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:38');
INSERT INTO `s_page_role` VALUES ('438cea26-3024-4297-95df-699860d22794', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:55');
INSERT INTO `s_page_role` VALUES ('442ae51d-4694-4e45-8c2d-c32a25709282', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:05');
INSERT INTO `s_page_role` VALUES ('4467681f-72d6-49c6-8ffe-7cfe090956b7', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:39');
INSERT INTO `s_page_role` VALUES ('44f5a7a8-3ea0-4f77-879f-6bae1dfefb85', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:58');
INSERT INTO `s_page_role` VALUES ('454d8dc1-7b3f-4518-922c-cf360e61198c', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:44');
INSERT INTO `s_page_role` VALUES ('4586099c-731d-443d-bdaa-5ba8735912bf', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:43');
INSERT INTO `s_page_role` VALUES ('45bcf3fa-ae77-477a-8957-1c108c93bd5e', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:37');
INSERT INTO `s_page_role` VALUES ('45c62a66-e0d5-4e06-8436-914e071ad77a', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:06');
INSERT INTO `s_page_role` VALUES ('469cacc7-5416-469a-9ba2-cafdd93de41f', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:09');
INSERT INTO `s_page_role` VALUES ('46f77cc0-4393-4836-8518-35b591c5efa1', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:03');
INSERT INTO `s_page_role` VALUES ('46fb21af-801e-470f-86d3-63d22d4c27bf', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:31');
INSERT INTO `s_page_role` VALUES ('47386a59-6929-492a-8220-7c078266a266', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:48');
INSERT INTO `s_page_role` VALUES ('475bca0b-3fcb-47c1-9ca8-7663e19cfeef', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:30');
INSERT INTO `s_page_role` VALUES ('477bb4b2-32ec-44f9-b50b-14730b17f35a', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:23');
INSERT INTO `s_page_role` VALUES ('47f676cd-a950-43ae-b283-e1b717389ba7', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:36');
INSERT INTO `s_page_role` VALUES ('48404075-a4b6-4535-ab73-293ea31d6ff2', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:30');
INSERT INTO `s_page_role` VALUES ('489d8d34-1d3b-40ef-8464-c6af22fc8fb7', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:18');
INSERT INTO `s_page_role` VALUES ('48ab7ac0-6e2e-4bd4-9810-321df43baf8a', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:12');
INSERT INTO `s_page_role` VALUES ('48c4f984-aff9-46ae-994b-26c38bfc978b', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:23');
INSERT INTO `s_page_role` VALUES ('48ff2ccc-54fb-4ac4-bb34-60eccfd39bac', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:56');
INSERT INTO `s_page_role` VALUES ('498222dc-8244-4d8f-8c11-c5e8e16ad0fd', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:08');
INSERT INTO `s_page_role` VALUES ('4988f8d5-3bc0-4461-b8ba-253b23055c1b', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:21');
INSERT INTO `s_page_role` VALUES ('49ae13c8-34f3-4d28-bf69-d1668221f932', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:31');
INSERT INTO `s_page_role` VALUES ('49fd0a38-e1be-4f45-a23e-c9ac8aaa7003', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:02');
INSERT INTO `s_page_role` VALUES ('4a151c30-5dc8-42f1-96ee-f46ee9878651', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:18');
INSERT INTO `s_page_role` VALUES ('4a77d431-44d8-434f-8caf-012269af0902', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:19');
INSERT INTO `s_page_role` VALUES ('4ab306fc-0236-420e-9a2f-848e8ab989db', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:10');
INSERT INTO `s_page_role` VALUES ('4ac88108-40aa-4282-bdc7-e83207ef7809', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:57');
INSERT INTO `s_page_role` VALUES ('4adcc32e-f949-4718-a252-269ecd951d09', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:28');
INSERT INTO `s_page_role` VALUES ('4adf1967-2e19-4364-9aa7-2d63e3f5a883', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:30');
INSERT INTO `s_page_role` VALUES ('4b33f178-b18e-4ee1-a75c-977b47a8d2a8', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:49');
INSERT INTO `s_page_role` VALUES ('4b343769-a959-4c7d-b548-a68a5cd1ab97', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:07');
INSERT INTO `s_page_role` VALUES ('4b526ffc-56fe-419c-ae45-b8b04c352642', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:45');
INSERT INTO `s_page_role` VALUES ('4b683deb-e1e8-450a-ac89-2f5be1cc4447', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:56');
INSERT INTO `s_page_role` VALUES ('4c417da8-02d4-4ce1-969b-a3d08955bf6e', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:28');
INSERT INTO `s_page_role` VALUES ('4cd19f13-d1de-4298-b1f9-7d8d3ca75c82', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:03');
INSERT INTO `s_page_role` VALUES ('4cd9a8f4-bdfc-4f2a-91fe-61d2c913e0b2', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:32');
INSERT INTO `s_page_role` VALUES ('4ce8abd0-801b-4008-9040-6863923a221c', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:13');
INSERT INTO `s_page_role` VALUES ('4cea74b0-1e61-426b-97a2-7c9759f0f259', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:22');
INSERT INTO `s_page_role` VALUES ('4d0eb641-2993-43fe-a89b-fe50d161ec5e', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:42');
INSERT INTO `s_page_role` VALUES ('4d1ef45c-0670-4f85-8b54-36d42284d2e6', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:41');
INSERT INTO `s_page_role` VALUES ('4d2aca6a-0599-44ab-9fc4-cb217b7b5b1e', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:09');
INSERT INTO `s_page_role` VALUES ('4d385715-c290-422d-b4a4-cb77848b2eb7', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:10');
INSERT INTO `s_page_role` VALUES ('4dbb6c9e-0c85-4b9a-ad00-769bf5d763da', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:05');
INSERT INTO `s_page_role` VALUES ('4e6703e3-abcc-4997-8af4-0fc8c271c932', 'd942abc1-b177-452e-8c53-1914ac448c7d', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:53');
INSERT INTO `s_page_role` VALUES ('4e8782f8-0802-46ce-8582-42159a407a63', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:06');
INSERT INTO `s_page_role` VALUES ('4f38061f-4500-44c3-a98d-7063e0d20df8', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:46');
INSERT INTO `s_page_role` VALUES ('4fea00b1-6bb9-46cd-85e1-36021fd7e12c', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:36');
INSERT INTO `s_page_role` VALUES ('5005558b-c6b5-4c91-81ef-3a65d6dd6aa1', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:15');
INSERT INTO `s_page_role` VALUES ('501340be-9ced-4a47-ad01-83321ae69665', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:23');
INSERT INTO `s_page_role` VALUES ('504de27f-d8b8-4fda-a268-d357f8d69e49', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:43');
INSERT INTO `s_page_role` VALUES ('504f7d76-542e-41f0-8911-b56a20fc8ec1', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:44');
INSERT INTO `s_page_role` VALUES ('5064b108-f4d6-4b2a-9b9e-ddab3876a87b', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:18');
INSERT INTO `s_page_role` VALUES ('5088c4f7-a792-4379-b83d-9e02b77349c8', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:37');
INSERT INTO `s_page_role` VALUES ('5099d0bd-e4e4-4d9c-a440-1942293d8982', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:40');
INSERT INTO `s_page_role` VALUES ('50c622c4-a09a-47d8-8a40-3a81a6417a90', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:57');
INSERT INTO `s_page_role` VALUES ('50e5efd6-d926-41b4-9ff8-7b5c22304765', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:19');
INSERT INTO `s_page_role` VALUES ('50e6ef34-f4e1-4ec3-b8f5-395afece9a19', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:27');
INSERT INTO `s_page_role` VALUES ('51282b02-26da-4b6f-b8ea-ac53ed4653f2', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:37');
INSERT INTO `s_page_role` VALUES ('5147ce21-5fd9-4afc-a449-b9acd398a347', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:03');
INSERT INTO `s_page_role` VALUES ('516d24c7-87f1-47d8-8e01-df28aaebc30a', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:10');
INSERT INTO `s_page_role` VALUES ('51c54f93-c553-4245-b485-3d4df7580d40', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:38');
INSERT INTO `s_page_role` VALUES ('51c67c7f-3404-4619-9f97-f5dc041a6d03', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:53');
INSERT INTO `s_page_role` VALUES ('5214e2a5-ba60-448a-941d-fe882112e601', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:06');
INSERT INTO `s_page_role` VALUES ('522ad1f5-c7b9-4955-b101-219f3b1c9b4b', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:21');
INSERT INTO `s_page_role` VALUES ('526dd681-055c-4c4b-b5d5-900b390214f2', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:14');
INSERT INTO `s_page_role` VALUES ('528c630e-5abd-4b87-92a9-58dbd1575a87', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:41');
INSERT INTO `s_page_role` VALUES ('52d783c3-bf94-4e9c-ad4b-28746d5561fe', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:20');
INSERT INTO `s_page_role` VALUES ('530286e5-6139-48d1-81b2-8ff5d054c376', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:19');
INSERT INTO `s_page_role` VALUES ('530e46a6-9c9a-478a-8c05-601769a15b19', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:55');
INSERT INTO `s_page_role` VALUES ('535d348d-464e-460d-bb36-b24c896c76b6', 'ded1d6eb-2c41-407e-9a3e-bf3615ced9ff', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:28');
INSERT INTO `s_page_role` VALUES ('53a52a66-2cd6-4487-84c4-ffecc586d96a', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:09');
INSERT INTO `s_page_role` VALUES ('54363f33-843a-41a6-884d-7d30d50b8400', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:11');
INSERT INTO `s_page_role` VALUES ('54c2ec6f-b630-4dc0-b266-e9bc18a901cd', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:55');
INSERT INTO `s_page_role` VALUES ('54da0ca1-336f-472a-ae96-01c1ec96ed4e', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:02');
INSERT INTO `s_page_role` VALUES ('5525a514-66ae-42c6-ae5e-8308ea98a654', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:30');
INSERT INTO `s_page_role` VALUES ('55290f08-b328-4d19-8644-af86f6c5ab98', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:12');
INSERT INTO `s_page_role` VALUES ('55426de5-9214-4c57-9bfa-f82916589a32', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:09');
INSERT INTO `s_page_role` VALUES ('55bf82a7-997f-40a0-b13a-e412103a1e5d', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:24');
INSERT INTO `s_page_role` VALUES ('55cf3cee-a326-42e3-9382-cda8c7fbb1ab', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:58');
INSERT INTO `s_page_role` VALUES ('55d1700b-b9e9-4302-b356-a3f9ee8515a1', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:14');
INSERT INTO `s_page_role` VALUES ('55ec076b-3350-45d8-8885-7e24e1dc746c', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:01');
INSERT INTO `s_page_role` VALUES ('5634031a-e859-4202-ab15-0c13d0f8d13c', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:59');
INSERT INTO `s_page_role` VALUES ('56f125a4-d0c2-4e3b-aa7b-c02bce969d47', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:07');
INSERT INTO `s_page_role` VALUES ('57110367-2d21-4ad8-8cf3-7c98888c73f0', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:20');
INSERT INTO `s_page_role` VALUES ('571cce07-1f19-4d36-a416-faa32d2baca7', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:24');
INSERT INTO `s_page_role` VALUES ('57dd5404-0cb0-4774-be9f-236e41a7b533', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:08');
INSERT INTO `s_page_role` VALUES ('583c5728-7527-4593-9828-7d1eec8cec7d', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:49');
INSERT INTO `s_page_role` VALUES ('58559771-7e14-4c7b-bff5-898363c36ad1', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:48');
INSERT INTO `s_page_role` VALUES ('585d42f2-f313-4c5f-ab9f-8a327b92a8a3', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:29');
INSERT INTO `s_page_role` VALUES ('586ddf86-49ac-4fba-a594-36fcc5f5a883', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:03');
INSERT INTO `s_page_role` VALUES ('58b6a7cd-a45b-41a5-8ee7-96037ce5385b', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:30');
INSERT INTO `s_page_role` VALUES ('58ee99ef-54d7-4535-a812-f0317874804b', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:16');
INSERT INTO `s_page_role` VALUES ('59846d41-a448-41b2-b156-faa194156213', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:24');
INSERT INTO `s_page_role` VALUES ('598f4876-14ec-4797-9259-f2c3ac507e30', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:19');
INSERT INTO `s_page_role` VALUES ('5a024ef2-85d2-45e3-aa7e-85b526d153c6', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:47');
INSERT INTO `s_page_role` VALUES ('5b84566a-9958-4823-b41d-d5c285dbcf85', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:26');
INSERT INTO `s_page_role` VALUES ('5b945457-08c3-499c-923b-8edd17313daa', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:46');
INSERT INTO `s_page_role` VALUES ('5bcd5734-37c9-408f-91be-6370a0e53b3e', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:36');
INSERT INTO `s_page_role` VALUES ('5bf495ce-273a-4d8c-a65d-c1222d7beb82', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:15');
INSERT INTO `s_page_role` VALUES ('5c095676-b7d9-481c-9ae4-b9174ef00541', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:15');
INSERT INTO `s_page_role` VALUES ('5c1f15fb-9f86-4496-b820-d009f6c183df', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:33');
INSERT INTO `s_page_role` VALUES ('5cb7ecc2-361e-493e-9839-4620df59f5e9', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:28');
INSERT INTO `s_page_role` VALUES ('5d1376b1-934d-4d00-9c3f-bf348a025bf6', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:58');
INSERT INTO `s_page_role` VALUES ('5d2dda2a-b833-40ff-869b-61d6b634a3dd', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:26');
INSERT INTO `s_page_role` VALUES ('5df91695-141d-415b-879a-3eca438f38c2', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:12');
INSERT INTO `s_page_role` VALUES ('5e245f79-9f26-42ca-91a8-9b8073e5912f', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:48');
INSERT INTO `s_page_role` VALUES ('5e5447e7-330a-41e1-b558-ef7c866e6f17', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:28');
INSERT INTO `s_page_role` VALUES ('5e6546a7-4964-42e3-ab8d-6589244cec1b', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:15');
INSERT INTO `s_page_role` VALUES ('5e83f553-3fca-4cb5-a707-f3d25ea683b0', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:17');
INSERT INTO `s_page_role` VALUES ('5e9fcddb-3aa8-48c8-b6ca-d0b1cad14da7', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:58');
INSERT INTO `s_page_role` VALUES ('5ec14e19-64c4-4f5e-bb17-d97f4f748a88', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:51');
INSERT INTO `s_page_role` VALUES ('5f2017b9-b65e-4544-86ce-bf6fbdea7480', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:55');
INSERT INTO `s_page_role` VALUES ('5f48cb97-b5c7-4734-8d02-4b84a6383eda', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:21');
INSERT INTO `s_page_role` VALUES ('5f9a5c57-01fd-4d14-aed8-ee83d4956aa2', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:30');
INSERT INTO `s_page_role` VALUES ('5f9acf3a-654b-477a-937e-14553eca9077', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:13');
INSERT INTO `s_page_role` VALUES ('5faf15f4-f072-405b-810f-cd026ac1e750', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:48');
INSERT INTO `s_page_role` VALUES ('5fb6f1c1-95b3-4713-82ef-c9ae41a587de', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:57');
INSERT INTO `s_page_role` VALUES ('6021a746-d372-4f7d-a323-b47a9c18784b', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:05');
INSERT INTO `s_page_role` VALUES ('604ab85a-3a7d-433f-83cb-93a706d848da', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:10');
INSERT INTO `s_page_role` VALUES ('6084bc0a-4f20-4910-abb9-672a753ad1dc', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:11');
INSERT INTO `s_page_role` VALUES ('60c835de-3af6-4cac-98d8-024038774f62', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:13');
INSERT INTO `s_page_role` VALUES ('60fd5d34-8c6b-47ca-bb64-10f0eedc8f60', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:51');
INSERT INTO `s_page_role` VALUES ('613e7321-9422-40e1-8355-8239111f7199', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:21');
INSERT INTO `s_page_role` VALUES ('613fc519-5e46-498b-8b16-a2a47aef9ba0', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:11');
INSERT INTO `s_page_role` VALUES ('61447d6d-0818-4d62-af26-60f0c00522a4', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:31');
INSERT INTO `s_page_role` VALUES ('6176934e-3692-4c2f-a9c8-fbc05d2d6f89', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:28');
INSERT INTO `s_page_role` VALUES ('61ccf727-8672-44de-963c-260338760ee1', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:59');
INSERT INTO `s_page_role` VALUES ('6211cd59-41af-4439-a5f8-4fc4846a078a', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:31');
INSERT INTO `s_page_role` VALUES ('6216279c-11aa-41ca-a68e-a758bec82b82', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:43');
INSERT INTO `s_page_role` VALUES ('6218adf9-683a-4e19-aaa9-f64022299a4f', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:30');
INSERT INTO `s_page_role` VALUES ('6237e5f2-3edc-4e30-9bf1-c37a7fe7069a', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:12');
INSERT INTO `s_page_role` VALUES ('62a7c58d-ed0d-41c2-baf6-b449b5465746', '5863e4f5-927d-4c96-8bda-2294703bc909', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:25');
INSERT INTO `s_page_role` VALUES ('62cd1a2f-c477-422c-be14-75d81cb64db5', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:33');
INSERT INTO `s_page_role` VALUES ('62d479f3-7b5e-4642-ad75-cf40435967f1', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:39');
INSERT INTO `s_page_role` VALUES ('638a122b-7595-42f6-9a57-c01a3bd0cb0c', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:54');
INSERT INTO `s_page_role` VALUES ('63d25a5f-fdc3-4299-a571-263874213c3e', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:23');
INSERT INTO `s_page_role` VALUES ('640efdad-7409-42e5-9157-4b028acb1a16', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:17');
INSERT INTO `s_page_role` VALUES ('64579f34-4051-4a81-8aa1-e26224957a20', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:12');
INSERT INTO `s_page_role` VALUES ('64e3e0b7-5570-449a-a659-b5a61285c6ae', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:51');
INSERT INTO `s_page_role` VALUES ('65320d58-9f20-4563-a49b-7dd3b088cc7d', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:40');
INSERT INTO `s_page_role` VALUES ('660d3893-2dad-4c41-9de8-c63d6dca929a', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:38');
INSERT INTO `s_page_role` VALUES ('66a5fcf9-c41f-4fa6-89bc-b5a35486270f', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:46');
INSERT INTO `s_page_role` VALUES ('66b44cec-aaa2-40d1-a9d5-709bbc822a7b', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:03:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:03:58');
INSERT INTO `s_page_role` VALUES ('66b68754-f5f5-4984-adc2-96ef45e3478b', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:24');
INSERT INTO `s_page_role` VALUES ('6708f242-3ec6-4296-8068-ed8740e2dc12', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:48');
INSERT INTO `s_page_role` VALUES ('67131e7a-3914-4918-8b73-0564a87b9be7', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:26');
INSERT INTO `s_page_role` VALUES ('67343f74-b1f4-4cc2-99a9-3e7b2f440222', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:29');
INSERT INTO `s_page_role` VALUES ('67403ce8-1238-4fc2-918b-da55cd85926b', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:46');
INSERT INTO `s_page_role` VALUES ('677cb353-dfee-49ab-8057-0620cc14f87f', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:34');
INSERT INTO `s_page_role` VALUES ('677d436c-8d48-493b-9a2c-61b0103da9a8', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:06');
INSERT INTO `s_page_role` VALUES ('67c619d6-d05c-46d3-84a0-aab33022667a', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:42');
INSERT INTO `s_page_role` VALUES ('6829af81-1490-4e1f-8e16-0ff4fc715376', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:36');
INSERT INTO `s_page_role` VALUES ('682f58b3-2ba5-473f-ad10-c2c3eb4ee746', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:31');
INSERT INTO `s_page_role` VALUES ('68381187-43ec-4fde-a9aa-b0afe38e767f', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:22');
INSERT INTO `s_page_role` VALUES ('68519e2d-53b2-49d0-aabb-d44816521c23', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:06');
INSERT INTO `s_page_role` VALUES ('6916f12c-923e-4b4f-ba39-bcb444be382e', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:48');
INSERT INTO `s_page_role` VALUES ('691df926-d423-4c5f-a420-bcc9f1aa262d', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:34');
INSERT INTO `s_page_role` VALUES ('693299be-11b5-4f88-972e-fd26cf96b1b8', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:12');
INSERT INTO `s_page_role` VALUES ('69a99555-8ca1-4c8c-a739-572f58b93526', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:04');
INSERT INTO `s_page_role` VALUES ('69bea788-7707-436e-a120-c2cfcb1f411f', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:43');
INSERT INTO `s_page_role` VALUES ('69d377da-8e53-46f5-bb69-58cf82e22c4a', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:04');
INSERT INTO `s_page_role` VALUES ('69e74e43-b63e-4782-872e-e439f25ba7f3', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:12');
INSERT INTO `s_page_role` VALUES ('6a068fd8-92f1-4f52-8c16-c876c9c5b9eb', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:02');
INSERT INTO `s_page_role` VALUES ('6ac9ef59-14b2-4af4-a8a9-aff5226ee54f', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:10');
INSERT INTO `s_page_role` VALUES ('6b8afa4d-094a-4d2a-b879-88177ccc21d3', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:18');
INSERT INTO `s_page_role` VALUES ('6c1ebf53-3e1f-4cf1-95c9-dc98991f14c4', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:00');
INSERT INTO `s_page_role` VALUES ('6c315722-79c3-47c6-94ab-1f87f3b338fa', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:24');
INSERT INTO `s_page_role` VALUES ('6c3d5381-bf89-43b7-a0bd-d921a350a0bc', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:01');
INSERT INTO `s_page_role` VALUES ('6d6fa8f1-bbca-419b-873c-f03bbe62358c', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:47');
INSERT INTO `s_page_role` VALUES ('6d709a85-4b54-488a-9734-2a31bd2b312a', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:20');
INSERT INTO `s_page_role` VALUES ('6d7c70bd-d39a-4b4e-95bf-922c057ed361', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:17');
INSERT INTO `s_page_role` VALUES ('6dbdeccf-d1ef-4d03-a614-3777ce41de1a', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:47');
INSERT INTO `s_page_role` VALUES ('6ddf1ec3-ae75-4bbd-b26b-a3fba7fef186', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:25');
INSERT INTO `s_page_role` VALUES ('6df26337-f70f-45c3-8914-e46d387578fd', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:32');
INSERT INTO `s_page_role` VALUES ('6e4e70b0-99dc-4665-828b-33303baf33ea', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:27');
INSERT INTO `s_page_role` VALUES ('6e786857-0246-46f1-9c57-0ebbd0c60578', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:18:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:18:58');
INSERT INTO `s_page_role` VALUES ('6e871904-bace-41ae-8230-ca89a66ffa4b', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:21');
INSERT INTO `s_page_role` VALUES ('6f357651-5c05-4823-8f2a-62d5ae0eca3a', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:38');
INSERT INTO `s_page_role` VALUES ('6f39e778-5a64-40b7-b29d-974c9b213935', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:54');
INSERT INTO `s_page_role` VALUES ('6f58897b-fdfa-498e-a50f-f3ca8bc8b024', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:36');
INSERT INTO `s_page_role` VALUES ('6f972f2d-fd4e-451e-ae42-5a4a23bb361e', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:24');
INSERT INTO `s_page_role` VALUES ('6fe5ebc0-30ba-487a-afe9-1586de91bc21', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:44');
INSERT INTO `s_page_role` VALUES ('6feba73b-0278-4abb-868f-538e2c1a6394', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:51');
INSERT INTO `s_page_role` VALUES ('700a41e9-89cb-4567-ae5e-0f42873f7b89', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:01');
INSERT INTO `s_page_role` VALUES ('701df874-2dc7-4cf0-bb1a-9564bae1028b', 'ce43305b-a658-4e8c-b864-10b6ee797429', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:33');
INSERT INTO `s_page_role` VALUES ('7037343a-4d83-486d-b9ca-0d6a56845c20', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:04');
INSERT INTO `s_page_role` VALUES ('7040bae6-6521-4420-a14e-931d2c7050ba', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:05');
INSERT INTO `s_page_role` VALUES ('7092df9d-b5a4-4c83-a97c-701db01ae716', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:08');
INSERT INTO `s_page_role` VALUES ('71708ec9-6163-4e1b-b128-2cad710e5c63', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:21');
INSERT INTO `s_page_role` VALUES ('71793655-146f-474c-b927-b3e1374c83bf', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:48');
INSERT INTO `s_page_role` VALUES ('71b59acb-855b-43e4-a9c4-73cc056815ec', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:17');
INSERT INTO `s_page_role` VALUES ('71cf91a0-44a2-4e31-a1db-062cc9f30628', '2fe964ba-f060-47cf-8c81-fcd0ba615d63', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:21');
INSERT INTO `s_page_role` VALUES ('725b12e9-d663-4291-a40c-a160bfa73f4f', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:18:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:18:57');
INSERT INTO `s_page_role` VALUES ('726895a9-24d3-46d5-a2ba-8f0d463dcbcd', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:49');
INSERT INTO `s_page_role` VALUES ('7291299f-1997-4207-bf14-b8237477d1aa', 'caf65c04-beed-11e7-959c-38d547b81379', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:47');
INSERT INTO `s_page_role` VALUES ('72a4d41f-3974-4934-a0e6-e7e60d7dc648', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:45');
INSERT INTO `s_page_role` VALUES ('72b5fb47-134e-469a-99fa-0c7a701fed3c', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:22');
INSERT INTO `s_page_role` VALUES ('72fc9b58-0323-477f-a068-33a6318fb86d', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:55');
INSERT INTO `s_page_role` VALUES ('7315ec9a-28cc-4e05-982d-8171de17a830', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:20');
INSERT INTO `s_page_role` VALUES ('73a42a0c-c1c3-45b1-bed1-faec6375e0e4', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:26');
INSERT INTO `s_page_role` VALUES ('7401737d-02e0-42c0-9a14-9c794d67e841', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:33');
INSERT INTO `s_page_role` VALUES ('742edc22-90f9-452d-9f60-0e58c990d9c6', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:09');
INSERT INTO `s_page_role` VALUES ('742ef9c6-d356-4657-91c1-17fa3d86b2a9', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:05');
INSERT INTO `s_page_role` VALUES ('745ef6d7-39b5-46db-8790-0ac9e7538a51', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:52');
INSERT INTO `s_page_role` VALUES ('747d5631-05b2-4772-8dda-4aed3e12098c', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:01');
INSERT INTO `s_page_role` VALUES ('74b8b586-8377-4fae-a37e-633b028b332d', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:45');
INSERT INTO `s_page_role` VALUES ('75098962-7ce6-4d95-ac68-558a2b968867', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:01');
INSERT INTO `s_page_role` VALUES ('7523f703-a15a-4ad9-9927-8a387393039a', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:36');
INSERT INTO `s_page_role` VALUES ('756b0dff-5464-4385-8bcc-a560fbe263e3', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:50');
INSERT INTO `s_page_role` VALUES ('75b4aa9c-c2f6-46ad-aa32-53ac309959dc', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:56');
INSERT INTO `s_page_role` VALUES ('75d48f09-00ed-4a29-930c-3312d8c8b4df', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:22');
INSERT INTO `s_page_role` VALUES ('75d74c31-5f4b-4c48-97ab-d91e7bbfa8d3', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:44');
INSERT INTO `s_page_role` VALUES ('75fdda1b-01b0-4175-8997-41285d67e0c4', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:45');
INSERT INTO `s_page_role` VALUES ('76441396-9548-409b-aa36-234aff5f8560', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:07');
INSERT INTO `s_page_role` VALUES ('7650237b-c34b-4fee-b12f-907fbe37a1ca', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:46');
INSERT INTO `s_page_role` VALUES ('768e6d6c-379e-40fc-8919-ef21a9a5798a', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:00');
INSERT INTO `s_page_role` VALUES ('775781ca-cac8-453e-9ab4-bef5245e18d9', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:52');
INSERT INTO `s_page_role` VALUES ('77afd3f8-8f95-493d-98f3-c232f684b798', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:37');
INSERT INTO `s_page_role` VALUES ('77b565aa-1a9f-4538-8387-1e9c3a2d69f7', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:24');
INSERT INTO `s_page_role` VALUES ('77c7f05b-1611-47b6-8158-24393163aefc', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:20');
INSERT INTO `s_page_role` VALUES ('77ccd8de-595c-413e-9a7e-b536e77cae96', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:00');
INSERT INTO `s_page_role` VALUES ('77cdd522-1762-47ea-b752-220ae6b729e2', '3dacb910-a325-4939-aec5-f1e05218513c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:44');
INSERT INTO `s_page_role` VALUES ('781f9731-b26e-4106-9ef6-fb968eb1d3b3', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:59');
INSERT INTO `s_page_role` VALUES ('7883cd03-57e0-4778-8f60-9f385a44be95', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:27');
INSERT INTO `s_page_role` VALUES ('78a5ea4b-bf37-4d55-9d8c-432951b3865a', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:47');
INSERT INTO `s_page_role` VALUES ('78e12f25-098e-45d9-8bef-5e09bb256d5f', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:21');
INSERT INTO `s_page_role` VALUES ('790cc867-0cf6-4630-a217-d36c87ee8c48', '43d5b520-eafe-4f7f-a846-4fba12c9ffab', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:30');
INSERT INTO `s_page_role` VALUES ('795c6284-15af-4d8f-a614-375524c1f982', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:47');
INSERT INTO `s_page_role` VALUES ('797c3ad2-eb8d-4809-b352-329e8b97b4d8', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:40');
INSERT INTO `s_page_role` VALUES ('79ce2421-1200-485c-b387-fc45b297f52a', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:05');
INSERT INTO `s_page_role` VALUES ('79eaecd8-5c8b-4801-b3c3-b006b00f116c', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:41');
INSERT INTO `s_page_role` VALUES ('79f47297-8db1-4d5c-becb-e594fa3f11b2', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:02');
INSERT INTO `s_page_role` VALUES ('7a1d0e79-eec5-455c-a829-3213f0f3ff27', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:18');
INSERT INTO `s_page_role` VALUES ('7a41c03f-8238-421a-b72a-ebd30054dae4', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:14');
INSERT INTO `s_page_role` VALUES ('7aa54946-8a4c-4724-8df2-409edd6d1e56', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:40');
INSERT INTO `s_page_role` VALUES ('7aadceee-1adf-4364-adac-5c2d1dce16bb', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:29');
INSERT INTO `s_page_role` VALUES ('7ab3d35c-06a9-4b5a-9f71-7735f6b99589', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:34');
INSERT INTO `s_page_role` VALUES ('7b595048-3793-4823-815e-0e94b7dde06a', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:57');
INSERT INTO `s_page_role` VALUES ('7c7be0d6-4779-4bb8-833f-7a155709889e', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:05');
INSERT INTO `s_page_role` VALUES ('7c88128a-c011-4cda-962f-504b77737104', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:16');
INSERT INTO `s_page_role` VALUES ('7d1302c2-1202-46a3-8921-220f725a11f9', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:53');
INSERT INTO `s_page_role` VALUES ('7dd3ac5d-4448-4f2b-a8dd-ef80174c8b62', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:00');
INSERT INTO `s_page_role` VALUES ('7e873657-177d-420d-b2b3-686abfb341ea', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:21');
INSERT INTO `s_page_role` VALUES ('7ec6b704-cc5d-4d4f-a680-89418c71d4f8', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:14');
INSERT INTO `s_page_role` VALUES ('7ee8704f-7fb3-45f1-87dd-c18879b783b9', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:17');
INSERT INTO `s_page_role` VALUES ('7ef63e42-ead9-4d96-88b2-4bb2407ef900', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:32');
INSERT INTO `s_page_role` VALUES ('7f0f7cfa-848f-4127-88c3-570f93d76956', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:12');
INSERT INTO `s_page_role` VALUES ('7f1ef68a-a13b-408b-9779-aa8c3f41271e', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:42');
INSERT INTO `s_page_role` VALUES ('805a355d-3236-4fd0-98ab-9624dc535545', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:16');
INSERT INTO `s_page_role` VALUES ('808375e4-4686-4aef-a27d-7c49f2d8a9e5', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:01');
INSERT INTO `s_page_role` VALUES ('80b03523-2054-4359-955c-d69525ebbed6', 'e38ab74b-bf14-11e7-a301-24fd52935962', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:51');
INSERT INTO `s_page_role` VALUES ('80e68873-a1fb-4704-b949-67947e26b6d3', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:17');
INSERT INTO `s_page_role` VALUES ('80ef5fad-fbbc-48d3-8958-9a9e78d43576', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:28');
INSERT INTO `s_page_role` VALUES ('80fdea5c-483b-49cd-8df5-e0e8aa85234b', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:16');
INSERT INTO `s_page_role` VALUES ('8149339a-d294-44b4-bc9d-5d254a056fcc', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:47');
INSERT INTO `s_page_role` VALUES ('8176a49f-9837-4217-be8b-f2fd45e535da', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:59');
INSERT INTO `s_page_role` VALUES ('8182c08c-33e8-4639-9ab1-e45d1bfb63a4', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:21');
INSERT INTO `s_page_role` VALUES ('81d4e21c-0b58-4f12-bfd7-519aebdc95f2', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:27');
INSERT INTO `s_page_role` VALUES ('82291df6-1508-4c9f-ab02-cd766072d940', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:00');
INSERT INTO `s_page_role` VALUES ('8288214f-9b49-4691-aca3-295a84366a17', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:41');
INSERT INTO `s_page_role` VALUES ('82f23698-2358-4af3-85ad-30170212f3fc', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:36');
INSERT INTO `s_page_role` VALUES ('839c2d76-7e8c-42e8-a203-be0038cf03a4', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:40');
INSERT INTO `s_page_role` VALUES ('83c6fe89-d165-422a-9b77-210a57922c96', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:13');
INSERT INTO `s_page_role` VALUES ('83e28198-cd33-4344-81c5-7a46e43141cf', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:45');
INSERT INTO `s_page_role` VALUES ('83fcde73-483f-4ea7-be06-db1e2dee8bf1', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:37');
INSERT INTO `s_page_role` VALUES ('84037e85-a027-4ecf-b6ba-d17ae2e6829b', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:03');
INSERT INTO `s_page_role` VALUES ('841b3411-f0ab-4d48-869e-57afc3cd8b2e', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:40');
INSERT INTO `s_page_role` VALUES ('8422b8d1-650e-4848-a599-521a31964acc', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:04');
INSERT INTO `s_page_role` VALUES ('84674637-3990-454e-86db-056a9bbb0f2f', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:09');
INSERT INTO `s_page_role` VALUES ('84c51314-eb72-484d-9d7a-1fd1f4f17c46', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:18');
INSERT INTO `s_page_role` VALUES ('851125ed-5772-4b62-8da5-e9ddb7937afd', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:13');
INSERT INTO `s_page_role` VALUES ('85729b14-023e-4ed1-892b-c2bec629251b', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:32');
INSERT INTO `s_page_role` VALUES ('85a0a410-759b-48fe-a9a0-ca6e96f8ec84', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:37');
INSERT INTO `s_page_role` VALUES ('85dcf696-7564-4ab0-99c9-f172fccba05b', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:18');
INSERT INTO `s_page_role` VALUES ('861ae4ee-f61c-4ab8-b91a-d4ce2b1f3a0d', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:20');
INSERT INTO `s_page_role` VALUES ('8634e17f-3fe4-465e-a792-b240f608e642', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:18');
INSERT INTO `s_page_role` VALUES ('869355a9-1fa9-4e84-af66-2fa7de8714a5', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:01');
INSERT INTO `s_page_role` VALUES ('86be4300-c156-4eba-86c5-e22f9331a014', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:18');
INSERT INTO `s_page_role` VALUES ('871a61ac-336c-49d7-9905-2f8d1b3fa89e', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:33');
INSERT INTO `s_page_role` VALUES ('87221d8a-be8e-4cde-bfb6-fbf07641f6bf', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:13');
INSERT INTO `s_page_role` VALUES ('87259e39-a9ef-4013-9e38-b0a9bcf46f29', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:54');
INSERT INTO `s_page_role` VALUES ('8730f65d-16a0-4f25-bca1-7c8bf38ef3f9', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:32');
INSERT INTO `s_page_role` VALUES ('8757d813-61ff-4637-9e16-07568312b873', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:09');
INSERT INTO `s_page_role` VALUES ('87623aa0-5945-4825-9d20-51b36d8bf299', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:38');
INSERT INTO `s_page_role` VALUES ('87657c55-f181-4e58-bcf2-514c4c667c2e', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:43:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:43:26');
INSERT INTO `s_page_role` VALUES ('8765c67e-b7bd-4d39-a0a8-cbdc9e6df052', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:11');
INSERT INTO `s_page_role` VALUES ('87735da0-f40f-4a4c-8b7c-9a90aa802bac', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:56');
INSERT INTO `s_page_role` VALUES ('87a9e636-5a3d-4ea4-b231-81894f475fd9', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:43');
INSERT INTO `s_page_role` VALUES ('87cb0a1e-53d9-42bc-8fbc-d17faa0f2f41', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:49');
INSERT INTO `s_page_role` VALUES ('8821a687-8ce8-4a75-a2f2-8479e74a741b', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:13');
INSERT INTO `s_page_role` VALUES ('886477a7-2d02-4f90-be03-1983d3528a32', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:48');
INSERT INTO `s_page_role` VALUES ('8890c2c6-b3f4-4e62-a29e-31a9b79b0fd6', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:17');
INSERT INTO `s_page_role` VALUES ('895e62d7-84d9-479b-80cb-ccea00cf2f93', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:01');
INSERT INTO `s_page_role` VALUES ('89c35393-8056-4644-a2a1-2110497dfcc3', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:57');
INSERT INTO `s_page_role` VALUES ('8a10c1ca-bb32-4469-904e-5afe85e0dac1', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:24:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:24:05');
INSERT INTO `s_page_role` VALUES ('8a83caec-235a-4f72-a255-1c8256f4822f', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:26');
INSERT INTO `s_page_role` VALUES ('8ac0aa33-bb2e-461f-9821-04dcaa634e55', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:15');
INSERT INTO `s_page_role` VALUES ('8af8edee-7b09-4708-9514-53437b154097', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:23');
INSERT INTO `s_page_role` VALUES ('8b85b2df-d3b2-4724-8706-d93790545df1', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:57');
INSERT INTO `s_page_role` VALUES ('8b8fee70-a44a-4e48-a2e5-e6d08512f14d', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:33');
INSERT INTO `s_page_role` VALUES ('8b935a4c-13e2-4c4f-a62b-5b1dac89cdc1', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:13');
INSERT INTO `s_page_role` VALUES ('8c61ee8b-3e38-410b-824f-547d9cb04638', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:19');
INSERT INTO `s_page_role` VALUES ('8c6f69f1-7652-4870-bdd3-1ed32fddd800', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:36');
INSERT INTO `s_page_role` VALUES ('8c84d3e0-c48d-4cbe-af2d-ee2f5792b5fe', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:25');
INSERT INTO `s_page_role` VALUES ('8d3e106d-9af3-4683-ba0c-2596c9917d5f', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:18');
INSERT INTO `s_page_role` VALUES ('8d575d02-e420-40ca-b184-9c40a62dc651', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:10');
INSERT INTO `s_page_role` VALUES ('8de974b9-9c01-4492-a7d6-e9480f15a3dc', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:20');
INSERT INTO `s_page_role` VALUES ('8e307813-6d3d-4555-974d-2fe1e0c5fb5d', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:34');
INSERT INTO `s_page_role` VALUES ('8f4c8a14-ebac-4e0a-8dd8-852235a81b4b', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:27');
INSERT INTO `s_page_role` VALUES ('8f777215-5376-4ae4-8c75-04b993d42cb7', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:42');
INSERT INTO `s_page_role` VALUES ('8f8ea0bc-0010-4435-adc7-f47a6924aa88', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:01');
INSERT INTO `s_page_role` VALUES ('8ff128ce-e378-49d6-82af-48c6cc7a4897', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:22');
INSERT INTO `s_page_role` VALUES ('902d7832-e4c3-4e7a-9d3a-1b1a22d97a87', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:56');
INSERT INTO `s_page_role` VALUES ('90415720-f82d-418c-9734-65bcc5918f3c', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:19');
INSERT INTO `s_page_role` VALUES ('90896a95-35a6-4a20-b889-09dd9b29521b', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:11');
INSERT INTO `s_page_role` VALUES ('9091f2fa-b5c1-4267-bfef-8a8d0554c69d', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:47');
INSERT INTO `s_page_role` VALUES ('90aadb84-9ad4-4aff-ab94-efb9ca5fd8bf', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:46');
INSERT INTO `s_page_role` VALUES ('90cf500b-95b7-44b1-99ad-4f876b5b6737', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:19');
INSERT INTO `s_page_role` VALUES ('916d81e3-2027-48b0-84e0-6afcb1fb38a6', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:28');
INSERT INTO `s_page_role` VALUES ('91b0e9ce-13d5-4c09-83c4-c5252f78b186', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:24:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:24:07');
INSERT INTO `s_page_role` VALUES ('921956ea-f3f3-42a9-bcf0-aabd2a6bad1f', '5863e4f5-927d-4c96-8bda-2294703bc909', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:44');
INSERT INTO `s_page_role` VALUES ('924550b7-eb75-42b1-899e-211c005fd3ee', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:28');
INSERT INTO `s_page_role` VALUES ('928724bc-997b-467b-8b30-8c368d68728a', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:04');
INSERT INTO `s_page_role` VALUES ('92f00295-e90b-4dcc-92eb-4bafbf1c6b2a', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:45');
INSERT INTO `s_page_role` VALUES ('930f3ddd-0cf5-46b7-bebd-486702a18471', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:59');
INSERT INTO `s_page_role` VALUES ('93d9118a-7058-47cf-896c-0bb96f32db62', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:40');
INSERT INTO `s_page_role` VALUES ('940f6a54-75e5-4e9d-a441-6254133f8c7c', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:38');
INSERT INTO `s_page_role` VALUES ('9430be45-2137-4977-8959-3dfa0281c96d', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:00');
INSERT INTO `s_page_role` VALUES ('9474f5e2-2b8a-4128-8145-92f0832c81ab', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:06');
INSERT INTO `s_page_role` VALUES ('948e95f3-0bca-44f8-92bf-8eed54d0fa22', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:18');
INSERT INTO `s_page_role` VALUES ('94fd9ecc-e489-4413-bf0a-2451f069d305', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:27');
INSERT INTO `s_page_role` VALUES ('9539fb1b-3a32-42d4-875a-e211a895b4c5', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:12');
INSERT INTO `s_page_role` VALUES ('95c787f0-d0da-4015-ac92-7b84e512f7ca', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:20');
INSERT INTO `s_page_role` VALUES ('964b21e7-51fc-4321-87a3-50cc14166b50', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:37');
INSERT INTO `s_page_role` VALUES ('96969437-3fb2-4d19-87f3-5fa8c48cbf5e', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:15');
INSERT INTO `s_page_role` VALUES ('96faeeb8-fd70-435f-927c-615667642bb0', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:26');
INSERT INTO `s_page_role` VALUES ('97422c85-58a5-4879-a9c9-e27307cb8c2b', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:24');
INSERT INTO `s_page_role` VALUES ('97c9060e-0fd3-4e00-86c8-4c60b9b40a27', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:07');
INSERT INTO `s_page_role` VALUES ('97cc6954-8e1c-4c95-a4ed-860cf5f62e71', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:19');
INSERT INTO `s_page_role` VALUES ('97dc6155-4ca7-45f5-b993-712219e757be', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:16');
INSERT INTO `s_page_role` VALUES ('97eb9038-610f-40b7-8b28-4bf0c8abcc6b', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:27');
INSERT INTO `s_page_role` VALUES ('9828f3fe-d4f4-44cc-bada-3e44c04ecbd2', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:27');
INSERT INTO `s_page_role` VALUES ('9852d454-254a-49a7-a407-3b71990b3515', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:18');
INSERT INTO `s_page_role` VALUES ('98872958-807f-464f-a081-df893d6e6052', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:44');
INSERT INTO `s_page_role` VALUES ('9919cf0f-e58d-46e5-b1b8-22dfec6a431a', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:21');
INSERT INTO `s_page_role` VALUES ('992dfaa2-8749-4e33-9a3d-3e7f57d43fd8', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:26');
INSERT INTO `s_page_role` VALUES ('99700b15-87c5-4e63-8d2f-2d20524326d8', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:44');
INSERT INTO `s_page_role` VALUES ('99db2e8c-0f3b-4a67-a733-d312350bb8bb', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:11');
INSERT INTO `s_page_role` VALUES ('9a2f7ef3-fc85-47d3-9893-6af1ec7cf4f5', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:06');
INSERT INTO `s_page_role` VALUES ('9a802bab-de24-4ae0-ad3d-d969ef9c4017', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:30');
INSERT INTO `s_page_role` VALUES ('9b1f1ea8-ad23-4fbb-9aff-2c7b9bdf52f7', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:57');
INSERT INTO `s_page_role` VALUES ('9b3ed398-dad8-446f-b147-012cdea73725', 'ce43305b-a658-4e8c-b864-10b6ee797429', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:32');
INSERT INTO `s_page_role` VALUES ('9b43fceb-48b6-414b-b38b-69798ba594f0', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:22');
INSERT INTO `s_page_role` VALUES ('9b64d3fd-c30b-409c-98e8-22928778961a', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:50');
INSERT INTO `s_page_role` VALUES ('9b6dbd28-757b-4f7a-a5d1-c5ecaf5c54d6', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:50');
INSERT INTO `s_page_role` VALUES ('9b6e7143-bcc5-4311-860f-7cae124fddea', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:04');
INSERT INTO `s_page_role` VALUES ('9b7f2ee5-2a98-4e79-a036-0d8cb9925639', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:08');
INSERT INTO `s_page_role` VALUES ('9ba3e496-4c6e-4d43-860d-1ef21b6edcfb', 'caf65c04-beed-11e7-959c-38d547b81379', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:45');
INSERT INTO `s_page_role` VALUES ('9bd9ee94-27a9-4f74-afa9-dddb07832086', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:20');
INSERT INTO `s_page_role` VALUES ('9c1e0614-9419-484f-bcdf-d1ab4a57c89f', '68522995-30dc-4fb0-97d8-7468e6af4853', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 12:55:26');
INSERT INTO `s_page_role` VALUES ('9cebab83-e9dd-41b9-afa9-0f4f0c2360c8', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:09');
INSERT INTO `s_page_role` VALUES ('9d4e3425-4742-4f52-9e75-c92dfedbfd1a', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:37');
INSERT INTO `s_page_role` VALUES ('9d5835f2-6033-429a-9272-d81df5e65f6f', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:03');
INSERT INTO `s_page_role` VALUES ('9e7cbafe-c7c1-4372-9813-4caa16577bb3', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:17');
INSERT INTO `s_page_role` VALUES ('9f007b28-efe1-4b44-bb39-036ca1110177', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:09');
INSERT INTO `s_page_role` VALUES ('9f33be4b-010a-494c-a6b7-d07d56204582', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:09');
INSERT INTO `s_page_role` VALUES ('a02deaf2-e638-4d2b-aa2f-775ceed478fc', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:13');
INSERT INTO `s_page_role` VALUES ('a0669442-d0c1-4509-b697-bd13520e33da', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:40');
INSERT INTO `s_page_role` VALUES ('a0992344-a906-43a5-adcc-a88900aba964', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:50');
INSERT INTO `s_page_role` VALUES ('a1013132-0247-4101-8ad3-7682dda526cd', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:04');
INSERT INTO `s_page_role` VALUES ('a1a49b49-9c0c-48fb-a850-57b55d6c8865', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:22');
INSERT INTO `s_page_role` VALUES ('a1a8e2ae-166d-4753-a202-7db54aae0ec4', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:30');
INSERT INTO `s_page_role` VALUES ('a1d56c8a-4da1-44cd-9d36-e26e27e36615', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:03');
INSERT INTO `s_page_role` VALUES ('a21072fb-ee73-4cde-b046-088f94ae3191', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:05');
INSERT INTO `s_page_role` VALUES ('a2e76970-77e9-40df-9e36-92cedd25602f', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:40');
INSERT INTO `s_page_role` VALUES ('a2f3c0a1-a1c2-4982-9ebe-59720638a114', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:30');
INSERT INTO `s_page_role` VALUES ('a31f6119-e9d4-4967-8bd2-ae5c1724adb5', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:13');
INSERT INTO `s_page_role` VALUES ('a39cda9c-e6bd-43dd-bf35-ee241d5cb941', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:27');
INSERT INTO `s_page_role` VALUES ('a3aa3eca-f123-4649-842f-2fb5b6f44028', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:03');
INSERT INTO `s_page_role` VALUES ('a3d4eadb-9e43-49ef-a40e-7696626ffd72', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:25');
INSERT INTO `s_page_role` VALUES ('a4066778-3967-4eb8-a065-97360dfe163b', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:22');
INSERT INTO `s_page_role` VALUES ('a42435b9-bb26-40c0-b30b-19fb563a9c75', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:49');
INSERT INTO `s_page_role` VALUES ('a4455b47-f7d2-4792-acf3-4a7f2cf76437', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:17');
INSERT INTO `s_page_role` VALUES ('a449ff24-d38c-4e5b-a03c-dc3af9c7ca2b', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:48');
INSERT INTO `s_page_role` VALUES ('a44e3b03-9bbd-4378-957c-4e8dac70d5b5', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:47');
INSERT INTO `s_page_role` VALUES ('a45f4e8f-432e-4b59-b24a-9a9c03e5bcd7', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:59');
INSERT INTO `s_page_role` VALUES ('a46ecfbd-9193-47c4-b694-00bf2eba4092', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:08');
INSERT INTO `s_page_role` VALUES ('a4de1283-6226-4c5d-869c-d4bacf43c64e', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:34');
INSERT INTO `s_page_role` VALUES ('a53e449b-4b79-46c6-b693-3e9787074e73', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:43');
INSERT INTO `s_page_role` VALUES ('a62e4deb-7ca6-419f-974a-4296d50f3fd0', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:25');
INSERT INTO `s_page_role` VALUES ('a6947f14-84a3-491d-9c72-c27b79606ec2', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:10');
INSERT INTO `s_page_role` VALUES ('a6b6ad9c-3321-4700-870e-7cce306ca947', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:04');
INSERT INTO `s_page_role` VALUES ('a70a1ec0-7b5c-47bb-b58d-b26c85a15521', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:11');
INSERT INTO `s_page_role` VALUES ('a793dd04-5bab-4473-a5b2-31a2d52cb84f', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:27');
INSERT INTO `s_page_role` VALUES ('a81726e6-e297-4bd5-a41e-01c5dc636a60', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:29');
INSERT INTO `s_page_role` VALUES ('a88d6867-c8b6-4bb2-b01e-edb9c861479d', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:49');
INSERT INTO `s_page_role` VALUES ('a993d8c1-568f-4e85-9ac9-03a5cbabc095', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:06');
INSERT INTO `s_page_role` VALUES ('a9f5be1a-b205-4ccb-be6f-e6a651a1845a', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:40');
INSERT INTO `s_page_role` VALUES ('aa224ce6-30dc-4c78-85b9-43fe1020e602', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:44');
INSERT INTO `s_page_role` VALUES ('aa2ad4fa-e964-41f9-a4fa-ea9a118dc589', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:31');
INSERT INTO `s_page_role` VALUES ('aa4aea47-c17b-4c31-b5cb-f7f30b6354bb', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:56');
INSERT INTO `s_page_role` VALUES ('aa5299f9-04d9-496a-8d65-3f02f81b441a', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:06');
INSERT INTO `s_page_role` VALUES ('aa93f63e-cfc1-4d82-b4d5-bccf57d3f3df', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:08');
INSERT INTO `s_page_role` VALUES ('aab7e696-a31d-4ad7-a853-d001ebc91973', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:44');
INSERT INTO `s_page_role` VALUES ('ac2bddcd-64e2-4e66-b99a-96efcc47b41a', 'ce43305b-a658-4e8c-b864-10b6ee797429', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:35');
INSERT INTO `s_page_role` VALUES ('ac44d175-16ef-4ace-82e5-e07f4edb7d74', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:00');
INSERT INTO `s_page_role` VALUES ('ac78a126-701e-478d-a101-17a84d1ceae5', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:36');
INSERT INTO `s_page_role` VALUES ('acc17164-cfff-48db-acb1-647ccb2f9669', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:23');
INSERT INTO `s_page_role` VALUES ('acc82e5f-0d6e-42f5-8f2d-457222179c48', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:30');
INSERT INTO `s_page_role` VALUES ('acf03ca4-0019-4896-b74e-9e43791211e6', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:00');
INSERT INTO `s_page_role` VALUES ('acfa8e09-bba2-4e33-a743-b96e2be58c0d', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:34');
INSERT INTO `s_page_role` VALUES ('ad58460a-a5f9-4c45-a123-a77de21e72ef', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:39');
INSERT INTO `s_page_role` VALUES ('ade9a03b-4866-4198-bc8c-d9b14de0f0a7', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:41');
INSERT INTO `s_page_role` VALUES ('ae0a2942-2fba-44fb-97b4-29581ab06356', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:09');
INSERT INTO `s_page_role` VALUES ('ae286946-fd54-46b5-97f4-60eab5c2502e', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:16');
INSERT INTO `s_page_role` VALUES ('ae4c4c64-87e5-44c0-8725-088ca68ecb50', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:31');
INSERT INTO `s_page_role` VALUES ('ae56902c-d723-4abd-a74e-25cc2483eb74', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:17');
INSERT INTO `s_page_role` VALUES ('aecf74ad-0fe4-4dbf-a32e-1fa64dcfb8e5', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:01');
INSERT INTO `s_page_role` VALUES ('af71824a-355f-4438-9fd6-f36bf9acf632', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:09');
INSERT INTO `s_page_role` VALUES ('af784936-c6a4-4998-b78b-d60a51225c2e', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:02');
INSERT INTO `s_page_role` VALUES ('b00d3079-0dd0-4148-8fe6-f88d0e501051', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:06');
INSERT INTO `s_page_role` VALUES ('b012597d-204b-4c1c-8967-beb95b86874c', '67416840-6b15-473b-80fc-bbf1b28dfac5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:51');
INSERT INTO `s_page_role` VALUES ('b07274a5-5bff-4d4e-b9d1-75085d289c25', '5863e4f5-927d-4c96-8bda-2294703bc909', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:29');
INSERT INTO `s_page_role` VALUES ('b07a7ba5-93a8-4f85-b327-fbfb403b6a5d', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:09');
INSERT INTO `s_page_role` VALUES ('b0abee24-fa1d-4570-9c62-0ed30d0293a5', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:34');
INSERT INTO `s_page_role` VALUES ('b0f332eb-08c4-4d05-869c-cdbcd68824d3', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:31');
INSERT INTO `s_page_role` VALUES ('b1276f65-1a89-436b-a5d3-717f8645b898', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:32');
INSERT INTO `s_page_role` VALUES ('b186f862-ffa3-4974-b5c9-e6a23428a4af', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:11');
INSERT INTO `s_page_role` VALUES ('b232963f-0b97-4fad-a61e-cae282e18e22', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:14');
INSERT INTO `s_page_role` VALUES ('b261f4df-2f55-49c9-8210-f6a697597a3d', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:42');
INSERT INTO `s_page_role` VALUES ('b28f0835-f7d6-405a-b465-fdb34e0de40c', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:40');
INSERT INTO `s_page_role` VALUES ('b299877a-fa96-48c7-bde9-0ea4cf6c99d1', '3dacb910-a325-4939-aec5-f1e05218513c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:40');
INSERT INTO `s_page_role` VALUES ('b29cb75f-900d-4c5c-a111-7147fb4c38a3', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:18');
INSERT INTO `s_page_role` VALUES ('b29dfc92-5140-4f76-b9a4-bb3b32a4f4cb', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:00');
INSERT INTO `s_page_role` VALUES ('b2a2697f-514b-4655-bcf4-ee9b94971e38', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:53');
INSERT INTO `s_page_role` VALUES ('b2a9c5ff-2bf0-4046-b944-7a295ffdd665', 'caf65c04-beed-11e7-959c-38d547b81379', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:48');
INSERT INTO `s_page_role` VALUES ('b37b2e5c-80fb-4d9c-ada1-4f1e79c641d2', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:11');
INSERT INTO `s_page_role` VALUES ('b391e6c9-a5b9-492d-bb0f-6bfb763ff2ef', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:52');
INSERT INTO `s_page_role` VALUES ('b3b88704-0e6f-4822-9588-938092072f08', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:56');
INSERT INTO `s_page_role` VALUES ('b408c715-19ed-46ee-9428-5e5cfd58fd13', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:50');
INSERT INTO `s_page_role` VALUES ('b42cfa63-73b7-4dad-9663-b199fe650e1c', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:47');
INSERT INTO `s_page_role` VALUES ('b46a8064-1d60-46a0-a0c2-9bcf74b76978', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:43');
INSERT INTO `s_page_role` VALUES ('b49fdb82-d948-4b3f-81c0-12953e5382c7', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:00');
INSERT INTO `s_page_role` VALUES ('b4f00ac8-8c14-4ae0-8b39-20265fd31750', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:02');
INSERT INTO `s_page_role` VALUES ('b500bd35-b8a4-48ca-a5ec-4537d887fd4d', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:58');
INSERT INTO `s_page_role` VALUES ('b53d4628-5a45-4691-898f-ef0cc868d854', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:39');
INSERT INTO `s_page_role` VALUES ('b541062f-24d4-4937-8071-d712a445b025', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:41');
INSERT INTO `s_page_role` VALUES ('b54faa66-1051-445c-841f-bd8100230966', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:28');
INSERT INTO `s_page_role` VALUES ('b57077a3-fda4-48a4-98f4-bbd8ff1ad5e3', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:57');
INSERT INTO `s_page_role` VALUES ('b57955c8-172d-43ee-b6d6-3c61d38636ed', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:34');
INSERT INTO `s_page_role` VALUES ('b59b773f-4a69-4b32-9c09-85afd20fd7f0', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:12');
INSERT INTO `s_page_role` VALUES ('b7e6633d-c745-4f1d-a01d-8e2b7cee4977', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:07');
INSERT INTO `s_page_role` VALUES ('b832ef82-16c3-4bf6-9ebc-4e4532a27bde', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:49');
INSERT INTO `s_page_role` VALUES ('b85720bf-9b1a-43ec-bc0a-e82ce6c0af86', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:14');
INSERT INTO `s_page_role` VALUES ('b975457a-ec07-4102-831a-70dd9b517a8e', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:39');
INSERT INTO `s_page_role` VALUES ('b97c8347-4989-460e-a150-e050f303855d', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:41');
INSERT INTO `s_page_role` VALUES ('b98fe3f8-1853-41af-8e8e-5fd7d45bf82a', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:31');
INSERT INTO `s_page_role` VALUES ('b9a585ad-c700-402b-8519-4a3536e3a365', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:59');
INSERT INTO `s_page_role` VALUES ('b9fb63a2-04bf-4ca7-8c88-7be16579fc15', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:04');
INSERT INTO `s_page_role` VALUES ('ba1a27d3-ed45-4d0b-8f61-8aa9c0c14fca', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:33');
INSERT INTO `s_page_role` VALUES ('ba225e35-ea52-4ee8-b3fd-4a2883dd5103', 'e38ab74b-bf14-11e7-a301-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:15');
INSERT INTO `s_page_role` VALUES ('ba3039f5-a7aa-425a-8dcf-178847f79544', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:00');
INSERT INTO `s_page_role` VALUES ('ba5d5ae0-b0f7-41f0-92b6-d69906a70c17', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:44');
INSERT INTO `s_page_role` VALUES ('babb6627-62f5-4930-94b8-b50b1f0f8737', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:11');
INSERT INTO `s_page_role` VALUES ('bae2c5a6-7ba4-4745-a8dc-9a4c3cfa2bbb', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:44');
INSERT INTO `s_page_role` VALUES ('bae8b7b5-b9f3-11e7-b0f1-38d547b81379', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-26 10:17:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-10-26 10:17:50');
INSERT INTO `s_page_role` VALUES ('bb1be8e2-e6a9-404d-ac5a-2e27c160df9c', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:44');
INSERT INTO `s_page_role` VALUES ('bb27aeb6-c166-4db5-846a-d0ccf618ab2c', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:29');
INSERT INTO `s_page_role` VALUES ('bb31bb96-6892-45c4-99f2-1e0ed9d733b1', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:56');
INSERT INTO `s_page_role` VALUES ('bb38eaae-6535-4650-9062-c8a844cd430a', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:46');
INSERT INTO `s_page_role` VALUES ('bbe3e06f-70a6-4142-9aae-165c9dd0d0ef', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:20');
INSERT INTO `s_page_role` VALUES ('bc17942c-36c0-4851-aeb8-7ba5f53184a4', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:55');
INSERT INTO `s_page_role` VALUES ('bc8d987c-2492-4262-8740-1d774f8f576f', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:02');
INSERT INTO `s_page_role` VALUES ('bcbf5d72-c4f1-4a59-94f6-e4eec80d6957', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:38');
INSERT INTO `s_page_role` VALUES ('bcc72356-e874-42c1-84ef-b9248738ce58', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:31');
INSERT INTO `s_page_role` VALUES ('bcf4758c-39e0-49fb-b514-d0d7cce6496d', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:10');
INSERT INTO `s_page_role` VALUES ('bdbcf569-ccd9-11e7-b07e-24fd52935962', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:28:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:28:42');
INSERT INTO `s_page_role` VALUES ('bdced845-fc44-4aea-886b-5ce4ec97d7df', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:22');
INSERT INTO `s_page_role` VALUES ('bdfd6c68-442a-4eb0-aeaf-9de4522c5f93', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:51');
INSERT INTO `s_page_role` VALUES ('bdfe932e-4885-4756-89d1-0e9aa6b8d955', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:25');
INSERT INTO `s_page_role` VALUES ('be00ccc2-45a1-4045-9515-3e04e1995f05', 'caf65c04-beed-11e7-959c-38d547b81379', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:36');
INSERT INTO `s_page_role` VALUES ('be05e115-31b0-4aec-afb3-fe151045f09d', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:10');
INSERT INTO `s_page_role` VALUES ('bfa17a3b-f044-4a63-8057-7a0a571ed8bd', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:51');
INSERT INTO `s_page_role` VALUES ('bfd828f9-a2f0-4ee7-a9af-9c0c13b01bb2', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:17');
INSERT INTO `s_page_role` VALUES ('bff31f2d-61db-45f1-8285-bb82cae08dcc', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:15');
INSERT INTO `s_page_role` VALUES ('c01c547e-14f2-4935-b525-5d73a6ad9a4a', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:24');
INSERT INTO `s_page_role` VALUES ('c0bf13e3-dd20-4128-b9ed-e3720c8482cb', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:07');
INSERT INTO `s_page_role` VALUES ('c10844ba-24de-42cd-bd30-323d5e901ecd', '3dacb910-a325-4939-aec5-f1e05218513c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:43');
INSERT INTO `s_page_role` VALUES ('c1929652-1bd5-4e11-b5fb-42f3bc088ca4', '55638077-269d-41fc-981e-d6f8eeaee8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:08');
INSERT INTO `s_page_role` VALUES ('c1cce5ab-dfaf-424e-8700-4994ebfac93d', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:23');
INSERT INTO `s_page_role` VALUES ('c1df4395-0f32-4d4e-9708-50abeb935c97', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:47', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:47');
INSERT INTO `s_page_role` VALUES ('c1f8d2b9-bca0-442a-b274-17a4dc230c9a', '91d81894-dca3-4738-a408-77d23108a710', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:39');
INSERT INTO `s_page_role` VALUES ('c23a9d95-d00e-4a29-be26-27231be72c3c', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:52');
INSERT INTO `s_page_role` VALUES ('c24b3129-776d-4738-b4e1-57845e141def', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:43');
INSERT INTO `s_page_role` VALUES ('c2828e38-615f-41c9-a850-12f3d2a455f3', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:52');
INSERT INTO `s_page_role` VALUES ('c2841c5d-f130-4636-8c71-f594f4bf0524', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:39:57');
INSERT INTO `s_page_role` VALUES ('c2c45e9e-19e4-4bcf-b17f-f0674f379e48', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:46');
INSERT INTO `s_page_role` VALUES ('c308e511-780e-41b8-81b8-30c68599fef3', '04c21bbc-f0c1-4981-bbe7-17627cce0664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:14');
INSERT INTO `s_page_role` VALUES ('c3343d56-220c-474e-9fc8-97d7f40c3930', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:15');
INSERT INTO `s_page_role` VALUES ('c3545d29-7f26-4358-bd3c-f91aeb4302f1', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:33');
INSERT INTO `s_page_role` VALUES ('c370a6e6-59e5-425b-b4e4-a471da549db3', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:49');
INSERT INTO `s_page_role` VALUES ('c3c8f6bc-eaf5-406b-9e0d-857716cf9280', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:45');
INSERT INTO `s_page_role` VALUES ('c451b195-4865-4c12-a0db-a74fdfe9f436', '91d81894-dca3-4738-a408-77d23108a710', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:01:14');
INSERT INTO `s_page_role` VALUES ('c4ef8b50-c599-44c5-9e83-ea8b7de36134', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:59');
INSERT INTO `s_page_role` VALUES ('c4f42f8f-ccd9-11e7-b07e-24fd52935962', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:28:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:28:54');
INSERT INTO `s_page_role` VALUES ('c5029761-54f2-4633-823a-d140df89ca70', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:34');
INSERT INTO `s_page_role` VALUES ('c502e471-a48c-494e-b771-23a65a8eb0b1', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:37');
INSERT INTO `s_page_role` VALUES ('c513009e-beb2-4693-920b-1747d9d8fcf7', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:26');
INSERT INTO `s_page_role` VALUES ('c518b30e-0e5e-44c2-920b-f212dbdc3324', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:05');
INSERT INTO `s_page_role` VALUES ('c54f41e0-c2c8-43c3-a734-be4848c36a8f', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:51');
INSERT INTO `s_page_role` VALUES ('c56668bb-c56b-40c4-9143-f87d8c139def', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:24');
INSERT INTO `s_page_role` VALUES ('c5e7afc3-bafb-4c99-bfe0-dd84c0c719a4', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:15');
INSERT INTO `s_page_role` VALUES ('c61a948e-a08e-4ebf-8c01-5675b5d70327', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:10');
INSERT INTO `s_page_role` VALUES ('c6352c33-05d3-4d2e-b66e-2f5627e6dfb0', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:35');
INSERT INTO `s_page_role` VALUES ('c6cd6715-6203-4f84-b55a-68c57eae82e4', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:37', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:37');
INSERT INTO `s_page_role` VALUES ('c6e7a1f7-31cc-439a-9daa-69b5aab08308', '67416840-6b15-473b-80fc-bbf1b28dfac5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:38');
INSERT INTO `s_page_role` VALUES ('c6fd29d4-1bb9-40f2-91b4-b47be3db72a0', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:18');
INSERT INTO `s_page_role` VALUES ('c74316a2-41e1-489b-aa20-215199bc2840', '2dc7b0aa-e46e-4583-9738-72e71de1426c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:13');
INSERT INTO `s_page_role` VALUES ('c75bdedd-1e0c-4a56-9783-4724ec7045a0', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:22');
INSERT INTO `s_page_role` VALUES ('c785808b-9951-4f97-8fec-1037e797ae0e', '41220884-50a6-4204-8168-f8e3eb5ad2ce', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:27');
INSERT INTO `s_page_role` VALUES ('c791d2a6-924c-4582-8505-e8fea281a479', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:48');
INSERT INTO `s_page_role` VALUES ('c8171143-ff8c-49b1-aa73-3ef4b9014e78', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:58');
INSERT INTO `s_page_role` VALUES ('c88715d6-a279-42a4-8ee1-03b92152b074', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:44');
INSERT INTO `s_page_role` VALUES ('c8ea16e2-79ad-42c3-b76a-883b4d4a4724', 'caf65c04-beed-11e7-959c-38d547b81379', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:43');
INSERT INTO `s_page_role` VALUES ('c970d4ec-fce8-421f-b9eb-090b86c8d4c9', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:13');
INSERT INTO `s_page_role` VALUES ('c9b7e47a-080c-439f-9f5c-d5259c4e811d', 'ce43305b-a658-4e8c-b864-10b6ee797429', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:36');
INSERT INTO `s_page_role` VALUES ('ca226d39-4697-410d-a0e1-412557015d79', '0277b5ce-acca-4f31-a43c-20585768c596', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:39');
INSERT INTO `s_page_role` VALUES ('ca5f2566-cd8a-4628-a730-da6449b57d38', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:21');
INSERT INTO `s_page_role` VALUES ('ca9b9c64-ccd9-11e7-b07e-24fd52935962', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:03');
INSERT INTO `s_page_role` VALUES ('cb0383f9-b8eb-4935-8184-30276f350193', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:41:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:41:58');
INSERT INTO `s_page_role` VALUES ('cb165983-89b6-40f7-abd9-f24449f12fd6', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:11');
INSERT INTO `s_page_role` VALUES ('cb1fe717-69b3-40ba-8c23-2bbec9927b3e', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:49');
INSERT INTO `s_page_role` VALUES ('cc1b6982-85ad-468f-bc48-5628e7b166f0', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:42');
INSERT INTO `s_page_role` VALUES ('cc2c9f40-8f5d-414e-a342-9cda9523b1ef', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:46');
INSERT INTO `s_page_role` VALUES ('cc2e0288-62cc-4821-b7a5-afa6f9261ce8', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:02');
INSERT INTO `s_page_role` VALUES ('cc73891a-fb0f-4b71-bc12-c2bec2190ee0', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:31');
INSERT INTO `s_page_role` VALUES ('cca00a14-7794-450e-9cce-7c006b345a7d', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:23');
INSERT INTO `s_page_role` VALUES ('ccbbfe99-3cdd-4b58-b6bd-dc5820f31e16', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:15');
INSERT INTO `s_page_role` VALUES ('cce81da0-033e-4880-b695-7538293d73d6', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:14');
INSERT INTO `s_page_role` VALUES ('cd03a4bd-97b4-4b2f-8631-641f3ed245fc', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:21');
INSERT INTO `s_page_role` VALUES ('cd50d009-7db3-46c2-9f47-0e2eac44a7ba', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:24');
INSERT INTO `s_page_role` VALUES ('cd5414b1-9715-4fa1-a996-007e31aa5417', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:19');
INSERT INTO `s_page_role` VALUES ('cd976fd8-9aee-4de3-a21d-1e3d349721fd', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:28');
INSERT INTO `s_page_role` VALUES ('ce04cfcd-4809-4321-aaca-9be5e869b73e', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:25');
INSERT INTO `s_page_role` VALUES ('ce05a5bb-278b-415d-9d93-f14678fd7308', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:02');
INSERT INTO `s_page_role` VALUES ('ce14377d-f314-4ab6-ba8f-ae600e7016d0', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:53');
INSERT INTO `s_page_role` VALUES ('ce384a00-c88b-4a79-a96b-74c43945c4fb', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:46');
INSERT INTO `s_page_role` VALUES ('ce4ab591-49f8-494a-b4cc-18bb5f3a3f37', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:32');
INSERT INTO `s_page_role` VALUES ('ce7bae32-c358-4e07-a91f-22bea1a06653', '20692517-9187-41df-920b-7c7342a93d37', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:32');
INSERT INTO `s_page_role` VALUES ('cebfd65b-4ba3-48ed-be7f-362c868f6aac', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:53');
INSERT INTO `s_page_role` VALUES ('cec65957-4e26-42c9-b329-1185393e740d', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:21');
INSERT INTO `s_page_role` VALUES ('cf1ece1e-55ff-4622-b016-e9e62d9dcec4', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:55');
INSERT INTO `s_page_role` VALUES ('cf43f9fb-e2e6-4fbc-bbed-9cfcb682c4f8', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:08');
INSERT INTO `s_page_role` VALUES ('cf44b720-e3d3-4289-a3b9-962f1fa83c9f', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:38');
INSERT INTO `s_page_role` VALUES ('cf7493a1-0e95-4693-a464-daeb5ffc9bd4', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:46');
INSERT INTO `s_page_role` VALUES ('cff06d81-8833-460c-a0d2-4386cb30fcab', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:29');
INSERT INTO `s_page_role` VALUES ('d03df047-cf6a-414e-bf9a-bc714bd4e9fc', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:02');
INSERT INTO `s_page_role` VALUES ('d09d02b9-3480-4f27-acfa-95d67eb08841', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:48');
INSERT INTO `s_page_role` VALUES ('d0f06bbb-ccd9-11e7-b07e-24fd52935962', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:14');
INSERT INTO `s_page_role` VALUES ('d129c794-7794-4259-acfb-5a50e7deaea1', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 23:29:42');
INSERT INTO `s_page_role` VALUES ('d1e02f4e-99b6-471c-8e15-2046aee7d8ff', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:58');
INSERT INTO `s_page_role` VALUES ('d2026586-87c1-41c2-afc5-984d48021cf6', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:39:36');
INSERT INTO `s_page_role` VALUES ('d22ee122-fedf-42b1-b9bc-6341ac426aba', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:49');
INSERT INTO `s_page_role` VALUES ('d275b505-2c04-4a6e-81d5-cd7abb44af09', '2c68aa86-891b-4661-ba76-327e8a2a6215', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:08');
INSERT INTO `s_page_role` VALUES ('d2df2ad7-f940-4741-8b8c-1c6f026889d5', 'ce43305b-a658-4e8c-b864-10b6ee797429', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:34');
INSERT INTO `s_page_role` VALUES ('d2e0f127-6f93-4911-9282-f5969266b64c', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:50');
INSERT INTO `s_page_role` VALUES ('d345ef8f-4645-4843-9745-8774314f8cd5', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:04');
INSERT INTO `s_page_role` VALUES ('d39aeb0d-b9c2-47c4-bd8c-53b2c3dbb010', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:09');
INSERT INTO `s_page_role` VALUES ('d3e5e467-160b-4f48-a897-e2f31cbac50b', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:54');
INSERT INTO `s_page_role` VALUES ('d3ead305-a1b4-4177-b6ac-1ecacc8cf4ce', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:06');
INSERT INTO `s_page_role` VALUES ('d456e17d-7da1-4a6c-a7af-9a76fceff0a6', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:20');
INSERT INTO `s_page_role` VALUES ('d4869692-e7ab-47e8-b71c-76d522a0528a', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:57');
INSERT INTO `s_page_role` VALUES ('d4b76915-12f2-4be4-a7ca-bcd12ee40a67', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:09');
INSERT INTO `s_page_role` VALUES ('d4bbad42-e01a-4d8e-8109-b6c3abe7f82e', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:51');
INSERT INTO `s_page_role` VALUES ('d4d4c103-4099-4ab8-a294-84adf12e2f43', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:29');
INSERT INTO `s_page_role` VALUES ('d54537a9-3704-40d8-926b-675cbfb5d092', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:46');
INSERT INTO `s_page_role` VALUES ('d56c48d2-94a1-4415-849b-ffc021e2a5ff', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:49');
INSERT INTO `s_page_role` VALUES ('d5dc4eda-6ea4-46c4-8a0d-3cca65177c5e', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:49');
INSERT INTO `s_page_role` VALUES ('d5f79392-4bf8-4191-9ad5-120405501ede', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:12');
INSERT INTO `s_page_role` VALUES ('d616cd91-a77d-4c8b-a1f0-51fe8ad00ccb', '02886d5a-211c-4e58-800c-90cf79640ef5', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:11', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:11');
INSERT INTO `s_page_role` VALUES ('d62cbf1c-ccd9-11e7-b07e-24fd52935962', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:23', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:23');
INSERT INTO `s_page_role` VALUES ('d63dcac0-7b94-4ca9-bfd5-4b573be6aec2', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:03');
INSERT INTO `s_page_role` VALUES ('d6c5bedf-a5d0-4eec-8012-14981608f3a9', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:43', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:43');
INSERT INTO `s_page_role` VALUES ('d6dbe90a-6c86-4557-9bfb-2729e87c3ccc', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:48');
INSERT INTO `s_page_role` VALUES ('d777a574-f70d-4945-9f7c-4acc4adbe20c', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:17');
INSERT INTO `s_page_role` VALUES ('d7b18c0a-b97b-4e8e-b4fc-df93c0c6c492', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:57');
INSERT INTO `s_page_role` VALUES ('d843aa92-3321-4904-91a2-b57d4791a2ba', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:53');
INSERT INTO `s_page_role` VALUES ('d8895364-5ec2-46d5-9f59-e779fae092ad', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:07');
INSERT INTO `s_page_role` VALUES ('d8a85b62-e3e3-4d15-b07b-0fe04f27bfda', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:16');
INSERT INTO `s_page_role` VALUES ('d8ee9f2b-e184-4495-ad7a-3499fa501229', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:03:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:03:56');
INSERT INTO `s_page_role` VALUES ('d9af98fe-e22a-4f91-b987-cb7cdf27b0a4', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:50');
INSERT INTO `s_page_role` VALUES ('da3b01f5-d782-4809-a2fc-72e88d618d1c', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:27');
INSERT INTO `s_page_role` VALUES ('da6cce00-1a7c-4137-b321-fe667b67030d', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:09');
INSERT INTO `s_page_role` VALUES ('da8f6635-76c0-4f5a-a26e-55c103f6360d', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:22');
INSERT INTO `s_page_role` VALUES ('db43422f-2410-462f-b0b4-72ca7f9d24ff', '682cc88a-5424-4f14-8298-bf19a8c1a726', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:40');
INSERT INTO `s_page_role` VALUES ('db5e94f5-c98e-4ce0-91d2-81b2c406e125', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:48');
INSERT INTO `s_page_role` VALUES ('db61db80-2c9c-432e-96cd-ba243e08c89d', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:15');
INSERT INTO `s_page_role` VALUES ('db62a912-c2cf-4205-9400-204af2acf516', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:14');
INSERT INTO `s_page_role` VALUES ('db7ff3ff-76b9-4065-be18-85363614dd7c', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:01');
INSERT INTO `s_page_role` VALUES ('dbbcc22a-c265-40a1-aab7-a986f70ceeef', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:48');
INSERT INTO `s_page_role` VALUES ('dc2d1ff3-bca5-4490-98f8-def7b72989ae', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:31');
INSERT INTO `s_page_role` VALUES ('dc5f605e-9d81-48bc-ae4d-d5d3e49fdfca', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:29');
INSERT INTO `s_page_role` VALUES ('dcaa2e3d-4783-41d4-bc75-4a79c10da2ef', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:19');
INSERT INTO `s_page_role` VALUES ('dce2af65-6ab5-47a8-92f2-5c977b410148', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:31');
INSERT INTO `s_page_role` VALUES ('dd0d2a34-2f19-4765-94ab-bc0b688b58de', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:52');
INSERT INTO `s_page_role` VALUES ('dd0eac49-ccd9-11e7-b07e-24fd52935962', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:34');
INSERT INTO `s_page_role` VALUES ('dd78c981-1f4c-40b2-863d-e0a9e43fc206', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:49');
INSERT INTO `s_page_role` VALUES ('dda029b3-2fd7-4729-9658-983d2683bed0', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:01');
INSERT INTO `s_page_role` VALUES ('dda59241-e8d3-4a37-8017-5210e17db839', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:03');
INSERT INTO `s_page_role` VALUES ('ddb7f2cc-8f4c-4197-99d6-eaaa1a1fb3a5', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:04');
INSERT INTO `s_page_role` VALUES ('de0b6a9a-5d0e-4181-ba75-4f9d67059831', '0277b5ce-acca-4f31-a43c-20585768c596', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:13');
INSERT INTO `s_page_role` VALUES ('de4f341e-41cd-4ac4-8898-98b07d2a265f', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:01');
INSERT INTO `s_page_role` VALUES ('de89694a-b104-43e1-b2d8-0aeeabae9150', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:14');
INSERT INTO `s_page_role` VALUES ('dea98dbe-9843-4bd3-8b4c-3af8595eab1d', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:54');
INSERT INTO `s_page_role` VALUES ('df5243fb-9eb9-4cc4-b4bc-829fc7d7e6a8', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:59');
INSERT INTO `s_page_role` VALUES ('dfdadb44-9ae4-4836-98bb-bd63f2d35118', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:17');
INSERT INTO `s_page_role` VALUES ('e044daef-b5de-494d-ba91-e05d9c08a060', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:25');
INSERT INTO `s_page_role` VALUES ('e05754b4-f8d4-4564-ac13-c6bd487a8556', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:51');
INSERT INTO `s_page_role` VALUES ('e05efa02-15e8-4917-aaa7-388b8362d755', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:20');
INSERT INTO `s_page_role` VALUES ('e0add266-8920-448b-9991-8c36d9d2e0e7', '162e38d7-5b27-488b-9776-e60d7aa07b68', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:12');
INSERT INTO `s_page_role` VALUES ('e0b14634-4ae5-4ad0-b393-be6eb642c281', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:45');
INSERT INTO `s_page_role` VALUES ('e1268312-eee5-4663-9f77-8a3f3bb2b5c0', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:22', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:22');
INSERT INTO `s_page_role` VALUES ('e15d21d0-7bd4-418c-aa1c-21779d9a143b', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:19');
INSERT INTO `s_page_role` VALUES ('e17d31a2-844e-43b3-a7dd-d4a8a93e0e87', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:23:04');
INSERT INTO `s_page_role` VALUES ('e18f80e1-c5d9-4ac2-93b8-65afe4f18813', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:19');
INSERT INTO `s_page_role` VALUES ('e1b0637b-d514-431b-959d-32f5a80eb57f', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:14');
INSERT INTO `s_page_role` VALUES ('e1d6f7e5-edda-41f1-b902-f22f33e6b1b7', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:46');
INSERT INTO `s_page_role` VALUES ('e1d7517f-890a-44e7-917c-e1198f8bf73a', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:33');
INSERT INTO `s_page_role` VALUES ('e2713994-44d1-40e2-99a5-e9a6f3455379', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:56');
INSERT INTO `s_page_role` VALUES ('e2f4e4c1-bb81-4308-8d5d-8d1c19a27845', '3dacb910-a325-4939-aec5-f1e05218513c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:49');
INSERT INTO `s_page_role` VALUES ('e36216ab-0482-43ad-b533-08eee88ce014', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:36');
INSERT INTO `s_page_role` VALUES ('e36b96d7-2d81-4df0-b5d1-1f5b5992f1ab', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:17');
INSERT INTO `s_page_role` VALUES ('e3c67641-8f6b-4f09-81a2-b47287cc1c3c', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:59');
INSERT INTO `s_page_role` VALUES ('e3d4dd30-77ef-4633-8856-c9be7c98838d', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:55', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:55');
INSERT INTO `s_page_role` VALUES ('e3f5810a-11cd-44b8-9b93-80ad4fb01010', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:48');
INSERT INTO `s_page_role` VALUES ('e456183f-c532-4502-ac5b-ce7603e591fb', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:56');
INSERT INTO `s_page_role` VALUES ('e4742be7-1217-4545-a067-b8d7d7fa82dc', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:06');
INSERT INTO `s_page_role` VALUES ('e50dc9b1-1c19-4c85-b49f-2662357113d3', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:04', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:04');
INSERT INTO `s_page_role` VALUES ('e5c003a6-e0b6-4886-a902-8fdc929dc6b6', '3dacb910-a325-4939-aec5-f1e05218513c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:49');
INSERT INTO `s_page_role` VALUES ('e5eb0f56-ccd9-11e7-b07e-24fd52935962', 'caf65c04-beed-11e7-959c-38d547b81379', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-19 11:29:49');
INSERT INTO `s_page_role` VALUES ('e5ef03e4-3980-424d-81c7-3e343975f1df', '5863e4f5-927d-4c96-8bda-2294703bc909', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:26');
INSERT INTO `s_page_role` VALUES ('e5f19360-d7ac-49d3-ac88-c7cf8bcb2634', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:03');
INSERT INTO `s_page_role` VALUES ('e6137328-db20-4dba-9a37-0bb314035ab2', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:25', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:44:25');
INSERT INTO `s_page_role` VALUES ('e6307870-aa9d-46d5-b704-b2f856fdf973', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:46');
INSERT INTO `s_page_role` VALUES ('e6342063-f231-4ab1-b212-bc246a551c64', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:18');
INSERT INTO `s_page_role` VALUES ('e6991522-feed-4167-bb97-c2ff9a16fe67', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:58');
INSERT INTO `s_page_role` VALUES ('e6c58554-59df-4b1a-a2d6-7d5738613596', '0a1e90f6-cc25-11e7-843e-24fd52935962', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:03:00');
INSERT INTO `s_page_role` VALUES ('e6d5c234-0eb6-4517-9731-45f61ee6e80f', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:13');
INSERT INTO `s_page_role` VALUES ('e7317461-92f1-487a-b225-eb2a6d87236b', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:49');
INSERT INTO `s_page_role` VALUES ('e81d39ea-4538-4165-a88c-7a9911bbf2db', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:35');
INSERT INTO `s_page_role` VALUES ('e833f5b8-e22b-4aeb-ad9e-6f247eee3a5f', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:24');
INSERT INTO `s_page_role` VALUES ('e8b1dc5b-9fac-431d-a4e1-b6a79bd7b0f2', '55638077-269d-41fc-981e-d6f8eeaee8f3', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:07');
INSERT INTO `s_page_role` VALUES ('e91c7100-0da4-4c63-8e44-aeac84d5b396', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:29', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:29');
INSERT INTO `s_page_role` VALUES ('e92df18f-0406-4e3f-bd1e-6b62ee6888e6', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:45');
INSERT INTO `s_page_role` VALUES ('e959be1c-e6aa-47c6-b96e-bad7e39b9981', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-20 20:26:26');
INSERT INTO `s_page_role` VALUES ('e9bfb256-1956-43fd-b8ba-cd65bbf13cac', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:05:00');
INSERT INTO `s_page_role` VALUES ('ea0d72e1-40f1-4848-b1fc-c1fcacff0698', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:38');
INSERT INTO `s_page_role` VALUES ('ea138998-64fa-4592-a1db-f4b93ff34492', '3dacb910-a325-4939-aec5-f1e05218513c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:50', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:50');
INSERT INTO `s_page_role` VALUES ('ea13d151-96ed-4b89-b7e9-632225bf29a8', '682cc88a-5424-4f14-8298-bf19a8c1a726', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:40');
INSERT INTO `s_page_role` VALUES ('ea3f6d1e-c700-4877-9a8b-e87483f0c2d7', '0a1e90f6-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-23 21:35:46');
INSERT INTO `s_page_role` VALUES ('ea466613-c9c4-4c47-bc2f-e74c951d5e42', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:18');
INSERT INTO `s_page_role` VALUES ('ea49b9de-515b-48a0-802e-09aa13a348f3', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:00');
INSERT INTO `s_page_role` VALUES ('eaee4614-bfa6-43e6-b5d3-2876f9abf476', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:16');
INSERT INTO `s_page_role` VALUES ('eb01f894-3c82-4b32-be90-451fac2cb8e6', '96e55b56-ab35-4774-a248-14a683a932e7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:02:40');
INSERT INTO `s_page_role` VALUES ('eb4e1fdc-c50c-4d6f-af9b-9229ad7d795b', '3dacb910-a325-4939-aec5-f1e05218513c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:24:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:24:10');
INSERT INTO `s_page_role` VALUES ('ebb9497f-33b2-42b9-aea8-cab7c3f3e99c', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:06');
INSERT INTO `s_page_role` VALUES ('ebff6e98-d797-4d36-8cfd-e5af8d3b2a4e', '55f9ecb5-b899-4321-952f-64a1f579d2c2', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:20');
INSERT INTO `s_page_role` VALUES ('ec69f624-15fd-4aa7-babe-191e31b52888', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:03:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 23:03:01');
INSERT INTO `s_page_role` VALUES ('ec86ca7f-d6e6-4fd7-8f62-c0d92e1b6631', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:20');
INSERT INTO `s_page_role` VALUES ('ec993411-82d4-4a78-97b1-c47ac6833541', 'ce43305b-a658-4e8c-b864-10b6ee797429', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:09');
INSERT INTO `s_page_role` VALUES ('eca3eafd-1466-4151-91c4-71a16c4880eb', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:53', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:53');
INSERT INTO `s_page_role` VALUES ('ecb0ed3e-0ec6-4a0d-bf3f-ec82958b9e38', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:31');
INSERT INTO `s_page_role` VALUES ('ed62853f-cc57-43a8-9166-dfe990dc5c51', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:26');
INSERT INTO `s_page_role` VALUES ('edbc7725-7e7c-4052-a996-105948ffd67e', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:19', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:19');
INSERT INTO `s_page_role` VALUES ('edbd0508-40ef-4a3c-b150-67db24c6186d', '55638077-269d-41fc-981e-d6f8eeaee8f3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:32');
INSERT INTO `s_page_role` VALUES ('edeb4021-bf49-4a5a-bbcd-ba4f32e900bd', '02886d5a-211c-4e58-800c-90cf79640ef5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:03:21');
INSERT INTO `s_page_role` VALUES ('ef5405bd-d6e3-42d5-8f7a-4d2c8b1537bf', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:00');
INSERT INTO `s_page_role` VALUES ('ef68d492-096e-46a2-8ec7-a3a0d256e76e', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:14');
INSERT INTO `s_page_role` VALUES ('ef75d802-1a72-4c25-9ea2-2383285d6904', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:40:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:40:01');
INSERT INTO `s_page_role` VALUES ('efd1d268-1660-4d40-b159-1abb26698352', '162e38d7-5b27-488b-9776-e60d7aa07b68', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:08', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:38:08');
INSERT INTO `s_page_role` VALUES ('f078cce2-d524-41d1-940d-f50d88726aca', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:59');
INSERT INTO `s_page_role` VALUES ('f0b39d28-8290-436f-a1b5-341dcf9ba5a8', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:27', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:27');
INSERT INTO `s_page_role` VALUES ('f1191880-57f4-48cf-bc50-57eab84ef2e2', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:42', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:42');
INSERT INTO `s_page_role` VALUES ('f142186a-2591-40ee-bad9-7d231514a924', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:26');
INSERT INTO `s_page_role` VALUES ('f188171b-2ac4-4ee2-a8aa-a6c3e0efc23f', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:40', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:40');
INSERT INTO `s_page_role` VALUES ('f20153b2-7a2a-40d1-8efe-0df21c0987f6', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:49');
INSERT INTO `s_page_role` VALUES ('f20ffba9-7193-4862-8377-5e9f1316c6e2', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:02');
INSERT INTO `s_page_role` VALUES ('f34ca4ed-0bd8-4861-885b-a0b2538148f6', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:09', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:09');
INSERT INTO `s_page_role` VALUES ('f37fd2a8-9016-45d8-98a1-61e8084da693', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:17');
INSERT INTO `s_page_role` VALUES ('f40cd7ad-f817-406d-bbe2-f2ad9a667a94', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:34');
INSERT INTO `s_page_role` VALUES ('f4104582-97d0-423c-952d-e0dd7b0f9a55', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:57');
INSERT INTO `s_page_role` VALUES ('f4489827-6464-4d1f-957e-aad0243059f1', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:49:24');
INSERT INTO `s_page_role` VALUES ('f4538551-5373-4c13-b2b6-ba92585aadae', 'b246e414-5c86-468e-81e0-0edf77710e3f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:45');
INSERT INTO `s_page_role` VALUES ('f49f0f1e-b7c4-4cce-b5b9-365be9de0c0b', '682cc88a-5424-4f14-8298-bf19a8c1a726', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:46:51');
INSERT INTO `s_page_role` VALUES ('f4a3b17b-9563-4c59-befb-0226bab29610', '3dacb910-a325-4939-aec5-f1e05218513c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:34', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:17:34');
INSERT INTO `s_page_role` VALUES ('f50ab5e3-cf67-4133-92ca-0ad3c26754da', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:28');
INSERT INTO `s_page_role` VALUES ('f574de8f-972f-4583-b210-23789dfac8bf', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:45:01');
INSERT INTO `s_page_role` VALUES ('f5a64d94-6b06-49bd-9756-a6b359f9a783', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:32', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:32');
INSERT INTO `s_page_role` VALUES ('f649cd51-fd14-4859-8150-b324ea991e4e', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:20', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:20');
INSERT INTO `s_page_role` VALUES ('f64a1385-983b-4556-a68d-14a4a51bbc8e', 'df1a659b-180f-4fd2-abb0-b42c7db62714', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:39', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:39');
INSERT INTO `s_page_role` VALUES ('f65e82bd-ef86-4307-9f51-ea88f8121807', 'ce43305b-a658-4e8c-b864-10b6ee797429', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:14:33');
INSERT INTO `s_page_role` VALUES ('f65ec14b-18e7-4a0f-b5af-640c794aef7b', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:17:44');
INSERT INTO `s_page_role` VALUES ('f6c37b80-fd72-494a-ad25-2d0369e42aa7', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:26');
INSERT INTO `s_page_role` VALUES ('f6dcf20c-2bdc-4aaa-8bcb-94ad3e07aae5', '02886d5a-211c-4e58-800c-90cf79640ef5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:45', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:45');
INSERT INTO `s_page_role` VALUES ('f6fd0b34-637d-4c6b-a2e6-68438f59c121', '5863e4f5-927d-4c96-8bda-2294703bc909', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:01', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:01');
INSERT INTO `s_page_role` VALUES ('f74025a9-2af5-4853-bea4-d01320dc7e6a', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:15:00');
INSERT INTO `s_page_role` VALUES ('f78fdbbd-6387-497e-8788-a4874cddf5e6', 'd942abc1-b177-452e-8c53-1914ac448c7d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 15:19:13');
INSERT INTO `s_page_role` VALUES ('f7e6755b-2b53-4c1d-a5b5-344c48e1a8f6', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:56', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:56');
INSERT INTO `s_page_role` VALUES ('f7e6d269-e262-4d59-b4ce-bdc88a845aa5', 'd07687ef-2798-11e5-965c-000c29d7a3a0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:36:03');
INSERT INTO `s_page_role` VALUES ('f7ed72a4-a861-4711-ae86-a1c2205ec5ae', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:21:00');
INSERT INTO `s_page_role` VALUES ('f84afcca-2f12-4986-9e95-5ca546fec17f', '9d377b71-bd84-47b6-a4f3-c08a24703b08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-27 18:15:24');
INSERT INTO `s_page_role` VALUES ('f84fa0d9-7e87-4ac4-88ed-e40372d62189', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:58', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:58');
INSERT INTO `s_page_role` VALUES ('f8be31eb-342c-46cb-b609-974f34c36e92', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-23 23:02:54');
INSERT INTO `s_page_role` VALUES ('f92a3b7e-c89f-4543-a992-f8b9db17b9f1', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:14', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:14');
INSERT INTO `s_page_role` VALUES ('f96d6f90-55ab-4e51-b091-d0d8da2fe6c0', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:54', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:54');
INSERT INTO `s_page_role` VALUES ('f99a98a0-a71d-43a6-bccd-f3c90df8f2d3', '0277b5ce-acca-4f31-a43c-20585768c596', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:26', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:45:26');
INSERT INTO `s_page_role` VALUES ('f99c364a-0c64-4195-af35-9bc17074190f', 'b246e414-5c86-468e-81e0-0edf77710e3f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:31', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:31');
INSERT INTO `s_page_role` VALUES ('fa326ab1-8ba3-4439-b3a6-d816ed1b6558', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:30');
INSERT INTO `s_page_role` VALUES ('fa48bf4a-3529-4028-9ed1-11868563994d', '2bb748c6-224b-4fff-a3c2-82b684faf56d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:44:57');
INSERT INTO `s_page_role` VALUES ('fa7c986d-187f-4b86-b82e-419d426135ac', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:52');
INSERT INTO `s_page_role` VALUES ('faa68fa4-1d98-4f27-b76c-39c3bae97a45', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:30', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:30');
INSERT INTO `s_page_role` VALUES ('face3fc3-88ca-4e18-83ee-3850afcd1499', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:15', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:15');
INSERT INTO `s_page_role` VALUES ('fb3448e1-7636-42c1-964d-c3c573a8d7d4', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:18');
INSERT INTO `s_page_role` VALUES ('fbe67745-d711-417b-b46d-2c87da81b57d', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:22:59');
INSERT INTO `s_page_role` VALUES ('fc34153b-47f2-4b84-9d5a-047b1ea82910', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-25 17:42:02');
INSERT INTO `s_page_role` VALUES ('fc5aa26b-2821-4f7a-b950-1026b5b41fc7', '514111b1-1e3d-472f-8f47-02ae0bae13e9', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9bda9313-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:03:59', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:03:59');
INSERT INTO `s_page_role` VALUES ('fc747e02-de80-4c13-9585-3606295bc43b', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:49', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-07 15:25:49');
INSERT INTO `s_page_role` VALUES ('fcd8471e-7001-4f85-93fb-7bf4de637246', 'b246e414-5c86-468e-81e0-0edf77710e3f', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:06', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:20:06');
INSERT INTO `s_page_role` VALUES ('fd545369-4df0-4f8b-aca8-260ed346fce2', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:46', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:46');
INSERT INTO `s_page_role` VALUES ('fd631cc1-eaea-4771-b174-3d52d57bb08b', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'deed64de-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:36', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:36');
INSERT INTO `s_page_role` VALUES ('fd69d1ac-ae0e-4a0a-9148-2393a448a385', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d590186-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:05', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:23:05');
INSERT INTO `s_page_role` VALUES ('fdd243c9-2cf6-4aae-937b-e32ba07dfd63', '2c68aa86-891b-4661-ba76-327e8a2a6215', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fea1871b-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:52', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:16:52');
INSERT INTO `s_page_role` VALUES ('fe66a627-5617-42e0-8e1f-a8a71bbcdb67', '2c68aa86-891b-4661-ba76-327e8a2a6215', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:37:57');
INSERT INTO `s_page_role` VALUES ('feb59b50-743f-4ad0-985a-b945e2d7ec46', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:21', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:48:21');
INSERT INTO `s_page_role` VALUES ('fef35ffb-d7cf-48cd-ba71-b74453db24b9', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9e15db46-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:16', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:19:16');
INSERT INTO `s_page_role` VALUES ('fefe9210-9307-4141-bf08-e54707f7779b', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:51', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:47:51');
INSERT INTO `s_page_role` VALUES ('ff0fed30-a894-4ba3-9ef8-a7015092bd5f', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:24', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:04:24');
INSERT INTO `s_page_role` VALUES ('ff1d2bd2-f7fc-4b80-86ed-a0f38a431acd', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c50dc6f7-b35b-4294-959e-e6e79abffc1e', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:00', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:25:00');
INSERT INTO `s_page_role` VALUES ('ff4182b7-3106-4a81-9fad-26db55b190c6', '5863e4f5-927d-4c96-8bda-2294703bc909', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'de46c408-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:28', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:18:28');
INSERT INTO `s_page_role` VALUES ('ff493225-c6e1-4a63-a36f-3bddb03ee6ac', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8978edce-c9c6-11e7-8126-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:35', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-20 10:43:35');

-- ----------------------------
-- Table structure for s_roles
-- ----------------------------
DROP TABLE IF EXISTS `s_roles`;
CREATE TABLE `s_roles` (
  `id` varchar(36) NOT NULL COMMENT '角色id',
  `name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `description` varchar(500) DEFAULT NULL COMMENT '角色描述',
  `type` int(11) DEFAULT NULL COMMENT '角色类别',
  `status` int(1) NOT NULL DEFAULT '1',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_roles
-- ----------------------------
INSERT INTO `s_roles` VALUES ('0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '厂长', '厂长角色', '1', '1', '2018-01-16 18:38:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:38:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_roles` VALUES ('0C03F6B6-8CC4-4826-8A51-149990861BE3', '门店', '门店角色', '1', '1', '2017-11-01 17:32:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-01 17:32:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_roles` VALUES ('257ae84e-d86a-11e6-ba64-d8490bd28593', '管理员', '管理员', '1', '1', '2017-11-01 14:32:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-01 14:32:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_roles` VALUES ('d2b9b0cd-d52d-48eb-8811-f71dad818ea1', '质检', '质检角色', '1', '1', '2018-01-16 23:47:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:47:10', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_roles` VALUES ('f8692cd2-e801-11e4-8fee-40167e64eefd', '系统管理员', '系统管理员', '1', '1', '2017-11-01 11:32:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-01 11:32:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_roles` VALUES ('ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '财务', '财务角色', '1', '1', '2018-01-16 18:36:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:36:07', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');

-- ----------------------------
-- Table structure for s_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `s_role_menu`;
CREATE TABLE `s_role_menu` (
  `id` varchar(36) NOT NULL,
  `role_id` varchar(36) DEFAULT NULL COMMENT '角色ID',
  `menu_id` varchar(36) NOT NULL COMMENT '菜单ID',
  `status` int(1) NOT NULL DEFAULT '1',
  `create_id` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_role_menu
-- ----------------------------
INSERT INTO `s_role_menu` VALUES ('00457726-22d1-4485-bc85-7a723c37eec8', '257ae84e-d86a-11e6-ba64-d8490bd28593', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('013fe808-43fb-4817-afc6-35fd3c62972e', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'ce43305b-a658-4e8c-b864-10b6ee797429', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('015f2644-1d41-4250-8e81-3c59767c9189', 'c716be42-78c2-4c80-8c88-25814b2e683b', '43d5b520-eafe-4f7f-a846-4fba12c9ffab', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('05c5cf15-9fd9-47f2-b03a-3607de630666', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'caf65c04-beed-11e7-959c-38d547b81379', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('091eab92-d53b-45d9-9d56-8609905eb2f5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '5863e4f5-927d-4c96-8bda-2294703bc909', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('0c00848c-7228-493c-ab22-75bb134623f0', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'ce43305b-a658-4e8c-b864-10b6ee797429', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('0cf0f74d-bcc5-4814-a737-4f37f068c37d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('0ed383da-d544-45c9-816d-bab214b80032', '257ae84e-d86a-11e6-ba64-d8490bd28593', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('0ef372e4-dd4a-4267-a195-c49edd3e5bc6', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'c3538d54-8e09-11e6-b311-005056812bf6', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('0f376505-c36f-42e8-81e6-21ab406ca3db', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('108821cb-5b55-4a0b-9bb0-fa893130fc7b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('117f61b3-18c0-459c-84f5-138e8405f483', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'f5baa02f-7e39-421f-a7dd-c8ee4773966b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('11826290-08f5-45e6-a651-bf3513aba74e', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '0a1e90f6-cc25-11e7-843e-24fd52935962', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:10');
INSERT INTO `s_role_menu` VALUES ('120a99d6-f198-466d-a642-a3a3501a3cda', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('12abba29-8284-48b0-9fd9-06c28ee9d359', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('12de943e-d491-46ec-a046-8bc63ea70620', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'c3538d54-8e09-11e6-b311-005056812bf6', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('152fa507-9961-4116-a255-3db1fee59159', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'd942abc1-b177-452e-8c53-1914ac448c7d', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:10');
INSERT INTO `s_role_menu` VALUES ('16174b7e-4c99-486d-98dc-1dd85bfcc247', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '68522995-30dc-4fb0-97d8-7468e6af4853', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('188d4fc9-663c-47ec-a59b-126611c4ed0c', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '97ea6edb-1178-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('199bb34c-ff79-4a31-9586-5c1dbf7f965e', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('1baca17f-f581-4784-a76e-7fe6268b50f7', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'c3538d54-8e09-11e6-b311-005056812bf6', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('1e44ec98-27dc-4e98-837d-8cb7ec07cdcb', '257ae84e-d86a-11e6-ba64-d8490bd28593', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('2119d8a7-9253-43cb-87d7-af6c7cf8eba5', '257ae84e-d86a-11e6-ba64-d8490bd28593', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('2211076e-01d3-4aa3-bf28-cec3b2912083', '257ae84e-d86a-11e6-ba64-d8490bd28593', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('2329bec1-4eda-4f74-b256-8b6ea2b98e96', '257ae84e-d86a-11e6-ba64-d8490bd28593', '96e55b56-ab35-4774-a248-14a683a932e7', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:22');
INSERT INTO `s_role_menu` VALUES ('2343e0c2-d067-11e7-a807-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '33fb6e82-2b8b-48fb-af3c-fb886049ca77', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('23879256-29fb-4fd0-a0e2-27cdbbdd99f5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('23d6664b-ae04-4f84-9bc9-c8b688489357', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('2435dc46-e51e-4253-849b-8f554b5665c8', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('265fb67d-6489-4f04-bae3-7555eb7cc6f8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('26a7ad9f-ff89-4345-8c6b-95d0f95a242d', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('2700c504-367d-4c2f-bd99-ad5f919768cb', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'e4b9b1d7-79da-4490-9bce-5d2a78d150b9', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('28987f86-4ac8-460c-a581-fd7be0d9c124', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'fb69a533-1178-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('29805307-37f1-407f-82e9-aa989369c2a5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '20692517-9187-41df-920b-7c7342a93d37', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('2ca5b61e-34ee-476d-b1a6-b2cb408edf65', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('2d6c3c96-12be-4e9e-a2bc-8e1d81c8fe7f', '257ae84e-d86a-11e6-ba64-d8490bd28593', '0277b5ce-acca-4f31-a43c-20585768c596', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('2eb6ba6d-4fb4-4691-9d4c-b23f7f07e3d1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('2ece302f-27c9-4a5a-a754-737d54aec452', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('2f3c57aa-4bef-412c-88f5-9e6ce376ff16', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('2f95acd0-d067-11e7-a807-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('31477da1-d021-49a9-884c-2ba4e8287a04', '257ae84e-d86a-11e6-ba64-d8490bd28593', '20692517-9187-41df-920b-7c7342a93d37', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('32020f2f-a94b-4645-863f-5c9acad7edd5', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('32d5e7f9-0b65-42a6-8a66-605ff09d1244', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('3686eea2-5a4c-48af-af9f-57e01cfc42ec', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '66f106c0-6be1-4a7c-bad2-e3b830c28d8b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('370072f7-8a1e-49f5-b3c7-aa2c557c1d9b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '5a90ce13-c8ce-43c6-a9ed-21fd4a4fb2c5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('3744e89c-a116-4783-9f47-bb935386ec41', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '5d2f2a0d-9326-4026-b338-c03bf6e255db', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('3d299846-657e-4b17-9b7e-f3c10e716632', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('3e0916ba-ef26-42f6-89b7-b014e72a66dc', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '02886d5a-211c-4e58-800c-90cf79640ef5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('3ebfa450-43ea-42e1-b650-23d5cabdd6f5', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('3f7b3895-6c89-4796-bc9b-d5ce07bebb73', '257ae84e-d86a-11e6-ba64-d8490bd28593', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('3fee64c8-5784-42bc-96ef-f7f9526fea6c', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('4041ef2e-0c8b-4e42-83f1-845ac19cfffe', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('444a9443-f1ec-4e87-9cec-ae682427674a', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:48:55');
INSERT INTO `s_role_menu` VALUES ('464c5be6-803b-494f-ae2f-055f328460f2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '55638077-269d-41fc-981e-d6f8eeaee8f3', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('478233a6-3ee8-42f5-93d5-5d06df2f2d4f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '96e55b56-ab35-4774-a248-14a683a932e7', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-28 21:54:07');
INSERT INTO `s_role_menu` VALUES ('49ea090b-1f1e-4e4b-baa5-fbbb392d474d', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'caf65c04-beed-11e7-959c-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:10');
INSERT INTO `s_role_menu` VALUES ('4a6ba0f4-00f8-461f-958d-d1d5884e1dbb', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('4d93d642-4992-4ee0-ba11-9ed25d785eff', '257ae84e-d86a-11e6-ba64-d8490bd28593', '5863e4f5-927d-4c96-8bda-2294703bc909', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('512ce723-cc25-11e7-843e-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '0a1e90f6-cc25-11e7-843e-24fd52935962', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('519d6387-4e6e-4ab9-976a-41b9b331edfa', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '2c68aa86-891b-4661-ba76-327e8a2a6215', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('53ad2c50-0c45-4db5-923e-52c5ff1d30b6', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:41:19');
INSERT INTO `s_role_menu` VALUES ('5497f879-7c96-41a7-a52c-5ecedf44f11d', '257ae84e-d86a-11e6-ba64-d8490bd28593', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('55fc33d9-1631-46af-992f-a1abb3857d29', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('574858b8-1fc1-4dea-b458-d46a88202051', 'c716be42-78c2-4c80-8c88-25814b2e683b', '10000000-0000-0000-0000-300000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('5830e971-74c3-444a-ba86-ae418ff6ac70', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'e38ab74b-bf14-11e7-a301-24fd52935962', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('58ac537e-c804-4114-bf8e-e2a95eef389d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('59e78d63-d836-4468-b39c-798672f57388', '257ae84e-d86a-11e6-ba64-d8490bd28593', '0a1e90f6-cc25-11e7-843e-24fd52935962', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('5b4dc37a-3cfa-4c91-84f5-7624cacc11a4', '257ae84e-d86a-11e6-ba64-d8490bd28593', '682cc88a-5424-4f14-8298-bf19a8c1a726', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('5bf77994-dd62-47ff-8492-de6689fd6e10', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'caa095d9-c2b9-45d9-89b1-3b75315c9940', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('5c6efcb2-62a1-4a80-860f-85556ff2ad96', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('5cc1d242-8b26-4768-87f5-b68168ebc0a7', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '2c68aa86-891b-4661-ba76-327e8a2a6215', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('5cd2a9d5-97bb-4cc7-912e-9d7f4931e803', '257ae84e-d86a-11e6-ba64-d8490bd28593', '67416840-6b15-473b-80fc-bbf1b28dfac5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:22');
INSERT INTO `s_role_menu` VALUES ('5e03e76a-5b01-4b50-99b6-ec088cbbe482', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '0bc54201-f2e3-4585-a9c7-bb5d9b44e26d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('60b693ab-a858-41cc-9996-51df6ce9d8f3', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('614e2550-7862-4705-973b-edbf75b0c4ff', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '682cc88a-5424-4f14-8298-bf19a8c1a726', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('63444c8b-9718-46c3-a290-bb637e80b638', 'c716be42-78c2-4c80-8c88-25814b2e683b', '2fe964ba-f060-47cf-8c81-fcd0ba615d63', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('636e1efb-36ee-4f35-b2c2-caf11790e587', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('64b94f39-d82a-4104-a784-523b28b8b1b9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '5863e4f5-927d-4c96-8bda-2294703bc909', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('67d4f9c9-c5da-4734-ad1d-512ab9e8c190', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('682452ae-3a55-4663-a292-aad9d3f34b89', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'e4b9b1d7-79da-4490-9bce-5d2a78d150b9', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('6b571011-cdf0-11e7-a0af-50465deb996e', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '76849bfe-dfd4-476c-b2f8-11072c25ceb8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('6b635317-1b02-43f3-b982-bd2b15414d6c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '0277b5ce-acca-4f31-a43c-20585768c596', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('6c3d1ba8-2277-4fbf-a1c1-22be49f4476f', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '10000000-0000-0000-0000-100000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:48:55');
INSERT INTO `s_role_menu` VALUES ('6c5b1ec4-b576-4a01-92de-28a5ee87b416', '257ae84e-d86a-11e6-ba64-d8490bd28593', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('6c9cbb56-6f97-44c1-a912-1106a5939ba2', '257ae84e-d86a-11e6-ba64-d8490bd28593', '2c68aa86-891b-4661-ba76-327e8a2a6215', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('6e179d0b-1999-4cd2-8d65-c74aeac86138', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '4bcab523-1174-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-14 17:13:46');
INSERT INTO `s_role_menu` VALUES ('71451f50-91c5-46bd-bd42-79fa2dd80e36', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '86b97cad-9b5d-4ab9-8bd6-fab7de92d5da', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('71bbed5f-79d7-4bf1-b5a1-d2e4db4614ca', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '3dacb910-a325-4939-aec5-f1e05218513c', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('73ca6c93-6213-4a56-b0d7-d717b2a40fdd', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'e38ab74b-bf14-11e7-a301-24fd52935962', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:10');
INSERT INTO `s_role_menu` VALUES ('75d8f621-3c27-4d62-a8d2-51cf6012a8a3', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'b17105b9-8da9-47b7-a4b1-7dbcfa60d250', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('7630df30-136e-44b9-83b4-77236ccfded7', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'b246e414-5c86-468e-81e0-0edf77710e3f', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('7ac89dd4-dafb-4eea-997e-cb0dff2698a4', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'caf65c04-beed-11e7-959c-38d547b81379', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('7bff7054-b148-4188-8145-00c4c171c499', '257ae84e-d86a-11e6-ba64-d8490bd28593', '162e38d7-5b27-488b-9776-e60d7aa07b68', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:22');
INSERT INTO `s_role_menu` VALUES ('7cc3fdfb-cf40-11e7-ad32-38d547b81379', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:10');
INSERT INTO `s_role_menu` VALUES ('7cc42f97-cf40-11e7-ad32-38d547b81379', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('7e758f00-9953-4eb2-be42-a43498b925c2', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('85b47219-4e92-48cf-b57a-1c73ac6b1e05', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('8649b785-0b34-47cb-b36f-99a4b3e7cb50', '257ae84e-d86a-11e6-ba64-d8490bd28593', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('87b72623-a691-4405-97b2-2a4cd03b7b65', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'df1a659b-180f-4fd2-abb0-b42c7db62714', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('88fcdad2-b707-40da-9132-0c0dfc6be15f', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('8a0b7028-622c-4a56-8d7a-4fc9ac7248e4', '257ae84e-d86a-11e6-ba64-d8490bd28593', '37a082cd-0e38-49f8-b6f1-fc26e05383cc', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('8b1bc67a-34c2-422d-9574-b236371ddfa6', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:18:24');
INSERT INTO `s_role_menu` VALUES ('8dff7a2b-aa7d-48de-b074-f9837b690d20', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '43d5b520-eafe-4f7f-a846-4fba12c9ffab', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('8e057f01-4a65-4d3a-9773-3b2b59287f67', '257ae84e-d86a-11e6-ba64-d8490bd28593', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('8e2d5768-1536-4a14-af0a-c829c506f436', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('91f9761d-39a9-4ff3-82c6-4037c31aeb7a', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('92f0fa89-c19e-4abc-844a-badc03ec9ae2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '2dc7b0aa-e46e-4583-9738-72e71de1426c', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('9a1168d6-884c-489a-babb-c88060f5173c', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '90860ae5-6ef3-4ba7-9aba-b894ea0ceea8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('9c0572bc-3a0d-455f-8cb9-48e6ad95fc49', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '3dacb910-a325-4939-aec5-f1e05218513c', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('9c0e2b38-4c38-4195-a08d-db287ff6df00', '257ae84e-d86a-11e6-ba64-d8490bd28593', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('9c85de13-8c9e-4281-bebd-820036b178cd', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '162e38d7-5b27-488b-9776-e60d7aa07b68', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:35:28');
INSERT INTO `s_role_menu` VALUES ('9c8c80fb-7b0c-482e-870a-d1c285d89664', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('9c9c5220-c9f4-4b70-a01e-54f2c0c47c84', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('9cc63b59-9e3d-4f1e-bfd4-29d7f81f202c', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '3dacb910-a325-4939-aec5-f1e05218513c', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('9d3b77bc-5c93-41c5-a6e0-bab1e35ac792', '257ae84e-d86a-11e6-ba64-d8490bd28593', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('9dc5bb52-053f-4e26-b408-ee5ca15f9011', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'b246e414-5c86-468e-81e0-0edf77710e3f', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('9e0d7f7e-2bd2-49b0-9ed8-bd61579ef24d', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'd942abc1-b177-452e-8c53-1914ac448c7d', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('9fc64967-48d7-4793-8693-464041bc6421', '257ae84e-d86a-11e6-ba64-d8490bd28593', '8c4baf7a-a6dd-4f0a-aa13-4078f6c74320', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('a0b68430-ae2a-49b1-84c0-7162f0a71b63', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('a215308f-384c-43cd-8190-6074b8e4ba99', '257ae84e-d86a-11e6-ba64-d8490bd28593', '04c21bbc-f0c1-4981-bbe7-17627cce0664', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('a33fa1a2-a9b0-450e-bb0b-13badc128780', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('a4149933-e39a-413d-82df-200d5a06c2e3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '91d81894-dca3-4738-a408-77d23108a710', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('a7cdb3d0-8bda-4ae8-a479-2561014eedeb', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '10000000-0000-0000-0000-100000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('aa515762-d166-4a24-a7bc-aaacfe1c62f7', '257ae84e-d86a-11e6-ba64-d8490bd28593', '02886d5a-211c-4e58-800c-90cf79640ef5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('ab14c90a-87b5-4f9a-a7e5-79ff49f5fadd', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:22:04');
INSERT INTO `s_role_menu` VALUES ('ac8fb970-78ad-40f5-a082-1f2a171f1986', '0C03F6B6-8CC4-4826-8A51-149990861BE3', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('ae8c4cf3-3afa-453d-a321-e21909d094b3', '257ae84e-d86a-11e6-ba64-d8490bd28593', '55638077-269d-41fc-981e-d6f8eeaee8f3', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('af3df7f2-d51e-11e7-b7f6-24fd52935962', '257ae84e-d86a-11e6-ba64-d8490bd28593', '10000000-0000-0000-0000-100000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:27');
INSERT INTO `s_role_menu` VALUES ('af3e52db-d51e-11e7-b7f6-24fd52935962', '257ae84e-d86a-11e6-ba64-d8490bd28593', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('af3fa99e-d51e-11e7-b7f6-24fd52935962', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('af401896-d51e-11e7-b7f6-24fd52935962', '257ae84e-d86a-11e6-ba64-d8490bd28593', '33fb6e82-2b8b-48fb-af3c-fb886049ca77', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('af41d875-d51e-11e7-b7f6-24fd52935962', '257ae84e-d86a-11e6-ba64-d8490bd28593', '5d2f2a0d-9326-4026-b338-c03bf6e255db', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:22');
INSERT INTO `s_role_menu` VALUES ('b0a6e8c1-0806-45b8-ab71-b5271a72942a', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'ce43305b-a658-4e8c-b864-10b6ee797429', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('b12ff8a5-e84e-4d42-8ae7-54a667f7c867', '257ae84e-d86a-11e6-ba64-d8490bd28593', '0ef5eb36-2a53-4ec0-ab6b-7c5ed02d3ccf', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('b3eab242-e811-410f-a0ef-61111786f1a8', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('b452c7d9-8570-45c7-a4ee-b55938cc1047', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '21136dca-a230-4902-b370-73cedbfd37d1', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('b5b562a6-94db-4540-b217-9aa057ad7d8a', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '02886d5a-211c-4e58-800c-90cf79640ef5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('b8b84474-02e6-4210-a5e5-e94390685099', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'e38ab74b-bf14-11e7-a301-24fd52935962', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('b9ece692-b7f6-439f-8cc0-e72cac1c1ab4', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'b246e414-5c86-468e-81e0-0edf77710e3f', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('bbc25957-1a92-436b-a0bf-ff4b8738435b', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:41:42');
INSERT INTO `s_role_menu` VALUES ('bd70ed16-8fc5-4f21-a2fa-4fc5f82faa80', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'd942abc1-b177-452e-8c53-1914ac448c7d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('bdf1927a-e0b7-4c5e-921b-758ff46f3f19', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '97ea6edb-1178-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('be1d9d70-19c5-4abd-980e-3c837a7ef2f5', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '0277b5ce-acca-4f31-a43c-20585768c596', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('be32b052-2ed3-47f4-a373-53fc004739da', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'd07687ef-2798-11e5-965c-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('be6dc1df-384d-4c77-8b7f-4b4d345df339', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '2fe964ba-f060-47cf-8c81-fcd0ba615d63', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('c238d924-fad4-11e7-9760-50465deb996e', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', 'f5baa02f-7e39-421f-a7dd-c8ee4773966b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:48:55');
INSERT INTO `s_role_menu` VALUES ('c3a7e654-d653-11e7-8fec-38d547b81379', 'c716be42-78c2-4c80-8c88-25814b2e683b', '10000000-0000-0000-0000-200000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('c43cd869-f872-4a53-bc75-833ce47cbbd7', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '2bb748c6-224b-4fff-a3c2-82b684faf56d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('c56e414b-f510-4334-b1a4-794ead9cac01', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fb69a533-1178-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('c5fe3bfb-dbfb-4b8a-b08b-5f2d429ff844', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('c7c89fea-40f3-4417-99f3-3c12adfc3a08', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '67416840-6b15-473b-80fc-bbf1b28dfac5', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-24 00:20:59');
INSERT INTO `s_role_menu` VALUES ('c826c0b0-a0fb-4325-af4a-19804275e4d9', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'dd6448d3-ade1-40c3-9043-a77c3036f829', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('c8f6360b-745c-4bcd-a21e-97dcf4185b60', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '10000000-0000-0000-0000-100000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:10');
INSERT INTO `s_role_menu` VALUES ('c93365d4-faa9-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('c933dcca-faa9-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('c9340250-faa9-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('c9342731-faa9-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '33fb6e82-2b8b-48fb-af3c-fb886049ca77', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:41:19');
INSERT INTO `s_role_menu` VALUES ('c9344c0f-faa9-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('c9349f5d-faa9-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '21136dca-a230-4902-b370-73cedbfd37d1', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('cb3c1fae-16ec-4020-96e5-612d92aeb050', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '41220884-50a6-4204-8168-f8e3eb5ad2ce', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('cc559a1f-baeb-4392-a7af-2dd50ff90b2d', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'ded1d6eb-2c41-407e-9a3e-bf3615ced9ff', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('cc8fc171-c683-46ac-ac8c-9582da04b2ea', '257ae84e-d86a-11e6-ba64-d8490bd28593', '2d42e55d-5e6a-4b92-ba22-5c188c0d13d2', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-30 00:02:22');
INSERT INTO `s_role_menu` VALUES ('cf31615b-cecb-11e7-979d-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '10000000-0000-0000-0000-300000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('cfc040ed-70e9-483a-b5b6-7ba9f9ba7f86', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '55638077-269d-41fc-981e-d6f8eeaee8f3', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('d00a97b2-f067-4495-9f24-fb5bdbe8df4a', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('d0233780-ee85-4293-9322-e2acdc0506b3', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'b4a121a8-5e4d-41f8-b4a0-672eebb0a74d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('d02cac90-32db-41a6-8fe6-2a44f713156a', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('d16a6713-89bd-4b99-86f3-9fb1e12d5ef7', '257ae84e-d86a-11e6-ba64-d8490bd28593', '3dacb910-a325-4939-aec5-f1e05218513c', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('d178db18-cecb-11e7-979d-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '10000000-0000-0000-0000-200000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('d260eb96-3144-4ca6-a6f9-cc4b00135717', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'ce43305b-a658-4e8c-b864-10b6ee797429', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('d28bed18-15b3-429e-aeb3-65a26ccd7e2c', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'dd6448d3-ade1-40c3-9043-a77c3036f829', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('d3af5e46-cecb-11e7-979d-24fd52935962', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '10000000-0000-0000-0000-100000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('d3d93f48-c824-4e02-93a3-bb7a6c0a0e09', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d9e29bb-7ba2-418f-bcc6-1137f7a49c14', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('d5d7ddbc-9bf4-41e7-b88b-8b1a5f025549', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '4bcab523-1174-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:13');
INSERT INTO `s_role_menu` VALUES ('d68230c8-56f4-4161-b266-99806cbbb0f6', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '5863e4f5-927d-4c96-8bda-2294703bc909', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('d7123878-3252-4b83-a3a3-c9aa00010cbb', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '97ea6edb-1178-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('dc230d34-6887-41f3-9cde-6c963b1c8c4d', 'c716be42-78c2-4c80-8c88-25814b2e683b', 'ded1d6eb-2c41-407e-9a3e-bf3615ced9ff', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('dccd6d98-faaa-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'dd6448d3-ade1-40c3-9043-a77c3036f829', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('dccd8fdd-faaa-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '91d81894-dca3-4738-a408-77d23108a710', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('dccdb2da-faaa-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'f5baa02f-7e39-421f-a7dd-c8ee4773966b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('dccdd58f-faaa-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '10000000-0000-0000-0000-100000000000', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:41:19');
INSERT INTO `s_role_menu` VALUES ('dccdf834-faaa-11e7-8c52-6045cb7f62f1', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '0bc54201-f2e3-4585-a9c7-bb5d9b44e26d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('dd1ccf78-2897-483b-80e2-8e37a51fcdcd', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-03 00:22:47');
INSERT INTO `s_role_menu` VALUES ('df1607d2-6cc4-49af-b455-98ae8c73fcb0', '257ae84e-d86a-11e6-ba64-d8490bd28593', '5903d97e-84bc-4a0b-b45b-0b61acd2d238', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('dfe63cdc-5706-4e4d-97a9-3958c7d70750', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '0B6D1F77-BAEC-4CFA-8D19-E1C4ECE995B9', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('e13c2826-edd4-4f96-b1ca-fce6d9dfc3a2', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('e4f1f204-7900-402a-bf5b-3d20b254c6e9', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'bf94d776-81b3-4d0d-bbf5-3b3e4df1a0f4', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('e51b9572-7e90-45d6-9726-cf5ac17f0074', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '682cc88a-5424-4f14-8298-bf19a8c1a726', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('e52fd93f-ca2f-4856-acc7-0a9a1cf0563e', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '1dfa1ebf-5e50-4976-90b8-290bcea2e057', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-01 12:36:57');
INSERT INTO `s_role_menu` VALUES ('e89d84cf-d664-11e7-8fec-38d547b81379', 'c716be42-78c2-4c80-8c88-25814b2e683b', '68522995-30dc-4fb0-97d8-7468e6af4853', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-01 14:59:30');
INSERT INTO `s_role_menu` VALUES ('e8b7cac1-81c6-4eb2-9136-d2c0b5e19c8f', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', 'baf74d02-a7fa-41cf-a7c6-d1e5da805701', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('ea07ba03-9952-485c-9d1c-22c980f2f3d1', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '20692517-9187-41df-920b-7c7342a93d37', '2', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:10');
INSERT INTO `s_role_menu` VALUES ('edb78aaa-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'dd6448d3-ade1-40c3-9043-a77c3036f829', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb7b2e2-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb7d866-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', '91d81894-dca3-4738-a408-77d23108a710', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb7fd15-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', '3631e59e-1175-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb82211-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', '5af24cc1-0a73-4f28-8972-dae2f138c1a8', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb8481d-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'd6b1760b-e2e4-47e1-8e65-660fcd0c0f2a', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb86e7e-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', 'f5baa02f-7e39-421f-a7dd-c8ee4773966b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb89426-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', '0bc54201-f2e3-4585-a9c7-bb5d9b44e26d', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('edb8b85e-faa9-11e7-8c52-6045cb7f62f1', '257ae84e-d86a-11e6-ba64-d8490bd28593', '21136dca-a230-4902-b370-73cedbfd37d1', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('ee14142c-83f7-4361-ac20-73da7cfe3a28', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'd2aad1f2-4230-4aee-a1f1-91a6a6c5db40', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('ef14f211-3a20-419c-82dc-ac014f6bc189', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'b17105b9-8da9-47b7-a4b1-7dbcfa60d250', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('f42bac93-b5a8-4b6b-8fff-73b21d27e3df', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '6fc0d40a-ca6e-4c19-8d24-485d5a61ea50', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:49:01');
INSERT INTO `s_role_menu` VALUES ('f59a8281-bce6-4f1f-86d6-761128dc1be2', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '514111b1-1e3d-472f-8f47-02ae0bae13e9', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('f8cf17d1-a22d-495e-a819-1c49a00f3ee2', '257ae84e-d86a-11e6-ba64-d8490bd28593', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:20');
INSERT INTO `s_role_menu` VALUES ('fa852e84-4a4c-492b-9954-457ac01f9fe7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '55f9ecb5-b899-4321-952f-64a1f579d2c2', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('fd06b1fb-c591-44d1-b47e-ca0d2521a4d8', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '9d377b71-bd84-47b6-a4f3-c08a24703b08', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 23:48:55');
INSERT INTO `s_role_menu` VALUES ('fde649a2-faa9-11e7-8c52-6045cb7f62f1', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', 'f04e0fcf-11b2-42a9-90f8-b8d0002f78cf', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('fde66e1e-faa9-11e7-8c52-6045cb7f62f1', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '91d81894-dca3-4738-a408-77d23108a710', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-16 18:42:47');
INSERT INTO `s_role_menu` VALUES ('ff6b2534-3818-4b32-b079-ae3c90ef69c7', 'f8692cd2-e801-11e4-8fee-40167e64eefd', 'fd1d49d4-0d1d-4294-a304-c1ae7432e53b', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-12-29 14:24:51');
INSERT INTO `s_role_menu` VALUES ('ffb36530-8fa3-4f63-a96a-f3e47ca6ab92', '257ae84e-d86a-11e6-ba64-d8490bd28593', '4bcab523-1174-11e5-a9de-000c29d7a3a0', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2017-11-22 12:49:27');

-- ----------------------------
-- Table structure for s_store_info
-- ----------------------------
DROP TABLE IF EXISTS `s_store_info`;
CREATE TABLE `s_store_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(36) NOT NULL COMMENT '门店名称',
  `signature` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `country` varchar(50) DEFAULT NULL COMMENT '国',
  `address` varchar(255) DEFAULT NULL,
  `location_x` char(20) DEFAULT NULL COMMENT '纬度',
  `location_y` char(20) DEFAULT NULL COMMENT '经度',
  `img_url` varchar(255) DEFAULT NULL,
  `store_scale` int(10) DEFAULT NULL COMMENT '人数规模',
  `floor_space` double(8,2) DEFAULT NULL COMMENT '占地面积',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_id` varchar(36) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_id` varchar(36) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_store_info
-- ----------------------------
INSERT INTO `s_store_info` VALUES ('01a283c9-14e6-4048-a407-84ae566c2af5', '马山分店一号', '是', '梅州市', '广东省', '梅江区', '三号街', null, null, '', '5', '25.00', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-10 12:33:44', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-10 12:33:44');
INSERT INTO `s_store_info` VALUES ('2ac0e26b-2b11-483d-9fe8-a40dd6b4cb76', '马山2号分店', '我', '梅州市', '广东省', '梅江区', 'xxx街', null, null, 'http://of8rkrh1w.bkt.clouddn.com/2018/1/19/haderImg.png', '6', '60.00', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 20:54:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 20:54:17');
INSERT INTO `s_store_info` VALUES ('5dc21977-7626-4ed0-b1b5-5923325653ec', '门店4号', '慰问费', '梅州市', '广东省', '五华县', '闪电似的', null, null, 'http://of8rkrh1w.bkt.clouddn.com/2018/1/20/haderImg.png', '2', '23.00', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-20 04:39:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-20 04:39:33');
INSERT INTO `s_store_info` VALUES ('9cde1d05-c651-4015-a33b-f1bb8c134e8c', '马山门店3C号', '备注信息', '梅州市', '广东省', '梅县区', '梅县区，国贸大厦', null, null, 'http://of8rkrh1w.bkt.clouddn.com/2018/1/19/haderImg.png', '3', '55.00', '1', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 20:55:13', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', '2018-01-19 20:55:13');
INSERT INTO `s_store_info` VALUES ('c7202ff8-5791-4bc1-9b2a-06d8aff52c3e', '门店A', '微', '梅州市', '广东省', '丰顺县', 'X', null, null, 'http://of8rkrh1w.bkt.clouddn.com/2018/1/17/hex0.jpg', '3', '35.00', '1', '06b85a81-2727-4ed0-9a8a-9e8ed085bac8', '2018-01-17 15:45:37', '06b85a81-2727-4ed0-9a8a-9e8ed085bac8', '2018-01-17 15:45:37');

-- ----------------------------
-- Table structure for s_system_log
-- ----------------------------
DROP TABLE IF EXISTS `s_system_log`;
CREATE TABLE `s_system_log` (
  `id` varchar(36) NOT NULL,
  `log_time` date DEFAULT NULL COMMENT '发生时间',
  `error_type` varchar(50) DEFAULT NULL COMMENT '错误类型',
  `error_desc` text COMMENT '错误描述',
  `stauts` int(11) DEFAULT NULL COMMENT '处理状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of s_system_log
-- ----------------------------

-- ----------------------------
-- Table structure for s_users
-- ----------------------------
DROP TABLE IF EXISTS `s_users`;
CREATE TABLE `s_users` (
  `id` varchar(36) NOT NULL COMMENT '用户唯一ID',
  `account` varchar(50) NOT NULL COMMENT '用户账号',
  `password` varchar(50) NOT NULL COMMENT '系统密码',
  `chinese_name` varchar(50) NOT NULL COMMENT '中文名称',
  `email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `mobile` varchar(30) DEFAULT NULL COMMENT '手机号码',
  `user_type` varchar(36) NOT NULL COMMENT '用户类型',
  `store_id` varchar(36) DEFAULT NULL,
  `last_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `status` int(1) NOT NULL COMMENT '激活状态',
  `login_type` varchar(36) NOT NULL COMMENT '登陆类型',
  `role_id` varchar(36) DEFAULT NULL COMMENT '角色ID',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_users
-- ----------------------------
INSERT INTO `s_users` VALUES ('06b85a81-2727-4ed0-9a8a-9e8ed085bac8', 'adminUser', '8418884046455c613213155055b48886', '溯源系统', 'adminUser@mashan.com', '13813888888', '241f8263-5e9e-4479-8463-4b902f54e736', null, '2018-01-17 13:37:17', '1', 'systemUser', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '2018-01-17 13:37:17', '2018-01-17 13:37:17', '06b85a81-2727-4ed0-9a8a-9e8ed085bac8');
INSERT INTO `s_users` VALUES ('0f1443aa-eade-410d-b8bf-74ebfa914ca4', 'morgan', '6a3fd4ce78066de7876e189ab9db43a9', '波波', 'jionlandry@gmail.com', '13713666160', '241f8263-5e9e-4479-8463-4b902f54e736', null, '2017-10-18 13:30:04', '1', 'systemUser', 'f8692cd2-e801-11e4-8fee-40167e64eefd', '2017-10-18 13:30:10', '2017-10-18 13:30:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_users` VALUES ('3f10c605-db70-4ca8-8553-bba0c049f5dc', 'guanli', '2ece5587a7ca3ed08039888c5c78d7b3', '张管理', '398229889@mashan.com', '13242001588', '241f8263-5e9e-4479-8463-4b902f54e736', null, '2018-01-16 23:13:02', '1', 'systemUser', '257ae84e-d86a-11e6-ba64-d8490bd28593', '2018-01-16 23:13:02', '2018-01-16 23:13:02', '3f10c605-db70-4ca8-8553-bba0c049f5dc');
INSERT INTO `s_users` VALUES ('6c73c3a2-d7c4-41d2-8ecd-a632ad151799', 'storeUserB', '50c0d8964168aad0ffbec51cb689e595', '店长2号', 'userB@mashan.com', '13713666136', 'e7fbdea9-82a8-47d9-bbe0-82fd66f7bd27', '2ac0e26b-2b11-483d-9fe8-a40dd6b4cb76', '2018-01-19 20:32:12', '1', 'storeUser', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '2018-01-19 20:32:12', '2018-01-19 20:32:12', '6c73c3a2-d7c4-41d2-8ecd-a632ad151799');
INSERT INTO `s_users` VALUES ('787b92a3-e6cb-435a-b7f1-bbb5496e3022', 'storeUserC', 'd5d370a8c4042091cd1200745bebd8e1', '分店3C号', 'store3@mashan.com', '15312312312', 'e7fbdea9-82a8-47d9-bbe0-82fd66f7bd27', '9cde1d05-c651-4015-a33b-f1bb8c134e8c', '2018-01-19 20:52:41', '1', 'storeUser', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '2018-01-19 20:52:41', '2018-01-19 20:52:41', '787b92a3-e6cb-435a-b7f1-bbb5496e3022');
INSERT INTO `s_users` VALUES ('9f4dba49-6be4-401e-800d-ef5207f18b9f', 'storeD', '6a008ed77356a06bff5749008074afca', '店长4号', 'store4@mashan.com', '13913991399', 'e7fbdea9-82a8-47d9-bbe0-82fd66f7bd27', '5dc21977-7626-4ed0-b1b5-5923325653ec', '2018-01-20 04:38:38', '1', 'storeUser', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '2018-01-20 04:38:38', '2018-01-20 04:38:38', '9f4dba49-6be4-401e-800d-ef5207f18b9f');
INSERT INTO `s_users` VALUES ('a32f3cfc-777c-49a3-a3d1-ba1e64459dcf', 'caiwu', '5bd76187fb2f89aeb01c211ddb7064c5', '杨财务', '398229888@mashan.com', '13242001586', '241f8263-5e9e-4479-8463-4b902f54e736', null, '2018-01-16 23:02:18', '1', 'systemUser', 'ffe22cd2-32fe-45c4-81f4-1ca15ee8ea27', '2018-01-16 23:02:18', '2018-01-16 23:02:18', 'a32f3cfc-777c-49a3-a3d1-ba1e64459dcf');
INSERT INTO `s_users` VALUES ('a4cc4a66-8215-4ca7-a71c-25a056179d9a', 'mendianAuser', '31dc775714097992f161823d47f19e60', '门店用户A', 'mendianAuser@mashan.com', '15011191119', 'e7fbdea9-82a8-47d9-bbe0-82fd66f7bd27', 'c7202ff8-5791-4bc1-9b2a-06d8aff52c3e', '2018-01-17 15:39:13', '1', 'storeUser', '0C03F6B6-8CC4-4826-8A51-149990861BE3', '2018-01-17 15:39:13', '2018-01-17 15:39:13', 'a4cc4a66-8215-4ca7-a71c-25a056179d9a');
INSERT INTO `s_users` VALUES ('c80f5300-cd21-40ed-93a7-f8094f342c2d', 'zhijian', 'a8010a34e47d8d879ae84045f4f5e84e', '孙质检', '398556225@mashan.com', '13713845583', '241f8263-5e9e-4479-8463-4b902f54e736', null, '2018-01-16 23:50:48', '1', 'systemUser', 'd2b9b0cd-d52d-48eb-8811-f71dad818ea1', '2018-01-16 23:50:48', '2018-01-16 23:50:48', 'c80f5300-cd21-40ed-93a7-f8094f342c2d');
INSERT INTO `s_users` VALUES ('e113551d-3ab7-457e-a108-a8f6a8727e68', 'changzhang', 'ba5bad46e6f3c297a6457fe451b236d7', '李厂长', '312548584@mashan.com', '13713845581', '241f8263-5e9e-4479-8463-4b902f54e736', null, '2018-01-16 22:59:56', '1', 'systemUser', '0032e5e5-d1e7-41da-bb0d-b32b725a7d31', '2018-01-16 22:59:56', '2018-01-16 22:59:56', 'e113551d-3ab7-457e-a108-a8f6a8727e68');

-- ----------------------------
-- Table structure for s_user_info
-- ----------------------------
DROP TABLE IF EXISTS `s_user_info`;
CREATE TABLE `s_user_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `user_id` varchar(36) NOT NULL COMMENT '用户ID',
  `nick_name` varchar(36) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `country` varchar(50) DEFAULT NULL COMMENT '国',
  `address` varchar(255) DEFAULT NULL,
  `location_x` char(20) DEFAULT NULL COMMENT '纬度',
  `location_y` char(20) DEFAULT NULL COMMENT '经度',
  `head_imgurl` varchar(255) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信',
  `create_time` datetime NOT NULL,
  `create_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_user_info
-- ----------------------------
INSERT INTO `s_user_info` VALUES ('0403f5db-95d7-491f-89fe-89688207b185', 'e113551d-3ab7-457e-a108-a8f6a8727e68', null, '', '梅州市', '广东省', '梅县区', '', null, null, '', null, '2018-01-16 22:59:57', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('0e813589-a977-4a52-9e96-6785efa1667e', 'aae3184b-0af7-49c8-9b8c-0ec33cb5ffa1', null, '123123123', '包头市', '内蒙古自治区', '达尔罕茂明安联合旗', '123123', null, null, '', null, '2017-11-26 17:31:03', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('16098961-8653-45f9-9080-4cbe1ff41e8d', '787b92a3-e6cb-435a-b7f1-bbb5496e3022', null, '无', '梅州市', '广东省', '丰顺县', 'xxx大厦', null, null, '', null, '2018-01-19 20:52:41', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('1776d7f9-2787-4f38-87b8-6096a77a57d0', 'a882638a-e36e-46d5-83a6-b08f1d3583c2', null, '', '', '', '', '', null, null, '', null, '2018-01-07 16:54:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('182c58d4-3b0a-4792-b783-a64d6b3e1d38', '06b85a81-2727-4ed0-9a8a-9e8ed085bac8', null, '系统管理员', '梅州市', '广东省', '梅江区', '梅州市', null, null, 'http://of8rkrh1w.bkt.clouddn.com/2018/1/17/微信截图_20180117135636.png', null, '2018-01-17 13:37:17', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('4b3da7d4-ca5f-4a8a-966d-8f8baadbeef3', '9f4dba49-6be4-401e-800d-ef5207f18b9f', null, 'xxx', '梅州市', '广东省', '梅江区', 'xxx大厦', null, null, '', null, '2018-01-20 04:38:38', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('4c92e024-dc43-424d-a1fd-0a079b072992', 'c80f5300-cd21-40ed-93a7-f8094f342c2d', null, '', '中山市', '广东省', '湖滨北路', '', null, null, '', null, '2018-01-16 23:50:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('a8381549-d1d9-11e7-ad5f-24fd52935962', '0f1443aa-eade-410d-b8bf-74ebfa914ca4', 'Mollty', '我再写代码', '深圳市', '广东省', '南山区', '西丽官龙村', '22.123123', '113.3211', '', '123123', '2017-11-25 20:11:48', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('c1db1398-f9eb-4cfd-a262-d3c58715768b', 'ff92d2e1-87be-4c32-b61c-3e32c6c45d13', null, '12121212', '厦门市', '福建省', '湖里区', '1212', null, null, '', null, '2017-11-26 17:29:33', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('d1374227-f10f-4a9e-9559-6d8426d1d395', '6c73c3a2-d7c4-41d2-8ecd-a632ad151799', null, '的', '梅州市', '广东省', '梅县区', 'xxx大厦', null, null, 'http://of8rkrh1w.bkt.clouddn.com/2018/1/19/微信截图_20180117135636.png', null, '2018-01-19 20:32:12', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('d7d79862-91a3-4eaa-8b8c-9d2a8a18b2e8', 'a32f3cfc-777c-49a3-a3d1-ba1e64459dcf', null, '', '梅州市', '广东省', '梅县区', '梅州', null, null, '', null, '2018-01-16 23:02:18', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');
INSERT INTO `s_user_info` VALUES ('eb99bea9-eca2-4e07-a7d8-a01c03581ee5', '3f10c605-db70-4ca8-8553-bba0c049f5dc', null, '管理好', '东莞市', '广东省', '三元里', '小镇', null, null, '', null, '2018-01-16 23:13:02', '0f1443aa-eade-410d-b8bf-74ebfa914ca4');

-- ----------------------------
-- Table structure for t_wechat
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat`;
CREATE TABLE `t_wechat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '公众号名称',
  `orgid` varchar(255) NOT NULL DEFAULT '' COMMENT '公众号原始ID',
  `weixin` varchar(255) NOT NULL DEFAULT '' COMMENT '微信号',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `appid` varchar(255) NOT NULL COMMENT 'AppID',
  `appsecret` varchar(255) NOT NULL COMMENT 'AppSecret',
  `type` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '公众号类型',
  `oauth_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启微信登录',
  `oauth_name` varchar(100) DEFAULT NULL,
  `oauth_redirecturi` varchar(255) DEFAULT NULL,
  `oauth_count` int(11) unsigned NOT NULL DEFAULT '0',
  `time` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `default_wx` int(1) NOT NULL DEFAULT '1' COMMENT '1为默认使用，0为不默认',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat
-- ----------------------------
INSERT INTO `t_wechat` VALUES ('6', '锦绣神州', '', '', 'jinxiushenzhou', 'wx746679c0eb31b0a7', '961604e3bac8703aa84faa7d82b4c6f5', '0', '0', null, 'http://jxcs.jxworld.net/jxworld/weixin', '0', '0', '0', '1', '1');

-- ----------------------------
-- Table structure for t_wechat_custom_message
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_custom_message`;
CREATE TABLE `t_wechat_custom_message` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `msg` varchar(255) DEFAULT NULL COMMENT '信息内容',
  `iswechat` smallint(1) unsigned DEFAULT NULL,
  `send_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_custom_message
-- ----------------------------

-- ----------------------------
-- Table structure for t_wechat_log
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_log`;
CREATE TABLE `t_wechat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(20) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `message` text,
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_wechat_mass_history
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_mass_history`;
CREATE TABLE `t_wechat_mass_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '素材id',
  `type` varchar(10) DEFAULT NULL COMMENT '发送内容类型',
  `status` varchar(20) DEFAULT NULL COMMENT '发送状态，对应微信通通知状态',
  `send_time` int(11) unsigned NOT NULL DEFAULT '0',
  `msg_id` varchar(20) DEFAULT NULL COMMENT '微信端返回的消息ID',
  `totalcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'group_id下粉丝数；或者openid_list中的粉丝数',
  `filtercount` int(10) unsigned NOT NULL DEFAULT '0',
  `sentcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送成功的粉丝数',
  `errorcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送失败的粉丝数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_mass_history
-- ----------------------------

-- ----------------------------
-- Table structure for t_wechat_media
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_media`;
CREATE TABLE `t_wechat_media` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '图文消息标题',
  `command` varchar(20) NOT NULL COMMENT '关键词',
  `author` varchar(20) DEFAULT NULL,
  `is_show` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否显示封面，1为显示，0为不显示',
  `digest` varchar(255) DEFAULT NULL COMMENT '图文消息的描述',
  `content` text NOT NULL COMMENT '图文消息页面的内容，支持HTML标签',
  `link` varchar(255) DEFAULT NULL COMMENT '点击图文消息跳转链接',
  `file` varchar(255) DEFAULT NULL COMMENT '图片链接',
  `size` int(7) DEFAULT NULL COMMENT '媒体文件上传后，获取时的唯一标识',
  `file_name` varchar(255) DEFAULT NULL COMMENT '媒体文件上传时间戳',
  `thumb` varchar(255) DEFAULT NULL,
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(11) unsigned NOT NULL DEFAULT '0',
  `type` varchar(10) DEFAULT NULL,
  `article_id` varchar(100) DEFAULT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_media
-- ----------------------------

-- ----------------------------
-- Table structure for t_wechat_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_menu`;
CREATE TABLE `t_wechat_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `name` varchar(255) NOT NULL COMMENT '菜单标题',
  `type` varchar(10) NOT NULL COMMENT '菜单的响应动作类型',
  `key` varchar(255) NOT NULL COMMENT '菜单KEY值，click类型必须',
  `url` varchar(255) NOT NULL COMMENT '网页链接，view类型必须',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `scope` int(3) NOT NULL DEFAULT '0' COMMENT '验证方式, 0:不验证，1:base',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_menu
-- ----------------------------
INSERT INTO `t_wechat_menu` VALUES ('1', '0', '当期活动', 'click', 'q', '', '0', '1', '0');
INSERT INTO `t_wechat_menu` VALUES ('2', '1', '线下活动', 'view', '', 'http://mp.weixin.qq.com/s?__biz=MzI4NzM2Mzc4Mw==&mid=2247483916&idx=1&sn=ddaa90132ac2a6f16f1ad4c33bd77771&chksm=ebcf85a4dcb80cb203c662e40761a367f9c86f8a3240835012ae55c75ad728f5e10b31141f4f&scene=0#wechat_redirect', '0', '1', '0');
INSERT INTO `t_wechat_menu` VALUES ('3', '0', '锦绣商城', 'view', '通知', 'http://jxcs.jxworld.net/jxworld/weixin/getShopHome', '0', '1', '1');
INSERT INTO `t_wechat_menu` VALUES ('4', '0', '平台服务', 'click', 'q', '', '0', '1', '0');
INSERT INTO `t_wechat_menu` VALUES ('5', '4', '个人中心', 'view', '通知', 'http://jxcs.jxworld.net/jxworld/weixin/getUserinfo', '0', '1', '1');
INSERT INTO `t_wechat_menu` VALUES ('6', '4', '我要赚钱', 'view', '', 'http://mp.weixin.qq.com/s?__biz=MzI4NzM2Mzc4Mw==&mid=100000134&idx=1&sn=2d5c12dbae3892fa0f417639e94ae5f2&scene=0#wechat_redirect', '0', '1', '0');
INSERT INTO `t_wechat_menu` VALUES ('7', '4', '商务合作', 'view', '', 'http://mp.weixin.qq.com/s?__biz=MzI4NzM2Mzc4Mw==&mid=100000565&idx=1&sn=c410ce08d321cad5c5eaceb52d384f5e&chksm=6bcf849d5cb80d8bd606b328fe1b18c9084ad74faa44d4e0d1c51c1564fda844ef86b515c067&scene=0#wechat_redirect', '0', '1', '0');

-- ----------------------------
-- Table structure for t_wechat_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_qrcode`;
CREATE TABLE `t_wechat_qrcode` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '二维码类型，0临时，1永久',
  `expire_seconds` int(4) DEFAULT NULL COMMENT '二维码有效时间',
  `scene_id` int(10) NOT NULL COMMENT '场景值ID，临时二维码时为32位非0整型，永久二维码时最大值为100000（目前参数只支持1--100000）',
  `username` varchar(60) DEFAULT NULL COMMENT '推荐人',
  `function` varchar(255) NOT NULL COMMENT '功能',
  `ticket` varchar(255) DEFAULT NULL COMMENT '二维码ticket',
  `qrcode_url` varchar(255) DEFAULT NULL COMMENT '二维码路径',
  `endtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `scan_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扫描量',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `sort` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_qrcode
-- ----------------------------

-- ----------------------------
-- Table structure for t_wechat_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_reply`;
CREATE TABLE `t_wechat_reply` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL COMMENT '自动回复类型',
  `content` varchar(255) DEFAULT NULL,
  `media_id` int(10) DEFAULT NULL,
  `rule_name` varchar(180) DEFAULT NULL,
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  `reply_type` varchar(10) DEFAULT NULL COMMENT '关键词回复内容的类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_reply
-- ----------------------------
INSERT INTO `t_wechat_reply` VALUES ('1', 'keywords', '商城升级维护中。。。。。。', '0', '通知', '1479472969', 'text');

-- ----------------------------
-- Table structure for t_wechat_rule_keywords
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_rule_keywords`;
CREATE TABLE `t_wechat_rule_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NOT NULL COMMENT '规则id',
  `rule_keywords` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_rule_keywords
-- ----------------------------
INSERT INTO `t_wechat_rule_keywords` VALUES ('1', '1', '通知');

-- ----------------------------
-- Table structure for t_wechat_template
-- ----------------------------
DROP TABLE IF EXISTS `t_wechat_template`;
CREATE TABLE `t_wechat_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(255) DEFAULT NULL,
  `template_id` varchar(255) DEFAULT NULL,
  `contents` varchar(133) DEFAULT NULL,
  `template` text,
  `title` varchar(33) NOT NULL,
  `add_time` int(11) DEFAULT NULL,
  `switch` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_wechat_template
-- ----------------------------
