-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 15, 2022 at 07:55 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_findstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_address`
--

CREATE TABLE `tbl_address` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `inseredAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deletedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_address`
--

INSERT INTO `tbl_address` (`id`, `user_id`, `address`, `inseredAt`, `updatedAt`, `deletedAt`) VALUES
(1, 1, 'ranip', '2022-07-29 10:46:24', '2022-09-01 11:50:17', NULL),
(2, 2, 'ranip', '2022-07-29 10:46:24', '2022-09-01 11:50:17', NULL),
(3, 3, 'nikol', '2022-07-29 10:46:24', '2022-09-01 11:50:17', NULL),
(4, 4, 'naroda', '2022-07-29 10:46:24', '2022-09-01 11:50:17', NULL),
(5, 5, 'law garden', '2022-07-29 10:46:24', '2022-09-01 11:50:17', NULL),
(6, 6, 'navarangpura', '2022-07-29 10:46:24', '2022-09-01 11:50:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_category`
--

CREATE TABLE `tbl_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(128) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `insertedAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_category`
--

INSERT INTO `tbl_category` (`id`, `name`, `is_active`, `insertedAt`, `updatedAt`) VALUES
(1, 'household', 1, '2022-07-29 10:16:38', '2022-09-01 11:50:17'),
(2, 'grocery', 1, '2022-07-29 10:16:38', '2022-09-01 11:50:17'),
(3, 'pharmacy', 1, '2022-07-29 10:16:38', '2022-09-01 11:50:17'),
(4, 'furniture', 1, '2022-07-29 10:16:38', '2022-09-01 11:50:17');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `store_id` bigint(20) NOT NULL,
  `address_id` bigint(20) NOT NULL,
  `transaction_no` bigint(20) NOT NULL,
  `order_no` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `discount_amt` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sub_total` decimal(10,2) NOT NULL,
  `service_charge` decimal(10,2) NOT NULL,
  `grand_total` decimal(10,2) NOT NULL,
  `status` enum('pending','prepared','out for delivery','cancalled','deliverd') NOT NULL,
  `payment_methode` enum('cash','online') NOT NULL,
  `rating` float DEFAULT NULL,
  `inseredAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order_details`
--

CREATE TABLE `tbl_order_details` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `inseredAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_otp`
--

