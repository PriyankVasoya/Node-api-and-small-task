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
-- Database: `db_bathroom_showcase`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contactus`
--

CREATE TABLE `tbl_contactus` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `message` varchar(128) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `inserted_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_faq`
--

CREATE TABLE `tbl_faq` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `inserted_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_place`
--

CREATE TABLE `tbl_place` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `location` varchar(128) DEFAULT NULL,
  `about` text DEFAULT NULL,
  `latitude` varchar(16) DEFAULT NULL,
  `longitude` varchar(16) DEFAULT NULL,
  `avg_rating` float(5,1) DEFAULT 0.0,
  `total_review` bigint(20) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `inserted_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_place`
--

INSERT INTO `tbl_place` (`id`, `user_id`, `location`, `about`, `latitude`, `longitude`, `avg_rating`, `total_review`, `is_active`, `inserted_at`, `updated_at`) VALUES
(49, 18, 'ahmedabad', 'it is an amazing place', '23.0225', '72.5714', 4.5, 1, 1, '2022-08-25 14:36:46', '2022-08-29 10:14:33'),
(50, 18, 'mumbai', 'it is an amazing place', '23.1225', '72.6714', 4.7, 1, 1, '2022-08-25 14:38:07', '2022-08-29 10:15:18'),
(51, 18, 'delhi', 'it is an amazing place', '23.5225', '72.5714', 3.4, 1, 1, '2022-08-25 14:38:49', '2022-08-29 10:15:23'),
(52, 18, 'chennai', 'it is an amazing place', '23.8225', '72.8714', 2.1, 1, 1, '2022-08-25 14:41:09', '2022-08-29 10:15:26'),
(53, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 5.0, 1, 1, '2022-08-26 05:02:54', '2022-08-29 10:15:28'),
(54, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 4.3, 1, 1, '2022-08-26 05:41:36', '2022-08-29 10:15:33'),
(55, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 0.0, 0, 1, '2022-08-26 05:42:56', '2022-08-26 05:42:56'),
(56, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 5.0, 1, 1, '2022-08-26 05:42:59', '2022-08-26 06:01:08'),
(57, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 4.5, 1, 1, '2022-08-26 06:24:05', '2022-08-26 07:35:40'),
(58, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 4.5, 1, 1, '2022-08-26 06:25:28', '2022-08-26 07:40:26'),
(59, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 4.2, 1, 1, '2022-08-26 06:26:03', '2022-08-27 07:31:33'),
(60, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 0.0, 0, 1, '2022-08-26 06:39:01', '2022-08-26 06:39:01'),
(61, 18, 'Surat', 'world\'s cleanest city', '123467', '123467', 0.0, 0, 1, '2022-08-27 07:18:05', '2022-08-27 07:18:05'),
(62, 20, 'Montreal', 'Montreal is the second-most populous city in Canada and most populous city in the Canadian province of Quebec.', '12.56.85', '75.85.96', 0.0, 0, 1, '2022-08-27 07:38:58', '2022-08-27 07:38:58'),
(63, 20, 'Montreal', 'Montreal is the second-most populous city in Canada and most populous city in the Canadian province of Quebec.', '12.56.85', '75.85.96', 0.0, 0, 1, '2022-08-27 07:41:55', '2022-08-27 07:41:55'),
(64, 19, 'Montreal', 'Montreal is the second-most populous city in Canada and most populous city in the Canadian province of Quebec.', '12.56.85', '75.85.96', 0.0, 0, 1, '2022-08-27 07:45:23', '2022-08-27 07:45:23'),
(66, 19, 'Montreal', 'Montreal is the second-most populous city in Canada and most populous city in the Canadian province of Quebec.', '12.56.85', '75.85.96', 3.8, 3, 1, '2022-08-27 07:48:39', '2022-08-27 10:55:29'),
(67, 19, 'Montreal', 'Montreal is the second-most populous city in Canada and most populous city in the Canadian province of Quebec.', '12.56.85', '75.85.96', 0.0, 0, 1, '2022-09-02 12:26:17', '2022-09-02 12:26:17'),
(68, 19, 'Montreal', 'Montreal is the second-most populous city in Canada and most populous city in the Canadian province of Quebec.', '12.56.85', '75.85.96', 0.0, 0, 1, '2022-09-05 05:08:37', '2022-09-05 05:08:37');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_place_image`
--

