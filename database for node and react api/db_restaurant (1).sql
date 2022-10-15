-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 15, 2022 at 07:57 AM
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
-- Database: `db_restaurant`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_address`
--

CREATE TABLE `tbl_address` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `del_location` enum('Home','Office','Others') NOT NULL,
  `longitude` varchar(16) NOT NULL,
  `latitude` varchar(16) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_address`
--

INSERT INTO `tbl_address` (`id`, `user_id`, `del_location`, `longitude`, `latitude`, `created_at`, `updated_at`) VALUES
(1, 1, 'Home', '72.5714', '23.0225', '2022-07-28 06:19:34', '2022-07-28 22:39:08'),
(2, 1, 'Office', '77.5714', '24.0225', '2022-07-28 06:19:34', '2022-07-28 22:39:08'),
(3, 1, 'Home', '79.5714', '79.5714', '2022-07-28 06:19:34', '2022-07-28 22:39:08');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cuisine`
--

CREATE TABLE `tbl_cuisine` (
  `id` bigint(20) NOT NULL,
  `cui_name` varchar(64) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_cuisine`
--

INSERT INTO `tbl_cuisine` (`id`, `cui_name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Indian', 1, '2022-07-28 16:26:20', '2022-07-28 16:26:20'),
(2, 'Korean', 1, '2022-07-28 16:26:20', '2022-07-28 16:26:20'),
(3, 'Italian', 1, '2022-07-28 16:26:20', '2022-07-28 16:26:20'),
(4, 'Indian', 1, '2022-07-28 18:25:38', '2022-07-28 18:25:38'),
(5, 'Korean', 1, '2022-07-28 18:25:38', '2022-07-28 18:25:38'),
(6, 'Italian', 1, '2022-07-28 18:25:38', '2022-07-28 18:25:38'),
(7, 'American', 1, '2022-07-28 18:25:38', '2022-07-28 18:25:38'),
(8, 'Mexican', 1, '2022-07-28 18:25:38', '2022-07-28 18:25:38');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dish`
--

CREATE TABLE `tbl_dish` (
  `id` bigint(20) NOT NULL,
  `res_id` bigint(20) NOT NULL,
  `cui_id` bigint(20) NOT NULL,
  `image` varchar(256) NOT NULL,
  `name` varchar(64) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `about` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_dish`
--

INSERT INTO `tbl_dish` (`id`, `res_id`, `cui_id`, `image`, `name`, `price`, `about`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '1.jpeg', 'Chhole Bhature.', '50.00', 'good', 1, '2022-07-28 16:32:16', '2022-07-28 21:57:46'),
(2, 1, 2, '2.jpeg', 'Paneer Tikka.', '100.00', 'excellent', 1, '2022-07-28 16:32:16', '2022-09-12 12:49:33'),
(3, 3, 3, '3.jpeg', 'Dhosa.', '500.00', 'avarage', 1, '2022-07-28 16:32:16', '2022-07-28 21:57:46'),
(4, 4, 4, '4.jpeg', 'Pizza.', '545.00', 'excellent', 1, '2022-07-28 18:27:13', '2022-07-28 21:57:46'),
(5, 5, 5, '5.jpeg', 'Burger.', '250.00', 'avarage', 1, '2022-07-28 18:27:13', '2022-07-28 21:57:46');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `id` bigint(20) NOT NULL,
  `res_id` bigint(20) NOT NULL,
  `dish_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_no` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `sub_total` double(16,2) NOT NULL,
  `service_charge` double(8,2) NOT NULL,
  `discount_amount` int(11) NOT NULL,
  `grand_total` double(16,2) NOT NULL,
  `status` enum('Pending','Prepared','Out for deliver','Delivered') NOT NULL,
  `promocode` varchar(32) NOT NULL,
  `payment_method` enum('Cash','Online') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_order`
--

INSERT INTO `tbl_order` (`id`, `res_id`, `dish_id`, `user_id`, `order_no`, `quantity`, `total`, `sub_total`, `service_charge`, `discount_amount`, `grand_total`, `status`, `promocode`, `payment_method`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 3, 123, 3, 100, 300.00, 20.00, 100, 220.00, 'Delivered', 'FIRST50', 'Cash', 1, '2022-07-28 16:58:38', '2022-07-28 16:58:38'),
(2, 2, 1, 2, 124, 2, 200, 400.00, 40.00, 100, 340.00, 'Prepared', 'NONE', 'Online', 1, '2022-07-28 16:58:38', '2022-07-28 16:58:38'),
(3, 3, 3, 1, 125, 1, 200, 200.00, 30.00, 100, 130.00, 'Pending', 'OKAY', 'Cash', 1, '2022-07-28 16:58:38', '2022-07-28 16:58:38');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order_detail`
--

CREATE TABLE `tbl_order_detail` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `res_id` bigint(20) NOT NULL,
  `dish_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double(16,2) NOT NULL,
  `sub_total` double(16,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_order_detail`
--

INSERT INTO `tbl_order_detail` (`id`, `order_id`, `res_id`, `dish_id`, `quantity`, `price`, `sub_total`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 2, 3, 100.00, 300.00, '2022-07-28 17:05:55', '2022-07-28 17:05:55'),
(2, 1, 2, 1, 2, 200.00, 400.00, '2022-07-28 17:05:55', '2022-07-28 17:05:55'),
(3, 3, 3, 3, 1, 200.00, 200.00, '2022-07-28 17:05:55', '2022-07-28 17:05:55'),
(4, 2, 1, 2, 3, 100.00, 300.00, '2022-07-28 17:10:09', '2022-07-28 17:10:09'),
(5, 1, 2, 1, 2, 200.00, 400.00, '2022-07-28 17:10:09', '2022-07-28 17:10:09'),
(6, 3, 3, 3, 1, 200.00, 200.00, '2022-07-28 17:10:09', '2022-07-28 17:10:09'),
(7, 1, 1, 1, 3, 300.00, 900.00, '2022-07-30 10:18:05', '2022-07-30 10:18:05');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_resta_detail`
--

CREATE TABLE `tbl_resta_detail` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `location` varchar(256) NOT NULL,
  `latitude` varchar(16) NOT NULL,
  `longitude` varchar(16) NOT NULL,
  `image` varchar(256) NOT NULL,
  `avg_rating` double(2,1) NOT NULL,
  `total_review` int(11) NOT NULL,
  `about` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_resta_detail`
--

INSERT INTO `tbl_resta_detail` (`id`, `name`, `location`, `latitude`, `longitude`, `image`, `avg_rating`, `total_review`, `about`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Polo Bar', 'ahmedabad', '23.0225', '72.5714', '1.jpej', 2.3, 106, 'delicious', 1, '2022-07-28 16:20:32', '2022-07-30 09:56:32'),
(2, 'The Salad Life', 'ahmedabad', '22.0225', '73.5714', '2.jpej', 5.4, 305, 'mouthwatering', 1, '2022-07-28 16:20:32', '2022-09-06 15:07:34'),
(3, 'Tuscany Courtyard', 'bhavnagar', '24.0225', '72.7714', '3.jpej', 4.2, 69, 'delectable', 1, '2022-07-28 16:20:32', '2022-07-29 09:26:13'),
(4, 'Grill & Chill', 'junagadh', '25.7586', '78.9685', '4.jpej', 3.8, 64, 'mouthwatering', 1, '2022-07-28 18:21:50', '2022-07-29 09:26:13'),
(5, 'Dine In a Dime', 'vadodara', '23.0225', '72.5538', '5.jpej', 3.5, 51, 'delicious', 1, '2022-07-28 18:21:50', '2022-07-29 09:26:13');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_review`
--

CREATE TABLE `tbl_review` (
  `id` bigint(20) NOT NULL,
  `res_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `review` text DEFAULT NULL,
  `rating` double(2,1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_review`
--

INSERT INTO `tbl_review` (`id`, `res_id`, `user_id`, `review`, `rating`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '8jjjij', 2.0, 1, '2022-07-28 16:23:15', '2022-07-28 21:16:09'),
(2, 1, 2, 'gttgtb', 2.3, 1, '2022-07-28 16:23:15', '2022-07-28 21:16:09'),
(3, 3, 3, 'hnun', 5.6, 1, '2022-07-28 16:23:15', '2022-07-28 21:16:09'),
(4, 1, 2, 'sd', 2.3, 1, '2022-07-28 17:37:17', '2022-07-28 17:37:17'),
(20, 4, 2, 'j ccj cfcf ', 2.5, 1, '2022-07-28 21:18:02', '2022-07-28 21:18:02'),
(21, 4, 2, 'j cfnvevv cj cfcf ', 4.5, 1, '2022-07-28 21:19:21', '2022-07-28 21:19:21'),
(22, 4, 2, 'j cfnvevv cj cfcf ', 4.5, 1, '2022-07-28 21:19:55', '2022-07-28 21:19:55'),
(23, 1, 1, 'shvjkvhd', 2.3, 1, '2022-07-30 09:56:32', '2022-07-30 09:56:32');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_time`
--

CREATE TABLE `tbl_time` (
  `id` bigint(20) NOT NULL,
  `res_id` bigint(20) NOT NULL,
  `open_time` time NOT NULL,
  `close_time` time NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_time`
--

INSERT INTO `tbl_time` (`id`, `res_id`, `open_time`, `close_time`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, '11:30:00', '10:00:00', 1, '2022-07-28 18:27:59', '2022-07-28 22:14:56'),
(2, 2, '11:30:00', '10:00:00', 1, '2022-07-28 18:27:59', '2022-07-28 22:14:56'),
(3, 3, '10:00:00', '05:00:00', 1, '2022-07-28 18:27:59', '2022-07-28 22:14:56');

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
  `mobile_no` varchar(16) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `profile_image` varchar(256) NOT NULL,
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

INSERT INTO `tbl_user` (`id`, `name`, `email`, `social_id`, `username`, `mobile_no`, `password`, `profile_image`, `role`, `latitude`, `longitude`, `language`, `login`, `login_type`, `is_online`, `last_login`, `is_deleted`, `is_verify`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'nishant', 'nishant@gmail.com', 'nishant12345', 'nishant', NULL, '', 'default.png', 'User', NULL, NULL, NULL, NULL, 'F', 1, '2022-09-06 14:28:11', 0, 0, 1, '2022-09-06 08:48:35', '2022-09-06 08:58:11');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_device`
--

CREATE TABLE `tbl_user_device` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_type` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `device_token` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `uuid` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `os_version` varchar(8) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `insertdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_user_device`
--

INSERT INTO `tbl_user_device` (`id`, `user_id`, `token`, `device_type`, `device_token`, `uuid`, `os_version`, `device_name`, `model_name`, `ip`, `insertdate`, `updatetime`) VALUES
(2, 2, 'yrs32tpmyj8uv74a5j5fpfirvaal1jxk1zy9qvqzinkkgn1z8rv8t1ifqoo3sccf', 'I', 'nishant123', '', '', NULL, '', '', '2022-09-06 08:47:57', '2022-09-06 08:47:57'),
(3, 1, '50pn7rrbpbmx82bnchjwi43w394hr8nmfrdwy0nmwx0sby2t55kl1g2xqk6gqaio', 'I', 'nishant123', '', '', NULL, '', '', '2022-09-06 08:48:35', '2022-09-06 08:58:11');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_otp_details`
--

CREATE TABLE `tbl_user_otp_details` (
  `id` bigint(20) NOT NULL,
  `code` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `otp` varchar(8) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `insertdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_address`
--
ALTER TABLE `tbl_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_cuisine`
--
ALTER TABLE `tbl_cuisine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_dish`
--
ALTER TABLE `tbl_dish`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tbl_dish_1_idx` (`res_id`),
  ADD KEY `fk_tbl_dish_2_idx` (`cui_id`);

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_order_detail`
--
ALTER TABLE `tbl_order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tbl_order_detail_1_idx` (`dish_id`),
  ADD KEY `fk_tbl_order_detail_2_idx` (`res_id`),
  ADD KEY `fk_tbl_order_detail_3_idx` (`order_id`);

--
-- Indexes for table `tbl_resta_detail`
--
ALTER TABLE `tbl_resta_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_review`
--
ALTER TABLE `tbl_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_time`
--
ALTER TABLE `tbl_time`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tbl_time_1_idx` (`res_id`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_cuisine`
--
ALTER TABLE `tbl_cuisine`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_dish`
--
ALTER TABLE `tbl_dish`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_order_detail`
--
ALTER TABLE `tbl_order_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_resta_detail`
--
ALTER TABLE `tbl_resta_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_review`
--
ALTER TABLE `tbl_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tbl_time`
--
ALTER TABLE `tbl_time`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_user_device`
--
ALTER TABLE `tbl_user_device`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_dish`
--
ALTER TABLE `tbl_dish`
  ADD CONSTRAINT `fk_tbl_dish_1` FOREIGN KEY (`res_id`) REFERENCES `tbl_resta_detail` (`id`),
  ADD CONSTRAINT `fk_tbl_dish_2` FOREIGN KEY (`cui_id`) REFERENCES `tbl_cuisine` (`id`);

--
-- Constraints for table `tbl_order_detail`
--
ALTER TABLE `tbl_order_detail`
  ADD CONSTRAINT `fk_tbl_order_detail_1` FOREIGN KEY (`dish_id`) REFERENCES `tbl_dish` (`id`),
  ADD CONSTRAINT `fk_tbl_order_detail_2` FOREIGN KEY (`res_id`) REFERENCES `tbl_resta_detail` (`id`),
  ADD CONSTRAINT `fk_tbl_order_detail_3` FOREIGN KEY (`order_id`) REFERENCES `tbl_order` (`id`);

--
-- Constraints for table `tbl_time`
--
ALTER TABLE `tbl_time`
  ADD CONSTRAINT `fk_tbl_time_1` FOREIGN KEY (`res_id`) REFERENCES `tbl_resta_detail` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
