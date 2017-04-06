-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 03, 2014 at 10:24 AM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `poson_lp`
--

-- --------------------------------------------------------

--
-- Table structure for table `ospos_app_config`
--

CREATE TABLE IF NOT EXISTS `ospos_app_config` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_app_config`
--

INSERT INTO `ospos_app_config` (`key`, `value`, `id_owner`) VALUES
('address', 'Indonesia', 0),
('company', 'BPInternusa', 0),
('currency_symbol', 'Rp.', 0),
('default_tax_1_name', 'PPN', 0),
('default_tax_1_rate', '5', 0),
('default_tax_2_name', 'Sales Tax 2', 0),
('default_tax_2_rate', '10', 0),
('default_tax_rate', '8', 0),
('email', '', 0),
('fax', '', 0),
('language', 'english', 0),
('phone', '000000', 0),
('print_after_sale', 'print_after_sale', 0),
('purchase_point', '15000,00', 0),
('return_policy', '-', 0),
('timezone', 'Asia/Hong_Kong', 0),
('website', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_customers`
--

CREATE TABLE IF NOT EXISTS `ospos_customers` (
  `person_id` int(10) NOT NULL,
  `company` varchar(200) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `taxable` int(1) NOT NULL DEFAULT '1',
  `point` int(11) NOT NULL DEFAULT '0',
  `deleted` int(1) NOT NULL DEFAULT '0',
  `id_owner` int(10) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_customers`
--

INSERT INTO `ospos_customers` (`person_id`, `company`, `account_number`, `taxable`, `point`, `deleted`, `id_owner`) VALUES
(2, '', '000001A', 1, 10, 1, 0),
(3, '', '2', 1, 5, 1, 0),
(5, 'Sheraton', NULL, 1, 6, 1, 0),
(6, '', '3', 1, 1, 1, 0),
(8, 'internusa', NULL, 0, 0, 1, 0),
(9, 'lombok taxi', NULL, 1, 0, 1, 0),
(11, 'BCA', '', 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_employees`
--

CREATE TABLE IF NOT EXISTS `ospos_employees` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ospos_employees`
--

INSERT INTO `ospos_employees` (`id`, `username`, `password`, `person_id`, `deleted`) VALUES
(1, 'admin', '25d55ad283aa400af464c76d713c07ad', 1, 0),
(2, 'penjualan', '25d55ad283aa400af464c76d713c07ad', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_giftcards`
--

CREATE TABLE IF NOT EXISTS `ospos_giftcards` (
  `giftcard_id` int(11) NOT NULL AUTO_INCREMENT,
  `giftcard_number` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `value` double(3,2) NOT NULL,
  `giftcard_count` int(4) NOT NULL,
  `activated` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`giftcard_id`),
  UNIQUE KEY `giftcard_number` (`giftcard_number`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ospos_giftcards`
--

INSERT INTO `ospos_giftcards` (`giftcard_id`, `giftcard_number`, `value`, `giftcard_count`, `activated`, `deleted`) VALUES
(1, '123', 0.00, 0, 0, 0),
(2, '111', 9.99, 0, 0, 0),
(3, '222', 0.00, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_giftcards_movement`
--

CREATE TABLE IF NOT EXISTS `ospos_giftcards_movement` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_giftcard` int(11) NOT NULL DEFAULT '0',
  `trans_person_id` int(11) NOT NULL DEFAULT '0',
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text NOT NULL,
  PRIMARY KEY (`trans_id`),
  KEY `ospos_inventory_ibfk_1` (`trans_giftcard`),
  KEY `ospos_inventory_ibfk_2` (`trans_person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=278 ;

--
-- Dumping data for table `ospos_giftcards_movement`
--

INSERT INTO `ospos_giftcards_movement` (`trans_id`, `trans_giftcard`, `trans_person_id`, `trans_date`, `trans_comment`) VALUES
(277, 1, 5, '2013-03-05 10:56:38', '');

-- --------------------------------------------------------

--
-- Table structure for table `ospos_inventory`
--

CREATE TABLE IF NOT EXISTS `ospos_inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL DEFAULT '0',
  `trans_user` int(11) NOT NULL DEFAULT '0',
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text NOT NULL,
  `trans_inventory` int(11) NOT NULL DEFAULT '0',
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`trans_id`),
  KEY `ospos_inventory_ibfk_1` (`trans_items`),
  KEY `ospos_inventory_ibfk_2` (`trans_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=291 ;

--
-- Dumping data for table `ospos_inventory`
--

INSERT INTO `ospos_inventory` (`trans_id`, `trans_items`, `trans_user`, `trans_date`, `trans_comment`, `trans_inventory`, `id_owner`) VALUES
(1, 1, 1, '2012-11-07 09:54:38', 'Manual Edit of Quantity', 10, 0),
(2, 1, 1, '2012-12-31 23:12:31', 'RECV 1', 1, 0),
(3, 1, 1, '2013-02-07 02:38:51', 'POS 5', -1, 0),
(4, 1, 1, '2013-02-07 19:32:35', 'POS 6', -1, 0),
(5, 2, 1, '2013-02-08 10:43:46', 'Manual Edit of Quantity', 10, 0),
(6, 2, 1, '2013-02-08 14:00:56', 'Manual Edit of Quantity', 0, 0),
(7, 2, 1, '2013-02-08 15:05:27', 'POS 7', -1, 0),
(8, 1, 1, '2013-02-08 20:16:54', 'Manual Edit of Quantity', 0, 0),
(9, 1, 1, '2013-02-08 20:17:07', 'Manual Edit of Quantity', 0, 0),
(10, 1, 1, '2013-02-08 20:27:18', 'Manual Edit of Quantity', 0, 0),
(11, 2, 1, '2013-02-08 20:49:59', 'POS 8', -1, 0),
(12, 1, 1, '2013-02-08 20:49:59', 'POS 8', -1, 0),
(13, 2, 1, '2013-02-08 21:01:31', 'POS 9', -1, 0),
(14, 1, 1, '2013-02-08 21:01:31', 'POS 9', -3, 0),
(15, 2, 1, '2013-02-08 21:03:08', 'POS 10', -1, 0),
(16, 2, 1, '2013-02-08 21:03:56', 'POS 11', -1, 0),
(17, 1, 1, '2013-02-08 21:11:55', 'POS 12', -1, 0),
(18, 2, 1, '2013-02-08 21:11:55', 'POS 12', -1, 0),
(19, 1, 1, '2013-02-08 21:12:56', 'POS 13', -1, 0),
(20, 2, 1, '2013-02-08 21:12:56', 'POS 13', -1, 0),
(21, 1, 1, '2013-02-08 21:13:34', 'POS 14', -1, 0),
(22, 2, 1, '2013-02-08 21:13:34', 'POS 14', -1, 0),
(23, 1, 1, '2013-02-08 21:14:01', 'POS 15', -1, 0),
(24, 2, 1, '2013-02-08 21:14:01', 'POS 15', -1, 0),
(25, 1, 1, '2013-02-08 21:14:49', 'POS 16', -1, 0),
(26, 2, 1, '2013-02-08 21:14:49', 'POS 16', -1, 0),
(27, 1, 1, '2013-02-08 21:15:17', 'POS 17', -1, 0),
(28, 2, 1, '2013-02-08 21:15:17', 'POS 17', -1, 0),
(29, 1, 1, '2013-02-08 21:18:14', 'POS 18', -1, 0),
(30, 2, 1, '2013-02-08 21:18:14', 'POS 18', -1, 0),
(31, 1, 1, '2013-02-08 21:18:24', 'POS 19', -1, 0),
(32, 2, 1, '2013-02-08 21:18:24', 'POS 19', -1, 0),
(33, 1, 1, '2013-02-08 21:19:11', 'POS 20', -1, 0),
(34, 2, 1, '2013-02-08 21:19:11', 'POS 20', -1, 0),
(35, 1, 1, '2013-02-08 21:20:10', 'POS 21', -1, 0),
(36, 2, 1, '2013-02-08 21:20:10', 'POS 21', -1, 0),
(37, 1, 1, '2013-02-08 21:20:28', 'POS 22', -1, 0),
(38, 2, 1, '2013-02-08 21:20:28', 'POS 22', -1, 0),
(39, 1, 1, '2013-02-08 21:21:28', 'POS 23', -1, 0),
(40, 2, 1, '2013-02-08 21:21:28', 'POS 23', -1, 0),
(41, 1, 1, '2013-02-08 21:21:43', 'POS 24', -1, 0),
(42, 2, 1, '2013-02-08 21:21:43', 'POS 24', -1, 0),
(43, 1, 1, '2013-02-08 21:22:27', 'POS 25', -1, 0),
(44, 2, 1, '2013-02-08 21:22:27', 'POS 25', -1, 0),
(45, 1, 1, '2013-02-08 21:22:38', 'POS 26', -1, 0),
(46, 2, 1, '2013-02-08 21:22:38', 'POS 26', -1, 0),
(47, 1, 1, '2013-02-08 21:23:02', 'POS 27', -1, 0),
(48, 2, 1, '2013-02-08 21:23:02', 'POS 27', -1, 0),
(49, 1, 1, '2013-02-08 21:23:48', 'POS 28', -1, 0),
(50, 2, 1, '2013-02-08 21:23:48', 'POS 28', -1, 0),
(51, 1, 1, '2013-02-08 21:24:01', 'POS 29', -1, 0),
(52, 2, 1, '2013-02-08 21:24:01', 'POS 29', -1, 0),
(53, 1, 1, '2013-02-08 21:24:17', 'POS 30', -1, 0),
(54, 2, 1, '2013-02-08 21:24:17', 'POS 30', -1, 0),
(55, 1, 1, '2013-02-08 21:24:46', 'POS 31', -1, 0),
(56, 2, 1, '2013-02-08 21:24:46', 'POS 31', -1, 0),
(57, 1, 1, '2013-02-08 21:25:10', 'POS 32', -1, 0),
(58, 2, 1, '2013-02-08 21:25:10', 'POS 32', -1, 0),
(59, 1, 1, '2013-02-08 21:25:33', 'POS 33', -1, 0),
(60, 2, 1, '2013-02-08 21:25:33', 'POS 33', -1, 0),
(61, 1, 1, '2013-02-08 21:26:15', 'POS 34', -1, 0),
(62, 2, 1, '2013-02-08 21:26:15', 'POS 34', -1, 0),
(63, 1, 1, '2013-02-08 21:26:26', 'POS 35', -1, 0),
(64, 2, 1, '2013-02-08 21:26:26', 'POS 35', -1, 0),
(65, 1, 1, '2013-02-08 21:26:53', 'POS 36', -1, 0),
(66, 2, 1, '2013-02-08 21:26:53', 'POS 36', -1, 0),
(67, 1, 1, '2013-02-08 21:27:01', 'POS 37', -1, 0),
(68, 2, 1, '2013-02-08 21:27:01', 'POS 37', -1, 0),
(69, 1, 1, '2013-02-08 21:27:08', 'POS 38', -1, 0),
(70, 2, 1, '2013-02-08 21:27:08', 'POS 38', -1, 0),
(71, 1, 1, '2013-02-08 21:27:17', 'POS 39', -1, 0),
(72, 2, 1, '2013-02-08 21:27:17', 'POS 39', -1, 0),
(73, 1, 1, '2013-02-08 21:28:07', 'POS 40', -1, 0),
(74, 2, 1, '2013-02-08 21:28:07', 'POS 40', -1, 0),
(75, 1, 1, '2013-02-08 21:29:42', 'POS 41', -1, 0),
(76, 2, 1, '2013-02-08 21:29:42', 'POS 41', -1, 0),
(77, 1, 1, '2013-02-08 21:30:57', 'POS 42', -1, 0),
(78, 2, 1, '2013-02-08 21:30:57', 'POS 42', -1, 0),
(79, 1, 1, '2013-02-08 21:31:08', 'POS 43', -1, 0),
(80, 2, 1, '2013-02-08 21:31:08', 'POS 43', -1, 0),
(81, 1, 1, '2013-02-08 21:31:25', 'POS 44', -1, 0),
(82, 2, 1, '2013-02-08 21:31:25', 'POS 44', -1, 0),
(83, 1, 1, '2013-02-08 21:32:12', 'POS 45', -1, 0),
(84, 2, 1, '2013-02-08 21:32:12', 'POS 45', -1, 0),
(85, 1, 1, '2013-02-08 21:33:02', 'POS 46', -1, 0),
(86, 2, 1, '2013-02-08 21:33:02', 'POS 46', -1, 0),
(87, 1, 1, '2013-02-08 21:33:58', 'POS 47', -1, 0),
(88, 2, 1, '2013-02-08 21:33:58', 'POS 47', -1, 0),
(89, 1, 1, '2013-02-08 21:34:30', 'POS 48', -1, 0),
(90, 2, 1, '2013-02-08 21:34:30', 'POS 48', -1, 0),
(91, 1, 1, '2013-02-08 21:34:53', 'POS 49', -1, 0),
(92, 2, 1, '2013-02-08 21:34:53', 'POS 49', -1, 0),
(93, 1, 1, '2013-02-08 21:35:05', 'POS 50', -1, 0),
(94, 2, 1, '2013-02-08 21:35:05', 'POS 50', -1, 0),
(95, 1, 1, '2013-02-08 21:35:48', 'POS 51', -1, 0),
(96, 2, 1, '2013-02-08 21:35:48', 'POS 51', -1, 0),
(97, 1, 1, '2013-02-08 21:36:17', 'POS 52', -1, 0),
(98, 2, 1, '2013-02-08 21:36:17', 'POS 52', -1, 0),
(99, 1, 1, '2013-02-08 21:36:46', 'POS 53', -1, 0),
(100, 2, 1, '2013-02-08 21:36:46', 'POS 53', -1, 0),
(101, 1, 1, '2013-02-08 21:39:54', 'POS 54', -1, 0),
(102, 2, 1, '2013-02-08 21:39:54', 'POS 54', -1, 0),
(103, 1, 1, '2013-02-08 21:40:57', 'POS 55', -1, 0),
(104, 2, 1, '2013-02-08 21:40:57', 'POS 55', -1, 0),
(105, 1, 1, '2013-02-08 21:42:59', 'POS 56', -1, 0),
(106, 2, 1, '2013-02-08 21:42:59', 'POS 56', -1, 0),
(107, 1, 1, '2013-02-08 21:44:36', 'POS 57', -1, 0),
(108, 2, 1, '2013-02-08 21:44:36', 'POS 57', -1, 0),
(109, 1, 1, '2013-02-08 21:45:18', 'POS 58', -1, 0),
(110, 2, 1, '2013-02-08 21:45:18', 'POS 58', -1, 0),
(111, 1, 1, '2013-02-08 21:45:45', 'POS 59', -1, 0),
(112, 2, 1, '2013-02-08 21:45:45', 'POS 59', -1, 0),
(113, 1, 1, '2013-02-08 21:46:39', 'POS 60', -1, 0),
(114, 2, 1, '2013-02-08 21:46:39', 'POS 60', -1, 0),
(115, 1, 1, '2013-02-08 21:47:02', 'POS 61', -1, 0),
(116, 2, 1, '2013-02-08 21:47:02', 'POS 61', -1, 0),
(117, 1, 1, '2013-02-08 21:47:23', 'POS 62', -1, 0),
(118, 2, 1, '2013-02-08 21:47:23', 'POS 62', -1, 0),
(119, 1, 1, '2013-02-08 21:47:58', 'POS 63', -1, 0),
(120, 2, 1, '2013-02-08 21:47:58', 'POS 63', -1, 0),
(121, 1, 1, '2013-02-08 21:48:33', 'POS 64', -1, 0),
(122, 2, 1, '2013-02-08 21:48:33', 'POS 64', -1, 0),
(123, 1, 1, '2013-02-08 21:49:07', 'POS 65', -1, 0),
(124, 2, 1, '2013-02-08 21:49:07', 'POS 65', -1, 0),
(125, 1, 1, '2013-02-08 21:49:30', 'POS 66', -1, 0),
(126, 2, 1, '2013-02-08 21:49:30', 'POS 66', -1, 0),
(127, 1, 1, '2013-02-08 21:49:46', 'POS 67', -1, 0),
(128, 2, 1, '2013-02-08 21:49:46', 'POS 67', -1, 0),
(129, 1, 1, '2013-02-08 21:50:49', 'POS 68', -1, 0),
(130, 2, 1, '2013-02-08 21:50:49', 'POS 68', -1, 0),
(131, 1, 1, '2013-02-08 21:51:24', 'POS 69', -1, 0),
(132, 2, 1, '2013-02-08 21:51:24', 'POS 69', -1, 0),
(133, 1, 1, '2013-02-08 21:51:57', 'POS 70', -1, 0),
(134, 2, 1, '2013-02-08 21:51:57', 'POS 70', -1, 0),
(135, 1, 1, '2013-02-08 21:52:18', 'POS 71', -1, 0),
(136, 2, 1, '2013-02-08 21:52:19', 'POS 71', -1, 0),
(137, 1, 1, '2013-02-08 21:52:38', 'POS 72', -1, 0),
(138, 2, 1, '2013-02-08 21:52:38', 'POS 72', -1, 0),
(139, 1, 1, '2013-02-08 21:54:11', 'POS 73', -1, 0),
(140, 2, 1, '2013-02-08 21:54:11', 'POS 73', -1, 0),
(141, 1, 1, '2013-02-08 21:54:38', 'POS 74', -1, 0),
(142, 2, 1, '2013-02-08 21:54:38', 'POS 74', -1, 0),
(143, 1, 1, '2013-02-08 21:55:16', 'POS 75', -1, 0),
(144, 2, 1, '2013-02-08 21:55:16', 'POS 75', -1, 0),
(145, 1, 1, '2013-02-08 21:55:40', 'POS 76', -1, 0),
(146, 2, 1, '2013-02-08 21:55:40', 'POS 76', -1, 0),
(147, 1, 1, '2013-02-08 21:56:40', 'POS 77', -1, 0),
(148, 2, 1, '2013-02-08 21:56:40', 'POS 77', -1, 0),
(149, 1, 1, '2013-02-08 21:57:03', 'POS 78', -1, 0),
(150, 2, 1, '2013-02-08 21:57:03', 'POS 78', -1, 0),
(151, 1, 1, '2013-02-08 21:57:38', 'POS 79', -1, 0),
(152, 2, 1, '2013-02-08 21:57:38', 'POS 79', -1, 0),
(153, 1, 1, '2013-02-08 21:58:07', 'POS 80', -1, 0),
(154, 2, 1, '2013-02-08 21:58:07', 'POS 80', -1, 0),
(155, 1, 1, '2013-02-08 21:58:25', 'POS 81', -1, 0),
(156, 2, 1, '2013-02-08 21:58:25', 'POS 81', -1, 0),
(157, 1, 1, '2013-02-08 21:59:33', 'POS 82', -1, 0),
(158, 2, 1, '2013-02-08 21:59:33', 'POS 82', -1, 0),
(159, 1, 1, '2013-02-08 22:00:39', 'POS 83', -1, 0),
(160, 2, 1, '2013-02-08 22:00:39', 'POS 83', -1, 0),
(161, 1, 1, '2013-02-08 22:11:38', 'POS 84', -1, 0),
(162, 2, 1, '2013-02-08 22:11:38', 'POS 84', -1, 0),
(163, 1, 1, '2013-02-08 22:12:50', 'Penyesuaian', 100, 0),
(164, 2, 1, '2013-02-08 22:13:00', 'Penyesuaian', 100, 0),
(165, 2, 1, '2013-02-08 22:14:58', 'POS 85', -1, 0),
(166, 2, 1, '2013-02-08 22:15:24', 'POS 86', -1, 0),
(167, 2, 1, '2013-02-08 22:30:34', 'TRANS - 87', -10, 0),
(168, 2, 1, '2013-02-08 22:31:08', 'TRANS - 88', -1, 0),
(169, 2, 1, '2013-02-08 22:33:07', 'TRANS - 89', -1, 0),
(170, 2, 1, '2013-02-08 22:48:39', 'TRANS - 91', -10, 0),
(171, 2, 1, '2013-02-08 22:54:15', 'TRANS - 95', -10, 0),
(172, 2, 1, '2013-02-08 22:56:58', 'TRANS - 96', -10, 0),
(173, 2, 1, '2013-02-08 22:57:14', 'TRANS - 97', -10, 0),
(174, 2, 1, '2013-02-08 22:57:43', 'TRANS - 98', -10, 0),
(175, 2, 1, '2013-02-08 22:58:02', 'TRANS - 99', -10, 0),
(176, 2, 1, '2013-02-08 22:59:01', 'TRANS - 100', -10, 0),
(177, 2, 1, '2013-02-08 23:01:15', 'TRANS - 101', -10, 0),
(178, 2, 1, '2013-02-08 23:07:10', '', 100, 0),
(179, 2, 1, '2013-02-08 23:07:34', 'TRANS - 102', -10, 0),
(180, 2, 1, '2013-02-08 23:08:25', 'TRANS - 103', -10, 0),
(181, 1, 1, '2013-02-08 23:22:07', 'TRANS - 104', -3, 0),
(182, 1, 1, '2013-02-09 00:16:58', 'TRANS - 105', -10, 0),
(183, 1, 1, '2013-02-10 05:11:26', 'RECV 2', 10, 0),
(184, 2, 1, '2013-02-10 05:11:27', 'RECV 2', 3, 0),
(185, 1, 1, '2013-02-10 05:20:13', 'RECV 3', 1, 0),
(186, 2, 1, '2013-02-10 05:43:55', 'RECV 4', 9, 0),
(187, 2, 1, '2013-02-10 08:00:32', 'RECV 5', 2, 0),
(188, 1, 1, '2013-02-10 08:17:29', 'RECV 6', 1, 0),
(189, 1, 1, '2013-02-10 08:28:12', 'RECV 7', 1, 0),
(190, 1, 1, '2013-02-10 08:30:07', 'TRANS - 106', -1, 0),
(191, 1, 1, '2013-02-10 08:32:22', 'RECV 8', 1, 0),
(192, 1, 1, '2013-02-10 08:32:28', 'RECV 9', 1, 0),
(193, 1, 1, '2013-02-10 08:33:41', 'RECV 10', 1, 0),
(194, 1, 1, '2013-02-10 08:34:04', 'RECV 11', 1, 0),
(195, 1, 1, '2013-02-10 08:34:39', 'RECV 12', 1, 0),
(196, 1, 1, '2013-02-10 08:35:20', 'RECV 13', 1, 0),
(197, 1, 1, '2013-02-10 08:35:44', 'RECV 14', 1, 0),
(198, 2, 1, '2013-02-10 08:35:44', 'RECV 14', 1, 0),
(199, 1, 1, '2013-02-10 08:36:58', 'RECV 15', 1, 0),
(200, 2, 1, '2013-02-10 08:36:58', 'RECV 15', 1, 0),
(201, 1, 1, '2013-02-10 08:37:28', 'RECV 16', 1, 0),
(202, 2, 1, '2013-02-10 08:37:28', 'RECV 16', 1, 0),
(203, 1, 1, '2013-02-10 08:38:03', 'RECV 17', 1, 0),
(204, 2, 1, '2013-02-10 08:38:03', 'RECV 17', 1, 0),
(205, 1, 1, '2013-02-10 08:38:36', 'RECV 18', 1, 0),
(206, 2, 1, '2013-02-10 08:38:36', 'RECV 18', 1, 0),
(207, 1, 1, '2013-02-10 08:38:50', 'RECV 19', 1, 0),
(208, 2, 1, '2013-02-10 08:38:50', 'RECV 19', 1, 0),
(209, 1, 1, '2013-02-10 08:41:09', 'RECV 20', 1, 0),
(210, 2, 1, '2013-02-10 08:41:09', 'RECV 20', 1, 0),
(211, 1, 1, '2013-02-10 08:41:36', 'RECV 21', 1, 0),
(212, 2, 1, '2013-02-10 08:41:36', 'RECV 21', 1, 0),
(213, 1, 1, '2013-02-10 08:43:02', 'RECV 22', 1, 0),
(214, 2, 1, '2013-02-10 08:43:02', 'RECV 22', 1, 0),
(215, 1, 1, '2013-02-10 08:43:37', 'RECV 23', 1, 0),
(216, 2, 1, '2013-02-10 08:43:37', 'RECV 23', 1, 0),
(217, 1, 1, '2013-02-10 08:43:57', 'RECV 24', 1, 0),
(218, 1, 1, '2013-02-10 08:45:02', 'RECV 25', 1, 0),
(219, 1, 1, '2013-02-10 08:52:52', 'RECV 26', 1, 0),
(220, 1, 1, '2013-02-10 08:54:37', 'RECV 27', 1, 0),
(221, 1, 1, '2013-02-10 08:54:47', 'RECV 28', 1, 0),
(222, 1, 1, '2013-02-10 08:55:01', 'RECV 29', 1, 0),
(223, 1, 1, '2013-02-10 08:55:11', 'RECV 30', 1, 0),
(224, 1, 1, '2013-02-10 08:55:28', 'RECV 31', 1, 0),
(225, 1, 1, '2013-02-10 08:55:40', 'RECV 32', 1, 0),
(226, 1, 1, '2013-02-10 08:55:54', 'RECV 33', 1, 0),
(227, 1, 1, '2013-02-10 08:56:13', 'RECV 34', 1, 0),
(228, 1, 1, '2013-02-10 08:56:35', 'RECV 35', 1, 0),
(229, 1, 1, '2013-02-10 08:56:48', 'RECV 36', 1, 0),
(230, 1, 1, '2013-02-10 08:57:37', 'RECV 37', 1, 0),
(231, 1, 1, '2013-02-10 08:57:54', 'RECV 38', 1, 0),
(232, 1, 1, '2013-02-10 08:58:51', 'RECV 39', 1, 0),
(233, 1, 1, '2013-02-10 08:59:13', 'RECV 40', 1, 0),
(234, 1, 1, '2013-02-10 09:01:32', 'RECV 41', 1, 0),
(235, 1, 1, '2013-02-10 09:01:53', 'RECV 42', 1, 0),
(236, 1, 1, '2013-02-10 09:02:46', 'RECV 43', 1, 0),
(237, 1, 1, '2013-02-10 09:03:30', 'RECV 44', 1, 0),
(238, 1, 1, '2013-02-10 09:08:38', 'RECV 45', 1, 0),
(239, 1, 1, '2013-02-10 09:09:22', 'RECV 46', 1, 0),
(240, 1, 1, '2013-02-10 09:09:52', 'RECV 47', 1, 0),
(241, 1, 1, '2013-02-10 09:10:48', 'RECV 48', 1, 0),
(242, 1, 1, '2013-02-10 09:11:28', 'RECV 49', 1, 0),
(243, 1, 1, '2013-02-10 09:11:53', 'RECV 50', 1, 0),
(244, 1, 1, '2013-02-10 09:12:26', 'RECV 51', 1, 0),
(245, 1, 1, '2013-02-10 09:12:44', 'RECV 52', 1, 0),
(246, 1, 1, '2013-02-10 09:30:40', 'TRANS - 107', -1, 0),
(247, 2, 1, '2013-02-10 09:30:40', 'TRANS - 107', -2, 0),
(248, 3, 1, '2013-02-11 01:24:16', 'Manual Edit of Quantity', 10, 0),
(249, 3, 1, '2013-02-11 01:25:44', 'RECV 53', 10, 0),
(250, 3, 1, '2013-02-11 01:27:26', 'TRANS - 108', -3, 0),
(251, 2, 1, '2013-02-11 01:27:26', 'TRANS - 108', -2, 0),
(252, 3, 1, '2013-02-11 01:33:25', 'TRANS - 109', -1, 0),
(253, 3, 1, '2013-02-11 01:36:23', 'TRANS - 110', -1, 0),
(254, 3, 1, '2013-02-11 01:39:11', 'RECV 54', 1, 0),
(255, 3, 1, '2013-02-11 03:26:58', 'TRANS - 111', -1, 0),
(256, 3, 1, '2013-02-11 03:27:52', 'RECV 55', 5, 0),
(257, 3, 1, '2013-02-11 03:31:31', 'RECV 56', 1, 0),
(258, 3, 1, '2013-02-11 03:35:15', 'TRANS - 112', -1, 0),
(259, 3, 1, '2013-02-11 03:40:20', 'TRANS - 113', -1, 0),
(260, 3, 1, '2013-02-11 03:42:06', 'TRANS - 114', -1, 0),
(261, 3, 1, '2013-02-11 03:43:35', 'TRANS - 115', -1, 0),
(262, 3, 1, '2013-02-11 03:46:07', 'RECV 57', 1, 0),
(263, 3, 1, '2013-02-11 03:46:33', 'RECV 58', 1, 0),
(264, 3, 1, '2013-02-11 03:47:30', 'RECV 59', 1, 0),
(265, 3, 1, '2013-02-11 03:51:21', 'TRANS - 116', -1, 0),
(266, 3, 1, '2013-02-11 05:26:47', 'TRANS - 117', -1, 0),
(267, 3, 1, '2013-02-12 00:22:16', 'RECV 60', 1, 0),
(268, 1, 1, '2013-02-12 06:50:44', 'TRANS - 118', -5, 0),
(269, 1, 1, '2013-03-04 06:07:41', 'TRANS - 119', -1, 0),
(270, 4, 1, '2013-03-04 07:00:24', 'Edit Jumlah Manual', 500, 0),
(271, 4, 1, '2013-03-04 07:06:01', 'Edit Jumlah Manual', 0, 0),
(272, 4, 1, '2013-03-04 07:07:32', 'TRANS - 120', -1, 0),
(273, 4, 1, '2013-03-05 05:34:03', 'Edit Jumlah Manual', 0, 0),
(274, 3, 1, '2013-03-05 05:36:05', 'Edit Jumlah Manual', 0, 0),
(275, 3, 1, '2013-03-05 06:49:23', 'Edit Jumlah Manual', 0, 0),
(276, 4, 1, '2013-03-05 07:45:35', '', 50, 0),
(277, 3, 1, '2013-03-06 11:02:49', 'TRANS - 121', -1, 0),
(278, 3, 1, '2013-03-06 11:04:02', 'TRANS - 122', -1, 0),
(279, 3, 1, '2013-03-06 11:06:37', 'TRANS - 123', -1, 0),
(280, 3, 1, '2013-03-06 11:52:36', 'TRANS - 124', -1, 0),
(281, 3, 1, '2013-03-06 13:00:51', 'TRANS - 125', -1, 0),
(282, 3, 1, '2013-10-17 03:06:54', 'xhahxffxsax', 10, 0),
(283, 3, 1, '2013-10-17 03:07:03', '', -20, 0),
(284, 4, 1, '2013-10-17 03:07:30', 'Edit Jumlah Manual', 0, 0),
(285, 4, 1, '2013-10-17 03:12:25', 'Edit Jumlah Manual', -539, 0),
(286, 4, 1, '2013-11-23 07:05:15', 'TRANS - 126', -1, 0),
(287, 3, 1, '2013-11-27 05:59:37', 'TRANS - 127', -1, 0),
(288, 3, 1, '2013-11-27 06:00:15', 'TRANS - 128', -1, 0),
(289, 3, 1, '2013-11-27 06:01:32', 'TRANS - 129', -1, 0),
(290, 2, 1, '2013-11-27 06:03:46', 'TRANS - 130', -1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_items`
--

CREATE TABLE IF NOT EXISTS `ospos_items` (
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item_number` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `cost_price` double(15,2) NOT NULL,
  `unit_price` double(15,2) NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT '0',
  `reorder_level` int(10) NOT NULL DEFAULT '0',
  `location` varchar(255) NOT NULL,
  `item_id` int(10) NOT NULL AUTO_INCREMENT,
  `allow_alt_description` tinyint(1) NOT NULL,
  `is_serialized` tinyint(1) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_number` (`item_number`),
  KEY `ospos_items_ibfk_1` (`supplier_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ospos_items`
--

INSERT INTO `ospos_items` (`name`, `category`, `supplier_id`, `item_number`, `description`, `cost_price`, `unit_price`, `quantity`, `reorder_level`, `location`, `item_id`, `allow_alt_description`, `is_serialized`, `deleted`, `id_owner`) VALUES
('flashdisk', 'computer', NULL, '123', '', 10000.00, 10000.00, 69, 2, '', 1, 0, 0, 1, 0),
('Narmada 600ml', 'Minuman', NULL, '0946386525721', '', 10000.00, 5000.00, 37, 5, '', 2, 0, 0, 0, 0),
('Coca Cola 300ml', 'Minuman', NULL, '1111', '', 1000.00, 4000.00, 1, 20, 'Rak 1', 3, 0, 0, 0, 0),
('Ring', 'cincin', NULL, 'R21921921', '', 1000.00, 2500.00, 9, 100, 'toko 1', 4, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_items_taxes`
--

CREATE TABLE IF NOT EXISTS `ospos_items_taxes` (
  `item_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `percent` double(15,2) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`item_id`,`name`,`percent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ospos_item_kits`
--

CREATE TABLE IF NOT EXISTS `ospos_item_kits` (
  `item_kit_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`item_kit_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ospos_item_kits`
--

INSERT INTO `ospos_item_kits` (`item_kit_id`, `name`, `description`, `id_owner`) VALUES
(1, 'Hadiah', 'flash', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_item_kit_items`
--

CREATE TABLE IF NOT EXISTS `ospos_item_kit_items` (
  `item_kit_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` double(15,2) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`item_kit_id`,`item_id`,`quantity`),
  KEY `ospos_item_kit_items_ibfk_2` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_item_kit_items`
--

INSERT INTO `ospos_item_kit_items` (`item_kit_id`, `item_id`, `quantity`, `id_owner`) VALUES
(1, 1, 1.00, 0),
(1, 2, 2.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_modules`
--

CREATE TABLE IF NOT EXISTS `ospos_modules` (
  `name_lang_key` varchar(255) NOT NULL,
  `desc_lang_key` varchar(255) NOT NULL,
  `sort` int(10) NOT NULL,
  `module_id` varchar(255) NOT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `desc_lang_key` (`desc_lang_key`),
  UNIQUE KEY `name_lang_key` (`name_lang_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_modules`
--

INSERT INTO `ospos_modules` (`name_lang_key`, `desc_lang_key`, `sort`, `module_id`) VALUES
('module_config', 'module_config_desc', 100, 'config'),
('module_customers', 'module_customers_desc', 10, 'customers'),
('module_employees', 'module_employees_desc', 80, 'employees'),
('module_giftcards', 'module_giftcards_desc', 50, 'giftcards'),
('module_items', 'module_items_desc', 20, 'items'),
('module_item_kits', 'module_item_kits_desc', 30, 'item_kits'),
('module_receivings', 'module_receivings_desc', 60, 'receivings'),
('module_reports', 'module_reports_desc', 90, 'reports'),
('module_sales', 'module_sales_desc', 70, 'sales'),
('module_suppliers', 'module_suppliers_desc', 40, 'suppliers');

-- --------------------------------------------------------

--
-- Table structure for table `ospos_people`
--

CREATE TABLE IF NOT EXISTS `ospos_people` (
  `person_id` int(10) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_1` varchar(255) NOT NULL,
  `address_2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `comments` text NOT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `ospos_people`
--

INSERT INTO `ospos_people` (`person_id`, `first_name`, `last_name`, `phone_number`, `email`, `address_1`, `address_2`, `city`, `state`, `zip`, `country`, `comments`) VALUES
(1, 'admin', 'root', '555-555-5555', 'admin@pappastech.com', 'Address 1', '', '', '', '', '', ''),
(2, 'Darwin', 'Tok', '0810000000', 'darwin@tok.com', '', '', '', '', '', '', ''),
(3, 'Tyas', 'Ahmad', '085090000', 'tyas@ahmad.com', '', '', '', '', '', '', ''),
(4, 'Adi', 'Suryanto', '', '', '', '', '', '', '', '', ''),
(5, 'Fajar', 'Afrizal', '08112345678', '', '', '', '', '', '', '', ''),
(6, 'Mochi', 'Cicicic', '', '', '', '', '', '', '', '', ''),
(7, 'Donti', 'Chila', '', '', '', '', '', '', '', '', ''),
(8, 'Batu', 'Permata', '6283241053444', 'sales@bpinternusa.com', '', '', 'Mataram', 'NTB', '', 'Indonesia', ''),
(9, 'Titin', 'Prihatin Sekali', '0000', 'aw@aw.com', '', '', '', '', '', '', ''),
(10, 'Pak', 'Bos', '', '', '', '', '', '', '', '', ''),
(11, 'Donti', 'Rafee', '081339090909', 'donti@rafee.com', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `ospos_permissions`
--

CREATE TABLE IF NOT EXISTS `ospos_permissions` (
  `module_id` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`module_id`,`person_id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_permissions`
--

INSERT INTO `ospos_permissions` (`module_id`, `person_id`, `id_owner`) VALUES
('config', 1, 0),
('customers', 1, 0),
('employees', 1, 0),
('giftcards', 1, 0),
('items', 1, 0),
('item_kits', 1, 0),
('receivings', 1, 0),
('reports', 1, 0),
('sales', 1, 0),
('suppliers', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_receivings`
--

CREATE TABLE IF NOT EXISTS `ospos_receivings` (
  `receiving_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `receiving_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(20) DEFAULT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`receiving_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `ospos_receivings`
--

INSERT INTO `ospos_receivings` (`receiving_time`, `supplier_id`, `employee_id`, `comment`, `receiving_id`, `payment_type`, `id_owner`) VALUES
('2013-01-01 12:12:31', NULL, 1, '', 1, 'Tunai', 0),
('2013-02-10 05:11:26', NULL, 1, '', 2, 'Tunai', 0),
('2013-02-10 05:20:13', 4, 1, '', 3, 'Tunai', 0),
('2013-02-10 05:43:55', NULL, 1, '', 4, 'Tunai', 0),
('2013-02-10 08:00:32', NULL, 1, '0', 5, '0', 0),
('2013-02-10 08:17:29', NULL, 1, '0', 6, '0', 0),
('2013-02-10 08:28:11', NULL, 1, '0', 7, '0', 0),
('2013-02-10 08:32:22', NULL, 1, '0', 8, '0', 0),
('2013-02-10 08:32:28', NULL, 1, '0', 9, '0', 0),
('2013-02-10 08:33:41', NULL, 1, '0', 10, '0', 0),
('2013-02-10 08:34:04', NULL, 1, '0', 11, '0', 0),
('2013-02-10 08:34:39', NULL, 1, '0', 12, '0', 0),
('2013-02-10 08:35:20', NULL, 1, '0', 13, '0', 0),
('2013-02-10 08:35:44', NULL, 1, '0', 14, '0', 0),
('2013-02-10 08:36:58', NULL, 1, '0', 15, '0', 0),
('2013-02-10 08:37:28', NULL, 1, '0', 16, '0', 0),
('2013-02-10 08:38:03', NULL, 1, '0', 17, '0', 0),
('2013-02-10 08:38:36', NULL, 1, '0', 18, '0', 0),
('2013-02-10 08:38:50', NULL, 1, '0', 19, '0', 0),
('2013-02-10 08:41:09', NULL, 1, '0', 20, '0', 0),
('2013-02-10 08:41:36', NULL, 1, '0', 21, '0', 0),
('2013-02-10 08:43:02', NULL, 1, '0', 22, '0', 0),
('2013-02-10 08:43:37', NULL, 1, '0', 23, NULL, 0),
('2013-02-10 08:43:57', NULL, 1, '0', 24, NULL, 0),
('2013-02-10 08:45:02', NULL, 1, '0', 25, NULL, 0),
('2013-02-10 08:52:52', NULL, 1, '0', 26, NULL, 0),
('2013-02-10 08:54:37', NULL, 1, '0', 27, NULL, 0),
('2013-02-10 08:54:47', NULL, 1, '0', 28, NULL, 0),
('2013-02-10 08:55:01', NULL, 1, '0', 29, NULL, 0),
('2013-02-10 08:55:11', NULL, 1, '0', 30, NULL, 0),
('2013-02-10 08:55:28', NULL, 1, '0', 31, NULL, 0),
('2013-02-10 08:55:40', NULL, 1, '0', 32, NULL, 0),
('2013-02-10 08:55:54', NULL, 1, '0', 33, NULL, 0),
('2013-02-10 08:56:13', NULL, 1, '0', 34, NULL, 0),
('2013-02-10 08:56:35', NULL, 1, '0', 35, NULL, 0),
('2013-02-10 08:56:48', NULL, 1, '0', 36, NULL, 0),
('2013-02-10 08:57:37', NULL, 1, '0', 37, NULL, 0),
('2013-02-10 08:57:54', NULL, 1, '0', 38, NULL, 0),
('2013-02-10 08:58:51', NULL, 1, '0', 39, NULL, 0),
('2013-02-10 08:59:13', NULL, 1, '0', 40, NULL, 0),
('2013-02-10 09:01:32', NULL, 1, '0', 41, NULL, 0),
('2013-02-10 09:01:53', NULL, 1, '0', 42, NULL, 0),
('2013-02-10 09:02:46', NULL, 1, '0', 43, NULL, 0),
('2013-02-10 09:03:30', NULL, 1, '0', 44, NULL, 0),
('2013-02-10 09:08:37', NULL, 1, '0', 45, NULL, 0),
('2013-02-10 09:09:21', NULL, 1, '0', 46, NULL, 0),
('2013-02-10 09:09:52', NULL, 1, '0', 47, NULL, 0),
('2013-02-10 09:10:48', NULL, 1, '0', 48, NULL, 0),
('2013-02-10 09:11:27', NULL, 1, '0', 49, NULL, 0),
('2013-02-10 09:11:53', NULL, 1, '0', 50, NULL, 0),
('2013-02-10 09:12:26', NULL, 1, '0', 51, NULL, 0),
('2013-02-10 09:12:44', NULL, 1, '0', 52, NULL, 0),
('2013-02-11 01:25:44', 4, 1, '0', 53, NULL, 0),
('2013-02-11 01:39:11', NULL, 1, '0', 54, NULL, 0),
('2013-02-11 03:27:52', NULL, 1, '0', 55, NULL, 0),
('2013-02-11 03:31:31', NULL, 1, '0', 56, NULL, 0),
('2013-02-11 03:46:07', NULL, 1, '0', 57, NULL, 0),
('2013-02-11 03:46:33', NULL, 1, '0', 58, NULL, 0),
('2013-02-11 03:47:30', NULL, 1, '0', 59, NULL, 0),
('2013-02-12 00:22:16', NULL, 1, '0', 60, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_receivings_items`
--

CREATE TABLE IF NOT EXISTS `ospos_receivings_items` (
  `receiving_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL,
  `quantity_purchased` int(10) NOT NULL DEFAULT '0',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`receiving_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_receivings_items`
--

INSERT INTO `ospos_receivings_items` (`receiving_id`, `item_id`, `description`, `serialnumber`, `line`, `quantity_purchased`, `item_cost_price`, `item_unit_price`, `discount_percent`, `id_owner`) VALUES
(1, 1, '', '', 1, 1, '100000.00', 100000.00, 0, 0),
(2, 1, '', '0', 1, 10, '9000.00', 10000.00, 0, 0),
(2, 2, '', '', 2, 3, '4500.00', 4500.00, 0, 0),
(3, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(4, 2, '', '', 1, 9, '4500.00', 4500.00, 0, 0),
(5, 2, '', '0', 1, 2, '4500.00', 4500.00, 10, 0),
(6, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(7, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(8, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(9, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(10, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(11, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(12, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(13, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(14, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(14, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(15, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(15, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(16, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(16, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(17, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(17, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(18, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(18, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(19, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(19, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(20, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(20, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(21, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(21, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(22, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(22, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(23, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(23, 2, '', '', 2, 1, '4500.00', 4500.00, 0, 0),
(24, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(25, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(26, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(27, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(28, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(29, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(30, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(31, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(32, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(33, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(34, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(35, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(36, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(37, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(38, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(39, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(40, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(41, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(42, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(43, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(44, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(45, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(46, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(47, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(48, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(49, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(50, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(51, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(52, 1, '', '', 1, 1, '9000.00', 9000.00, 0, 0),
(53, 3, '', '0', 1, 10, '3500.00', 3500.00, 3, 0),
(54, 3, '', '', 1, 1, '3500.00', 3500.00, 0, 0),
(55, 3, '', '0', 1, 5, '3500.00', 3500.00, 0, 0),
(56, 3, '', '', 1, 1, '3500.00', 3500.00, 0, 0),
(57, 3, '', '', 1, 1, '3500.00', 3500.00, 0, 0),
(58, 3, '', '', 1, 1, '3500.00', 3500.00, 0, 0),
(59, 3, '', '', 1, 1, '3500.00', 3500.00, 0, 0),
(60, 3, '', '', 1, 1, '3500.00', 3500.00, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales`
--

CREATE TABLE IF NOT EXISTS `ospos_sales` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=131 ;

--
-- Dumping data for table `ospos_sales`
--

INSERT INTO `ospos_sales` (`sale_time`, `customer_id`, `employee_id`, `comment`, `sale_id`, `payment_type`, `id_owner`) VALUES
('2013-02-07 02:38:51', NULL, 1, '0', 5, 'Tunai: Rp.55000.00<br />', 0),
('2013-02-07 19:32:35', NULL, 1, '0', 6, 'Tunai: Rp.10000.00<br />', 0),
('2013-02-08 15:05:27', NULL, 1, '0', 7, 'Tunai: Rp.5,00<br />', 0),
('2013-02-08 20:49:59', NULL, 1, '0', 8, 'Tunai: Rp.1.000,00<br />', 0),
('2013-02-08 21:01:31', NULL, 1, '0', 9, 'Tunai: Rp.100.000,00<br />', 0),
('2013-02-08 21:03:08', NULL, 1, '0', 10, 'Tunai: Rp.10.000,00<br />', 0),
('2013-02-08 21:03:56', NULL, 1, '0', 11, 'Tunai: Rp.100.000,00<br />', 0),
('2013-02-08 21:11:55', NULL, 1, '0', 12, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:12:56', NULL, 1, '0', 13, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:13:34', NULL, 1, '0', 14, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:14:01', NULL, 1, '0', 15, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:14:49', NULL, 1, '0', 16, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:15:17', NULL, 1, '0', 17, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:18:14', NULL, 1, '0', 18, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:18:24', NULL, 1, '0', 19, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:19:11', NULL, 1, '0', 20, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:20:10', NULL, 1, '0', 21, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:20:28', NULL, 1, '0', 22, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:21:28', NULL, 1, '0', 23, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:21:43', NULL, 1, '0', 24, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:22:27', NULL, 1, '0', 25, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:22:38', NULL, 1, '0', 26, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:23:02', NULL, 1, '0', 27, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:23:48', NULL, 1, '0', 28, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:24:01', NULL, 1, '0', 29, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:24:17', NULL, 1, '0', 30, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:24:46', NULL, 1, '0', 31, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:25:10', NULL, 1, '0', 32, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:25:33', NULL, 1, '0', 33, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:26:15', NULL, 1, '0', 34, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:26:26', NULL, 1, '0', 35, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:26:53', NULL, 1, '0', 36, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:27:01', NULL, 1, '0', 37, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:27:08', NULL, 1, '0', 38, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:27:17', NULL, 1, '0', 39, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:28:07', NULL, 1, '0', 40, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:29:42', NULL, 1, '0', 41, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:30:57', NULL, 1, '0', 42, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:31:08', NULL, 1, '0', 43, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:31:25', NULL, 1, '0', 44, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:32:12', NULL, 1, '0', 45, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:33:02', NULL, 1, '0', 46, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:33:57', NULL, 1, '0', 47, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:34:30', NULL, 1, '0', 48, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:34:53', NULL, 1, '0', 49, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:35:05', NULL, 1, '0', 50, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:35:48', NULL, 1, '0', 51, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:36:17', NULL, 1, '0', 52, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:36:46', NULL, 1, '0', 53, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:39:54', NULL, 1, '0', 54, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:40:57', NULL, 1, '0', 55, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:42:59', NULL, 1, '0', 56, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:44:36', NULL, 1, '0', 57, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:45:18', NULL, 1, '0', 58, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:45:45', NULL, 1, '0', 59, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:46:39', NULL, 1, '0', 60, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:47:02', NULL, 1, '0', 61, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:47:23', NULL, 1, '0', 62, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:47:58', NULL, 1, '0', 63, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:48:33', NULL, 1, '0', 64, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:49:07', NULL, 1, '0', 65, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:49:30', NULL, 1, '0', 66, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:49:46', NULL, 1, '0', 67, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:50:49', NULL, 1, '0', 68, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:51:24', NULL, 1, '0', 69, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:51:57', NULL, 1, '0', 70, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:52:18', NULL, 1, '0', 71, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:52:38', NULL, 1, '0', 72, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:54:11', NULL, 1, '0', 73, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:54:38', NULL, 1, '0', 74, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:55:16', NULL, 1, '0', 75, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:55:40', NULL, 1, '0', 76, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:56:40', NULL, 1, '0', 77, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:57:03', NULL, 1, '0', 78, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:57:37', NULL, 1, '0', 79, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:58:07', NULL, 1, '0', 80, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:58:25', NULL, 1, '0', 81, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 21:59:33', NULL, 1, '0', 82, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 22:00:39', NULL, 1, '0', 83, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 22:11:38', NULL, 1, '0', 84, 'Tunai: Rp.20.000,00<br />', 0),
('2013-02-08 22:14:58', 5, 1, '0', 85, 'Tunai: Rp.10.000,00<br />', 0),
('2013-02-08 22:15:24', 5, 1, '0', 86, 'Tunai: Rp.10.000,00<br />', 0),
('2013-02-08 22:30:34', NULL, 1, '0', 87, 'Tunai: Rp.60.000,00<br />', 0),
('2013-02-08 22:31:08', NULL, 1, '0', 88, 'Tunai: Rp.10.000,00<br />', 0),
('2013-02-08 22:33:07', 5, 1, '0', 89, 'Tunai: Rp.10.000,00<br />', 0),
('2013-02-08 22:48:39', NULL, 1, '0', 91, 'Tunai: Rp.50.000,00<br />', 0),
('2013-02-08 22:54:15', 5, 1, '0', 95, 'Tunai: Rp.50.000,00<br />', 0),
('2013-02-08 22:56:57', 5, 1, '0', 96, 'Tunai: Rp.60.000,00<br />', 0),
('2013-02-08 22:57:14', 5, 1, '0', 97, 'Tunai: Rp.60.000,00<br />', 0),
('2013-02-08 22:57:43', 5, 1, '0', 98, 'Tunai: Rp.60.000,00<br />', 0),
('2013-02-08 22:58:02', 5, 1, '0', 99, 'Tunai: Rp.60.000,00<br />', 0),
('2013-02-08 22:59:01', 5, 1, '0', 100, 'Tunai: Rp.60.000,00<br />', 0),
('2013-02-08 23:01:15', 5, 1, '0', 101, 'Tunai: Rp.120.000,00<br />', 0),
('2013-02-08 23:07:34', NULL, 1, '0', 102, 'Tunai: Rp.60.000,00<br />', 0),
('2013-02-08 23:08:25', 5, 1, '0', 103, 'Tunai: Rp.55.000,00<br />', 0),
('2013-02-08 23:22:07', 5, 1, '0', 104, 'Tunai: Rp.32.000,00<br />', 0),
('2013-02-09 00:16:58', 5, 1, '0', 105, 'Tunai: Rp.105.000,00<br />', 0),
('2013-02-10 08:30:06', NULL, 1, '0', 106, 'Tunai: Rp.10.000,00<br />', 0),
('2013-02-10 09:30:40', NULL, 1, '0', 107, 'Tunai: Rp.50.000,00<br />', 0),
('2013-02-11 01:27:26', 6, 1, '0', 108, 'Kartu Debit: Rp.22.600,00<br />', 0),
('2013-02-11 01:33:25', NULL, 1, '0', 109, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-11 01:36:23', NULL, 1, '0', 110, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-11 03:26:58', NULL, 1, '0', 111, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-11 03:35:15', NULL, 1, '0', 112, 'Tunai: Rp.10.000,00<br />', 0),
('2013-02-11 03:40:20', NULL, 1, '0', 113, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-11 03:42:06', NULL, 1, '0', 114, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-11 03:43:35', NULL, 1, '0', 115, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-11 03:51:21', NULL, 1, '0', 116, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-11 05:26:47', NULL, 1, '0', 117, 'Tunai: Rp.5.000,00<br />', 0),
('2013-02-12 06:50:44', NULL, 1, '0', 118, 'Tunai: Rp.100.000,00<br />', 0),
('2013-03-04 06:07:41', NULL, 1, '0', 119, 'Tunai: Rp.15.000,00<br />', 0),
('2013-03-04 07:07:32', 5, 1, '0', 120, 'Tunai: Rp.2.500,00<br />', 0),
('2013-03-06 11:02:49', NULL, 1, '0', 121, 'Tunai: Rp.5.000,00<br />', 0),
('2013-03-06 11:04:02', NULL, 1, '0', 122, 'Tunai: Rp.5.000,00<br />', 0),
('2013-03-06 11:06:37', 11, 1, '0', 123, 'Kartu Credit: Rp.4.000,00<br />', 0),
('2013-03-06 11:52:36', 5, 1, '0', 124, 'Tunai: Rp.5.000,00<br />', 0),
('2013-03-06 13:00:50', NULL, 1, '0', 125, 'Tunai: Rp.5.000,00<br />', 0),
('2013-11-23 07:05:15', NULL, 1, '0', 126, 'Tunai: Rp.2.000,00<br />Kartu Debit: Rp.100,00<br />', 0),
('2013-11-27 05:59:37', NULL, 1, '0', 127, 'Kartu Debit: Rp.1.000,00<br />Kupon Hadiah:123: Rp.9,99<br />', 0),
('2013-11-27 06:00:15', NULL, 1, '0', 128, 'Tunai: Rp.1.000,00<br />', 0),
('2013-11-27 06:01:32', NULL, 1, '0', 129, 'Tunai: Rp.2.000,00<br />Kartu Debit: Rp.2.000,00<br />', 0),
('2013-11-27 06:03:46', NULL, 1, '0', 130, 'Kupon Hadiah:222: Rp.1,00<br />Tunai: Rp.4.999,00<br />', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales_items`
--

CREATE TABLE IF NOT EXISTS `ospos_sales_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_sales_items`
--

INSERT INTO `ospos_sales_items` (`sale_id`, `item_id`, `description`, `serialnumber`, `line`, `quantity_purchased`, `item_cost_price`, `item_unit_price`, `discount_percent`, `id_owner`) VALUES
(5, 1, '', '', 1, 1.00, '100000.00', 10000.00, 0, 0),
(6, 1, '', '', 1, 1.00, '100000.00', 10000.00, 0, 0),
(7, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(8, 1, '', '', 2, 1.00, '9000.00', 10000.00, 0, 0),
(8, 2, '', '', 1, 1.00, '4500.00', 5000.00, 10, 0),
(9, 1, '', '', 2, 3.00, '9000.00', 10000.00, 0, 0),
(9, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(10, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(11, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(12, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(12, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(13, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(13, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(14, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(14, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(15, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(15, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(16, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(16, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(17, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(17, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(18, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(18, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(19, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(19, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(20, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(20, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(21, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(21, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(22, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(22, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(23, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(23, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(24, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(24, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(25, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(25, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(26, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(26, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(27, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(27, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(28, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(28, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(29, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(29, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(30, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(30, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(31, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(31, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(32, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(32, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(33, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(33, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(34, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(34, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(35, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(35, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(36, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(36, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(37, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(37, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(38, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(38, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(39, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(39, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(40, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(40, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(41, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(41, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(42, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(42, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(43, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(43, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(44, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(44, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(45, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(45, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(46, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(46, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(47, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(47, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(48, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(48, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(49, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(49, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(50, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(50, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(51, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(51, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(52, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(52, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(53, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(53, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(54, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(54, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(55, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(55, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(56, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(56, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(57, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(57, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(58, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(58, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(59, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(59, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(60, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(60, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(61, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(61, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(62, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(62, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(63, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(63, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(64, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(64, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(65, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(65, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(66, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(66, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(67, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(67, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(68, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(68, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(69, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(69, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(70, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(70, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(71, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(71, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(72, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(72, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(73, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(73, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(74, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(74, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(75, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(75, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(76, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(76, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(77, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(77, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(78, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(78, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(79, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(79, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(80, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(80, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(81, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(81, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(82, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(82, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(83, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(83, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(84, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(84, 2, '', '', 2, 1.00, '4500.00', 5000.00, 0, 0),
(85, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(86, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(87, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(88, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(89, 2, '', '', 1, 1.00, '4500.00', 5000.00, 0, 0),
(91, 2, '', '', 1, 10.00, '4500.00', 5000.00, 5, 0),
(95, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(96, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(97, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(98, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(99, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(100, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(101, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(102, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(103, 2, '', '', 1, 10.00, '4500.00', 5000.00, 0, 0),
(104, 1, '', '', 1, 3.00, '9000.00', 10000.00, 0, 0),
(105, 1, '', '', 1, 10.00, '9000.00', 10000.00, 0, 0),
(106, 1, '', '', 1, 1.00, '9000.00', 10000.00, 0, 0),
(107, 1, '', '', 1, 1.00, '10000.00', 10000.00, 0, 0),
(107, 2, '', '', 2, 2.00, '10000.00', 5000.00, 0, 0),
(108, 2, '', '', 2, 2.00, '10000.00', 5000.00, 0, 0),
(108, 3, '', '', 1, 3.00, '3500.00', 4000.00, 0, 0),
(109, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(110, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(111, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(112, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(113, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(114, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(115, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(116, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(117, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(118, 1, '', '', 1, 5.00, '10000.00', 10000.00, 0, 0),
(119, 1, '', '', 1, 1.00, '10000.00', 10000.00, 0, 0),
(120, 4, '', '', 1, 1.00, '2000.00', 2300.00, 0, 0),
(121, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(122, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(123, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(124, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(125, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0),
(126, 4, '', '20', 1, 1.00, '1000.00', 2500.00, 0, 0),
(127, 3, '', '', 1, 1.00, '1000.00', 4000.00, 0, 0),
(128, 3, '', '', 1, 1.00, '1000.00', 4000.00, 0, 0),
(129, 3, '', '', 1, 1.00, '1000.00', 4000.00, 0, 0),
(130, 2, '', '', 1, 1.00, '10000.00', 5000.00, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales_items_taxes`
--

CREATE TABLE IF NOT EXISTS `ospos_sales_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_sales_items_taxes`
--

INSERT INTO `ospos_sales_items_taxes` (`sale_id`, `item_id`, `line`, `name`, `percent`, `id_owner`) VALUES
(7, 2, 1, 'Sales Tax', 5.000, 0),
(8, 1, 2, 'Sales Tax', 5.000, 0),
(8, 2, 1, 'Sales Tax', 5.000, 0),
(9, 1, 2, 'Sales Tax', 5.000, 0),
(9, 2, 1, 'Sales Tax', 5.000, 0),
(10, 2, 1, 'Sales Tax', 5.000, 0),
(11, 2, 1, 'Sales Tax', 5.000, 0),
(12, 1, 1, 'Sales Tax', 5.000, 0),
(12, 2, 2, 'Sales Tax', 5.000, 0),
(13, 1, 1, 'Sales Tax', 5.000, 0),
(13, 2, 2, 'Sales Tax', 5.000, 0),
(14, 1, 1, 'Sales Tax', 5.000, 0),
(14, 2, 2, 'Sales Tax', 5.000, 0),
(15, 1, 1, 'Sales Tax', 5.000, 0),
(15, 2, 2, 'Sales Tax', 5.000, 0),
(16, 1, 1, 'Sales Tax', 5.000, 0),
(16, 2, 2, 'Sales Tax', 5.000, 0),
(17, 1, 1, 'Sales Tax', 5.000, 0),
(17, 2, 2, 'Sales Tax', 5.000, 0),
(18, 1, 1, 'Sales Tax', 5.000, 0),
(18, 2, 2, 'Sales Tax', 5.000, 0),
(19, 1, 1, 'Sales Tax', 5.000, 0),
(19, 2, 2, 'Sales Tax', 5.000, 0),
(20, 1, 1, 'Sales Tax', 5.000, 0),
(20, 2, 2, 'Sales Tax', 5.000, 0),
(21, 1, 1, 'Sales Tax', 5.000, 0),
(21, 2, 2, 'Sales Tax', 5.000, 0),
(22, 1, 1, 'Sales Tax', 5.000, 0),
(22, 2, 2, 'Sales Tax', 5.000, 0),
(23, 1, 1, 'Sales Tax', 5.000, 0),
(23, 2, 2, 'Sales Tax', 5.000, 0),
(24, 1, 1, 'Sales Tax', 5.000, 0),
(24, 2, 2, 'Sales Tax', 5.000, 0),
(25, 1, 1, 'Sales Tax', 5.000, 0),
(25, 2, 2, 'Sales Tax', 5.000, 0),
(26, 1, 1, 'Sales Tax', 5.000, 0),
(26, 2, 2, 'Sales Tax', 5.000, 0),
(27, 1, 1, 'Sales Tax', 5.000, 0),
(27, 2, 2, 'Sales Tax', 5.000, 0),
(28, 1, 1, 'Sales Tax', 5.000, 0),
(28, 2, 2, 'Sales Tax', 5.000, 0),
(29, 1, 1, 'Sales Tax', 5.000, 0),
(29, 2, 2, 'Sales Tax', 5.000, 0),
(30, 1, 1, 'Sales Tax', 5.000, 0),
(30, 2, 2, 'Sales Tax', 5.000, 0),
(31, 1, 1, 'Sales Tax', 5.000, 0),
(31, 2, 2, 'Sales Tax', 5.000, 0),
(32, 1, 1, 'Sales Tax', 5.000, 0),
(32, 2, 2, 'Sales Tax', 5.000, 0),
(33, 1, 1, 'Sales Tax', 5.000, 0),
(33, 2, 2, 'Sales Tax', 5.000, 0),
(34, 1, 1, 'Sales Tax', 5.000, 0),
(34, 2, 2, 'Sales Tax', 5.000, 0),
(35, 1, 1, 'Sales Tax', 5.000, 0),
(35, 2, 2, 'Sales Tax', 5.000, 0),
(36, 1, 1, 'Sales Tax', 5.000, 0),
(36, 2, 2, 'Sales Tax', 5.000, 0),
(37, 1, 1, 'Sales Tax', 5.000, 0),
(37, 2, 2, 'Sales Tax', 5.000, 0),
(38, 1, 1, 'Sales Tax', 5.000, 0),
(38, 2, 2, 'Sales Tax', 5.000, 0),
(39, 1, 1, 'Sales Tax', 5.000, 0),
(39, 2, 2, 'Sales Tax', 5.000, 0),
(40, 1, 1, 'Sales Tax', 5.000, 0),
(40, 2, 2, 'Sales Tax', 5.000, 0),
(41, 1, 1, 'Sales Tax', 5.000, 0),
(41, 2, 2, 'Sales Tax', 5.000, 0),
(42, 1, 1, 'Sales Tax', 5.000, 0),
(42, 2, 2, 'Sales Tax', 5.000, 0),
(43, 1, 1, 'Sales Tax', 5.000, 0),
(43, 2, 2, 'Sales Tax', 5.000, 0),
(44, 1, 1, 'Sales Tax', 5.000, 0),
(44, 2, 2, 'Sales Tax', 5.000, 0),
(45, 1, 1, 'Sales Tax', 5.000, 0),
(45, 2, 2, 'Sales Tax', 5.000, 0),
(46, 1, 1, 'Sales Tax', 5.000, 0),
(46, 2, 2, 'Sales Tax', 5.000, 0),
(47, 1, 1, 'Sales Tax', 5.000, 0),
(47, 2, 2, 'Sales Tax', 5.000, 0),
(48, 1, 1, 'Sales Tax', 5.000, 0),
(48, 2, 2, 'Sales Tax', 5.000, 0),
(49, 1, 1, 'Sales Tax', 5.000, 0),
(49, 2, 2, 'Sales Tax', 5.000, 0),
(50, 1, 1, 'Sales Tax', 5.000, 0),
(50, 2, 2, 'Sales Tax', 5.000, 0),
(51, 1, 1, 'Sales Tax', 5.000, 0),
(51, 2, 2, 'Sales Tax', 5.000, 0),
(52, 1, 1, 'Sales Tax', 5.000, 0),
(52, 2, 2, 'Sales Tax', 5.000, 0),
(53, 1, 1, 'Sales Tax', 5.000, 0),
(53, 2, 2, 'Sales Tax', 5.000, 0),
(54, 1, 1, 'Sales Tax', 5.000, 0),
(54, 2, 2, 'Sales Tax', 5.000, 0),
(55, 1, 1, 'Sales Tax', 5.000, 0),
(55, 2, 2, 'Sales Tax', 5.000, 0),
(56, 1, 1, 'Sales Tax', 5.000, 0),
(56, 2, 2, 'Sales Tax', 5.000, 0),
(57, 1, 1, 'Sales Tax', 5.000, 0),
(57, 2, 2, 'Sales Tax', 5.000, 0),
(58, 1, 1, 'Sales Tax', 5.000, 0),
(58, 2, 2, 'Sales Tax', 5.000, 0),
(59, 1, 1, 'Sales Tax', 5.000, 0),
(59, 2, 2, 'Sales Tax', 5.000, 0),
(60, 1, 1, 'Sales Tax', 5.000, 0),
(60, 2, 2, 'Sales Tax', 5.000, 0),
(61, 1, 1, 'Sales Tax', 5.000, 0),
(61, 2, 2, 'Sales Tax', 5.000, 0),
(62, 1, 1, 'Sales Tax', 5.000, 0),
(62, 2, 2, 'Sales Tax', 5.000, 0),
(63, 1, 1, 'Sales Tax', 5.000, 0),
(63, 2, 2, 'Sales Tax', 5.000, 0),
(64, 1, 1, 'Sales Tax', 5.000, 0),
(64, 2, 2, 'Sales Tax', 5.000, 0),
(65, 1, 1, 'Sales Tax', 5.000, 0),
(65, 2, 2, 'Sales Tax', 5.000, 0),
(66, 1, 1, 'Sales Tax', 5.000, 0),
(66, 2, 2, 'Sales Tax', 5.000, 0),
(67, 1, 1, 'Sales Tax', 5.000, 0),
(67, 2, 2, 'Sales Tax', 5.000, 0),
(68, 1, 1, 'Sales Tax', 5.000, 0),
(68, 2, 2, 'Sales Tax', 5.000, 0),
(69, 1, 1, 'Sales Tax', 5.000, 0),
(69, 2, 2, 'Sales Tax', 5.000, 0),
(70, 1, 1, 'Sales Tax', 5.000, 0),
(70, 2, 2, 'Sales Tax', 5.000, 0),
(71, 1, 1, 'Sales Tax', 5.000, 0),
(71, 2, 2, 'Sales Tax', 5.000, 0),
(72, 1, 1, 'Sales Tax', 5.000, 0),
(72, 2, 2, 'Sales Tax', 5.000, 0),
(73, 1, 1, 'Sales Tax', 5.000, 0),
(73, 2, 2, 'Sales Tax', 5.000, 0),
(74, 1, 1, 'Sales Tax', 5.000, 0),
(74, 2, 2, 'Sales Tax', 5.000, 0),
(75, 1, 1, 'Sales Tax', 5.000, 0),
(75, 2, 2, 'Sales Tax', 5.000, 0),
(76, 1, 1, 'Sales Tax', 5.000, 0),
(76, 2, 2, 'Sales Tax', 5.000, 0),
(77, 1, 1, 'Sales Tax', 5.000, 0),
(77, 2, 2, 'Sales Tax', 5.000, 0),
(78, 1, 1, 'Sales Tax', 5.000, 0),
(78, 2, 2, 'Sales Tax', 5.000, 0),
(79, 1, 1, 'Sales Tax', 5.000, 0),
(79, 2, 2, 'Sales Tax', 5.000, 0),
(80, 1, 1, 'Sales Tax', 5.000, 0),
(80, 2, 2, 'Sales Tax', 5.000, 0),
(81, 1, 1, 'Sales Tax', 5.000, 0),
(81, 2, 2, 'Sales Tax', 5.000, 0),
(82, 1, 1, 'Sales Tax', 5.000, 0),
(82, 2, 2, 'Sales Tax', 5.000, 0),
(83, 1, 1, 'Sales Tax', 5.000, 0),
(83, 2, 2, 'Sales Tax', 5.000, 0),
(84, 1, 1, 'Sales Tax', 5.000, 0),
(84, 2, 2, 'Sales Tax', 5.000, 0),
(85, 2, 1, 'Sales Tax', 5.000, 0),
(86, 2, 1, 'Sales Tax', 5.000, 0),
(87, 2, 1, 'Sales Tax', 5.000, 0),
(88, 2, 1, 'Sales Tax', 5.000, 0),
(89, 2, 1, 'Sales Tax', 5.000, 0),
(91, 2, 1, 'Sales Tax', 5.000, 0),
(95, 2, 1, 'Sales Tax', 5.000, 0),
(96, 2, 1, 'Sales Tax', 5.000, 0),
(97, 2, 1, 'Sales Tax', 5.000, 0),
(98, 2, 1, 'Sales Tax', 5.000, 0),
(99, 2, 1, 'Sales Tax', 5.000, 0),
(100, 2, 1, 'Sales Tax', 5.000, 0),
(101, 2, 1, 'Sales Tax', 5.000, 0),
(102, 2, 1, 'Sales Tax', 5.000, 0),
(103, 2, 1, 'Sales Tax', 5.000, 0),
(104, 1, 1, 'Sales Tax', 5.000, 0),
(105, 1, 1, 'Sales Tax', 5.000, 0),
(106, 1, 1, 'Sales Tax', 5.000, 0),
(108, 3, 1, 'PPN', 5.000, 0),
(109, 3, 1, 'PPN', 5.000, 0),
(110, 3, 1, 'PPN', 5.000, 0),
(111, 3, 1, 'PPN', 5.000, 0),
(112, 3, 1, 'PPN', 5.000, 0),
(113, 3, 1, 'PPN', 5.000, 0),
(114, 3, 1, 'PPN', 5.000, 0),
(115, 3, 1, 'PPN', 5.000, 0),
(116, 3, 1, 'PPN', 5.000, 0),
(117, 3, 1, 'PPN', 5.000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales_payments`
--

CREATE TABLE IF NOT EXISTS `ospos_sales_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_sales_payments`
--

INSERT INTO `ospos_sales_payments` (`sale_id`, `payment_type`, `payment_amount`, `id_owner`) VALUES
(5, 'Tunai', '55000.00', 0),
(6, 'Tunai', '10000.00', 0),
(7, 'Tunai', '5.00', 0),
(8, 'Tunai', '1000.00', 0),
(9, 'Tunai', '100000.00', 0),
(10, 'Tunai', '10000.00', 0),
(11, 'Tunai', '100000.00', 0),
(12, 'Tunai', '20000.00', 0),
(13, 'Tunai', '20000.00', 0),
(14, 'Tunai', '20000.00', 0),
(15, 'Tunai', '20000.00', 0),
(16, 'Tunai', '20000.00', 0),
(17, 'Tunai', '20000.00', 0),
(18, 'Tunai', '20000.00', 0),
(19, 'Tunai', '20000.00', 0),
(20, 'Tunai', '20000.00', 0),
(21, 'Tunai', '20000.00', 0),
(22, 'Tunai', '20000.00', 0),
(23, 'Tunai', '20000.00', 0),
(24, 'Tunai', '20000.00', 0),
(25, 'Tunai', '20000.00', 0),
(26, 'Tunai', '20000.00', 0),
(27, 'Tunai', '20000.00', 0),
(28, 'Tunai', '20000.00', 0),
(29, 'Tunai', '20000.00', 0),
(30, 'Tunai', '20000.00', 0),
(31, 'Tunai', '20000.00', 0),
(32, 'Tunai', '20000.00', 0),
(33, 'Tunai', '20000.00', 0),
(34, 'Tunai', '20000.00', 0),
(35, 'Tunai', '20000.00', 0),
(36, 'Tunai', '20000.00', 0),
(37, 'Tunai', '20000.00', 0),
(38, 'Tunai', '20000.00', 0),
(39, 'Tunai', '20000.00', 0),
(40, 'Tunai', '20000.00', 0),
(41, 'Tunai', '20000.00', 0),
(42, 'Tunai', '20000.00', 0),
(43, 'Tunai', '20000.00', 0),
(44, 'Tunai', '20000.00', 0),
(45, 'Tunai', '20000.00', 0),
(46, 'Tunai', '20000.00', 0),
(47, 'Tunai', '20000.00', 0),
(48, 'Tunai', '20000.00', 0),
(49, 'Tunai', '20000.00', 0),
(50, 'Tunai', '20000.00', 0),
(51, 'Tunai', '20000.00', 0),
(52, 'Tunai', '20000.00', 0),
(53, 'Tunai', '20000.00', 0),
(54, 'Tunai', '20000.00', 0),
(55, 'Tunai', '20000.00', 0),
(56, 'Tunai', '20000.00', 0),
(57, 'Tunai', '20000.00', 0),
(58, 'Tunai', '20000.00', 0),
(59, 'Tunai', '20000.00', 0),
(60, 'Tunai', '20000.00', 0),
(61, 'Tunai', '20000.00', 0),
(62, 'Tunai', '20000.00', 0),
(63, 'Tunai', '20000.00', 0),
(64, 'Tunai', '20000.00', 0),
(65, 'Tunai', '20000.00', 0),
(66, 'Tunai', '20000.00', 0),
(67, 'Tunai', '20000.00', 0),
(68, 'Tunai', '20000.00', 0),
(69, 'Tunai', '20000.00', 0),
(70, 'Tunai', '20000.00', 0),
(71, 'Tunai', '20000.00', 0),
(72, 'Tunai', '20000.00', 0),
(73, 'Tunai', '20000.00', 0),
(74, 'Tunai', '20000.00', 0),
(75, 'Tunai', '20000.00', 0),
(76, 'Tunai', '20000.00', 0),
(77, 'Tunai', '20000.00', 0),
(78, 'Tunai', '20000.00', 0),
(79, 'Tunai', '20000.00', 0),
(80, 'Tunai', '20000.00', 0),
(81, 'Tunai', '20000.00', 0),
(82, 'Tunai', '20000.00', 0),
(83, 'Tunai', '20000.00', 0),
(84, 'Tunai', '20000.00', 0),
(85, 'Tunai', '10000.00', 0),
(86, 'Tunai', '10000.00', 0),
(87, 'Tunai', '60000.00', 0),
(88, 'Tunai', '10000.00', 0),
(89, 'Tunai', '10000.00', 0),
(91, 'Tunai', '50000.00', 0),
(95, 'Tunai', '50000.00', 0),
(96, 'Tunai', '60000.00', 0),
(97, 'Tunai', '60000.00', 0),
(98, 'Tunai', '60000.00', 0),
(99, 'Tunai', '60000.00', 0),
(100, 'Tunai', '60000.00', 0),
(101, 'Tunai', '120000.00', 0),
(102, 'Tunai', '60000.00', 0),
(103, 'Tunai', '55000.00', 0),
(104, 'Tunai', '32000.00', 0),
(105, 'Tunai', '105000.00', 0),
(106, 'Tunai', '10000.00', 0),
(107, 'Tunai', '50000.00', 0),
(108, 'Kartu Debit', '22600.00', 0),
(109, 'Tunai', '5000.00', 0),
(110, 'Tunai', '5000.00', 0),
(111, 'Tunai', '5000.00', 0),
(112, 'Tunai', '10000.00', 0),
(113, 'Tunai', '5000.00', 0),
(114, 'Tunai', '5000.00', 0),
(115, 'Tunai', '5000.00', 0),
(116, 'Tunai', '5000.00', 0),
(117, 'Tunai', '5000.00', 0),
(118, 'Tunai', '100000.00', 0),
(119, 'Tunai', '15000.00', 0),
(120, 'Tunai', '2500.00', 0),
(121, 'Tunai', '5000.00', 0),
(122, 'Tunai', '5000.00', 0),
(123, 'Kartu Credit', '4000.00', 0),
(124, 'Tunai', '5000.00', 0),
(125, 'Tunai', '5000.00', 0),
(126, 'Kartu Debit', '100.00', 0),
(126, 'Tunai', '2000.00', 0),
(127, 'Kartu Debit', '1000.00', 0),
(127, 'Kupon Hadiah:123', '9.99', 0),
(128, 'Tunai', '1000.00', 0),
(129, 'Kartu Debit', '2000.00', 0),
(129, 'Tunai', '2000.00', 0),
(130, 'Kupon Hadiah:222', '1.00', 0),
(130, 'Tunai', '4999.00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales_suspended`
--

CREATE TABLE IF NOT EXISTS `ospos_sales_suspended` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ospos_sales_suspended`
--

INSERT INTO `ospos_sales_suspended` (`sale_time`, `customer_id`, `employee_id`, `comment`, `sale_id`, `payment_type`, `id_owner`) VALUES
('2013-03-06 13:00:05', NULL, 1, '', 1, 'Tunai: Rp.5.000,00<br />', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales_suspended_items`
--

CREATE TABLE IF NOT EXISTS `ospos_sales_suspended_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_sales_suspended_items`
--

INSERT INTO `ospos_sales_suspended_items` (`sale_id`, `item_id`, `description`, `serialnumber`, `line`, `quantity_purchased`, `item_cost_price`, `item_unit_price`, `discount_percent`, `id_owner`) VALUES
(1, 3, '', '', 1, 1.00, '3500.00', 4000.00, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales_suspended_items_taxes`
--

CREATE TABLE IF NOT EXISTS `ospos_sales_suspended_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sales_suspended_payments`
--

CREATE TABLE IF NOT EXISTS `ospos_sales_suspended_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  `id_owner` int(10) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_sales_suspended_payments`
--

INSERT INTO `ospos_sales_suspended_payments` (`sale_id`, `payment_type`, `payment_amount`, `id_owner`) VALUES
(1, 'Tunai', '5000.00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ospos_sessions`
--

CREATE TABLE IF NOT EXISTS `ospos_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_sessions`
--

INSERT INTO `ospos_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('afcb35c693b98eab720b96363ddfd500', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36', 1388739939, 'a:6:{s:9:"user_data";s:0:"";s:9:"person_id";s:1:"1";s:8:"cartRecv";a:0:{}s:9:"recv_mode";s:7:"receive";s:16:"receive_payments";a:0:{}s:8:"supplier";i:-1;}'),
('c069d0eaa24abb4ea3b24fdc3dd87fc1', '192.168.1.8', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36', 1388740676, 'a:2:{s:9:"user_data";s:0:"";s:9:"person_id";s:1:"1";}');

-- --------------------------------------------------------

--
-- Table structure for table `ospos_suppliers`
--

CREATE TABLE IF NOT EXISTS `ospos_suppliers` (
  `person_id` int(10) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `id_owner` int(10) NOT NULL,
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ospos_suppliers`
--

INSERT INTO `ospos_suppliers` (`person_id`, `company_name`, `account_number`, `deleted`, `id_owner`) VALUES
(4, 'Batu Permata', NULL, 0, 0),
(10, 'MC Group', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `table 25`
--

CREATE TABLE IF NOT EXISTS `table 25` (
  `COL 1` varchar(10) DEFAULT NULL,
  `COL 2` varchar(9) DEFAULT NULL,
  `COL 3` varchar(18) DEFAULT NULL,
  `COL 4` varchar(12) DEFAULT NULL,
  `COL 5` varchar(18) DEFAULT NULL,
  `COL 6` varchar(8) DEFAULT NULL,
  `COL 7` varchar(7) DEFAULT NULL,
  `COL 8` varchar(5) DEFAULT NULL,
  `COL 9` varchar(5) DEFAULT NULL,
  `COL 10` varchar(7) DEFAULT NULL,
  `COL 11` varchar(11) DEFAULT NULL,
  `COL 12` varchar(14) DEFAULT NULL,
  `COL 13` varchar(7) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `table 25`
--

INSERT INTO `table 25` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`, `COL 7`, `COL 8`, `COL 9`, `COL 10`, `COL 11`, `COL 12`, `COL 13`) VALUES
('First Name', 'Last Name', 'E-Mail', 'Phone Number', 'Address 1', 'Address2', 'City', 'State', 'Zip', 'Country', 'Comments', 'Account Number', 'Taxable'),
('Bob', 'Smith', 'bsmith@nowhere.com', '585-555-1111', '123 Nowhere Street', 'Apt 4', 'Awesome', 'NY', '11111', 'USA', 'Awesome guy', '', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `table 26`
--

CREATE TABLE IF NOT EXISTS `table 26` (
  `COL 1` varchar(12) DEFAULT NULL,
  `COL 2` varchar(9) DEFAULT NULL,
  `COL 3` varchar(8) DEFAULT NULL,
  `COL 4` varchar(11) DEFAULT NULL,
  `COL 5` varchar(10) DEFAULT NULL,
  `COL 6` varchar(10) DEFAULT NULL,
  `COL 7` varchar(10) DEFAULT NULL,
  `COL 8` varchar(13) DEFAULT NULL,
  `COL 9` varchar(11) DEFAULT NULL,
  `COL 10` varchar(13) DEFAULT NULL,
  `COL 11` varchar(8) DEFAULT NULL,
  `COL 12` varchar(13) DEFAULT NULL,
  `COL 13` varchar(8) DEFAULT NULL,
  `COL 14` varchar(11) DEFAULT NULL,
  `COL 15` varchar(21) DEFAULT NULL,
  `COL 16` varchar(22) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `table 26`
--

INSERT INTO `table 26` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`, `COL 7`, `COL 8`, `COL 9`, `COL 10`, `COL 11`, `COL 12`, `COL 13`, `COL 14`, `COL 15`, `COL 16`) VALUES
('UPC/EAN/ISBN', 'Item Name', 'Category', 'Supplier ID', 'Cost Price', 'Unit Price', 'Tax 1 Name', 'Tax 1 Percent', 'Tax 2 Name ', 'Tax 2 Percent', 'Quantity', 'Reorder Level', 'Location', 'Description', 'Allow Alt Description', 'Item has Serial Number');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ospos_customers`
--
ALTER TABLE `ospos_customers`
  ADD CONSTRAINT `ospos_customers_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`);

--
-- Constraints for table `ospos_employees`
--
ALTER TABLE `ospos_employees`
  ADD CONSTRAINT `ospos_employees_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`);

--
-- Constraints for table `ospos_inventory`
--
ALTER TABLE `ospos_inventory`
  ADD CONSTRAINT `ospos_inventory_ibfk_1` FOREIGN KEY (`trans_items`) REFERENCES `ospos_items` (`item_id`),
  ADD CONSTRAINT `ospos_inventory_ibfk_2` FOREIGN KEY (`trans_user`) REFERENCES `ospos_employees` (`person_id`);

--
-- Constraints for table `ospos_items`
--
ALTER TABLE `ospos_items`
  ADD CONSTRAINT `ospos_items_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `ospos_suppliers` (`person_id`);

--
-- Constraints for table `ospos_items_taxes`
--
ALTER TABLE `ospos_items_taxes`
  ADD CONSTRAINT `ospos_items_taxes_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `ospos_item_kit_items`
--
ALTER TABLE `ospos_item_kit_items`
  ADD CONSTRAINT `ospos_item_kit_items_ibfk_1` FOREIGN KEY (`item_kit_id`) REFERENCES `ospos_item_kits` (`item_kit_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ospos_item_kit_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `ospos_permissions`
--
ALTER TABLE `ospos_permissions`
  ADD CONSTRAINT `ospos_permissions_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_employees` (`person_id`),
  ADD CONSTRAINT `ospos_permissions_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `ospos_modules` (`module_id`);

--
-- Constraints for table `ospos_receivings`
--
ALTER TABLE `ospos_receivings`
  ADD CONSTRAINT `ospos_receivings_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  ADD CONSTRAINT `ospos_receivings_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `ospos_suppliers` (`person_id`);

--
-- Constraints for table `ospos_receivings_items`
--
ALTER TABLE `ospos_receivings_items`
  ADD CONSTRAINT `ospos_receivings_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  ADD CONSTRAINT `ospos_receivings_items_ibfk_2` FOREIGN KEY (`receiving_id`) REFERENCES `ospos_receivings` (`receiving_id`);

--
-- Constraints for table `ospos_sales`
--
ALTER TABLE `ospos_sales`
  ADD CONSTRAINT `ospos_sales_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  ADD CONSTRAINT `ospos_sales_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ospos_customers` (`person_id`);

--
-- Constraints for table `ospos_sales_items`
--
ALTER TABLE `ospos_sales_items`
  ADD CONSTRAINT `ospos_sales_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  ADD CONSTRAINT `ospos_sales_items_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales` (`sale_id`);

--
-- Constraints for table `ospos_sales_items_taxes`
--
ALTER TABLE `ospos_sales_items_taxes`
  ADD CONSTRAINT `ospos_sales_items_taxes_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_items` (`sale_id`),
  ADD CONSTRAINT `ospos_sales_items_taxes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`);

--
-- Constraints for table `ospos_sales_payments`
--
ALTER TABLE `ospos_sales_payments`
  ADD CONSTRAINT `ospos_sales_payments_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales` (`sale_id`);

--
-- Constraints for table `ospos_sales_suspended`
--
ALTER TABLE `ospos_sales_suspended`
  ADD CONSTRAINT `ospos_sales_suspended_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  ADD CONSTRAINT `ospos_sales_suspended_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ospos_customers` (`person_id`);

--
-- Constraints for table `ospos_sales_suspended_items`
--
ALTER TABLE `ospos_sales_suspended_items`
  ADD CONSTRAINT `ospos_sales_suspended_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  ADD CONSTRAINT `ospos_sales_suspended_items_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended` (`sale_id`);

--
-- Constraints for table `ospos_sales_suspended_items_taxes`
--
ALTER TABLE `ospos_sales_suspended_items_taxes`
  ADD CONSTRAINT `ospos_sales_suspended_items_taxes_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended_items` (`sale_id`),
  ADD CONSTRAINT `ospos_sales_suspended_items_taxes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`);

--
-- Constraints for table `ospos_sales_suspended_payments`
--
ALTER TABLE `ospos_sales_suspended_payments`
  ADD CONSTRAINT `ospos_sales_suspended_payments_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended` (`sale_id`);

--
-- Constraints for table `ospos_suppliers`
--
ALTER TABLE `ospos_suppliers`
  ADD CONSTRAINT `ospos_suppliers_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
