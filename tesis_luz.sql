-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.15 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla tesis_luz.area
DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `id_area` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `detail` varchar(250) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_area`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.area: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`id_area`, `name`, `detail`, `status`, `create_at`, `update_at`) VALUES
	(1, 'Comercial', NULL, 1, '2019-10-13 18:50:32', '2019-10-13 18:50:32');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.company
DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `id_company` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `brand_name` varchar(250) NOT NULL,
  `document_number` varchar(15) NOT NULL,
  `telephone` varchar(25) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `id_ubigeo` int(10) unsigned DEFAULT NULL,
  `street` varchar(250) DEFAULT NULL,
  `state` tinyint(4) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_company`),
  KEY `FK_company_ubigeo` (`id_ubigeo`),
  CONSTRAINT `FK_company_ubigeo` FOREIGN KEY (`id_ubigeo`) REFERENCES `ubigeo` (`id_ubigeo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.company: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id_company`, `name`, `brand_name`, `document_number`, `telephone`, `phone`, `email`, `id_ubigeo`, `street`, `state`, `create_at`, `update_at`) VALUES
	(1, '', 'jarch.io', '1070043215', '950119887', '', 'jarch_2092@outlook.com', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', 1, '2019-10-13 05:47:40', '2019-10-13 05:47:40'),
	(2, '', 'TR', '456165161', '950119887', '950119887', 'jarch_2092@outlook.com', NULL, 'El Derby 254', 1, '2019-10-13 11:52:17', '2019-10-13 11:52:17'),
	(3, 'jarch.io', 'jarch', '4656546', '950119887', '265646', 'jarch_2092@outlook.com', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', 1, '2019-10-13 20:55:54', '2019-10-13 20:55:54');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.customer
DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `id_customer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL COMMENT 'Tipo de cliente, valores aceptados: company or person',
  `id_company` int(10) unsigned DEFAULT NULL,
  `id_person` int(10) unsigned DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_customer`),
  KEY `FK_customer_company` (`id_company`),
  KEY `FK_customer_person` (`id_person`),
  CONSTRAINT `FK_customer_company` FOREIGN KEY (`id_company`) REFERENCES `company` (`id_company`),
  CONSTRAINT `FK_customer_person` FOREIGN KEY (`id_person`) REFERENCES `person` (`id_person`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.customer: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` (`id_customer`, `type`, `id_company`, `id_person`, `status`, `create_at`, `update_at`) VALUES
	(1, 'comapany', NULL, NULL, 0, '2019-08-10 22:23:33', '2019-08-10 22:23:39'),
	(3, 'person', NULL, 2, 1, '2019-10-13 05:21:39', '2019-10-13 05:21:39'),
	(4, 'person', NULL, 3, 1, '2019-10-13 05:22:33', '2019-10-13 05:22:33'),
	(5, 'person', NULL, 4, 1, '2019-10-13 05:24:48', '2019-10-13 05:24:48'),
	(6, 'person', NULL, 5, 1, '2019-10-13 05:42:16', '2019-10-13 05:42:16'),
	(7, 'person', NULL, 6, 1, '2019-10-13 05:43:21', '2019-10-13 05:43:21'),
	(8, 'person', NULL, 7, 1, '2019-10-13 05:43:23', '2019-10-13 05:43:23'),
	(9, 'person', NULL, 8, 1, '2019-10-13 05:44:58', '2019-10-13 05:44:58'),
	(10, 'person', NULL, 9, 1, '2019-10-13 05:46:21', '2019-10-13 05:46:21'),
	(11, 'company', 1, NULL, 1, '2019-10-13 05:47:41', '2019-10-13 05:47:41'),
	(12, 'person', NULL, 10, 1, '2019-10-13 06:06:50', '2019-10-13 06:06:50'),
	(13, 'person', NULL, 11, 1, '2019-10-13 06:13:18', '2019-10-13 06:13:18'),
	(14, 'person', NULL, 12, 1, '2019-10-13 06:14:14', '2019-10-13 06:14:14'),
	(15, 'person', NULL, 13, 1, '2019-10-13 06:16:17', '2019-10-13 06:16:17'),
	(16, 'person', NULL, 14, 1, '2019-10-13 06:34:00', '2019-10-13 06:34:00'),
	(17, 'person', NULL, 15, 1, '2019-10-13 06:35:25', '2019-10-13 06:35:25'),
	(18, 'person', NULL, 16, 1, '2019-10-13 06:43:58', '2019-10-13 06:43:58'),
	(19, 'person', NULL, 17, 1, '2019-10-13 06:44:40', '2019-10-13 06:44:40'),
	(20, 'person', NULL, 18, 1, '2019-10-13 09:35:12', '2019-10-13 09:35:12'),
	(21, 'person', NULL, 19, 1, '2019-10-13 10:52:53', '2019-10-13 10:52:53'),
	(22, 'person', NULL, 20, 1, '2019-10-13 11:47:24', '2019-10-13 11:47:24'),
	(23, 'company', 2, NULL, 1, '2019-10-13 11:52:17', '2019-10-13 11:52:17'),
	(24, 'person', NULL, 21, 1, '2019-10-13 13:09:43', '2019-10-13 13:09:43'),
	(25, 'company', 3, NULL, 1, '2019-10-13 20:55:54', '2019-10-13 20:55:54'),
	(26, 'person', NULL, 22, 1, '2019-10-13 21:39:53', '2019-10-13 21:39:53');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.customer_user
DROP TABLE IF EXISTS `customer_user`;
CREATE TABLE IF NOT EXISTS `customer_user` (
  `id_user` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `hash` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `last_access` timestamp NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email_unique` (`username`),
  KEY `FK__customer` (`id_customer`),
  CONSTRAINT `FK__customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.customer_user: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `customer_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_user` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.employee
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `id_employee` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_person` int(10) unsigned NOT NULL,
  `id_area` int(10) unsigned NOT NULL,
  `id_position` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT NULL,
  `update_at` timestamp NOT NULL DEFAULT NULL,
  PRIMARY KEY (`id_employee`),
  KEY `FK__person` (`id_person`),
  KEY `FK_employee_area` (`id_area`),
  KEY `FK_employee_position_office` (`id_position`),
  CONSTRAINT `FK__person` FOREIGN KEY (`id_person`) REFERENCES `person` (`id_person`),
  CONSTRAINT `FK_employee_area` FOREIGN KEY (`id_area`) REFERENCES `area` (`id_area`),
  CONSTRAINT `FK_employee_position_office` FOREIGN KEY (`id_position`) REFERENCES `position_office` (`id_position`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.employee: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`id_employee`, `id_person`, `id_area`, `id_position`, `status`, `create_at`, `update_at`) VALUES
	(1, 18, 1, 1, 1, '2019-10-13 18:51:47', '2019-10-13 18:51:47');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.employee_service
DROP TABLE IF EXISTS `employee_service`;
CREATE TABLE IF NOT EXISTS `employee_service` (
  `id_employee_service` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) unsigned NOT NULL,
  `id_service` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_employee_service`),
  KEY `FK_employee_service_employee` (`id_employee`),
  KEY `FK_employee_service_service` (`id_service`),
  CONSTRAINT `FK_employee_service_employee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id_employee`),
  CONSTRAINT `FK_employee_service_service` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.employee_service: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `employee_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_service` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.employee_user
DROP TABLE IF EXISTS `employee_user`;
CREATE TABLE IF NOT EXISTS `employee_user` (
  `id_user` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) unsigned NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `hash` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `last_access` timestamp NOT NULL,
  `id_role` int(10) unsigned NOT NULL,
  `is_locked` bit(1) NOT NULL DEFAULT b'0',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email_unique` (`username`),
  KEY `FK__employee` (`id_employee`),
  KEY `FK_employee_user_user_rol` (`id_role`),
  CONSTRAINT `FK_employee_user_employee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id_employee`),
  CONSTRAINT `FK_employee_user_user_rol` FOREIGN KEY (`id_role`) REFERENCES `user_rol` (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.employee_user: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `employee_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_user` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.offer
DROP TABLE IF EXISTS `offer`;
CREATE TABLE IF NOT EXISTS `offer` (
  `id_offer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `detail` varchar(250) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `from` timestamp NOT NULL,
  `type` varchar(50) NOT NULL COMMENT 'Tipo de descuento precio fijo o porcentaje',
  `discount` decimal(10,2) NOT NULL COMMENT 'Monto a aplicar',
  `to` timestamp NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_offer`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.offer: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `offer` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.offer_service
DROP TABLE IF EXISTS `offer_service`;
CREATE TABLE IF NOT EXISTS `offer_service` (
  `id_offer_service` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_offer` int(10) unsigned NOT NULL,
  `id_service` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_offer_service`),
  KEY `FK_offer_service_offer` (`id_offer`),
  KEY `FK_offer_service_service` (`id_service`),
  CONSTRAINT `FK_offer_service_offer` FOREIGN KEY (`id_offer`) REFERENCES `offer` (`id_offer`),
  CONSTRAINT `FK_offer_service_service` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.offer_service: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `offer_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_service` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.person
DROP TABLE IF EXISTS `person`;
CREATE TABLE IF NOT EXISTS `person` (
  `id_person` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `id_ubigeo` int(10) unsigned DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `document_type` varchar(5) NOT NULL,
  `document_number` varchar(25) NOT NULL,
  `state` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_person`),
  KEY `Email` (`email`) /*!80000 INVISIBLE */,
  KEY `FK_person_ubigeo` (`id_ubigeo`),
  CONSTRAINT `FK_person_ubigeo` FOREIGN KEY (`id_ubigeo`) REFERENCES `ubigeo` (`id_ubigeo`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.person: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` (`id_person`, `firstname`, `lastname`, `email`, `telephone`, `phone`, `id_ubigeo`, `street`, `document_type`, `document_number`, `state`, `create_at`, `update_at`) VALUES
	(2, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:21:39', '2019-10-13 05:21:39'),
	(3, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:22:33', '2019-10-13 05:22:33'),
	(4, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:24:48', '2019-10-13 05:24:48'),
	(5, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:42:16', '2019-10-13 05:42:16'),
	(6, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:43:21', '2019-10-13 05:43:21'),
	(7, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:43:23', '2019-10-13 05:43:23'),
	(8, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:44:58', '2019-10-13 05:44:58'),
	(9, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 05:46:21', '2019-10-13 05:46:21'),
	(10, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 06:06:50', '2019-10-13 06:06:50'),
	(11, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 06:13:18', '2019-10-13 06:13:18'),
	(12, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 06:14:14', '2019-10-13 06:14:14'),
	(13, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 06:16:17', '2019-10-13 06:16:17'),
	(14, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 06:34:00', '2019-10-13 06:34:00'),
	(15, 'Jorge', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'El Derby 254', '', '', 1, '2019-10-13 06:35:25', '2019-10-13 06:35:25'),
	(16, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 06:43:58', '2019-10-13 06:43:58'),
	(17, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 06:44:40', '2019-10-13 06:44:40'),
	(18, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 09:35:11', '2019-10-13 09:35:11'),
	(19, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '950119887', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 10:52:53', '2019-10-13 10:52:53'),
	(20, 'José Anthony', 'Ramos Chavez', 'jarch_2092@outlook.com', '950119887', '950119887', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '', 1, '2019-10-13 11:47:24', '2019-10-13 11:47:24'),
	(21, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '950119887', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '70043215', 1, '2019-10-13 13:09:43', '2019-10-13 13:09:43'),
	(22, 'José Anthony', 'Chavez', 'jarch_2092@outlook.com', '950119887', '950119887', NULL, 'Mz. I1 Lt. 01 A.H Villa Emilia', '', '70043215', 1, '2019-10-13 21:39:53', '2019-10-13 21:39:53');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.position_office
DROP TABLE IF EXISTS `position_office`;
CREATE TABLE IF NOT EXISTS `position_office` (
  `id_position` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT NULL,
  `update_at` timestamp NOT NULL DEFAULT NULL,
  PRIMARY KEY (`id_position`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.position_office: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `position_office` DISABLE KEYS */;
INSERT INTO `position_office` (`id_position`, `name`, `detail`, `status`, `create_at`, `update_at`) VALUES
	(1, 'Asesor comercial', NULL, 1, '2019-10-13 18:51:10', '2019-10-13 18:51:10');
/*!40000 ALTER TABLE `position_office` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.quote
DROP TABLE IF EXISTS `quote`;
CREATE TABLE IF NOT EXISTS `quote` (
  `quote_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` bit(1) DEFAULT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`quote_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.quote: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `quote` DISABLE KEYS */;
INSERT INTO `quote` (`quote_id`, `status`, `create_at`, `update_at`) VALUES
	(4, b'1', '2019-10-12 15:18:05', '2019-10-12 15:18:05'),
	(5, b'1', '2019-10-12 15:19:04', '2019-10-12 15:19:04'),
	(6, b'1', '2019-10-12 15:20:13', '2019-10-12 15:20:13'),
	(7, b'1', '2019-10-12 15:21:07', '2019-10-12 15:21:07'),
	(8, b'1', '2019-10-12 15:21:55', '2019-10-12 15:21:55'),
	(9, b'1', '2019-10-12 15:22:50', '2019-10-12 15:22:50'),
	(10, b'1', '2019-10-12 15:23:10', '2019-10-12 15:23:10'),
	(11, b'1', '2019-10-12 15:23:53', '2019-10-12 15:23:53'),
	(12, b'1', '2019-10-12 15:24:28', '2019-10-12 15:24:28'),
	(13, b'1', '2019-10-12 15:25:16', '2019-10-12 15:25:16'),
	(14, b'1', '2019-10-12 15:25:31', '2019-10-12 15:25:31'),
	(15, b'1', '2019-10-12 15:26:49', '2019-10-12 15:26:49'),
	(16, b'1', '2019-10-12 15:27:19', '2019-10-12 15:27:19'),
	(17, b'1', '2019-10-12 15:27:31', '2019-10-12 15:27:31'),
	(18, b'1', '2019-10-12 15:28:17', '2019-10-12 15:28:17'),
	(19, b'1', '2019-10-12 15:28:53', '2019-10-12 15:28:53'),
	(20, b'1', '2019-10-12 15:29:06', '2019-10-12 15:29:06'),
	(21, b'1', '2019-10-12 15:35:51', '2019-10-12 15:35:51'),
	(22, b'1', '2019-10-12 16:17:46', '2019-10-12 16:17:46'),
	(23, b'1', '2019-10-12 16:18:30', '2019-10-12 16:18:30'),
	(24, b'1', '2019-10-12 16:18:57', '2019-10-12 16:18:57'),
	(25, b'1', '2019-10-12 16:21:32', '2019-10-12 16:21:32'),
	(26, b'1', '2019-10-12 16:21:39', '2019-10-12 16:21:39'),
	(27, b'1', '2019-10-12 16:24:56', '2019-10-12 16:24:56'),
	(28, b'1', '2019-10-12 16:38:15', '2019-10-12 16:38:15'),
	(29, b'1', '2019-10-12 16:38:24', '2019-10-12 16:38:24'),
	(30, b'1', '2019-10-12 23:58:48', '2019-10-12 23:58:48'),
	(31, b'1', '2019-10-12 23:59:05', '2019-10-12 23:59:05'),
	(32, b'1', '2019-10-12 23:59:38', '2019-10-12 23:59:38'),
	(33, b'1', '2019-10-13 00:01:27', '2019-10-13 00:01:27'),
	(34, b'1', '2019-10-13 00:28:51', '2019-10-13 00:28:51'),
	(35, b'1', '2019-10-13 00:30:46', '2019-10-13 00:30:46'),
	(36, b'1', '2019-10-13 01:18:00', '2019-10-13 01:18:00'),
	(37, b'1', '2019-10-13 05:47:11', '2019-10-13 05:47:11'),
	(38, b'1', '2019-10-13 06:06:37', '2019-10-13 06:06:37'),
	(39, b'1', '2019-10-13 06:13:06', '2019-10-13 06:13:06'),
	(40, b'1', '2019-10-13 06:16:07', '2019-10-13 06:16:07'),
	(41, b'1', '2019-10-13 06:22:49', '2019-10-13 06:22:49'),
	(42, b'1', '2019-10-13 06:35:07', '2019-10-13 06:35:07'),
	(43, b'1', '2019-10-13 06:43:46', '2019-10-13 06:43:46'),
	(44, b'1', '2019-10-13 06:44:29', '2019-10-13 06:44:29'),
	(45, b'1', '2019-10-13 09:34:34', '2019-10-13 09:34:34'),
	(46, b'1', '2019-10-13 10:52:16', '2019-10-13 10:52:16'),
	(47, b'1', '2019-10-13 11:43:40', '2019-10-13 11:43:40'),
	(48, b'1', '2019-10-13 11:51:38', '2019-10-13 11:51:38'),
	(49, b'1', '2019-10-13 13:08:57', '2019-10-13 13:08:57'),
	(50, b'1', '2019-10-13 14:35:31', '2019-10-13 14:35:31'),
	(51, b'1', '2019-10-13 21:39:13', '2019-10-13 21:39:13');
/*!40000 ALTER TABLE `quote` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.quote_item
DROP TABLE IF EXISTS `quote_item`;
CREATE TABLE IF NOT EXISTS `quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0',
  `service_id` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`item_id`),
  KEY `FK_quote_item_quote` (`quote_id`),
  KEY `FK_quote_item_service` (`service_id`),
  CONSTRAINT `FK_quote_item_quote` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`quote_id`),
  CONSTRAINT `FK_quote_item_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.quote_item: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `quote_item` DISABLE KEYS */;
INSERT INTO `quote_item` (`item_id`, `quote_id`, `service_id`, `quantity`, `create_at`, `update_at`) VALUES
	(1, 4, 1, 1, '2019-10-12 15:18:06', '2019-10-12 15:18:06'),
	(2, 5, 2, 1, '2019-10-12 15:19:04', '2019-10-13 00:25:24'),
	(3, 6, 1, 1, '2019-10-12 15:20:13', '2019-10-12 15:20:13'),
	(4, 7, 1, 1, '2019-10-12 15:21:07', '2019-10-12 15:21:07'),
	(5, 8, 1, 1, '2019-10-12 15:21:55', '2019-10-12 15:21:55'),
	(6, 9, 1, 1, '2019-10-12 15:22:51', '2019-10-12 15:22:51'),
	(7, 10, 1, 1, '2019-10-12 15:23:10', '2019-10-12 15:23:10'),
	(8, 11, 1, 1, '2019-10-12 15:23:53', '2019-10-12 15:23:53'),
	(9, 12, 1, 1, '2019-10-12 15:24:28', '2019-10-12 15:24:28'),
	(10, 13, 1, 1, '2019-10-12 15:25:16', '2019-10-12 15:25:16'),
	(11, 14, 1, 1, '2019-10-12 15:25:31', '2019-10-12 15:25:31'),
	(12, 15, 1, 1, '2019-10-12 15:26:49', '2019-10-12 15:26:49'),
	(13, 16, 1, 1, '2019-10-12 15:27:19', '2019-10-12 15:27:19'),
	(14, 17, 1, 1, '2019-10-12 15:27:31', '2019-10-12 15:27:31'),
	(15, 18, 1, 1, '2019-10-12 15:28:17', '2019-10-12 15:28:17'),
	(16, 19, 1, 1, '2019-10-12 15:28:53', '2019-10-12 15:28:53'),
	(17, 20, 1, 1, '2019-10-12 15:29:06', '2019-10-12 15:29:06'),
	(18, 21, 1, 1, '2019-10-12 15:35:51', '2019-10-12 15:35:51'),
	(19, 21, 2, 10, '2019-10-12 15:35:51', '2019-10-12 15:35:51'),
	(20, 22, 3, 1, '2019-10-12 16:17:46', '2019-10-12 16:17:46'),
	(21, 23, 3, 1, '2019-10-12 16:18:30', '2019-10-12 16:18:30'),
	(22, 24, 1, 1, '2019-10-12 16:18:57', '2019-10-12 16:18:57'),
	(23, 25, 2, 1, '2019-10-12 16:21:32', '2019-10-12 16:21:32'),
	(24, 26, 3, 1, '2019-10-12 16:21:39', '2019-10-12 16:21:39'),
	(25, 27, 2, 1, '2019-10-12 16:24:56', '2019-10-12 16:24:56'),
	(26, 28, 3, 1, '2019-10-12 16:38:15', '2019-10-12 16:38:15'),
	(27, 29, 3, 1, '2019-10-12 16:38:24', '2019-10-12 16:38:24'),
	(28, 30, 3, 1, '2019-10-12 23:58:48', '2019-10-12 23:58:48'),
	(29, 31, 2, 1, '2019-10-12 23:59:05', '2019-10-12 23:59:05'),
	(30, 32, 2, 1, '2019-10-12 23:59:38', '2019-10-12 23:59:38'),
	(31, 33, 1, 1, '2019-10-13 00:01:27', '2019-10-13 00:01:27'),
	(32, 33, 2, 1, '2019-10-13 00:27:00', '2019-10-13 00:27:00'),
	(33, 33, 3, 1, '2019-10-13 00:27:21', '2019-10-13 00:27:21'),
	(34, 34, 3, 1, '2019-10-13 00:28:51', '2019-10-13 00:28:51'),
	(35, 34, 2, 1, '2019-10-13 00:29:00', '2019-10-13 00:29:00'),
	(36, 34, 1, 1, '2019-10-13 00:29:11', '2019-10-13 00:29:11'),
	(37, 35, 2, 1, '2019-10-13 00:30:46', '2019-10-13 00:30:46'),
	(38, 35, 1, 1, '2019-10-13 00:30:54', '2019-10-13 00:30:54'),
	(39, 35, 3, 1, '2019-10-13 00:31:00', '2019-10-13 00:31:00'),
	(40, 36, 3, 1, '2019-10-13 01:18:00', '2019-10-13 01:18:00'),
	(41, 36, 1, 1, '2019-10-13 01:20:51', '2019-10-13 01:20:51'),
	(42, 36, 2, 1, '2019-10-13 01:22:20', '2019-10-13 01:22:20'),
	(43, 37, 2, 1, '2019-10-13 05:47:11', '2019-10-13 05:47:11'),
	(44, 38, 2, 1, '2019-10-13 06:06:37', '2019-10-13 06:06:37'),
	(45, 39, 2, 1, '2019-10-13 06:13:06', '2019-10-13 06:13:06'),
	(46, 40, 2, 1, '2019-10-13 06:16:07', '2019-10-13 06:16:07'),
	(47, 41, 2, 1, '2019-10-13 06:22:49', '2019-10-13 06:22:49'),
	(48, 42, 2, 1, '2019-10-13 06:35:07', '2019-10-13 06:35:07'),
	(49, 43, 2, 1, '2019-10-13 06:43:46', '2019-10-13 06:43:46'),
	(50, 44, 1, 1, '2019-10-13 06:44:29', '2019-10-13 06:44:29'),
	(51, 45, 3, 1, '2019-10-13 09:34:34', '2019-10-13 09:34:34'),
	(52, 46, 2, 1, '2019-10-13 10:52:16', '2019-10-13 10:52:16'),
	(53, 46, 3, 1, '2019-10-13 10:52:20', '2019-10-13 10:52:20'),
	(54, 46, 1, 1, '2019-10-13 10:52:23', '2019-10-13 10:52:23'),
	(55, 47, 2, 1, '2019-10-13 11:43:40', '2019-10-13 11:43:40'),
	(56, 47, 1, 1, '2019-10-13 11:43:47', '2019-10-13 11:43:47'),
	(57, 48, 2, 1, '2019-10-13 11:51:38', '2019-10-13 11:51:38'),
	(58, 49, 2, 1, '2019-10-13 13:08:57', '2019-10-13 13:08:57'),
	(59, 49, 1, 1, '2019-10-13 13:09:01', '2019-10-13 13:09:01'),
	(60, 50, 2, 1, '2019-10-13 14:35:31', '2019-10-13 14:35:31'),
	(61, 51, 2, 1, '2019-10-13 21:39:13', '2019-10-13 21:39:13'),
	(62, 51, 1, 1, '2019-10-13 21:39:17', '2019-10-13 21:39:17');
/*!40000 ALTER TABLE `quote_item` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.request
DROP TABLE IF EXISTS `request`;
CREATE TABLE IF NOT EXISTS `request` (
  `id_request` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `id_offer` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_employee` int(10) unsigned DEFAULT NULL,
  `id_request_status` int(10) unsigned NOT NULL,
  `quote_id` int(10) unsigned NOT NULL,
  `is_closed` bit(1) NOT NULL DEFAULT b'0',
  `satisfactory_rating` tinyint(3) unsigned DEFAULT NULL,
  `detail` varchar(250) DEFAULT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_request`),
  KEY `FK__offer` (`id_offer`),
  KEY `FK__employee` (`id_employee`),
  KEY `FK__customer_request` (`id_customer`),
  KEY `FK_request_status_request` (`id_request_status`),
  KEY `FK_request_quote` (`quote_id`),
  CONSTRAINT `FK__customer_request` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`),
  CONSTRAINT `FK__employee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id_employee`),
  CONSTRAINT `FK__offer` FOREIGN KEY (`id_offer`) REFERENCES `offer` (`id_offer`),
  CONSTRAINT `FK_request_quote` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`quote_id`),
  CONSTRAINT `FK_request_status_request` FOREIGN KEY (`id_request_status`) REFERENCES `status_request` (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.request: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` (`id_request`, `code`, `id_offer`, `id_customer`, `id_employee`, `id_request_status`, `quote_id`, `is_closed`, `satisfactory_rating`, `detail`, `create_at`, `update_at`) VALUES
	(1, '1570962099???', NULL, 3, NULL, 1, 36, b'1', NULL, NULL, '2019-10-13 05:21:39', '2019-10-13 18:45:08'),
	(2, '1570962153?[?x@', NULL, 4, NULL, 1, 36, b'1', NULL, '', '2019-10-13 05:22:33', '2019-10-13 18:45:08'),
	(3, '1570962288??aa', NULL, 5, NULL, 1, 36, b'1', NULL, 'dcvbnm,', '2019-10-13 05:24:48', '2019-10-13 18:45:08'),
	(4, '1570963336d54A&afmAsdS$#%', NULL, 6, NULL, 1, 36, b'1', NULL, 'dcvbnm,', '2019-10-13 05:42:16', '2019-10-13 18:45:08'),
	(5, '157096340153asm3kd$$#4!D5', NULL, 7, NULL, 1, 36, b'1', NULL, 'dcvbnm,', '2019-10-13 05:43:21', '2019-10-13 18:45:08'),
	(6, '1570963403m$sDd&S3#&D45%A', NULL, 8, NULL, 1, 36, b'1', NULL, 'dcvbnm,', '2019-10-13 05:43:23', '2019-10-13 18:45:08'),
	(7, '1570963498sd4Skf!mA5D$44m', NULL, 9, NULL, 1, 36, b'1', NULL, 'dcvbnm,', '2019-10-13 05:44:58', '2019-10-13 18:45:08'),
	(8, '1570963581DdS$g&gdD#fS43$', NULL, 10, NULL, 1, 36, b'1', NULL, '', '2019-10-13 05:46:21', '2019-10-13 18:45:08'),
	(9, 'D#5SA696!k45Sf%5d46&D1dA$', NULL, 11, NULL, 1, 37, b'1', NULL, 'lorem ipsum', '2019-10-13 05:47:41', '2019-10-13 18:45:08'),
	(10, 'mAmf!$d5%%54010D41dA$&9Dk', NULL, 12, NULL, 1, 38, b'1', NULL, '', '2019-10-13 06:06:50', '2019-10-13 18:45:08'),
	(11, '5Ad%5m3gS$g$f95Am!9Sk&48&', NULL, 13, NULL, 1, 39, b'1', NULL, '', '2019-10-13 06:13:18', '2019-10-13 18:45:08'),
	(12, '$4DAd644%1547&DkA$m$A0fS&', NULL, 14, NULL, 1, 39, b'1', NULL, '', '2019-10-13 06:14:14', '2019-10-13 18:45:08'),
	(13, '5dS#7A6$3g5&50%!41A3$a4&m', NULL, 15, NULL, 1, 40, b'1', NULL, '', '2019-10-13 06:16:17', '2019-10-13 18:45:08'),
	(14, 'AmaS740gm34&$31S$59dk%546', NULL, 16, NULL, 1, 41, b'1', NULL, '', '2019-10-13 06:34:00', '2019-10-13 18:45:08'),
	(15, 'A9$mmAD44%S4k5%5D5#0!Da6$', NULL, 17, NULL, 1, 42, b'1', NULL, '', '2019-10-13 06:35:25', '2019-10-13 18:45:08'),
	(16, 'Am4$89m4gAg7550!07#%$d5D6', NULL, 18, NULL, 1, 43, b'1', NULL, '', '2019-10-13 06:43:58', '2019-10-13 18:45:08'),
	(17, 'm0gAa6g1!3A7d%4&&S5780DSD', NULL, 19, NULL, 1, 44, b'1', NULL, '', '2019-10-13 06:44:40', '2019-10-13 18:45:08'),
	(18, '3Dm2d!Sa$g$5%5&57s$Dd#34D', NULL, 20, 1, 1, 45, b'0', NULL, '', '2019-10-13 09:35:12', '2019-10-13 19:15:48'),
	(19, 'k#$3859549gg$!dDm44%A5A54', NULL, 21, 1, 1, 46, b'0', NULL, '', '2019-10-13 10:52:53', '2019-10-13 19:10:37'),
	(20, '$&m#D&5!Ddg23AgA$44adk8fs', NULL, 22, 1, 1, 47, b'0', NULL, 'ghfjdks,vb,vcx', '2019-10-13 11:47:24', '2019-10-13 19:15:59'),
	(21, 'g13!A4&5AmS5Dkd755md5$%S4', NULL, 23, 1, 1, 48, b'0', NULL, 'sdfsdfsdfsdf', '2019-10-13 11:52:17', '2019-10-13 19:11:20'),
	(22, 'd0SS!D5A3%&3545a1k4dAm14g', NULL, 24, 1, 1, 49, b'0', NULL, 'Hola, necesito un buen servicio :)', '2019-10-13 13:09:43', '2019-10-13 19:11:57'),
	(23, 'k0#g1AfDD%1Ss15d544a3A&43', NULL, 25, 1, 1, 50, b'0', NULL, 'dfcvghbnjmk,', '2019-10-13 20:55:54', '2019-10-13 21:23:28'),
	(24, '&334fg1902S5A5s$4d1Dmd#75', NULL, 26, 1, 1, 51, b'0', NULL, ' hksfhskfhskfs sdkfsjdfhsfhs shfks fd sjdfh djshfksfhskf', '2019-10-13 21:39:53', '2019-10-13 21:40:11');
/*!40000 ALTER TABLE `request` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.request_history
DROP TABLE IF EXISTS `request_history`;
CREATE TABLE IF NOT EXISTS `request_history` (
  `id_request_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_status_request` int(10) unsigned DEFAULT NULL,
  `id_request` int(10) unsigned NOT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `from_type` varchar(150) DEFAULT NULL,
  `from_id` int(11) DEFAULT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_request_history`),
  KEY `FK_request_history_status_request` (`id_status_request`),
  KEY `FK_request_history_request` (`id_request`),
  CONSTRAINT `FK_request_history_request` FOREIGN KEY (`id_request`) REFERENCES `request` (`id_request`),
  CONSTRAINT `FK_request_history_status_request` FOREIGN KEY (`id_status_request`) REFERENCES `status_request` (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.request_history: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `request_history` DISABLE KEYS */;
INSERT INTO `request_history` (`id_request_history`, `id_status_request`, `id_request`, `comment`, `from_type`, `from_id`, `create_at`, `update_at`) VALUES
	(1, 1, 1, NULL, 'customer', 3, '2019-10-13 05:21:40', '2019-10-13 05:21:40'),
	(2, 1, 2, '', 'customer', 4, '2019-10-13 05:22:33', '2019-10-13 05:22:33'),
	(3, 1, 3, 'dcvbnm,', 'customer', 5, '2019-10-13 05:24:48', '2019-10-13 05:24:48'),
	(4, 1, 4, 'dcvbnm,', 'customer', 6, '2019-10-13 05:42:16', '2019-10-13 05:42:16'),
	(5, 1, 5, 'dcvbnm,', 'customer', 7, '2019-10-13 05:43:21', '2019-10-13 05:43:21'),
	(6, 1, 6, 'dcvbnm,', 'customer', 8, '2019-10-13 05:43:23', '2019-10-13 05:43:23'),
	(7, 1, 7, 'dcvbnm,', 'customer', 9, '2019-10-13 05:44:58', '2019-10-13 05:44:58'),
	(8, 1, 8, '', 'customer', 10, '2019-10-13 05:46:21', '2019-10-13 05:46:21'),
	(9, 1, 9, 'lorem ipsum', 'customer', 11, '2019-10-13 05:47:41', '2019-10-13 05:47:41'),
	(10, 1, 10, '', 'customer', 12, '2019-10-13 06:06:50', '2019-10-13 06:06:50'),
	(11, 1, 11, '', 'customer', 13, '2019-10-13 06:13:18', '2019-10-13 06:13:18'),
	(12, 1, 12, '', 'customer', 14, '2019-10-13 06:14:14', '2019-10-13 06:14:14'),
	(13, 1, 13, '', 'customer', 15, '2019-10-13 06:16:17', '2019-10-13 06:16:17'),
	(14, 1, 14, '', 'customer', 16, '2019-10-13 06:34:00', '2019-10-13 06:34:00'),
	(15, 1, 15, '', 'customer', 17, '2019-10-13 06:35:25', '2019-10-13 06:35:25'),
	(16, 1, 16, '', 'customer', 18, '2019-10-13 06:43:58', '2019-10-13 06:43:58'),
	(17, 1, 17, '', 'customer', 19, '2019-10-13 06:44:40', '2019-10-13 06:44:40'),
	(18, 1, 18, '', 'customer', 20, '2019-10-13 09:35:12', '2019-10-13 09:35:12'),
	(19, 1, 19, '', 'customer', 21, '2019-10-13 10:52:53', '2019-10-13 10:52:53'),
	(20, 1, 20, 'ghfjdks,vb,vcx', 'customer', 22, '2019-10-13 11:47:24', '2019-10-13 11:47:24'),
	(21, 1, 21, 'sdfsdfsdfsdf', 'customer', 23, '2019-10-13 11:52:18', '2019-10-13 11:52:18'),
	(22, 1, 22, 'Hola, necesito un buen servicio :)', 'customer', 24, '2019-10-13 13:09:43', '2019-10-13 13:09:43'),
	(23, NULL, 22, 'comentario 1', 'customer', 24, '2019-10-13 13:46:32', '2019-10-13 13:46:32'),
	(24, NULL, 22, 'comentario 2', 'customer', 24, '2019-10-13 13:47:33', '2019-10-13 13:47:33'),
	(25, NULL, 22, 'comentario 3', 'customer', 24, '2019-10-13 13:47:52', '2019-10-13 13:47:52'),
	(26, NULL, 22, 'comentario 4', 'customer', 24, '2019-10-13 13:49:33', '2019-10-13 13:49:33'),
	(27, NULL, 22, 'comentario 4', 'customer', 24, '2019-10-13 13:50:38', '2019-10-13 13:50:38'),
	(28, NULL, 22, 'comentario 5', 'customer', 24, '2019-10-13 13:52:06', '2019-10-13 13:52:06'),
	(29, NULL, 22, 'comentario 5', 'customer', 24, '2019-10-13 13:52:28', '2019-10-13 13:52:28'),
	(30, NULL, 22, 'comentario 6', 'customer', 24, '2019-10-13 13:52:36', '2019-10-13 13:52:36'),
	(31, NULL, 22, 'comentario 7', 'customer', 24, '2019-10-13 13:52:47', '2019-10-13 13:52:47'),
	(32, NULL, 22, 'holaaaaaaa', 'customer', 24, '2019-10-13 13:54:47', '2019-10-13 13:54:47'),
	(33, NULL, 22, 'fds', 'adviser', NULL, '2019-10-13 14:00:45', '2019-10-13 14:00:45'),
	(34, NULL, 22, 'mensaje del asesor', 'adviser', NULL, '2019-10-13 14:01:26', '2019-10-13 14:01:26'),
	(35, NULL, 22, 'a genial', 'customer', 24, '2019-10-13 14:02:10', '2019-10-13 14:02:10'),
	(36, NULL, 22, 'a genial, por fa lo mas pronto posible', 'customer', 24, '2019-10-13 14:13:47', '2019-10-13 14:13:47'),
	(37, NULL, 20, 'dfghjklñ', 'adviser', NULL, '2019-10-13 19:16:31', '2019-10-13 19:16:31'),
	(38, NULL, 19, 'sdfghjkl', 'adviser', NULL, '2019-10-13 19:23:09', '2019-10-13 19:23:09'),
	(39, NULL, 22, 'dfghjklñ', 'adviser', NULL, '2019-10-13 19:24:41', '2019-10-13 19:24:41'),
	(40, 1, 23, 'dfcvghbnjmk,', 'customer', 25, '2019-10-13 20:55:54', '2019-10-13 20:55:54'),
	(41, 1, 24, ' hksfhskfhskfs sdkfsjdfhsfhs shfks fd sjdfh djshfksfhskf', 'customer', 26, '2019-10-13 21:39:53', '2019-10-13 21:39:53'),
	(42, NULL, 24, 'xcvbnm, fgbhnm,', 'customer', 26, '2019-10-13 21:46:17', '2019-10-13 21:46:17'),
	(43, NULL, 24, 'jajajajaj', 'customer', 26, '2019-10-13 21:52:22', '2019-10-13 21:52:22'),
	(44, NULL, 24, 'como esta usted?', 'adviser', 1, '2019-10-13 21:56:49', '2019-10-13 21:56:49'),
	(45, NULL, 24, 'como esta usted?', 'adviser', 1, '2019-10-13 21:56:58', '2019-10-13 21:56:58'),
	(46, NULL, 24, 'no lo se', 'customer', 26, '2019-10-13 21:57:18', '2019-10-13 21:57:18'),
	(47, NULL, 24, 'shh bueno', 'adviser', 1, '2019-10-13 21:57:47', '2019-10-13 21:57:47'),
	(48, NULL, 23, 'xcvbnm,', 'adviser', 1, '2019-10-13 21:58:48', '2019-10-13 21:58:48'),
	(49, NULL, 23, 'xcvbnm,', 'adviser', 1, '2019-10-13 21:59:55', '2019-10-13 21:59:55'),
	(50, NULL, 23, 'xcvbnm, jajajajaj', 'adviser', 1, '2019-10-13 22:04:12', '2019-10-13 22:04:12'),
	(51, NULL, 24, 'asdadadadad', 'customer', 26, '2019-10-13 22:05:11', '2019-10-13 22:05:11'),
	(52, NULL, 24, 'asdadadadad', 'customer', 26, '2019-10-13 22:18:28', '2019-10-13 22:18:28'),
	(53, NULL, 24, 'asdadadadad iopokj', 'customer', 26, '2019-10-13 22:18:34', '2019-10-13 22:18:34'),
	(54, NULL, 23, 'mamamamamam', 'customer', 25, '2019-10-13 22:19:16', '2019-10-13 22:19:16');
/*!40000 ALTER TABLE `request_history` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.request_item
DROP TABLE IF EXISTS `request_item`;
CREATE TABLE IF NOT EXISTS `request_item` (
  `id_item` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_service` int(10) unsigned NOT NULL,
  `id_request` int(10) unsigned NOT NULL,
  `detail` varchar(250) DEFAULT NULL,
  `quantity` smallint(5) unsigned NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `discount` decimal(10,2) unsigned NOT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_item`),
  KEY `FK_request_item_service` (`id_service`),
  KEY `FK_request_item_request` (`id_request`),
  CONSTRAINT `FK_request_item_request` FOREIGN KEY (`id_request`) REFERENCES `request` (`id_request`),
  CONSTRAINT `FK_request_item_service` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.request_item: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `request_item` DISABLE KEYS */;
INSERT INTO `request_item` (`id_item`, `id_service`, `id_request`, `detail`, `quantity`, `price`, `discount`, `amount`, `create_at`, `update_at`) VALUES
	(1, 3, 1, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:21:40', '2019-10-13 05:21:40'),
	(2, 1, 1, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:21:40', '2019-10-13 05:21:40'),
	(3, 2, 1, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:21:40', '2019-10-13 05:21:40'),
	(4, 3, 2, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:22:33', '2019-10-13 05:22:33'),
	(5, 1, 2, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:22:33', '2019-10-13 05:22:33'),
	(6, 2, 2, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:22:33', '2019-10-13 05:22:33'),
	(7, 3, 3, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:24:48', '2019-10-13 05:24:48'),
	(8, 1, 3, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:24:48', '2019-10-13 05:24:48'),
	(9, 2, 3, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:24:48', '2019-10-13 05:24:48'),
	(10, 3, 4, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:42:16', '2019-10-13 05:42:16'),
	(11, 1, 4, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:42:16', '2019-10-13 05:42:16'),
	(12, 2, 4, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:42:16', '2019-10-13 05:42:16'),
	(13, 3, 5, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:43:21', '2019-10-13 05:43:21'),
	(14, 1, 5, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:43:21', '2019-10-13 05:43:21'),
	(15, 2, 5, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:43:21', '2019-10-13 05:43:21'),
	(16, 3, 6, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:43:23', '2019-10-13 05:43:23'),
	(17, 1, 6, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:43:23', '2019-10-13 05:43:23'),
	(18, 2, 6, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:43:23', '2019-10-13 05:43:23'),
	(19, 3, 7, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:44:58', '2019-10-13 05:44:58'),
	(20, 1, 7, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:44:58', '2019-10-13 05:44:58'),
	(21, 2, 7, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:44:58', '2019-10-13 05:44:58'),
	(22, 3, 8, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 05:46:21', '2019-10-13 05:46:21'),
	(23, 1, 8, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 05:46:21', '2019-10-13 05:46:21'),
	(24, 2, 8, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:46:21', '2019-10-13 05:46:21'),
	(25, 2, 9, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 05:47:41', '2019-10-13 05:47:41'),
	(26, 2, 10, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 06:06:50', '2019-10-13 06:06:50'),
	(27, 2, 11, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 06:13:18', '2019-10-13 06:13:18'),
	(28, 2, 12, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 06:14:14', '2019-10-13 06:14:14'),
	(29, 2, 13, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 06:16:17', '2019-10-13 06:16:17'),
	(30, 2, 14, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 06:34:00', '2019-10-13 06:34:00'),
	(31, 2, 15, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 06:35:25', '2019-10-13 06:35:25'),
	(32, 2, 16, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 06:43:58', '2019-10-13 06:43:58'),
	(33, 1, 17, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 06:44:40', '2019-10-13 06:44:40'),
	(34, 3, 18, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 09:35:12', '2019-10-13 09:35:12'),
	(35, 2, 19, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 10:52:53', '2019-10-13 10:52:53'),
	(36, 3, 19, NULL, 1, 56.36, 0.00, 56.36, '2019-10-13 10:52:53', '2019-10-13 10:52:53'),
	(37, 1, 19, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 10:52:53', '2019-10-13 10:52:53'),
	(38, 2, 20, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 11:47:24', '2019-10-13 11:47:24'),
	(39, 1, 20, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 11:47:24', '2019-10-13 11:47:24'),
	(40, 2, 21, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 11:52:17', '2019-10-13 11:52:17'),
	(41, 2, 22, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 13:09:43', '2019-10-13 13:09:43'),
	(42, 1, 22, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 13:09:43', '2019-10-13 13:09:43'),
	(43, 2, 23, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 20:55:54', '2019-10-13 20:55:54'),
	(44, 2, 24, NULL, 1, 125.23, 0.00, 125.23, '2019-10-13 21:39:53', '2019-10-13 21:39:53'),
	(45, 1, 24, NULL, 1, 265.45, 0.00, 265.45, '2019-10-13 21:39:53', '2019-10-13 21:39:53');
/*!40000 ALTER TABLE `request_item` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.service
DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id_service` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `details` text NOT NULL,
  `images` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_service`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.service: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` (`id_service`, `title`, `details`, `images`, `price`, `status`, `create_at`, `update_at`) VALUES
	(1, 'Desarrollo de software', 'lorem ipsum', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRGa19v0Ye67dNUJXC4Ti8wtf_Y01vw7ZntO8wqdexBqXWB5zbE', 265.45, 1, '2019-10-08 16:41:05', '2019-10-08 16:42:38'),
	(2, 'Soporte técnico', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id nulla ex. Nulla congue orci at dolor sagittis laoreet. Mauris iaculis, arcu vitae mattis rhoncus, ligula nisi pharetra quam, rhoncus luctus justo felis at velit. Sed blandit massa at gravida feugiat. Integer porttitor ipsum nec nulla scelerisque, vitae dapibus urna ultricies. Phasellus commodo neque in magna egestas sodales. Duis quis urna et augue mattis sodales in quis nulla. Pellentesque volutpat odio quis suscipit viverra. Morbi libero nibh, condimentum nec libero ultricies, pharetra viverra lacus. Nulla volutpat enim quam, vitae dapibus nulla rhoncus sit amet. Sed eu dolor pulvinar, feugiat ante a, condimentum erat. Sed eu massa laoreet, vehicula diam id, semper diam.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT8zFfCh4MtO3Ixwi3k4NQWixWlS3vS4Skdw3f5wfG4zEDc1lHm', 125.23, 1, '2019-10-08 16:44:41', '2019-10-11 01:22:50'),
	(3, 'Wifi digital', 'lorem ipsum', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTPB_cBJmyDq7BBTK_XEuoPIixir2H8TgERRmv6BDvJsYfy4sbC', 56.36, 1, '2019-10-08 16:46:07', '2019-10-08 16:46:07'),
	(4, 'ksdfjslkdjfk', 'dksskjasljdasld', 'dsfjs', 889.00, 0, '2019-10-08 17:56:33', '2019-10-11 01:22:04');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.status_request
DROP TABLE IF EXISTS `status_request`;
CREATE TABLE IF NOT EXISTS `status_request` (
  `id_status` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `detail` varchar(250) NOT NULL,
  `position` smallint(5) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.status_request: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `status_request` DISABLE KEYS */;
INSERT INTO `status_request` (`id_status`, `name`, `detail`, `position`, `status`, `create_at`, `update_at`) VALUES
	(1, 'new', 'Nuevo', 1, 1, '2019-10-13 04:28:56', '2019-10-13 22:12:51'),
	(2, 'processing', 'Procesando', 2, 1, '2019-10-13 22:12:45', '2019-10-13 22:12:45'),
	(3, 'hold', 'En Espera', 3, 1, '2019-10-13 22:14:05', '2019-10-13 22:14:05'),
	(4, 'approved', 'Aprobado', 4, 1, '2019-10-13 22:14:25', '2019-10-13 22:14:25'),
	(5, 'customer_cancel', 'Cancelado', 5, 0, '2019-10-13 22:16:07', '2019-10-13 23:20:16'),
	(6, 'cancel', 'Cancelado', 5, 1, '2019-10-13 22:16:45', '2019-10-13 22:16:45'),
	(7, 'closed', 'Cerrado', 6, 1, '2019-10-13 23:20:45', '2019-10-13 23:20:45');
/*!40000 ALTER TABLE `status_request` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.ubigeo
DROP TABLE IF EXISTS `ubigeo`;
CREATE TABLE IF NOT EXISTS `ubigeo` (
  `id_ubigeo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(15) NOT NULL,
  `name` varchar(100) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `state` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_ubigeo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.ubigeo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ubigeo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ubigeo` ENABLE KEYS */;

-- Volcando estructura para tabla tesis_luz.user_rol
DROP TABLE IF EXISTS `user_rol`;
CREATE TABLE IF NOT EXISTS `user_rol` (
  `id_role` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  `code` varchar(25) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '1990-01-01 12:00:12',
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tesis_luz.user_rol: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user_rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_rol` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