CREATE TABLE `tbl_place_image` (
  `id` bigint(20) NOT NULL,
  `place_id` bigint(20) DEFAULT NULL,
  `image` varchar(128) DEFAULT NULL,
  `inserted_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_place_image`
--

INSERT INTO `tbl_place_image` (`id`, `place_id`, `image`, `inserted_at`, `updated_at`) VALUES
(67, 61, 'image-2', '2022-08-27 07:18:05', '2022-08-27 07:18:05'),
(68, 61, 'image-3', '2022-08-27 07:18:05', '2022-08-27 07:18:05'),
(69, 62, 'a.jpj', '2022-08-27 07:38:58', '2022-08-27 07:38:58'),
(70, 62, 'b.jpj', '2022-08-27 07:38:58', '2022-08-27 07:38:58'),
(71, 62, 'c.jpj', '2022-08-27 07:38:58', '2022-08-27 07:38:58'),
(72, 63, 'image-1', '2022-08-27 07:41:55', '2022-08-27 07:41:55'),
(73, 63, 'image-2', '2022-08-27 07:41:55', '2022-08-27 07:41:55'),
(74, 63, 'image-3', '2022-08-27 07:41:55', '2022-08-27 07:41:55'),
(75, 64, 'image-1', '2022-08-27 07:45:23', '2022-08-27 07:45:23'),
(76, 64, 'image-2', '2022-08-27 07:45:23', '2022-08-27 07:45:23'),
(77, 64, 'image-3', '2022-08-27 07:45:23', '2022-08-27 07:45:23'),
(78, 65, 'image-1', '2022-08-27 07:47:03', '2022-08-27 07:47:03'),
(79, 65, 'image-2', '2022-08-27 07:47:03', '2022-08-27 07:47:03'),
(80, 65, 'image-3', '2022-08-27 07:47:03', '2022-08-27 07:47:03'),
(81, 66, 'image-1', '2022-08-27 07:48:39', '2022-08-27 07:48:39'),
(82, 66, 'image-2', '2022-08-27 07:48:39', '2022-08-27 07:48:39'),
(83, 66, 'image-3', '2022-08-27 07:48:39', '2022-08-27 07:48:39'),
(84, 67, 'image-1', '2022-09-02 12:26:17', '2022-09-02 12:26:17'),
(85, 67, 'image-2', '2022-09-02 12:26:17', '2022-09-02 12:26:17'),
(86, 67, 'image-3', '2022-09-02 12:26:17', '2022-09-02 12:26:17'),
(87, 68, 'image-1', '2022-09-05 05:08:37', '2022-09-05 05:08:37'),
(88, 68, 'image-2', '2022-09-05 05:08:37', '2022-09-05 05:08:37'),
(89, 68, 'image-3', '2022-09-05 05:08:37', '2022-09-05 05:08:37');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_review`
--

CREATE TABLE `tbl_review` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `place_id` bigint(20) DEFAULT NULL,
  `review` text DEFAULT NULL,
  `rating` float(2,1) NOT NULL DEFAULT 0.0,
  `is_active` tinyint(1) DEFAULT 1,
  `inserted_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_review`
--

INSERT INTO `tbl_review` (`id`, `user_id`, `place_id`, `review`, `rating`, `is_active`, `inserted_at`, `updated_at`) VALUES
(1, 18, 57, 'done', 4.5, 1, '2022-08-26 07:35:40', '2022-08-29 05:47:26'),
(2, 18, 56, 'ytruyjhy', 5.0, 1, '2022-08-26 06:01:08', '2022-08-26 06:01:08'),
(3, 18, 58, 'done', 4.5, 1, '2022-08-26 07:40:26', '2022-08-26 07:40:26'),
(4, 18, 59, 'good', 4.2, 1, '2022-08-27 07:31:33', '2022-08-27 07:31:33'),
(5, 18, 66, 'good', 4.2, 1, '2022-08-27 08:55:05', '2022-08-29 05:47:44'),
(6, 19, 66, 'good', 3.6, 1, '2022-08-27 10:30:23', '2022-08-27 10:30:23'),
(7, 19, 66, 'good', 3.6, 1, '2022-08-27 10:55:29', '2022-08-27 10:55:29');

--
-- Triggers `tbl_review`
--
DELIMITER $$
CREATE TRIGGER `tbl_review` AFTER INSERT ON `tbl_review` FOR EACH ROW BEGIN update `db_bathroom_showcase`.`tbl_place` 
set total_review = total_review + 1 , avg_rating = (select avg(rating) from tbl_review where tbl_review.place_id = tbl_place.id)
where id = new.place_id;
END
$$
DELIMITER ;

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
  `language` enum('en','fr') COLLATE utf8_unicode_ci NOT NULL COMMENT 'en -> English, fr -> French',
  `role` enum('User') COLLATE utf8_unicode_ci NOT NULL,
  `login` enum('login','logout') COLLATE utf8_unicode_ci NOT NULL,
  `profile_image` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
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

INSERT INTO `tbl_user` (`id`, `name`, `email`, `social_id`, `username`, `password`, `language`, `role`, `login`, `profile_image`, `rating`, `login_type`, `is_online`, `last_login`, `is_active`, `is_deleted`, `is_verify`, `insertdate`, `updatetime`) VALUES
(8, 'priyank', 'priyank@gmail.com', '', 'p123', 'RHdj3f6+5v63TGE1BShPUA==', 'en', '', 'login', 'default.png', 0.0, 'S', 0, '2022-08-23 19:22:32', 1, 0, 0, '2022-08-21 04:20:11', '2022-08-26 13:17:19'),
(9, 'priyank', 'priyank4751@gmail.com', '', 'p1gfdg23', 'DnrRtZaJTRhHU+yniG0v+w==', 'en', '', 'login', 'default.png', 0.0, 'S', 0, '0000-00-00 00:00:00', 1, 0, 0, '2022-08-22 06:12:39', '2022-08-27 07:11:45'),
(10, 'priyank', 'priyank9664@gmail.com', '', 'p1hj23', 'DnrRtZaJTRhHU+yniG0v+w==', 'en', '', 'login', 'default.png', 0.0, 'S', 1, '0000-00-00 00:00:00', 1, 0, 0, '2022-08-23 06:32:24', '2022-08-23 06:32:24'),
(11, 'meet', 'meet@gmail.com', '', 'meet123', 'X4wh8K5ph7Brr+IjJwW4Uw==', 'en', '', 'login', 'default.png', 0.0, 'S', 1, '2022-08-23 13:26:19', 1, 0, 0, '2022-08-23 07:41:56', '2022-08-23 07:56:19'),
(12, 'meet', 'meet12@gmail.com', '', 'meet3', 'X4wh8K5ph7Brr+IjJwW4Uw==', 'en', '', 'login', 'default.png', 0.0, 'S', 1, '0000-00-00 00:00:00', 1, 0, 0, '2022-08-23 08:10:01', '2022-08-23 08:10:01'),
(13, 'meet', 'meet312@gmail.com', '', 'meet33', 'X4wh8K5ph7Brr+IjJwW4Uw==', 'en', '', 'login', 'default.png', 0.0, 'S', 1, '0000-00-00 00:00:00', 1, 0, 0, '2022-08-23 08:16:44', '2022-08-23 08:16:44'),
(15, 'samir', 'samir312@gmail.com', '', 'samir33', '693i5sUW6fmMJpalY8pSCw==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '0000-00-00 00:00:00', 1, 0, 0, '2022-08-23 09:54:13', '2022-08-23 09:54:13'),
(16, 'priyank', 'priyankabc@gmail.com', '', 'pri123', 'DnrRtZaJTRhHU+yniG0v+w==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '2022-08-23 15:35:35', 1, 0, 0, '2022-08-23 10:03:40', '2022-08-23 10:05:35'),
(17, 'kirtesh', 'kirtesh@gmail.com', '', 'k123', 'Gp1Z3Xi6lEAxloTOglf0aA==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '2022-08-24 09:42:52', 1, 0, 0, '2022-08-24 03:57:50', '2022-08-24 04:12:52'),
(18, 'krish', 'krish@k.com', '', 'krish123', 'GDq9jzNpVQzohNY6TvMW6A==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '0000-00-00 00:00:00', 1, 0, 0, '2022-08-24 08:47:37', '2022-08-27 07:35:00'),
(19, 'jaimin', 'jaimin@gmail.com', '', 'jaimin123', 'Og3R9Wix/aPslsXyu+kQyw==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '0000-00-00 00:00:00', 1, 0, 0, '2022-08-26 09:56:00', '2022-08-26 09:56:00'),
(20, 'mauvlik', 'mav@gmail.com', '', 'm123', 'XusLfXyQBjr5gKC3Oaryeg==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '2022-09-02 15:42:05', 1, 0, 0, '2022-08-27 06:38:31', '2022-09-02 10:12:05'),
(21, 'mihir', 'mihir@gmail.com', 'mihir', 'mihir12', 'Lg6x5Ua3QcwNtIFCwydL9Q==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '2022-08-30 15:46:18', 1, 0, 0, '2022-08-30 04:22:39', '2022-09-02 09:49:34'),
(22, 'priyank', 'priyankvasoya@gmail.com', '', '', '3Ou/DihNrXNW59tNqXGOaw==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, NULL, 1, 0, 0, '2022-08-30 06:04:38', '2022-08-30 06:08:02'),
(23, 'priyank', 'priyankvasoya4751@gmail.com', NULL, '123abc', 'Lg6x5Ua3QcwNtIFCwydL9Q==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '2022-08-30 11:53:41', 1, 0, 0, '2022-08-30 06:13:50', '2022-08-30 06:23:41'),
(28, 'mihir', 'mihiDr@gmail.com', '', 'mihirF12', '3Ou/DihNrXNW59tNqXGOaw==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, NULL, 1, 0, 0, '2022-09-01 07:17:12', '2022-09-01 07:17:12'),
(31, 'akash', 'akash1@gmail.com', 'akash321', 'akash3211', 'DnrRtZaJTRhHU+yniG0v+w==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, '2022-09-02 15:32:26', 1, 0, 0, '2022-09-02 09:35:07', '2022-09-02 10:03:18'),
(33, 'akash', 'akash@gmail.com', 'akash321', 'akash321', '', 'en', 'User', 'login', 'default.png', 0.0, 'F', 1, '2022-09-03 15:24:24', 1, 0, 0, '2022-09-03 09:52:09', '2022-09-03 09:54:24'),
(35, 'nishant', 'nishant@gmail.com', 'nishant12345', 'nishant', '', 'en', 'User', 'login', 'default.png', 0.0, 'F', 1, NULL, 1, 0, 0, '2022-09-06 07:53:12', '2022-09-06 07:53:12'),
(36, 'sameer', 'sameer@gmail.com', '', 'sameer', 'Lg6x5Ua3QcwNtIFCwydL9Q==', 'en', 'User', 'login', 'default.png', 0.0, 'S', 1, NULL, 1, 0, 0, '2022-10-04 10:33:23', '2022-10-04 10:33:23');

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
(4, 6, '', 'A', 'fkjdsbfhbdjbh', '', '', '', '', '', '2022-08-20 06:47:26', '2022-08-20 06:47:26'),
(6, 7, 'jmjl85y1efmj2e95ph3hzdvi1uj7p4nav4l99psbjkagx65k4ef3wlqpwjszd1g4', 'A', 'fkjdsbfhbdjbh', '', '', '', '', '', '2022-08-20 06:59:24', '2022-08-20 06:59:24'),
(7, 8, '', 'A', '', '', '', '', '', '', '2022-08-21 04:20:11', '2022-08-26 13:17:19'),
(8, 9, '', 'A', '', '', '', '', '', '', '2022-08-22 06:12:39', '2022-08-27 07:11:45'),
(9, 10, '74oy9y3lo77suphnzypao35sqfo1qux73yb134psr3fmtd0eg86f1p4se689xoor', 'A', 'xvcbvbvcbv', '', '', '', '', '', '2022-08-23 06:32:24', '2022-08-23 06:32:24'),
(10, 11, '5ph90q3lkj5avq48wlvu2b32pb4alkb9cefn36s5kc13ralnb6jfv5ducye9wqxa', 'I', 'gbbhnjn', '', '', '', '', '', '2022-08-23 07:41:56', '2022-08-23 07:56:19'),
(11, 12, 'lz9vzmepnbd627gyuwjyandhzznszxdcdhe78u4q03kthpn49lqv5n1jkr6zrlyd', 'I', 'gbbhnjn', '', '', '', '', '', '2022-08-23 08:10:01', '2022-08-23 08:10:01'),
(12, 13, 'dy8hnpqh0n6sgf95z5qpmijrd4wogydi9okxiryh6cm9sjq5rpbtdypty2fpiiy4', 'I', 'gbbhnjn', '', '', '', '', '', '2022-08-23 08:16:45', '2022-08-23 08:16:45'),
(13, 14, '17e5kfs7eyesh1b91cypc13d0nbk20j31d7l1z9omdx9pxo2la26a2b3yzrlosq8', 'A', 'fkjdsbfhbdjbh', '', '', '', '', '', '2022-08-23 09:29:35', '2022-08-23 09:32:15'),
(14, 15, 'x4nmh23qkafp84ijuzdpwh09sx0pht8x1tcue9lgpr0il0vf714k8dnexo3p1w4u', 'I', 'bcvnvcngm', '', '', '', '', '', '2022-08-23 09:54:13', '2022-08-23 10:00:21'),
(15, 16, '86yf3htnz8busmllib03h9tvatjsze0jo8ppxy2xwihd69h6d8b3t59wfg48u4ez', 'A', 'fkjdsbfhbdjbh', '', '', NULL, '', '', '2022-08-23 10:03:41', '2022-08-23 10:05:35'),
(16, 17, 'i54t22qz9112jdi9a72xv4hivnry9fexv0kiuxvr4t8id9dpfkqfmzjhmtmr9vzg', 'A', 'bfhfghgj', '', '', NULL, '', '', '2022-08-24 03:57:51', '2022-08-24 04:12:52'),
(17, 18, 'ai6a1cioh20wha9c4he1ch5dfk6x9vhwo2go3at1e6gz1caav29e9x37ihzi67p2', 'A', 'vcbcbnf', '', '', NULL, '', '', '2022-08-24 08:47:37', '2022-08-24 08:47:37'),
(18, 19, 'v9514gxkei1amudg01puoqd2m75fy644859h66zqi07c4pzfo0qdoce38iig10nw', 'A', 'vcbbvbgfd', '', '', NULL, '', '', '2022-08-26 09:56:00', '2022-08-26 09:56:00'),
(19, 20, 'hrmvcco29qn57nixarvxm7be3glhsuo9rw47x2y4vvv8z6n9v1mymgc4w9k7zxwn', 'A', 'dfsdgdfgh', '', '', NULL, '', '', '2022-08-27 06:38:31', '2022-09-02 10:12:05'),
(20, 21, 'o36ujzr7ac73ylw0er9fzkr2arjbichwjnasfelcnebe2gp5pv9pcc9p9g8zav83', 'A', 'bvbvbcbn', '', '', NULL, '', '', '2022-08-30 04:22:39', '2022-08-30 10:16:18'),
(21, 22, 'eb1wude12vwkdiahq1obfjifpbz2z2ma2i3rxj0qz125bijtgw0a2asshzwpb75k', 'A', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:04:38', '2022-08-30 06:04:38'),
(22, 23, '7obsd3x7fdwhy3z0najcjeifyjx3xcb9dhi8fif7y3lkb54rctqycutix5xr9gvq', 'A', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:13:50', '2022-08-30 06:23:41'),
(23, 24, 'tzhvgn4pulxdsvfght5pp4qmwrjzlcybtxmi1twesrdexb4fyjyaiuy26ki2rdwr', 'I', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:48:46', '2022-08-30 06:48:46'),
(24, 25, 'xupn3rdyi68aw9y3wrpv2m32ezqhs1k11ufv6ua564fh17z9zu72smurelfym2ul', 'I', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:49:49', '2022-08-30 06:49:49'),
(25, 26, 'd42tro3fdh5s7pj0t4nutzpllu6qsfswbaas54itci1f1put0ch5uplnclmaajd0', 'I', 'fdstsgddy', '', '', NULL, '', '', '2022-08-30 06:50:30', '2022-08-30 06:50:30'),
(26, 27, 'z4bp8c7nzlty0jrsop4ojt8iof27fh1vfsglbh5avei3kdsjxtin5xkalmjpegji', 'A', 'bvbvbcbn', '', '', NULL, '', '', '2022-09-01 05:31:37', '2022-09-01 05:31:37'),
(27, 28, 'fqvrfkj3m0vwdo22n4g78flppz95zp5l871qoype7u0o7cvf3n8pu4zw1ljajmyq', 'A', 'bvbvbcbn', '', '', NULL, '', '', '2022-09-01 07:17:12', '2022-09-01 07:17:12'),
(28, 29, '1pex2pglhl7nv333zotfbsovyafjtazw0dmk9ion05w56yropq61vjfkxk0t76qa', 'I', 'akash123', '', '', NULL, '', '', '2022-09-02 09:28:29', '2022-09-02 09:28:29'),
(29, 30, 'wrr7d46d3padien2r0j0sxpnner79oec4vh7ik2p87x92srd82fp4f6kcqpcrhso', 'I', 'akash123', '', '', NULL, '', '', '2022-09-02 09:35:07', '2022-09-02 10:02:26'),
(30, 32, 'l9spkdtzrw3tpkww9zft8w8u8whmmp7jews3cgtbw8s15u71ck0cbqtg4jmmgq33', 'A', 'sameer', '', '', NULL, '', '', '2022-09-03 09:49:03', '2022-09-03 09:51:22'),
(31, 33, 'qgbpxa5fxfy8jed0l3cwf19ex3exrug7dp6h1nu21z27rh87zx6ifvxzfiyixeud', 'I', 'akash123', '', '', NULL, '', '', '2022-09-03 09:52:09', '2022-09-03 09:54:24'),
(32, 34, 'yzu37zrb8u6g1zpjxa7bh21jtqo0jwva22xtjnky1cg0oj0vpzpy44jr5zb372bt', 'I', 'nishant123', '', '', NULL, '', '', '2022-09-06 07:50:01', '2022-09-06 07:50:01'),
(33, 35, 'pq4j574eec3ult4izas5wq05f8ckfpv5s5fjjafzdtndpiwwfjkmd40zyc224xsr', 'I', 'nishant123', '', '', NULL, '', '', '2022-09-06 07:53:12', '2022-09-06 07:53:12'),
(34, 36, 'eblk30sdfqfebdl12lfnno41f5pxt55xjl3469c67cmvr8tp13nvpuolkydidhl7', 'A', 'sameer', '', '', NULL, '', '', '2022-10-04 10:33:23', '2022-10-04 10:33:23');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_otp_details`
--

CREATE TABLE `tbl_user_otp_details` (
  `id` bigint(20) NOT NULL,
  `code` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `mobile_number` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `otp` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `insertdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_contactus`
--
ALTER TABLE `tbl_contactus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkcu_userid` (`user_id`);

--
-- Indexes for table `tbl_faq`
--
ALTER TABLE `tbl_faq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkfaq_userid` (`user_id`);

--
-- Indexes for table `tbl_place`
--
ALTER TABLE `tbl_place`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_place_image`
--
ALTER TABLE `tbl_place_image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `place_fkk` (`place_id`);

--
-- Indexes for table `tbl_review`
--
ALTER TABLE `tbl_review`
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
-- Indexes for table `tbl_user_otp_details`
--
ALTER TABLE `tbl_user_otp_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_place`
--
ALTER TABLE `tbl_place`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `tbl_place_image`
--
ALTER TABLE `tbl_place_image`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `tbl_review`
--
ALTER TABLE `tbl_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `tbl_user_device`
--
ALTER TABLE `tbl_user_device`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `tbl_user_otp_details`
--
ALTER TABLE `tbl_user_otp_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
