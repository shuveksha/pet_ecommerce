-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2022 at 02:25 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `purrfectstorehouse`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `email`, `password`) VALUES
(1, 'admin@gmail.com', '1234'),
(2, 'admin2@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ordered_items`
--

CREATE TABLE `ordered_items` (
  `id` int(11) NOT NULL,
  `user_order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ordered_price` int(11) DEFAULT NULL,
  `ordered_quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `pid` int(11) NOT NULL,
  `pname` varchar(255) NOT NULL,
  `pprice` float(8,2) UNSIGNED NOT NULL,
  `pdiscription` varchar(255) NOT NULL,
  `pimage` varchar(255) NOT NULL,
  `pcategory` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`pid`, `pname`, `pprice`, `pdiscription`, `pimage`, `pcategory`) VALUES
(1, 'dog bed', 1000.00, 'comfy bed for dogs to sleep properly', 'assets/uploads/1c4d2081df9e7c5528f01e0e99f3d6b7', 'dog'),
(2, 'dog belt', 600.00, 'high quality belt for dogs ', 'assets/uploads/9745796309cf55caa25fd685fb3e1375', 'dog'),
(3, 'pet nail cutter', 300.00, 'trim your dog nails so it wont hurt you', 'assets/uploads/c63f50d1ae14b1b08535b6ab5cdd2c35', 'dog'),
(4, 'brush', 450.00, ' detangle your dog\'s hair before shower for smooth silky hair', 'assets/uploads/c0cbc5712bc1fdf9e83e3521de38951c', 'dog'),
(5, 'dog shoes', 720.00, 'shoes for you dog to go for walk without dirty feet', 'assets/uploads/5c20de9ffdf3ae28820e4ddf3882772d', 'dog'),
(6, 'leash', 700.00, 'take your dog anywhere comfortably in this leash ', 'assets/uploads/cf9047a27714bdd8e5dc4083b8cb3a04', 'dog'),
(7, 'dog bottle ', 500.00, 'feed your puppies when they get hungry ', 'assets/uploads/5dbb008c25ca5994ba6dd87d96a394c3', 'dog'),
(8, 'pet nail cutter (blue)', 350.00, 'trim your pet nails', 'assets/uploads/c5c8ae9bee8b5798deeb9bf194d3071f', 'dog'),
(9, 'leash size-xl color purple', 900.00, 'vfjjdfdklgrs;d', 'assets/uploads/17c894836b9c9eb0e4d684508365183f', 'dog'),
(10, 'brush size-small ', 200.00, 'dfgfd', 'assets/uploads/16482e944cfb425a399d919ae637f1f7', 'dog');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_address`
--

CREATE TABLE `shipping_address` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `name`, `user_password`, `user_email`) VALUES
(1, 'ipsha', '$2a$08$3Y315ioCN7MNqRDuCvzmxuE/s6vKVj5K6CT6CUu/yh9ev5pn6VPLO', 'ipsha@gmail.com'),
(2, 'tulsi', '$2a$08$6TERci2gSIYu1JDQLnQ9luC9sSqbk.5g9o9yElTUL4vFaOH9f/d5u', 'tulsi@gmail.com'),
(3, 'barsa', '$2a$08$Z6yLChszjMkRX3L8pwoC8uINm8hp40b1k.Q6sUEQ.0JsOTYfhZ9Oq', 'barsa@gmail.com'),
(4, 'anisha', '$2a$08$d9SPyhyP8.g8oHlJkGlLl.a2q5jH/pvTHaU.Y9UNIUs4u8B3zgMR.', 'anisha@gmail.com'),
(5, 'ipshatest', '$2a$08$jlYytuoNzfEYIfCPjUQxHusTdn9hpXc8sbkcBLuwhM0.ds/6nS9Du', 'ipshatest@gmail.com'),
(6, 'sample', '$2a$08$F7M4zBIsgeT5qy.k6UejtuYhkD7Aof8pBCKK7m.kndyid/C9lQtg6', 'sample@gmail.com'),
(7, '', '$2a$08$YxJ.2ZOGPaVnCh8Okg6e4OxJJgvXdblak4VlhWgwij9CiDiLKkfvS', 'admin@gmail.com'),
(8, 'suvi', '$2a$08$20gwxI/1A4Su3Vye7B0TOOR7KD1V3zqDm.7n1qnjhU44k1Cs.PqpC', 'shuveksha@gmail.com'),
(9, '', '$2a$08$X7nvMI44I.iWOKJt8E7JQOs1Jm9IxG43/qzO0ccLSFNyTEmMUAsXq', 'admin1@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `user_order`
--

CREATE TABLE `user_order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `shipping_address_id` int(11) NOT NULL,
  `order_status` varchar(15) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `ordered_items`
--
ALTER TABLE `ordered_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_order_id` (`user_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `shipping_address`
--
ALTER TABLE `shipping_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- Indexes for table `user_order`
--
ALTER TABLE `user_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `shipping_address_id` (`shipping_address_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordered_items`
--
ALTER TABLE `ordered_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `shipping_address`
--
ALTER TABLE `shipping_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user_order`
--
ALTER TABLE `user_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
