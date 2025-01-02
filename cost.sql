-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2025 at 05:51 PM
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
-- Database: `cost`
--
CREATE DATABASE IF NOT EXISTS `cost` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cost`;

-- --------------------------------------------------------

--
-- Table structure for table `allocation_base`
--

CREATE TABLE `allocation_base` (
  `allocation_base_id` int(11) NOT NULL,
  `base_name` varchar(255) NOT NULL,
  `base_type` enum('Labor_Hours','Machine_Hours','Square_Feet') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `allocation_base`
--

INSERT INTO `allocation_base` (`allocation_base_id`, `base_name`, `base_type`) VALUES
(1, 'Labor Hours', 'Labor_Hours');

-- --------------------------------------------------------

--
-- Table structure for table `annual_demand`
--

CREATE TABLE `annual_demand` (
  `demand_id` int(11) NOT NULL,
  `cost_element_id` int(11) NOT NULL,
  `annual_demand` int(11) NOT NULL,
  `last_updated` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE `budget` (
  `budget_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `total_budget` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `budgeted_cost`
--

CREATE TABLE `budgeted_cost` (
  `budgeted_cost_id` int(11) NOT NULL,
  `cost_element_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `budgeted_amount` decimal(15,2) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `budgeted_cost`
--

INSERT INTO `budgeted_cost` (`budgeted_cost_id`, `cost_element_id`, `project_id`, `budgeted_amount`, `description`) VALUES
(1, 1, 1, 2000.00, 'Cost allocated to equipment ');

-- --------------------------------------------------------

--
-- Table structure for table `companydetails`
--

CREATE TABLE `companydetails` (
  `company_id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `financial_year_start` date NOT NULL,
  `mailing_name` varchar(255) DEFAULT NULL,
  `books_start` date NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT 'India',
  `pincode` varchar(10) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `base_currency_symbol` varchar(10) DEFAULT '₹',
  `formal_currency_name` varchar(10) DEFAULT 'INR'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companydetails`
--

INSERT INTO `companydetails` (`company_id`, `company_name`, `financial_year_start`, `mailing_name`, `books_start`, `address`, `state`, `country`, `pincode`, `telephone`, `mobile`, `fax`, `email`, `website`, `base_currency_symbol`, `formal_currency_name`) VALUES
(1, 'Rolex pvt ltd', '2024-11-01', 'Rolex', '2024-11-13', 'Pune', 'Maharashtra', 'India', '411044', '2382746', '9379812389', '234535', 'rolex@gmail.com', 'http://www.rolex.com', '₹', 'INR');

-- --------------------------------------------------------

--
-- Table structure for table `company_budget`
--

CREATE TABLE `company_budget` (
  `id` int(11) NOT NULL,
  `year` int(100) DEFAULT NULL,
  `sales_revenue` decimal(15,2) NOT NULL,
  `other_income` decimal(15,2) NOT NULL,
  `cogs` decimal(15,2) NOT NULL,
  `salaries_wages` decimal(15,2) NOT NULL,
  `rent_utilities` decimal(15,2) NOT NULL,
  `office_supplies` decimal(15,2) NOT NULL,
  `marketing` decimal(15,2) NOT NULL,
  `insurance` decimal(15,2) NOT NULL,
  `travel_entertainment` decimal(15,2) NOT NULL,
  `depreciation` decimal(15,2) NOT NULL,
  `lease_payments` decimal(15,2) NOT NULL,
  `asset_purchases` decimal(15,2) NOT NULL,
  `renovation_costs` decimal(15,2) NOT NULL,
  `income_tax` decimal(15,2) NOT NULL,
  `other_taxes` decimal(15,2) NOT NULL,
  `debt_repayments` decimal(15,2) NOT NULL,
  `cash_flow_forecast` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_budget`
--

INSERT INTO `company_budget` (`id`, `year`, `sales_revenue`, `other_income`, `cogs`, `salaries_wages`, `rent_utilities`, `office_supplies`, `marketing`, `insurance`, `travel_entertainment`, `depreciation`, `lease_payments`, `asset_purchases`, `renovation_costs`, `income_tax`, `other_taxes`, `debt_repayments`, `cash_flow_forecast`, `created_at`) VALUES
(1, 2023, 10000.00, 2000.00, 100.00, 200.00, 100.00, 100.00, 200.00, 300.00, 100.00, 100.00, 200.00, 200.00, 300.00, 100.00, 100.00, 200.00, 300.00, '2024-11-12 19:21:34'),
(2, 2024, 20000.00, 3000.00, 100.00, 300.00, 300.00, 400.00, 500.00, 300.00, 300.00, 1000.00, 200.00, 200.00, 100.00, 300.00, 200.00, 300.00, 200.00, '2024-11-12 19:28:04');

-- --------------------------------------------------------

--
-- Table structure for table `cost_calculation`
--

CREATE TABLE `cost_calculation` (
  `cost_calculation_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `total_direct_cost` decimal(15,2) DEFAULT NULL,
  `total_indirect_cost` decimal(15,2) DEFAULT NULL,
  `total_overhead_cost` decimal(15,2) DEFAULT NULL,
  `total_cost` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cost_calculation`
--

INSERT INTO `cost_calculation` (`cost_calculation_id`, `project_id`, `total_direct_cost`, `total_indirect_cost`, `total_overhead_cost`, `total_cost`) VALUES
(1, 1, 265.00, 100.00, 0.00, 365.00);

-- --------------------------------------------------------

--
-- Table structure for table `cost_classification`
--

CREATE TABLE `cost_classification` (
  `classification_id` int(11) NOT NULL,
  `classification_name` varchar(255) NOT NULL,
  `cost_element_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cost_classification`
--

INSERT INTO `cost_classification` (`classification_id`, `classification_name`, `cost_element_id`) VALUES
(1, 'Machinery', 1),
(2, 'Lease', 2),
(3, 'plastic', 3);

-- --------------------------------------------------------

--
-- Table structure for table `cost_element`
--

CREATE TABLE `cost_element` (
  `cost_element_id` int(11) NOT NULL,
  `cost_element_name` varchar(255) NOT NULL,
  `cost_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cost_element`
--

INSERT INTO `cost_element` (`cost_element_id`, `cost_element_name`, `cost_type`) VALUES
(1, 'Equipment ', 1),
(2, 'Rent', 2),
(3, 'raw material', 4);

-- --------------------------------------------------------

--
-- Table structure for table `cost_element_type`
--

CREATE TABLE `cost_element_type` (
  `id` int(11) NOT NULL,
  `cost_element_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cost_element_type`
--

INSERT INTO `cost_element_type` (`id`, `cost_element_type`) VALUES
(1, 'Direct'),
(2, 'Indirect'),
(3, 'Overhead'),
(4, 'Material');

-- --------------------------------------------------------

--
-- Table structure for table `daily_demand`
--

CREATE TABLE `daily_demand` (
  `demand_id` int(11) NOT NULL,
  `cost_element_id` int(11) NOT NULL,
  `demand_date` date NOT NULL,
  `demand_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `direct_cost_calculation`
--

CREATE TABLE `direct_cost_calculation` (
  `direct_cost_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `total_direct_cost` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `direct_cost_calculation`
--

INSERT INTO `direct_cost_calculation` (`direct_cost_id`, `project_id`, `total_direct_cost`) VALUES
(1, 1, 265.00);

-- --------------------------------------------------------

--
-- Table structure for table `direct_labor_hour`
--

CREATE TABLE `direct_labor_hour` (
  `id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `labor_hours` decimal(10,2) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `direct_labor_hour`
--

INSERT INTO `direct_labor_hour` (`id`, `emp_id`, `project_id`, `labor_hours`, `date`) VALUES
(1, 0, 1, 5.00, '0019-05-17'),
(2, 1, 1, 12.00, '0020-05-16'),
(3, 1, 1, 12.00, '0020-05-16'),
(4, 1, 1, 12.00, '0020-05-16'),
(5, 1, 1, 12.00, '0020-05-16'),
(6, 3, 1, 12.00, '0030-06-16');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `name`, `email`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'raj@gmail.com', 'admin', 'admin@123', 'cost_accountant', '2024-11-12 19:05:33', '2024-12-23 05:06:01'),
(2, 'jivraj', 'raj@gmail.com', 'jivraj11', 'jivraj@123', 'cost_assistant', '2024-11-12 19:34:57', '2024-12-23 05:06:08'),
(3, 'sumit', 'sum@gmail.com', 'sumit22', 'sumit@123', 'cost_clerk', '2024-11-13 03:01:46', '2024-12-23 05:06:14');

-- --------------------------------------------------------

--
-- Table structure for table `eoq_calculation`
--

CREATE TABLE `eoq_calculation` (
  `cost_element_id` int(11) NOT NULL,
  `eoq` decimal(10,2) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gst_registration`
--

CREATE TABLE `gst_registration` (
  `id` int(11) NOT NULL,
  `state` varchar(100) NOT NULL,
  `registration_type` enum('Regular','Composition') NOT NULL,
  `assessee_other_territory` enum('Yes','No') NOT NULL,
  `gst_applicable_from` date NOT NULL,
  `gstin_uin` varchar(50) DEFAULT NULL,
  `periodicity` enum('Monthly','Quarterly') NOT NULL,
  `eway_bill_applicable` enum('Yes','No') NOT NULL,
  `applicable_from` date NOT NULL,
  `threshold_limit` decimal(10,2) DEFAULT NULL,
  `print_eway_bill` enum('Yes','No') NOT NULL,
  `e_invoicing_applicable` enum('Yes','No') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `indirect_cost_calculation`
--

CREATE TABLE `indirect_cost_calculation` (
  `indirect_cost_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `total_indirect_cost` decimal(15,2) DEFAULT NULL,
  `allocation_rate` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `indirect_cost_calculation`
--

INSERT INTO `indirect_cost_calculation` (`indirect_cost_id`, `project_id`, `total_indirect_cost`, `allocation_rate`) VALUES
(1, 1, 100.00, 1.89);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `cost_element_id` int(11) NOT NULL,
  `holding_cost` decimal(10,2) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp(),
  `current_stock_level` int(11) NOT NULL,
  `lead_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `material_cost`
--

CREATE TABLE `material_cost` (
  `cost_element_id` int(11) NOT NULL,
  `material_cost` decimal(10,2) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `material_cost`
--

INSERT INTO `material_cost` (`cost_element_id`, `material_cost`, `last_updated`) VALUES
(3, 486.00, '2024-12-11 17:54:34');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `overhead_calculation`
--

CREATE TABLE `overhead_calculation` (
  `overhead_cost_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `total_overhead_cost` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `overhead_calculation`
--

INSERT INTO `overhead_calculation` (`overhead_cost_id`, `project_id`, `total_overhead_cost`) VALUES
(1, 1, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `budgeted_cost` decimal(15,2) DEFAULT NULL,
  `actual_cost` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `description`, `project_id`, `budgeted_cost`, `actual_cost`) VALUES
(1, 'Pen', 'Pen for smooth writing on paper', 1, 100.00, 486.00);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `project_id` int(11) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `budget_amount` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`project_id`, `project_name`, `start_date`, `end_date`, `description`, `budget_amount`) VALUES
(1, 'Pen', '2024-11-13', '2024-12-31', 'Manufacture pens', 6000.00),
(2, 'Pensil', '2024-11-14', '2024-12-31', 'Manufacture of the pensil', 7000.00);

-- --------------------------------------------------------

--
-- Table structure for table `stock_levels`
--

CREATE TABLE `stock_levels` (
  `stock_level_id` int(11) NOT NULL,
  `cost_element_id` int(11) NOT NULL,
  `current_stock_level` int(11) NOT NULL,
  `min_stock_level` int(11) NOT NULL,
  `max_stock_level` int(11) NOT NULL,
  `danger_stock_level` int(11) NOT NULL,
  `reorder_point` int(11) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_parameters`
--

CREATE TABLE `stock_parameters` (
  `parameter_id` int(11) NOT NULL,
  `parameter_name` varchar(50) NOT NULL,
  `parameter_value` decimal(5,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `transaction_no` varchar(20) NOT NULL,
  `cost_element_id` int(11) DEFAULT NULL,
  `cost_classification_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `transaction_date` date DEFAULT NULL,
  `allocation_base_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `transaction_no`, `cost_element_id`, `cost_classification_id`, `project_id`, `product_id`, `amount`, `transaction_date`, `allocation_base_id`, `description`) VALUES
(1, 'TXN960597', 1, 1, 1, 1, 100.00, '2024-11-13', 1, 'new machine'),
(2, 'TXN74591', 2, 2, 1, 1, 100.00, '2024-11-13', 1, 'Lease paid for 1 month'),
(3, 'TXN297078', 1, 1, 1, 1, 44.00, '2024-11-14', 1, 'abc'),
(4, 'TXN351908', 1, 1, 1, 1, 121.00, '2024-11-15', 1, 'sdsad'),
(5, 'TXN56943', 3, 1, 1, 1, 121.00, '2024-11-15', 1, 'sdsad'),
(6, 'TXN314394', 1, 1, 1, 1, 123.00, '2024-12-24', 1, 'vxcvxc');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variance`
--

CREATE TABLE `variance` (
  `variance_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `actual_cost` decimal(15,2) DEFAULT NULL,
  `budgeted_cost` decimal(15,2) DEFAULT NULL,
  `variance` decimal(15,2) DEFAULT NULL,
  `variance_type_id` int(11) DEFAULT NULL,
  `status` varchar(39) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `variance`
--

INSERT INTO `variance` (`variance_id`, `project_id`, `actual_cost`, `budgeted_cost`, `variance`, `variance_type_id`, `status`) VALUES
(1, 1, 486.00, 10000.00, 9514.00, 1, 'Favorable');

-- --------------------------------------------------------

--
-- Table structure for table `variance_type`
--

CREATE TABLE `variance_type` (
  `variance_type_id` int(11) NOT NULL,
  `variance_type_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `variance_type`
--

INSERT INTO `variance_type` (`variance_type_id`, `variance_type_name`) VALUES
(1, 'budgeted_variance');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allocation_base`
--
ALTER TABLE `allocation_base`
  ADD PRIMARY KEY (`allocation_base_id`);

--
-- Indexes for table `annual_demand`
--
ALTER TABLE `annual_demand`
  ADD PRIMARY KEY (`demand_id`),
  ADD KEY `cost_element_id` (`cost_element_id`);

--
-- Indexes for table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`budget_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `budgeted_cost`
--
ALTER TABLE `budgeted_cost`
  ADD PRIMARY KEY (`budgeted_cost_id`),
  ADD KEY `cost_element_id` (`cost_element_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `companydetails`
--
ALTER TABLE `companydetails`
  ADD PRIMARY KEY (`company_id`);

--
-- Indexes for table `company_budget`
--
ALTER TABLE `company_budget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `year` (`year`);

--
-- Indexes for table `cost_calculation`
--
ALTER TABLE `cost_calculation`
  ADD PRIMARY KEY (`cost_calculation_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `cost_classification`
--
ALTER TABLE `cost_classification`
  ADD PRIMARY KEY (`classification_id`),
  ADD KEY `cost_element_id` (`cost_element_id`);

--
-- Indexes for table `cost_element`
--
ALTER TABLE `cost_element`
  ADD PRIMARY KEY (`cost_element_id`),
  ADD KEY `cost_type` (`cost_type`);

--
-- Indexes for table `cost_element_type`
--
ALTER TABLE `cost_element_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `daily_demand`
--
ALTER TABLE `daily_demand`
  ADD PRIMARY KEY (`demand_id`),
  ADD UNIQUE KEY `cost_element_id` (`cost_element_id`,`demand_date`);

--
-- Indexes for table `direct_cost_calculation`
--
ALTER TABLE `direct_cost_calculation`
  ADD PRIMARY KEY (`direct_cost_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `direct_labor_hour`
--
ALTER TABLE `direct_labor_hour`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `eoq_calculation`
--
ALTER TABLE `eoq_calculation`
  ADD PRIMARY KEY (`cost_element_id`);

--
-- Indexes for table `gst_registration`
--
ALTER TABLE `gst_registration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gstin_uin` (`gstin_uin`);

--
-- Indexes for table `indirect_cost_calculation`
--
ALTER TABLE `indirect_cost_calculation`
  ADD PRIMARY KEY (`indirect_cost_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `cost_element_id` (`cost_element_id`);

--
-- Indexes for table `material_cost`
--
ALTER TABLE `material_cost`
  ADD PRIMARY KEY (`cost_element_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `overhead_calculation`
--
ALTER TABLE `overhead_calculation`
  ADD PRIMARY KEY (`overhead_cost_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`project_id`);

--
-- Indexes for table `stock_levels`
--
ALTER TABLE `stock_levels`
  ADD PRIMARY KEY (`stock_level_id`),
  ADD KEY `cost_element_id` (`cost_element_id`);

--
-- Indexes for table `stock_parameters`
--
ALTER TABLE `stock_parameters`
  ADD PRIMARY KEY (`parameter_id`),
  ADD UNIQUE KEY `parameter_name` (`parameter_name`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `cost_element_id` (`cost_element_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `allocation_base_id` (`allocation_base_id`),
  ADD KEY `cost_classification_id` (`cost_classification_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variance`
--
ALTER TABLE `variance`
  ADD PRIMARY KEY (`variance_id`),
  ADD UNIQUE KEY `unique_project_id` (`project_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `variance_type_id` (`variance_type_id`);

--
-- Indexes for table `variance_type`
--
ALTER TABLE `variance_type`
  ADD PRIMARY KEY (`variance_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allocation_base`
--
ALTER TABLE `allocation_base`
  MODIFY `allocation_base_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `annual_demand`
--
ALTER TABLE `annual_demand`
  MODIFY `demand_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `budget_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budgeted_cost`
--
ALTER TABLE `budgeted_cost`
  MODIFY `budgeted_cost_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `companydetails`
--
ALTER TABLE `companydetails`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `company_budget`
--
ALTER TABLE `company_budget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cost_calculation`
--
ALTER TABLE `cost_calculation`
  MODIFY `cost_calculation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cost_classification`
--
ALTER TABLE `cost_classification`
  MODIFY `classification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cost_element`
--
ALTER TABLE `cost_element`
  MODIFY `cost_element_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cost_element_type`
--
ALTER TABLE `cost_element_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `daily_demand`
--
ALTER TABLE `daily_demand`
  MODIFY `demand_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `direct_cost_calculation`
--
ALTER TABLE `direct_cost_calculation`
  MODIFY `direct_cost_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `direct_labor_hour`
--
ALTER TABLE `direct_labor_hour`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gst_registration`
--
ALTER TABLE `gst_registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `indirect_cost_calculation`
--
ALTER TABLE `indirect_cost_calculation`
  MODIFY `indirect_cost_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `overhead_calculation`
--
ALTER TABLE `overhead_calculation`
  MODIFY `overhead_cost_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stock_levels`
--
ALTER TABLE `stock_levels`
  MODIFY `stock_level_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_parameters`
--
ALTER TABLE `stock_parameters`
  MODIFY `parameter_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variance`
--
ALTER TABLE `variance`
  MODIFY `variance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9835;

--
-- AUTO_INCREMENT for table `variance_type`
--
ALTER TABLE `variance_type`
  MODIFY `variance_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `annual_demand`
--
ALTER TABLE `annual_demand`
  ADD CONSTRAINT `annual_demand_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`);

--
-- Constraints for table `budget`
--
ALTER TABLE `budget`
  ADD CONSTRAINT `budget_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `budgeted_cost`
--
ALTER TABLE `budgeted_cost`
  ADD CONSTRAINT `budgeted_cost_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`),
  ADD CONSTRAINT `budgeted_cost_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `cost_calculation`
--
ALTER TABLE `cost_calculation`
  ADD CONSTRAINT `cost_calculation_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `cost_classification`
--
ALTER TABLE `cost_classification`
  ADD CONSTRAINT `cost_classification_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`);

--
-- Constraints for table `cost_element`
--
ALTER TABLE `cost_element`
  ADD CONSTRAINT `cost_element_ibfk_1` FOREIGN KEY (`cost_type`) REFERENCES `cost_element_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `daily_demand`
--
ALTER TABLE `daily_demand`
  ADD CONSTRAINT `daily_demand_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`);

--
-- Constraints for table `direct_cost_calculation`
--
ALTER TABLE `direct_cost_calculation`
  ADD CONSTRAINT `direct_cost_calculation_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `direct_labor_hour`
--
ALTER TABLE `direct_labor_hour`
  ADD CONSTRAINT `direct_labor_hour_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `eoq_calculation`
--
ALTER TABLE `eoq_calculation`
  ADD CONSTRAINT `eoq_calculation_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`);

--
-- Constraints for table `indirect_cost_calculation`
--
ALTER TABLE `indirect_cost_calculation`
  ADD CONSTRAINT `indirect_cost_calculation_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`);

--
-- Constraints for table `material_cost`
--
ALTER TABLE `material_cost`
  ADD CONSTRAINT `material_cost_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`);

--
-- Constraints for table `overhead_calculation`
--
ALTER TABLE `overhead_calculation`
  ADD CONSTRAINT `overhead_calculation_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `stock_levels`
--
ALTER TABLE `stock_levels`
  ADD CONSTRAINT `stock_levels_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`cost_element_id`) REFERENCES `cost_element` (`cost_element_id`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`),
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `transaction_ibfk_4` FOREIGN KEY (`allocation_base_id`) REFERENCES `allocation_base` (`allocation_base_id`),
  ADD CONSTRAINT `transaction_ibfk_5` FOREIGN KEY (`cost_classification_id`) REFERENCES `cost_classification` (`classification_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `variance`
--
ALTER TABLE `variance`
  ADD CONSTRAINT `variance_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`),
  ADD CONSTRAINT `variance_ibfk_2` FOREIGN KEY (`variance_type_id`) REFERENCES `variance_type` (`variance_type_id`);


--
-- Metadata
--
USE `phpmyadmin`;

--
-- Metadata for table allocation_base
--

--
-- Metadata for table annual_demand
--

--
-- Metadata for table budget
--

--
-- Metadata for table budgeted_cost
--

--
-- Metadata for table companydetails
--

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'cost', 'companydetails', '{\"CREATE_TIME\":\"2024-11-09 14:19:52\",\"sorted_col\":\"`companydetails`.`company_id` ASC\"}', '2024-11-12 19:09:11');

--
-- Metadata for table company_budget
--

--
-- Metadata for table cost_calculation
--

--
-- Metadata for table cost_classification
--

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'cost', 'cost_classification', '{\"CREATE_TIME\":\"2024-09-27 15:43:57\"}', '2024-11-12 16:16:25');

--
-- Metadata for table cost_element
--

--
-- Metadata for table cost_element_type
--

--
-- Metadata for table daily_demand
--

--
-- Metadata for table direct_cost_calculation
--

--
-- Metadata for table direct_labor_hour
--

--
-- Metadata for table employees
--

--
-- Metadata for table eoq_calculation
--

--
-- Metadata for table gst_registration
--

--
-- Metadata for table indirect_cost_calculation
--

--
-- Metadata for table inventory
--

--
-- Metadata for table material_cost
--

--
-- Metadata for table orders
--

--
-- Metadata for table overhead_calculation
--

--
-- Metadata for table product
--

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'cost', 'product', '{\"CREATE_TIME\":\"2024-09-27 15:43:30\"}', '2024-11-13 03:11:50');

--
-- Metadata for table project
--

--
-- Metadata for table stock_levels
--

--
-- Metadata for table stock_parameters
--

--
-- Metadata for table transaction
--

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'cost', 'transaction', '{\"sorted_col\":\"`transaction`.`transaction_id` ASC\",\"CREATE_TIME\":\"2024-10-15 15:07:20\"}', '2024-11-13 03:15:42');

--
-- Metadata for table user
--

--
-- Metadata for table variance
--

--
-- Metadata for table variance_type
--

--
-- Metadata for database cost
--

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `cost_calculation` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-13 23:53:30' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Insert new rows if no matching data exists
    INSERT INTO Cost_Calculation (project_id, total_direct_cost, total_indirect_cost, total_overhead_cost, total_cost)
    SELECT dc.project_id, dc.total_direct_cost, ic.total_indirect_cost, oc.total_overhead_cost,
           dc.total_direct_cost + ic.total_indirect_cost + oc.total_overhead_cost AS total_cost
    FROM direct_cost_calculation dc
    JOIN indirect_cost_calculation ic ON dc.project_id = ic.project_id
    JOIN overhead_calculation oc ON dc.project_id = oc.project_id
    WHERE NOT EXISTS (
        SELECT 1
        FROM Cost_Calculation cc
        WHERE cc.project_id = dc.project_id
    );

    -- Update the existing rows with new values
    UPDATE Cost_Calculation cc
    JOIN direct_cost_calculation dc ON cc.project_id = dc.project_id
    JOIN indirect_cost_calculation ic ON cc.project_id = ic.project_id
    JOIN overhead_calculation oc ON cc.project_id = oc.project_id
    SET cc.total_direct_cost = dc.total_direct_cost,
        cc.total_indirect_cost = ic.total_indirect_cost,
        cc.total_overhead_cost = oc.total_overhead_cost,
        cc.total_cost = dc.total_direct_cost + ic.total_indirect_cost + oc.total_overhead_cost;
  END$$

CREATE DEFINER=`root`@`localhost` EVENT `update_actual_product_cost` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-14 00:06:37' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO product (product_id, actual_cost)
SELECT t.product_id,
       -- Calculate the total actual cost (sum of all cost types: Direct, Indirect, Overhead, and Material)
       SUM(CASE WHEN cet.cost_element_type = 'Direct' THEN t.amount ELSE 0 END) +
       SUM(CASE WHEN cet.cost_element_type = 'Indirect' THEN t.amount ELSE 0 END) +
       SUM(CASE WHEN cet.cost_element_type = 'Overhead' THEN t.amount ELSE 0 END) +
       SUM(CASE WHEN cet.cost_element_type = 'Material' THEN t.amount ELSE 0 END) AS actual_cost
FROM Transaction t
JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id
JOIN cost_element_type cet ON ce.cost_type = cet.id
GROUP BY t.product_id
ON DUPLICATE KEY UPDATE actual_cost = VALUES(actual_cost);
END$$

CREATE DEFINER=`root`@`localhost` EVENT `calculate_annual_demand` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-13 00:00:25' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO annual_demand (cost_element_id, annual_demand, last_updated)
    SELECT 
        t.cost_element_id,
        SUM(o.quantity) AS annual_demand
    FROM orders o
    JOIN transaction t ON o.transaction_id = t.transaction_id
    JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id
    WHERE ce.cost_type = 'Material' -- Calculate for materials only
    GROUP BY t.cost_element_id
    ON DUPLICATE KEY UPDATE 
        annual_demand = VALUES(annual_demand),
        last_updated = NOW();
END$$

CREATE DEFINER=`root`@`localhost` EVENT `direct_cost_calculation` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-13 23:49:26' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Insert new rows if no matching data exists
    INSERT INTO direct_cost_calculation (project_id, total_direct_cost)
    SELECT direct_sum.project_id, direct_sum.total_direct_cost
    FROM (
        SELECT t.project_id, SUM(t.amount) AS total_direct_cost
        FROM Transaction t
        JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id
        JOIN cost_element_type cet ON ce.cost_type = cet.id
        WHERE cet.cost_element_type = 'Direct'
        GROUP BY t.project_id
    ) AS direct_sum
    WHERE NOT EXISTS (
        SELECT 1 
        FROM direct_cost_calculation dc 
        WHERE dc.project_id = direct_sum.project_id
    );

    -- Update the existing rows with new values
    UPDATE direct_cost_calculation dc
    JOIN (
        SELECT t.project_id, SUM(t.amount) AS total_direct_cost
        FROM Transaction t
        JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id
        JOIN cost_element_type cet ON ce.cost_type = cet.id
        WHERE cet.cost_element_type = 'Direct'
        GROUP BY t.project_id
    ) AS direct_sum ON dc.project_id = direct_sum.project_id
    SET dc.total_direct_cost = direct_sum.total_direct_cost;
  END$$

CREATE DEFINER=`root`@`localhost` EVENT `indirect_cost_calculation` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-13 23:51:26' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Insert new rows if no matching data exists
    INSERT INTO Indirect_Cost_Calculation (project_id, total_indirect_cost, allocation_rate)
    SELECT 
        indirect_sum.project_id, 
        indirect_sum.total_indirect_cost, 
        indirect_sum.total_indirect_cost / labor_sum.total_labor_hours AS allocation_rate
    FROM (
        SELECT 
            t.project_id, 
            SUM(t.amount) AS total_indirect_cost
        FROM 
            Transaction t
        JOIN 
            cost_element ce ON t.cost_element_id = ce.cost_element_id
        JOIN 
            cost_element_type cet ON ce.cost_type = cet.id
        WHERE 
            cet.cost_element_type = 'Indirect'
        GROUP BY 
            t.project_id
    ) AS indirect_sum
    JOIN (
        SELECT 
            project_id, 
            SUM(labor_hours) AS total_labor_hours
        FROM 
            Direct_Labor_Hour
        GROUP BY 
            project_id
    ) AS labor_sum ON indirect_sum.project_id = labor_sum.project_id
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Indirect_Cost_Calculation ic 
        WHERE ic.project_id = indirect_sum.project_id
    );

    -- Update the existing rows with new values
    UPDATE Indirect_Cost_Calculation ic
    JOIN (
        SELECT 
            t.project_id, 
            SUM(t.amount) AS total_indirect_cost
        FROM 
            Transaction t
        JOIN 
            cost_element ce ON t.cost_element_id = ce.cost_element_id
        JOIN 
            cost_element_type cet ON ce.cost_type = cet.id
        WHERE 
            cet.cost_element_type = 'Indirect'
        GROUP BY 
            t.project_id
    ) AS indirect_sum ON ic.project_id = indirect_sum.project_id
    JOIN (
        SELECT 
            project_id, 
            SUM(labor_hours) AS total_labor_hours
        FROM 
            Direct_Labor_Hour
        GROUP BY 
            project_id
    ) AS labor_sum ON ic.project_id = labor_sum.project_id
    SET 
        ic.total_indirect_cost = indirect_sum.total_indirect_cost,
        ic.allocation_rate = indirect_sum.total_indirect_cost / labor_sum.total_labor_hours;
END$$

CREATE DEFINER=`root`@`localhost` EVENT `calculate_eoq` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-12 23:58:20' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO eoq_calculation (cost_element_id, eoq, last_updated)
    SELECT 
        ad.cost_element_id,
        SQRT((2 * ad.annual_demand * i.holding_cost) / mc.material_cost) AS eoq,
        NOW()
    FROM 
        annual_demand ad
    JOIN 
        inventory i ON ad.cost_element_id = i.cost_element_id
    JOIN 
        material_cost mc ON ad.cost_element_id = mc.cost_element_id
    ON DUPLICATE KEY UPDATE 
        eoq = VALUES(eoq),
        last_updated = NOW();
END$$

CREATE DEFINER=`root`@`localhost` EVENT `calculate_variance` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-14 00:54:34' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Insert or Update the variance for each project_id
    INSERT INTO Variance (project_id, actual_cost, budgeted_cost, variance, variance_type_id, status)
    SELECT
        t.project_id,
        -- Calculate actual cost
        IFNULL(SUM(t.amount), 0) AS actual_cost,
        -- Calculate budgeted cost
        IFNULL(SUM(budgeted.budgeted_amount), 0) AS budgeted_cost,
        -- Calculate variance (budgeted_cost - actual_cost)
        IFNULL(SUM(budgeted.budgeted_amount), 0) - IFNULL(SUM(t.amount), 0) AS variance,
        -- Assign a variance type (you can map this based on your business rules, e.g., 1 for Budget, 2 for Actual)
        1 AS variance_type_id,  -- Example: "1" could represent "Budgeted Variance"
        -- Determine status: "Favorable" if variance is positive, "Unfavorable" if negative
        CASE 
            WHEN (IFNULL(SUM(budgeted.budgeted_amount), 0) - IFNULL(SUM(t.amount), 0)) > 0 THEN 'Favorable'
            WHEN (IFNULL(SUM(budgeted.budgeted_amount), 0) - IFNULL(SUM(t.amount), 0)) < 0 THEN 'Unfavorable'
            ELSE 'Neutral'  -- Optional: status for when there is no variance
        END AS status
    FROM
        (SELECT DISTINCT project_id FROM Transaction
         UNION 
         SELECT DISTINCT project_id FROM Budgeted_Cost) AS projects
    LEFT JOIN Transaction t ON t.project_id = projects.project_id
    LEFT JOIN budgeted_cost budgeted ON budgeted.project_id = projects.project_id
    GROUP BY projects.project_id
    ON DUPLICATE KEY UPDATE
        actual_cost = VALUES(actual_cost),
        budgeted_cost = VALUES(budgeted_cost),
        variance = VALUES(variance),
        variance_type_id = VALUES(variance_type_id),
        status = VALUES(status);

END$$

CREATE DEFINER=`root`@`localhost` EVENT `overhead_cost_calculation` ON SCHEDULE EVERY 1 SECOND STARTS '2024-11-13 23:52:31' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Insert new rows if no matching data exists
    INSERT INTO Overhead_Calculation (project_id, total_overhead_cost)
    SELECT overhead_sum.project_id, overhead_sum.total_overhead_cost
    FROM (
        SELECT t.project_id, SUM(t.amount) AS total_overhead_cost
        FROM Transaction t
        JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id
        JOIN cost_element_type cet ON ce.cost_type = cet.id
        WHERE cet.cost_element_type = 'Overhead'
        GROUP BY t.project_id
    ) AS overhead_sum
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Overhead_Calculation oc
        WHERE oc.project_id = overhead_sum.project_id
    );

    -- Update the existing rows with new values
    UPDATE Overhead_Calculation oc
    JOIN (
        SELECT t.project_id, SUM(t.amount) AS total_overhead_cost
        FROM Transaction t
        JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id
        JOIN cost_element_type cet ON ce.cost_type = cet.id
        WHERE cet.cost_element_type = 'Overhead'
        GROUP BY t.project_id
    ) AS overhead_sum ON oc.project_id = overhead_sum.project_id
    SET oc.total_overhead_cost = overhead_sum.total_overhead_cost;
  END$$

CREATE DEFINER=`root`@`localhost` EVENT `UpdateMaterialCostsEvent` ON SCHEDULE EVERY 1 SECOND STARTS '2024-12-11 23:07:48' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cost_element_id INT;
    DECLARE total_cost DECIMAL(10, 2);

    -- Declare cursor to fetch all Material cost_element_id based on cost_element_type
    DECLARE material_cursor CURSOR FOR 
        SELECT ce.cost_element_id
        FROM cost_element ce
        JOIN cost_element_type cet ON ce.cost_type = cet.id
        WHERE cet.cost_element_type = 'Material';

    -- Handler for when the cursor has no more rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN material_cursor;

    -- Loop through each cost_element_id
    read_loop: LOOP
        FETCH material_cursor INTO cost_element_id;

        -- Exit the loop if no more rows are found
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate total material cost for the current cost_element_id
        SELECT SUM(amount) INTO total_cost
        FROM transaction
        WHERE cost_element_id = cost_element_id;

        -- If no transactions exist, set total_cost to 0
        IF total_cost IS NULL THEN
            SET total_cost = 0;
        END IF;

        -- Insert or update the material cost in the material_cost table
        IF EXISTS (
            SELECT 1 
            FROM material_cost 
            WHERE cost_element_id = cost_element_id
        ) THEN
            -- Update the existing material cost
            UPDATE material_cost
            SET material_cost = total_cost, last_updated = NOW()
            WHERE cost_element_id = cost_element_id;
        ELSE
            -- Insert a new material cost
            INSERT INTO material_cost (cost_element_id, material_cost, last_updated)
            VALUES (cost_element_id, total_cost, NOW());
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE material_cursor;
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
