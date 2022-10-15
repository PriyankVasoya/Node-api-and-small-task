-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 15, 2022 at 07:56 AM
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
-- Database: `db_glass`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cart`
--

CREATE TABLE `tbl_cart` (
  `id` bigint(20) NOT NULL,
  `glass_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `qty` int(11) NOT NULL,
  `sub_total` varchar(16) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_cart`
--

INSERT INTO `tbl_cart` (`id`, `glass_id`, `user_id`, `qty`, `sub_total`, `is_active`, `inserted_at`, `updated_at`) VALUES
(1, 1, 31, 1, '120.00', 1, '2022-09-12 06:00:23', '2022-09-12 06:00:23'),
(2, 2, 31, 2, '2400', 1, '2022-09-12 06:00:23', '2022-09-12 06:00:23'),
(3, 3, 31, 4, '400.00', 1, '2022-09-12 06:00:46', '2022-09-12 06:00:46');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_color`
--

CREATE TABLE `tbl_color` (
  `id` bigint(20) NOT NULL,
  `p_id` bigint(20) NOT NULL,
  `color` varchar(64) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_color`
--

INSERT INTO `tbl_color` (`id`, `p_id`, `color`, `is_active`, `inserted_at`, `updated_at`) VALUES
(1, 1, 'brown', 1, '2022-09-03 09:39:33', '2022-09-03 09:39:33'),
(2, 1, 'green\r\n', 1, '2022-09-03 09:39:33', '2022-09-03 09:39:33'),
(3, 1, 'black\r\n', 1, '2022-09-03 09:39:33', '2022-09-03 09:39:33');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_frame_size`
--

CREATE TABLE `tbl_frame_size` (
  `id` bigint(20) NOT NULL,
  `p_id` bigint(20) NOT NULL,
  `size` varchar(16) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_it` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_frame_size`
--

INSERT INTO `tbl_frame_size` (`id`, `p_id`, `size`, `is_active`, `created_at`, `updated_it`) VALUES
(1, 1, 'narrow', 1, '2022-09-03 11:24:03', '2022-09-03 11:50:18'),
(2, 4, 'extra narrow', 1, '2022-09-03 11:24:03', '2022-09-03 11:25:05'),
(3, 4, 'm narrow', 1, '2022-09-03 11:24:16', '2022-09-03 11:47:51');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_frame_width`
--

CREATE TABLE `tbl_frame_width` (
  `id` bigint(20) NOT NULL,
  `p_id` bigint(20) NOT NULL,
  `width` varchar(16) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_it` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_frame_width`
--

INSERT INTO `tbl_frame_width` (`id`, `p_id`, `width`, `is_active`, `created_at`, `updated_it`) VALUES
(1, 1, '129mm', 1, '2022-09-03 11:25:45', '2022-09-03 11:51:20'),
(2, 4, '115mm', 1, '2022-09-03 11:25:45', '2022-09-03 11:25:45'),
(3, 4, '100cm', 1, '2022-09-03 11:25:56', '2022-09-03 11:25:56');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_gender`
--

CREATE TABLE `tbl_gender` (
  `id` bigint(20) NOT NULL,
  `type` enum('m','f') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_gender`
--

INSERT INTO `tbl_gender` (`id`, `type`, `is_active`, `inserted_at`, `updated_at`) VALUES
(1, 'm', 1, '2022-07-30 12:33:34', '2022-09-03 06:28:04'),
(2, 'f', 1, '2022-09-03 06:28:23', '2022-09-03 06:28:23');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `service_charge` double(4,2) NOT NULL,
  `sub_total` varchar(16) NOT NULL,
  `grand_total` double(8,2) NOT NULL,
  `total` double(8,2) DEFAULT NULL,
  `order_status` enum('Order Placed','In Production','Shipping On Way','Deliverd','Cancelled') NOT NULL,
  `payment_method` enum('Cash','Online') NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_order`
--

INSERT INTO `tbl_order` (`id`, `user_id`, `product_id`, `service_charge`, `sub_total`, `grand_total`, `total`, `order_status`, `payment_method`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 31, 3, 50.00, '550', 350.00, 500.00, '', 'Online', 1, '2022-09-10 06:19:04', '2022-09-10 06:19:04'),
(2, 31, 3, 50.00, '550', 350.00, 500.00, '', 'Online', 1, '2022-09-10 06:23:01', '2022-09-10 06:23:01'),
(3, 31, 3, 50.00, '550', 350.00, 500.00, 'Order Placed', 'Online', 1, '2022-09-12 04:22:16', '2022-09-12 04:22:16'),
(4, 31, 3, 50.00, '550', 350.00, 500.00, 'Order Placed', 'Online', 1, '2022-09-12 04:22:52', '2022-09-12 04:22:52');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order_detail`
--

CREATE TABLE `tbl_order_detail` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `glasses_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double(8,2) NOT NULL,
  `sub_total` double(8,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_order_detail`
--

INSERT INTO `tbl_order_detail` (`id`, `user_id`, `order_id`, `glasses_id`, `quantity`, `price`, `sub_total`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 31, 1, 2, 5, 50.00, 250.00, 1, '2022-09-10 06:19:04', '2022-09-10 06:19:04'),
(2, 31, 1, 2, 6, 50.00, 300.00, 1, '2022-09-10 06:19:04', '2022-09-10 06:19:04'),
(3, 31, 2, 2, 5, 50.00, 250.00, 1, '2022-09-10 06:23:01', '2022-09-10 06:23:01'),
(4, 31, 2, 3, 6, 50.00, 300.00, 1, '2022-09-10 06:23:01', '2022-09-10 06:23:01'),
(5, 31, 3, 2, 5, 50.00, 250.00, 1, '2022-09-12 04:22:16', '2022-09-12 04:22:16'),
(6, 31, 3, 2, 6, 50.00, 300.00, 1, '2022-09-12 04:22:16', '2022-09-12 04:22:16'),
(7, 31, 4, 2, 5, 50.00, 250.00, 1, '2022-09-12 04:22:52', '2022-09-12 04:22:52'),
(8, 31, 4, 2, 6, 50.00, 300.00, 1, '2022-09-12 04:22:52', '2022-09-12 04:22:52');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

CREATE TABLE `tbl_product` (
  `id` bigint(20) NOT NULL,
  `type_id` bigint(20) NOT NULL,
  `name` varchar(128) NOT NULL,
  `image` varchar(128) NOT NULL,
  `about` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `frame_size` text NOT NULL,
  `frame_width` int(11) NOT NULL,
  `avg_ratings` float(2,1) NOT NULL DEFAULT 0.0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`id`, `type_id`, `name`, `image`, `about`, `price`, `frame_size`, `frame_width`, `avg_ratings`, `is_active`, `inserted_at`, `updated_at`) VALUES
(1, 4, 'brown rec.', 'a.jpg', 'good', '120.00', '12.5', 12, 2.5, 1, '2022-07-30 12:34:30', '2022-09-03 09:35:05'),
(2, 4, 'yellow rec.', 'b.jpg', 'good', '1200.00', '11', 12, 4.5, 1, '2022-07-30 12:34:30', '2022-09-03 09:35:20'),
(3, 4, 'green rec.', 'c.jpg', 'good', '100.00', '10', 12, 4.0, 1, '2022-07-30 12:34:30', '2022-09-03 09:35:26');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pro_image`
--

CREATE TABLE `tbl_pro_image` (
  `id` bigint(20) NOT NULL,
  `p_id` bigint(20) NOT NULL,
  `imagee` varchar(128) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_pro_image`
--

INSERT INTO `tbl_pro_image` (`id`, `p_id`, `imagee`, `is_active`, `inserted_at`, `updatedAt`) VALUES
(1, 1, '1.jpg', 1, '2022-09-03 09:38:00', '2022-09-03 12:21:03'),
(2, 1, '2.jpg', 1, '2022-09-03 09:38:00', '2022-09-03 12:21:03');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_rating`
--

CREATE TABLE `tbl_rating` (
  `id` bigint(20) NOT NULL,
  `u_id` bigint(20) NOT NULL,
  `p_id` bigint(20) NOT NULL,
  `rating` float NOT NULL,
  `insertedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upadated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_type`
--

CREATE TABLE `tbl_type` (
  `id` bigint(20) NOT NULL,
  `gen_id` bigint(20) NOT NULL,
  `name` varchar(128) NOT NULL,
  `image` varchar(128) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_type`
--

INSERT INTO `tbl_type` (`id`, `gen_id`, `name`, `image`, `is_active`, `inserted_at`, `updated_at`) VALUES
(1, 1, 'rimmed', '1.jpg', 1, '2022-07-30 12:33:54', '2022-09-03 06:31:44'),
(2, 1, 'rimless', '2.jpg', 1, '2022-09-03 06:33:18', '2022-09-03 06:33:18'),
(3, 1, 'semi-rimmed', '3.jpg\r\n', 1, '2022-09-03 06:33:46', '2022-09-03 06:33:46'),
(4, 2, 'eye glass', '4.jpg\r\n', 1, '2022-09-03 06:34:19', '2022-09-03 06:34:19'),
(5, 2, 'sun glasses', '5.jpg', 1, '2022-09-03 06:34:58', '2022-09-03 06:34:58'),
(6, 2, 'avitor', '6.jpg', 1, '2022-09-03 06:34:58', '2022-09-03 06:34:58');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id` bigint(20) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `social_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '+91',
  `mobile` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `language` enum('en','fr') COLLATE utf8_unicode_ci NOT NULL COMMENT 'en -> English, fr -> French',
  `role` enum('User') COLLATE utf8_unicode_ci NOT NULL,
  `login` enum('login','logout') COLLATE utf8_unicode_ci NOT NULL,
  `profile_image` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rating` float(2,1) DEFAULT 0.0,
  `login_type` enum('S','F','G') COLLATE utf8_unicode_ci NOT NULL COMMENT 'S -> Simple Signup',
  `is_online` tinyint(1) NOT NULL DEFAULT 0,
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_verify` tinyint(1) NOT NULL DEFAULT 0,
  `insertdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`id`, `name`, `email`, `social_id`, `username`, `password`, `code`, `mobile`, `language`, `role`, `login`, `profile_image`, `rating`, `login_type`, `is_online`, `last_login`, `is_active`, `is_deleted`, `is_verify`, `insertdate`, `updatetime`) VALUES
(31, 'akash', 'akash@gmail.com', 'akash321', 'akash321', '', '+91', '9595959595', 'en', 'User', 'login', NULL, 0.0, 'F', 1, '2022-09-03 14:59:53', 1, 0, 0, '2022-09-03 05:49:58', '2022-09-05 04:49:39');

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
(30, 31, 'eubuv3mzxerr3daw6waqzu9q1jovcqr00cg3asiealogsl8l5320csq0jb6iaea8', 'I', 'akash123', '', '', NULL, '', '', '2022-09-03 05:49:58', '2022-09-03 09:29:53');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_otp_details`
--

CREATE TABLE `tbl_user_otp_details` (
  `id` bigint(20) NOT NULL,
  `code` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `otp` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `insertdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_user_otp_details`
--

INSERT INTO `tbl_user_otp_details` (`id`, `code`, `mobile`, `otp`, `insertdate`, `updatetime`) VALUES
(1, '+91', '9595959595', '4252', '2022-09-05 09:05:03', '2022-09-07 13:02:51'),
(2, '+91', '7897897890', '', '2022-09-05 09:46:57', '2022-09-05 12:23:43'),
(3, '+91', '6565656565', '6268', '2022-09-07 13:07:25', '2022-09-08 05:54:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_color`
--
ALTER TABLE `tbl_color`
  ADD PRIMARY KEY (`id`),
  ADD KEY `p_id` (`p_id`);

--
-- Indexes for table `tbl_frame_size`
--
ALTER TABLE `tbl_frame_size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_frame_width`
--
ALTER TABLE `tbl_frame_width`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_gender`
--
ALTER TABLE `tbl_gender`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_order_detail`
--
ALTER TABLE `tbl_order_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `tbl_pro_image`
--
ALTER TABLE `tbl_pro_image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `p_id` (`p_id`);

--
-- Indexes for table `tbl_rating`
--
ALTER TABLE `tbl_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `u_id` (`u_id`),
  ADD KEY `p_id` (`p_id`);

--
-- Indexes for table `tbl_type`
--
ALTER TABLE `tbl_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gen_id` (`gen_id`);

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
-- Indexes for table `tbl_user_otp_details`
--
ALTER TABLE `tbl_user_otp_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_color`
--
ALTER TABLE `tbl_color`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_frame_size`
--
ALTER TABLE `tbl_frame_size`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_frame_width`
--
ALTER TABLE `tbl_frame_width`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_gender`
--
ALTER TABLE `tbl_gender`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_order_detail`
--
ALTER TABLE `tbl_order_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_pro_image`
--
ALTER TABLE `tbl_pro_image`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_rating`
--
ALTER TABLE `tbl_rating`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_type`
--
ALTER TABLE `tbl_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `tbl_user_device`
--
ALTER TABLE `tbl_user_device`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tbl_user_otp_details`
--
ALTER TABLE `tbl_user_otp_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_color`
--
ALTER TABLE `tbl_color`
  ADD CONSTRAINT `tbl_color_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `tbl_product` (`id`);

--
-- Constraints for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD CONSTRAINT `tbl_product_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `tbl_type` (`id`);

--
-- Constraints for table `tbl_rating`
--
ALTER TABLE `tbl_rating`
  ADD CONSTRAINT `tbl_rating_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `tbl_user` (`id`);

--
-- Constraints for table `tbl_type`
--
ALTER TABLE `tbl_type`
  ADD CONSTRAINT `tbl_type_ibfk_1` FOREIGN KEY (`gen_id`) REFERENCES `tbl_gender` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