CREATE TABLE `tbl_otp` (
  `id` bigint(20) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `otp` int(11) NOT NULL,
  `insertedAt` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_otp`
--

INSERT INTO `tbl_otp` (`id`, `phone`, `otp`, `insertedAt`) VALUES
(19, '9874563251', 4875, '2022-07-29 10:01:35'),
(20, '9874123654', 7485, '2022-07-29 10:01:35'),
(21, '9874152634', 2514, '2022-07-29 10:01:35'),
(22, '8569741235', 3652, '2022-07-29 10:01:35'),
(23, '7458963215', 7521, '2022-07-29 10:01:35'),
(24, '7854126395', 7536, '2022-07-29 10:01:35');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

CREATE TABLE `tbl_product` (
  `id` bigint(20) NOT NULL,
  `sub_category_id` bigint(20) NOT NULL,
  `store_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `about` text NOT NULL,
  `image` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `inseredAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`id`, `sub_category_id`, `store_id`, `name`, `price`, `about`, `image`, `is_active`, `inseredAt`, `updatedAt`) VALUES
(1, 1, 2, 'milk', '50.00', 'milk', 'a.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(2, 1, 1, 'cleaner', '150.00', 'dish washer', 'd.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(3, 7, 3, 'cold', '150.00', 'asd', 'a.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(4, 8, 3, 'pain killer', '150.00', 'ertyu', 'e.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(5, 7, 3, 'fever', '740.00', 'rfvbgt', 'e.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(6, 4, 4, 'table', '4100.00', 'tyhnb', 'w.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(7, 3, 4, 'esasa', '410.00', 'as', 't.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(8, 4, 2, 'ewew', '100.00', 'jiko', 'k.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(9, 4, 1, 'mnbv', '100.00', 'bhgyt', 'o.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17'),
(10, 3, 1, 'tfyg', '100.00', 'drdr', 'fff.jpg', 1, '2022-07-29 10:44:46', '2022-09-01 11:50:17');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pro_fav`
--

CREATE TABLE `tbl_pro_fav` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `pro_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_pro_fav`
--

INSERT INTO `tbl_pro_fav` (`id`, `user_id`, `pro_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2022-07-30 10:56:14', '2022-07-30 10:56:14'),
(2, 2, 3, '2022-07-30 10:56:14', '2022-07-30 10:56:14'),
(3, 3, 2, '2022-07-30 10:56:14', '2022-07-30 10:56:14'),
(4, 4, 4, '2022-07-30 10:56:14', '2022-07-30 10:56:14'),
(5, 1, 1, '2022-09-02 13:52:41', '2022-09-02 13:52:41');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ratings`
--

CREATE TABLE `tbl_ratings` (
  `id` bigint(20) NOT NULL,
  `store_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `ratings` float(2,1) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `insertedAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_ratings`
--

INSERT INTO `tbl_ratings` (`id`, `store_id`, `user_id`, `ratings`, `is_active`, `insertedAt`, `updatedAt`) VALUES
(1, 1, 1, 4.2, 1, '2022-07-29 11:44:53', '2022-09-01 11:50:17'),
(2, 2, 1, 4.1, 1, '2022-07-29 11:44:53', '2022-09-01 11:50:17'),
(3, 3, 2, 3.6, 1, '2022-07-29 11:44:53', '2022-09-01 11:50:17'),
(4, 4, 3, 2.1, 1, '2022-07-29 11:44:53', '2022-09-01 11:50:17'),
(5, 1, 3, 4.2, 1, '2022-07-29 11:44:53', '2022-09-01 11:50:17'),
(7, 3, 5, 3.8, 1, '2022-07-29 11:44:53', '2022-09-01 11:50:17');

--
-- Triggers `tbl_ratings`
--
DELIMITER $$
CREATE TRIGGER `tbl_ratings_AFTER_DELETE` AFTER DELETE ON `tbl_ratings` FOR EACH ROW BEGIN 
update `db_findproduct`.`tbl_store`
set total_ratings = total_ratings - old.ratings 
where id=old.store_id;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tbl_ratings_AFTER_INSERT` AFTER INSERT ON `tbl_ratings` FOR EACH ROW BEGIN
 update `db_findproduct`.`tbl_store`
set total_ratings = (select avg(ratings) from tbl_ratings where tbl_ratings.store_id=tbl_store.id)
where id=new.store_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_store`
--

CREATE TABLE `tbl_store` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `name` varchar(128) NOT NULL,
  `address` varchar(128) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `latitude` varchar(255) NOT NULL,
  `about` varchar(128) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `total_rating` float(2,1) NOT NULL DEFAULT 0.0,
  `image` varchar(128) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `insertedAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_store`
--

INSERT INTO `tbl_store` (`id`, `user_id`, `category_id`, `name`, `address`, `longitude`, `latitude`, `about`, `email`, `phone`, `total_rating`, `image`, `is_active`, `insertedAt`, `updatedAt`) VALUES
(1, 60, 1, 'walmart', 'ranip', '72.5256887', '23.0751887', 'asdfghj', 'walmart@gmail.com', '7845965325', 4.2, 'a.jpg', 1, '2022-07-29 10:28:31', '2022-09-02 06:54:37'),
(2, 4, 2, 'XYZ', 'RANIP', '72.6714', '23.0368', 'ERT', 'xyz@gmail.com', '9854127555', 1.9, 'S.jpg', 0, '2022-07-29 10:28:31', '2022-09-02 04:34:14'),
(3, 5, 3, 'pharmacy', 'ranip', '72.5730', '23.0958', 'awsed', 'pharmacy@gmail.com', '8547265111', 3.7, 'f.jpg', 1, '2022-07-29 10:28:31', '2022-09-02 04:34:19'),
(4, 4, 4, 'jkl', 'ranip', '72.5715', '23.0356', 'poiuy', 'jkl@gmail.com', '8459671256', 2.1, 'r.jpg', 1, '2022-07-29 10:28:31', '2022-09-02 04:34:26'),
(5, 4, 1, 'a mart', 'ranip', '72.5859', '23.0389', 'nbhgvf', 'amart@gmail.com', '7452163854', 0.0, 'w.jpg', 0, '2022-07-29 10:28:31', '2022-09-02 04:34:31'),
(6, 5, 2, 'dmart', 'ranip', '72.5750', '23.0389', 'edcvfrt', 'dmart@gmail.com', '8569325415', 0.0, 'e.jpg', 1, '2022-07-29 10:28:31', '2022-09-02 04:34:38');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subcategory`
--

CREATE TABLE `tbl_subcategory` (
  `id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `name` varchar(128) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `insertedAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_subcategory`
--

INSERT INTO `tbl_subcategory` (`id`, `category_id`, `name`, `is_active`, `insertedAt`, `updatedAt`) VALUES
(1, 2, 'milk', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(2, 2, 'ice-cream', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(3, 2, 'vegetable', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(4, 1, 'cleaner', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(5, 1, 'pot', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(6, 1, 'spoon', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(7, 3, 'cold', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(8, 3, 'pain killer', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(9, 4, 'table', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17'),
(10, 4, 'chair', 1, '2022-07-29 10:19:36', '2022-09-01 11:50:17');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id` bigint(20) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `email` varchar(32) NOT NULL,
  `social_id` text NOT NULL,
  `username` varchar(32) DEFAULT NULL,
  `mobile_no` varchar(16) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role` enum('User','Vendor') NOT NULL,
  `latitude` varchar(16) DEFAULT NULL,
  `longitude` varchar(16) DEFAULT NULL,
  `language` enum('en') DEFAULT NULL,
  `login` enum('login','logout') DEFAULT NULL,
  `login_type` enum('S','F','G') DEFAULT 'S',
  `is_online` tinyint(1) DEFAULT 0,
  `last_login` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  `is_verify` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`id`, `name`, `email`, `social_id`, `username`, `mobile_no`, `password`, `role`, `latitude`, `longitude`, `language`, `login`, `login_type`, `is_online`, `last_login`, `is_deleted`, `is_verify`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'meet', 'meet@g.com', '', '', '7896541236', '2356', 'User', '', '', NULL, NULL, NULL, 0, NULL, 0, 0, 1, '2022-07-29 02:44:48', '2022-07-30 07:06:08'),
(2, 'Siddharth', 'siddharth@g.com', '', '', '9856478596', '5698', 'Vendor', '', '', NULL, NULL, NULL, 0, NULL, 0, 0, 1, '2022-07-29 02:44:48', '2022-07-30 07:06:08'),
(3, 'sammeer', 'sameer@g.com', '', '', '6352364152', '8965', 'User', '', '', NULL, NULL, NULL, 0, NULL, 0, 0, 1, '2022-07-29 02:44:48', '2022-07-30 07:06:08'),
(4, 'jay', 'jay@g.com', '', '', '8569745896', '5583413443164b56500def9a533c7c70', 'Vendor', '', '', NULL, NULL, NULL, 0, NULL, 0, 0, 1, '2022-07-29 02:44:48', '2022-07-30 07:06:08'),
(5, 'abc', 'abc@gmail.com', '', 'abc123', '', 'yElYOe391lFeeoNo8mtjBQ==', 'User', '', '', NULL, NULL, 'S', 1, NULL, 0, 0, 1, '2022-09-01 05:58:56', '2022-09-01 05:58:56'),
(6, 'abc', 'abcdef@gmail.com', '', 'abccgn123', '', 'yElYOe391lFeeoNo8mtjBQ==', 'User', '', '', NULL, NULL, 'S', 1, NULL, 0, 0, 1, '2022-09-01 06:00:18', '2022-09-01 06:00:18'),
(16, 'sachin', 'sachin@gmail.com', 'sachin12345', 'sachin123', '9998545417', '', 'User', NULL, NULL, NULL, NULL, 'F', 1, '2022-09-05 12:57:38', 0, 0, 1, '2022-09-01 12:10:06', '2022-09-05 07:27:38'),
(30, 'abc', 'abcdecdaggrf@gmail.com', '', 'abccgssadgsfgfn123', '9998545417', 'yElYOe391lFeeoNo8mtjBQ==', 'User', '', '', NULL, NULL, 'S', 1, NULL, 0, 0, 1, '2022-09-01 06:20:19', '2022-09-01 06:20:19'),
(60, 'nishant', 'nishant@gmail.com', 'nishant12345', 'nishant', '8787878787', '', 'User', NULL, NULL, NULL, NULL, 'F', 1, NULL, 0, 0, 1, '2022-09-02 05:23:06', '2022-09-02 05:23:06'),
(61, 'akash', 'akash@gmail.com', 'akash321', 'akash321', '', '', 'User', NULL, NULL, NULL, NULL, 'F', 1, NULL, 0, 0, 1, '2022-09-03 05:25:28', '2022-09-03 05:25:28');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_device`
--

CREATE TABLE `tbl_user_device` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_type` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `device_token` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `uuid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `os_version` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `device_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `insertdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_user_device`
--

INSERT INTO `tbl_user_device` (`id`, `user_id`, `token`, `device_type`, `device_token`, `uuid`, `os_version`, `device_name`, `model_name`, `ip`, `insertdate`, `updatetime`) VALUES
(1, 1, 'dbhskfgvdsyvyfgvsyfyg', 'A', 'dsadasfdsf', 'fdsfds', 'a', 'mi', 'dsadsdfd', '24.4343.432.3', '2022-08-17 06:55:27', '2022-08-17 06:55:27'),
(4, 6, '0pvvp0j2f12ecmrx3orbk5qlij7lv0ncbvic8l2n099lprrbadcmkqyefmhnrwkg', 'A', 'hkjb', '', '', '', '', '', '2022-08-20 06:47:26', '2022-09-01 06:00:18'),
(6, 7, 'hufo0ndo7qlzhe9s7m5lcsoauz2mv7nebjiys8st7gq5kz9dogtpgo3lxhcw698g', 'A', 'hkjb', '', '', '', '', '', '2022-08-20 06:59:24', '2022-09-01 06:06:25'),
(7, 8, 'hota9u64i0d6pgqxwvcfzak0pjqkfr7uesxeny48rdqzk4thh2f5rsd4hc32bojk', 'A', 'hkjb', '', '', '', '', '', '2022-08-21 04:20:11', '2022-09-01 06:07:25'),
(8, 9, '', 'A', 'hkjb', '', '', '', '', '', '2022-08-22 06:12:39', '2022-09-01 06:08:02'),
(9, 10, '74oy9y3lo77suphnzypao35sqfo1qux73yb134psr3fmtd0eg86f1p4se689xoor', 'A', 'xvcbvbvcbv', '', '', '', '', '', '2022-08-23 06:32:24', '2022-08-23 06:32:24'),
(10, 11, '5ph90q3lkj5avq48wlvu2b32pb4alkb9cefn36s5kc13ralnb6jfv5ducye9wqxa', 'I', 'gbbhnjn', '', '', '', '', '', '2022-08-23 07:41:56', '2022-08-23 07:56:19'),
(11, 12, 'lz9vzmepnbd627gyuwjyandhzznszxdcdhe78u4q03kthpn49lqv5n1jkr6zrlyd', 'I', 'gbbhnjn', '', '', '', '', '', '2022-08-23 08:10:01', '2022-08-23 08:10:01'),
(12, 13, 'dy8hnpqh0n6sgf95z5qpmijrd4wogydi9okxiryh6cm9sjq5rpbtdypty2fpiiy4', 'I', 'gbbhnjn', '', '', '', '', '', '2022-08-23 08:16:45', '2022-08-23 08:16:45'),
(13, 14, '17e5kfs7eyesh1b91cypc13d0nbk20j31d7l1z9omdx9pxo2la26a2b3yzrlosq8', 'A', 'fkjdsbfhbdjbh', '', '', '', '', '', '2022-08-23 09:29:35', '2022-08-23 09:32:15'),
(14, 15, 'x4nmh23qkafp84ijuzdpwh09sx0pht8x1tcue9lgpr0il0vf714k8dnexo3p1w4u', 'I', 'bcvnvcngm', '', '', '', '', '', '2022-08-23 09:54:13', '2022-08-23 10:00:21'),
(15, 16, 'lkyfppg6746emwitqm9r0vfxvcjhajinihhye1n6j9owhxmdmk2h9d1s04dbw7tl', 'I', 'sachin123', '', '', NULL, '', '', '2022-08-23 10:03:41', '2022-09-05 07:27:38'),
(16, 17, 'i54t22qz9112jdi9a72xv4hivnry9fexv0kiuxvr4t8id9dpfkqfmzjhmtmr9vzg', 'A', 'bfhfghgj', '', '', NULL, '', '', '2022-08-24 03:57:51', '2022-08-24 04:12:52'),
(17, 18, 'ai6a1cioh20wha9c4he1ch5dfk6x9vhwo2go3at1e6gz1caav29e9x37ihzi67p2', 'A', 'vcbcbnf', '', '', NULL, '', '', '2022-08-24 08:47:37', '2022-08-24 08:47:37'),
(18, 19, 'v9514gxkei1amudg01puoqd2m75fy644859h66zqi07c4pzfo0qdoce38iig10nw', 'A', 'vcbbvbgfd', '', '', NULL, '', '', '2022-08-26 09:56:00', '2022-08-26 09:56:00'),
(19, 20, 'wpfo4e3nih7efqq1ev0uvlrlbeel9ihg33i0eosog74zr2e0vixjj7ef4rdja5za', 'A', 'dfsdgdfgh', '', '', NULL, '', '', '2022-08-27 06:38:31', '2022-08-27 07:01:12'),
(20, 21, 'o36ujzr7ac73ylw0er9fzkr2arjbichwjnasfelcnebe2gp5pv9pcc9p9g8zav83', 'A', 'bvbvbcbn', '', '', NULL, '', '', '2022-08-30 04:22:39', '2022-08-30 10:16:18'),
(21, 22, 'eb1wude12vwkdiahq1obfjifpbz2z2ma2i3rxj0qz125bijtgw0a2asshzwpb75k', 'A', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:04:38', '2022-08-30 06:04:38'),
(22, 23, '7obsd3x7fdwhy3z0najcjeifyjx3xcb9dhi8fif7y3lkb54rctqycutix5xr9gvq', 'A', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:13:50', '2022-08-30 06:23:41'),
(23, 24, 'tzhvgn4pulxdsvfght5pp4qmwrjzlcybtxmi1twesrdexb4fyjyaiuy26ki2rdwr', 'I', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:48:46', '2022-08-30 06:48:46'),
(24, 25, 'xupn3rdyi68aw9y3wrpv2m32ezqhs1k11ufv6ua564fh17z9zu72smurelfym2ul', 'I', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:49:49', '2022-08-30 06:49:49'),
(25, 26, 'd42tro3fdh5s7pj0t4nutzpllu6qsfswbaas54itci1f1put0ch5uplnclmaajd0', 'I', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:50:30', '2022-08-30 06:50:30'),
(26, 5, '', 'A', 'hkjb', '', '', NULL, '', '', '2022-09-01 05:58:56', '2022-09-01 05:58:56'),
(27, 28, '', 'A', 'hksajb', '', '', NULL, '', '', '2022-09-01 06:19:26', '2022-09-01 06:19:26'),
(28, 30, '', 'A', 'hksajb', '', '', NULL, '', '', '2022-09-01 06:20:19', '2022-09-01 06:20:19'),
(29, 32, '', 'A', 'hksajb', '', '', NULL, '', '', '2022-09-01 06:21:36', '2022-09-01 06:21:36'),
(30, 34, '', 'A', 'bvbvbcbn', '', '', NULL, '', '', '2022-09-01 06:32:18', '2022-09-01 06:32:18'),
(31, 36, 'hxcav4vt3k1hto63p0ptl24h9cujx06mfxq69y2pe9ja7fskli45yrrad4pyj7rq', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 06:40:32', '2022-09-01 06:40:32'),
(33, 38, 'uecvmtw7mdzhzrtzjrursn3r641m8ytba8xp4pkrjxj0kn3qex4k5ct5v60apj9l', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 06:42:36', '2022-09-01 06:42:36'),
(34, 39, 'ilmcmkooec16ow802l3v4er250zwb6g9htq4siuzi0vasxjngwkkpewyu263e4se', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 06:46:06', '2022-09-01 06:46:06'),
(35, 40, 'nmk5st6qm5bjb4z1tf9m7a88npylllxutvdseznmifqbkqmksywt2u512ek1cm6o', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 06:49:03', '2022-09-01 06:49:03'),
(36, 41, 'k2l1kv4u0ewisp2w75zgx8pgvv265ebt2saogfvl8abpe9pa3ooqkbfbfh282jc4', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 06:50:02', '2022-09-01 06:50:02'),
(37, 42, 'gefoy0gko5pk7tz8d8etop9xkb8j4n5jgfjej64mmah7m1flv8g0qtm18quzxwu5', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 06:56:13', '2022-09-01 06:56:13'),
(38, 43, '158v9sv9g40oc4fyckft212bc63296ypbxa87vept1534vxq8lbdp2e0hhaut9kf', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:06:01', '2022-09-01 07:06:01'),
(39, 44, '51zctufucpfiq3p5v8r6f4i8cglnhd9rd1bffqo1w0wjhn2ogo8wy4xikpajsxfc', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:08:05', '2022-09-01 07:08:05'),
(41, 46, '1s0wq1b4f2ga0sk37fgr3wuqt8qvfss8x1r8r0m34cg1ueyi60xu1obhdkr7hj8d', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:10:31', '2022-09-01 07:10:31'),
(43, 48, 'fte5nq75awbqz05bzsb0y68xyl5unaw1utdqqj5ofcqsgfqu6kmpqxiuvujkira9', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:14:04', '2022-09-01 07:14:04'),
(44, 49, 'zccezj5arxngze4vtr3n7h5efp27cyt1q4vy2b72v3rek0wg3gao9kr1h4fpf4lf', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:14:58', '2022-09-01 07:14:58'),
(45, 50, 'm5q7s2gpr5k8gnv64qspml9fqu21g1cjbaczixg9euk37ru4thhgycoft9r1mifx', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:15:17', '2022-09-01 07:15:17'),
(46, 51, '8cwi0h80uo0zohtpqi0xn7t4er6zkgpuith97z0oybywj6magwsdllrrwilamyyi', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:19:05', '2022-09-01 07:19:05'),
(47, 52, 'suvnnle5233pvv3ec0ltchb7jigrbnjh71p62tqomlzy1xjslm7n0ednw19twf99', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:19:47', '2022-09-01 07:19:47'),
(48, 53, 'gtt7ay6gyzyldlb3sev09daxa9cj4trpontq8mh3o58ried6vsf8kcth4l9ohjfu', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:22:42', '2022-09-01 07:22:42'),
(49, 54, '8n07qh5z2yyfn0uptb0b5ox6qyj7lmkg3eeauf5249p9pidtixadil6vg44vygq0', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:23:15', '2022-09-01 07:23:15'),
(50, 55, '0efczs1ioe3eiukjt2g9i9v4cr0g3x2oviizla0ov8opajn185gecsnam9ho1e1h', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:24:20', '2022-09-01 07:24:20'),
(51, 56, 'xsmgspbkdgc3fiwvunt2xuhhlycrdgzi9uss9d3jwu3x37cqnpzwqp1tg1px7785', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 07:27:59', '2022-09-01 07:27:59'),
(52, 57, 'aie7a1lodd99mwom81s16py697nwp3mfpyol4siajtt5ts6ztvwz3ah7kudyw1qc', 'A', 'Kenil12345', '', '', NULL, '', '', '2022-09-01 09:24:03', '2022-09-01 09:30:19'),
(53, 58, 'u8xhdmtkx9fnv6gvrymewv0n2dyvgm52vcji1a5np1l6fyor9rctliyinfzym235', 'I', 'sachin123', '', '', NULL, '', '', '2022-09-01 09:36:49', '2022-09-01 09:38:59'),
(54, 59, 'y961uchafjb1ws2uturpwop7ts7l67r4izro3aak3x2d05zeoowqorvy9kkdscla', 'I', 'sachin123', '', '', NULL, '', '', '2022-09-01 12:10:06', '2022-09-02 04:42:04'),
(55, 60, 'xei42kq94cy4lxy1d367dn280gngfya5m77dx7lwsxnfs2p5ea5hgcxwgcwi1ty6', 'I', 'nishant123', '', '', NULL, '', '', '2022-09-02 05:23:06', '2022-09-02 05:23:06'),
(56, 61, 'bzi6sz7daiev5vul2405ikry2a3zojiw1gqlawqoxkakao2js4dacgzs4p0kidm7', 'I', 'akash123', '', '', NULL, '', '', '2022-09-03 05:25:28', '2022-09-03 05:25:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_address`
--
ALTER TABLE `tbl_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_category`
--
ALTER TABLE `tbl_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_order_details`
--
ALTER TABLE `tbl_order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_otp`
--
ALTER TABLE `tbl_otp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_pro_fav`
--
ALTER TABLE `tbl_pro_fav`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_ratings`
--
ALTER TABLE `tbl_ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_store`
--
ALTER TABLE `tbl_store`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_subcategory`
--
ALTER TABLE `tbl_subcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_user_device`
--
ALTER TABLE `tbl_user_device`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_address`
--
ALTER TABLE `tbl_address`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_category`
--
ALTER TABLE `tbl_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_order_details`
--
ALTER TABLE `tbl_order_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_otp`
--
ALTER TABLE `tbl_otp`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_pro_fav`
--
ALTER TABLE `tbl_pro_fav`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_ratings`
--
ALTER TABLE `tbl_ratings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_store`
--
ALTER TABLE `tbl_store`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_subcategory`
--
ALTER TABLE `tbl_subcategory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `tbl_user_device`
--
ALTER TABLE `tbl_user_device`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
