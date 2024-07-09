-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 09, 2024 at 03:48 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `techHaven`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `city`, `town`, `address`, `phone_number`, `comment`, `created_at`) VALUES
(4, 'test', 'test', 'test 1', '2343232', 'test 1', '2024-07-09 13:36:16'),
(5, 'Sulaymaniyah', 'Sarchnar', 'Sulaymaniyah srhnar', '7507145127', 'la kotaye eshy krd', '2024-07-09 13:42:49'),
(6, 'wdw d', 'we’d d', 'dw dw', '1232123', ' wdw dens ', '2024-07-09 13:45:05'),
(7, 'Test2', 'Test2', 'Test2 address', '123432123', 'Test2 omments', '2024-07-09 13:46:37');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `total_price`) VALUES
(1, 4, NULL, 3, 23750.00, 71250.00),
(2, 5, NULL, 3, 5000.00, 15000.00),
(5, 7, NULL, 6, 5000.00, 30000.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productDescription` text DEFAULT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productImage` varchar(255) DEFAULT NULL,
  `productCode` varchar(50) DEFAULT NULL,
  `productStatus` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `productColor` varchar(255) DEFAULT NULL,
  `productSize` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `productName`, `productDescription`, `productPrice`, `productImage`, `productCode`, `productStatus`, `category`, `created_at`, `updated_at`, `productColor`, `productSize`) VALUES
(2, 'LOOSE-FITTING DARTED TROUSERS', 'High-waist trousers with belt loops. Featuring side pockets and rear welt pockets. Darts on the front. Front zip and top button fastening.', 23750.00, 'http://localhost:3000/uploads/1720457665261.jpg', '2', 'complete', 'WOMEN', '2024-07-08 16:54:25', '2024-07-08 16:59:27', 'brown - black', 'XS - S - M - L '),
(3, 'Dress', 'VOID Dress for pretty', 28000.00, 'http://localhost:3000/uploads/1720470415050.jpg', '3', 'pending', 'WOMEN', '2024-07-08 20:26:55', '2024-07-08 20:26:55', 'purple - blue.shade700- brown - black', 'XS - S - M - L - XL'),
(5, 'Pants', 'VOID pant for mnes', 18000.00, 'http://localhost:3000/uploads/1720470544399.jpg', '4', 'pending', 'MEN', '2024-07-08 20:29:04', '2024-07-08 20:29:35', 'blue.shade900 - brown - black- white', 'XS - S - M - L - XL - XXL'),
(6, 'Dress', 'dressy hawina gulldar', 14000.00, 'http://localhost:3000/uploads/1720470689790.jpeg', '5', 'pending', 'KIDS', '2024-07-08 20:31:29', '2024-07-08 20:31:29', 'blue.shade700 - brown - black- white - purple', 'XS - S - M - L - XL - XXL'),
(7, 'Hood', 'Hood bo mndallan', 3000.00, 'http://localhost:3000/uploads/1720470772392.jpg', '6', 'pending', 'KIDS', '2024-07-08 20:32:52', '2024-07-08 20:32:52', 'blue.shade700 - brown - black- white', 'XS - S - M - L - XL - XXL'),
(8, 'Bon', 'Bon', 5000.00, 'http://localhost:3000/uploads/1720471088943.jpg', '7', 'pending', 'LCW HOME', '2024-07-08 20:38:08', '2024-07-08 20:38:08', 'blue.shade700 - brown - black- white - red - orange', 'none'),
(9, 'bard', 'bard', 5000.00, 'http://localhost:3000/uploads/1720471131702.jpg', '8', 'pending', 'LCW HOME', '2024-07-08 20:38:51', '2024-07-08 20:38:51', 'brown - black- white - red - orange', 'none'),
(10, 'bon', 'bony spra', 5000.00, 'http://localhost:3000/uploads/1720471186639.jpg', '8', 'pending', 'LCW HOME', '2024-07-08 20:39:46', '2024-07-08 20:39:46', 'brown - black- white - red - orange', 'none');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
