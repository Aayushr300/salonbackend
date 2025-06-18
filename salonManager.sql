-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: booking
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `expiry` datetime DEFAULT NULL,
  `tenant_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'SAVE10',10.00,'2025-06-30 00:00:00',14,'2025-06-12 04:15:43','2025-06-12 04:15:43'),(2,'SAVE10',10.00,'2025-06-30 00:00:00',16,'2025-06-13 08:10:11','2025-06-13 08:10:11');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `phone` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `is_member` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `tenant_id` int NOT NULL,
  PRIMARY KEY (`phone`,`tenant_id`),
  KEY `customers_ibfk_1` (`tenant_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('7415263635','Rahul Raj','rahul7453@gmail.com','2013-07-13','male',NULL,'2025-06-13 13:49:17','2025-06-13 13:49:17',16),('7485963254','Rakesh Kumar','rakesh@gmail.com','2025-06-13','male',NULL,'2025-06-13 13:42:42','2025-06-13 13:42:42',16),('8596325563','salina','salina425@gmail.com','2000-06-13','male',NULL,'2025-06-13 13:49:58','2025-06-13 13:49:58',16),('9652324589','Ramesh Kumar','ramesh@gmail.com','2018-05-13','male',NULL,'2025-06-13 13:43:18','2025-06-13 13:43:18',16);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_rates`
--

DROP TABLE IF EXISTS `exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_rates` (
  `currency_code` varchar(5) NOT NULL,
  `rate_to_usd` decimal(10,6) DEFAULT NULL,
  PRIMARY KEY (`currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_rates`
--

LOCK TABLES `exchange_rates` WRITE;
/*!40000 ALTER TABLE `exchange_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `exchange_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_sequences`
--

DROP TABLE IF EXISTS `invoice_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_sequences` (
  `tenant_id` int NOT NULL,
  `sequence_no` int DEFAULT NULL,
  PRIMARY KEY (`tenant_id`),
  CONSTRAINT `invoice_sequences_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_sequences`
--

LOCK TABLES `invoice_sequences` WRITE;
/*!40000 ALTER TABLE `invoice_sequences` DISABLE KEYS */;
INSERT INTO `invoice_sequences` VALUES (14,3),(16,10);
/*!40000 ALTER TABLE `invoice_sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `sub_total` decimal(10,2) DEFAULT NULL,
  `tax_total` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `tenant_id` int NOT NULL,
  PRIMARY KEY (`id`,`tenant_id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,'2025-06-12 09:47:15',240.00,10.80,24.00,226.80,14),(1,'2025-06-13 13:47:32',500.00,22.50,50.00,472.50,16),(2,'2025-06-12 12:35:54',240.00,10.80,24.00,226.80,14),(2,'2025-06-13 13:47:34',999.00,44.96,99.90,944.06,16),(3,'2025-06-12 12:48:50',240.00,11.25,15.00,236.25,14),(3,'2025-06-13 13:47:36',999.00,44.96,99.90,944.06,16),(4,'2025-06-13 13:51:17',500.00,22.50,50.00,472.50,16),(5,'2025-06-13 13:51:47',999.00,44.96,99.90,944.06,16),(6,'2025-06-13 13:51:49',999.00,44.96,99.90,944.06,16),(7,'2025-06-13 13:51:52',500.00,22.50,50.00,472.50,16),(8,'2025-06-13 13:51:54',500.00,22.50,50.00,472.50,16),(9,'2025-06-13 13:53:32',299.00,14.20,15.00,298.20,16),(10,'2025-06-13 13:53:42',450.00,20.25,45.00,425.25,16);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item_addons`
--

DROP TABLE IF EXISTS `menu_item_addons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item_addons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`,`item_id`),
  KEY `fk_menu_item_idx` (`item_id`),
  KEY `fk_menu_item_idx_index` (`item_id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `fk_addon_menu_item` FOREIGN KEY (`item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_item_addons_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item_addons`
--

LOCK TABLES `menu_item_addons` WRITE;
/*!40000 ALTER TABLE `menu_item_addons` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_item_addons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item_variants`
--

DROP TABLE IF EXISTS `menu_item_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`,`item_id`),
  KEY `fk_variant_menu_item_id_idx` (`item_id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `fk_variant_menu_item_id` FOREIGN KEY (`item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_item_variants_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item_variants`
--

LOCK TABLES `menu_item_variants` WRITE;
/*!40000 ALTER TABLE `menu_item_variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_item_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `net_price` decimal(10,2) DEFAULT NULL,
  `tax_id` int DEFAULT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `category` int DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `menu_items_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (13,'Pizza',240.00,240.00,2,NULL,NULL,14),(14,' 2. Advance Appointment (Scheduled Booking)',500.00,500.00,3,NULL,NULL,16),(15,'Online Booking',999.00,999.00,3,NULL,NULL,16),(16,'Meeting Appointment',450.00,450.00,3,NULL,NULL,16),(17,'Client Meeting',299.00,299.00,3,NULL,NULL,16);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `status` enum('created','preparing','completed','cancelled','delivered') DEFAULT 'created',
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` varchar(255) DEFAULT NULL,
  `addons` mediumtext,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (42,27,13,NULL,240.00,24.00,1,'created','2025-06-12 09:47:12',NULL,NULL,14),(43,28,13,NULL,240.00,24.00,1,'delivered','2025-06-12 12:35:39',NULL,NULL,14),(44,29,13,NULL,240.00,15.00,1,'created','2025-06-12 12:47:02',NULL,NULL,14),(45,30,14,NULL,500.00,50.00,1,'created','2025-06-13 13:45:54',NULL,NULL,16),(46,31,15,NULL,999.00,99.90,1,'created','2025-06-13 13:47:03',NULL,NULL,16),(47,32,15,NULL,999.00,99.90,1,'created','2025-06-13 13:47:25',NULL,NULL,16),(48,33,14,NULL,500.00,50.00,1,'created','2025-06-13 13:51:12',NULL,NULL,16),(49,34,15,NULL,999.00,99.90,1,'created','2025-06-13 13:51:27',NULL,NULL,16),(50,35,14,NULL,500.00,50.00,1,'created','2025-06-13 13:51:34',NULL,NULL,16),(51,36,15,NULL,999.00,99.90,1,'created','2025-06-13 13:51:38',NULL,NULL,16),(52,37,14,NULL,500.00,50.00,1,'created','2025-06-13 13:51:42',NULL,NULL,16),(53,38,17,NULL,299.00,15.00,1,'created','2025-06-13 13:53:12',NULL,NULL,16),(54,39,16,NULL,450.00,45.00,1,'created','2025-06-13 13:53:24',NULL,NULL,16);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `delivery_type` varchar(90) DEFAULT NULL,
  `customer_type` enum('WALKIN','CUSTOMER') DEFAULT 'WALKIN',
  `customer_id` varchar(20) DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `status` enum('created','completed','cancelled') DEFAULT 'created',
  `token_no` int DEFAULT NULL,
  `payment_status` enum('pending','paid') DEFAULT 'pending',
  `invoice_id` int DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (27,'2025-06-12 09:47:12','','WALKIN',NULL,NULL,'completed',1,'paid',1,14),(28,'2025-06-12 12:35:39','','WALKIN',NULL,NULL,'completed',2,'paid',2,14),(29,'2025-06-12 12:47:02','','WALKIN',NULL,NULL,'completed',3,'paid',3,14),(30,'2025-06-13 13:45:54','','WALKIN',NULL,NULL,'completed',1,'paid',1,16),(31,'2025-06-13 13:47:03','','WALKIN',NULL,NULL,'completed',2,'paid',2,16),(32,'2025-06-13 13:47:25','','WALKIN',NULL,NULL,'completed',3,'paid',3,16),(33,'2025-06-13 13:51:12','','WALKIN',NULL,NULL,'completed',4,'paid',4,16),(34,'2025-06-13 13:51:27','','WALKIN',NULL,NULL,'completed',5,'paid',5,16),(35,'2025-06-13 13:51:34','','WALKIN',NULL,NULL,'completed',6,'paid',7,16),(36,'2025-06-13 13:51:38','','WALKIN',NULL,NULL,'completed',7,'paid',6,16),(37,'2025-06-13 13:51:42','','WALKIN',NULL,NULL,'completed',8,'paid',8,16),(38,'2025-06-13 13:53:12','','WALKIN',NULL,NULL,'completed',9,'paid',9,16),(39,'2025-06-13 13:53:24','','WALKIN',NULL,NULL,'completed',10,'paid',10,16);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_types`
--

DROP TABLE IF EXISTS `payment_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `payment_types_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_types`
--

LOCK TABLES `payment_types` WRITE;
/*!40000 ALTER TABLE `payment_types` DISABLE KEYS */;
INSERT INTO `payment_types` VALUES (3,'Online',1,14),(4,'Online',1,16);
/*!40000 ALTER TABLE `payment_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policies`
--

DROP TABLE IF EXISTS `policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `content` text,
  `admin_username` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policies`
--

LOCK TABLES `policies` WRITE;
/*!40000 ALTER TABLE `policies` DISABLE KEYS */;
INSERT INTO `policies` VALUES (1,'privacy','<p>Error loading data</p>','admin@gmail.com','2025-06-12 21:26:47','2025-06-12 21:26:47'),(2,'refund','<p>Hello World</p>','admin@gmail.com','2025-06-12 21:26:55','2025-06-12 21:26:55'),(3,'terms','<p>hello Duniya</p>','admin@gmail.com','2025-06-12 21:27:05','2025-06-12 21:27:05'),(4,'privacy','<h2>&nbsp;</h2><p><i>Effective Date: June 13, 2025</i></p><p><strong>SalonManager</strong> (\"we,\" \"our,\" or \"us\") is committed to protecting the privacy and security of personal information provided by users of our salon management software, website (<a href=\"http://www.salonmanager.com/\">www.salonmanager.com</a>), mobile applications, and related services (collectively, the \"Services\"). This Privacy Policy explains how we collect, use, disclose, and safeguard personal data from our clients (salon owners, staff, and their customers) in compliance with applicable laws, including the General Data Protection Regulation (GDPR) and the California Consumer Privacy Act (CCPA). By using our Services, you agree to the practices described in this policy.</p><p>&nbsp;</p><h2>1. <strong>Scope of This Policy</strong></h2><p>This Privacy Policy applies to personal information collected through:</p><ul><li>The SalonManager software platform used by salon owners and staff.</li><li>Our website, <a href=\"http://www.salonmanager.com/\">www.salonmanager.com</a>.</li><li>Our mobile applications for iOS and Android.</li><li>Interactions with our customer support team or marketing communications.</li></ul><p>It covers data provided by salon owners, employees, and their clients, as well as data collected automatically through our Services.</p><h2>2. Information We Collect</h2><p>We collect the following types of personal information to provide and improve our Services:</p><h3>2.1 Information Provided Directly</h3><p>&nbsp;</p><ul><li><strong>Salon Owners and Staff</strong>:<ul><li>Contact details (e.g., name, email address, phone number, business address).</li><li>Account credentials (e.g., username, password).</li><li>Payment information (e.g., credit card details, billing address) for subscription or transaction processing.</li><li>Salon-specific data (e.g., employee schedules, service pricing, inventory details).</li><li>&nbsp;</li></ul></li><li><strong>Salon Clients</strong> (provided by salon owners or clients themselves via online booking):<ul><li>Contact details (e.g., name, email address, phone number).</li><li>Appointment details (e.g., service type, date, time, stylist preferences).</li><li>Payment information (e.g., card details for deposits or payments).</li><li>Optional data (e.g., health history, allergies, or service preferences, if relevant to the salon’s services).</li></ul></li></ul><h3>2.2 Information Collected Automatically</h3><p>&nbsp;</p><ul><li><strong>Usage Data</strong>: Information about how you interact with our Services, such as IP address, device type, browser type, pages visited, and actions taken (e.g., booking an appointment or generating a report).</li><li><strong>Cookies and Tracking Technologies</strong>: We use cookies, web beacons, and similar technologies to enhance user experience, analyze usage, and deliver personalized content. Essential cookies are required for core functionality, while optional cookies (e.g., for analytics or marketing) can be managed via your browser settings or our cookie consent tool.</li><li>&nbsp;</li><li><strong>Analytics Data</strong>: Aggregated data from tools like Google Analytics to understand Service performance and user behavior.</li></ul><h3>2.3 Information from Third Parties</h3><ul><li>We may receive data from third-party service providers, such as payment processors (e.g., Stripe, PayPal), marketing partners, or social media platforms (e.g., if you log in via Google or Facebook).</li><li>Publicly available data or data from referral partners may be used to enhance our Services or marketing efforts, in compliance with applicable laws.</li></ul><h2>3. How We Use Your Information</h2><p>We use personal information for the following purposes:</p><p>&nbsp;</p><ul><li><strong>Service Delivery</strong>:<ul><li>Manage salon operations (e.g., scheduling, payments, inventory, reporting).</li><li>Facilitate client bookings and communications (e.g., appointment reminders via email or SMS).</li><li>Process payments and subscriptions securely.</li><li>&nbsp;</li></ul></li><li><strong>Account Management</strong>:<ul><li>Create and maintain user accounts for salon owners and staff.</li><li>Provide customer support and respond to inquiries.</li><li>&nbsp;</li></ul></li><li><strong>Marketing and Communications</strong>:<ul><li>Send promotional offers, newsletters, or service updates (with your consent, where required).</li><li>Personalize marketing based on user preferences or salon activity.</li><li>&nbsp;</li></ul></li><li><strong>Analytics and Improvement</strong>:<ul><li>Analyze usage patterns to enhance software functionality and user experience.</li><li>Generate aggregated reports for salon owners (e.g., business performance metrics).</li><li>&nbsp;</li></ul></li><li><strong>Legal Compliance</strong>:<ul><li>Comply with legal obligations (e.g., tax reporting, data protection laws).</li><li>Respond to lawful requests from authorities or enforce our Terms of Service.</li></ul></li></ul><h2>4. How We Share Your Information</h2><p>We do not sell or rent personal information to third parties for their marketing purposes. We may share data in the following circumstances:</p><p>&nbsp;</p><ul><li><strong>With Service Providers</strong>: We engage trusted third parties (e.g., payment processors, cloud storage providers, email delivery services) to perform functions on our behalf. These providers are contractually obligated to protect your data and use it only for the purposes we specify.</li><li>&nbsp;</li><li><strong>Within the Salon</strong>: Salon owners and authorized staff may access client data (e.g., appointment details, payment history) to provide services. SalonManager ensures access is restricted to authorized personnel with traceable logins.</li><li>&nbsp;</li><li><strong>For Marketing Partnerships</strong>: With your consent, we may share limited data (e.g., email address) with trusted partners for joint marketing campaigns.</li><li>&nbsp;</li><li><strong>For Legal Reasons</strong>: We may disclose data to comply with legal obligations, respond to subpoenas, or protect the rights, property, or safety of SalonManager, our users, or others.</li><li>&nbsp;</li><li><strong>Business Transfers</strong>: In the event of a merger, acquisition, or sale of assets, personal information may be transferred to the acquiring entity, subject to equivalent privacy protections</li><li>&nbsp;</li></ul><h2><strong>5. Data Security</strong></h2><p>We implement industry-standard measures to protect your personal information, including:</p><ul><li><strong>Encryption</strong>: Data is encrypted in transit (e.g., via HTTPS) and at rest.</li><li><strong>Access Controls</strong>: Role-based access ensures only authorized users can view or edit sensitive data.</li><li><strong>Regular Backups</strong>: Cloud-based backups protect against data loss.</li><li><strong>Password Policies</strong>: Strong password requirements and optional two-factor authentication.</li><li><strong>Breach Response</strong>: In the unlikely event of a data breach, we will notify affected users and relevant authorities promptly, as required by law.</li></ul><p>While we strive to ensure security, no online system is entirely immune to risks. Users are responsible for safeguarding their account credentials.</p><h2>6. Your Rights and Choices</h2><p>Depending on your jurisdiction, you may have the following rights regarding your personal information:</p><ul><li><strong>Access</strong>: Request a copy of the data we hold about you.</li><li><strong>Correction</strong>: Update or correct inaccurate or outdated information.</li><li><strong>Deletion</strong>: Request deletion of your data, subject to legal or contractual obligations.</li><li><strong>Opt-Out</strong>: Unsubscribe from marketing communications via links in emails or by contacting us.</li><li><strong>Restrict Processing</strong>: Limit how we use your data in certain circumstances.</li><li><strong>Data Portability</strong>: Receive your data in a structured, machine-readable format.</li><li><strong>Withdraw Consent</strong>: Revoke consent for data processing (e.g., marketing), though this may limit access to certain features.</li></ul><p>To exercise these rights, contact us at <a href=\"mailto:privacy@salonmanager.com\">privacy@salonmanager.com</a>. We will respond within a reasonable timeframe (typically 30 days) and in accordance with applicable laws.</p><p>&nbsp;</p><h2><strong>7. Data Retention</strong></h2><p>We retain personal information only as long as necessary to fulfill the purposes outlined in this policy or as required by law. For example:</p><ul><li>Account data is retained while your subscription is active and for a reasonable period after termination (e.g., for billing or legal purposes).</li><li>Client data (e.g., appointment history) is retained as directed by the salon owner, typically for 2 years after the last interaction, unless otherwise required.</li><li>Usage data may be anonymized and retained indefinitely for analytics.</li></ul><p>Data no longer needed is securely deleted or anonymized.</p><p>&nbsp;</p><h2><strong>8. Children’s Privacy</strong></h2><p>Our Services are not intended for individuals under 13 (or 16 in certain jurisdictions). We do not knowingly collect personal information from children without parental consent. If we become aware of such data, we will delete it promptly. Contact us if you believe a child has provided us with personal information.</p><h2>9. International Data Transfers</h2><p>SalonManager operates globally, and your data may be processed in countries outside your jurisdiction (e.g., in the United States). We ensure that any international transfers comply with applicable data protection laws, using mechanisms like Standard Contractual Clauses or adequacy decisions.</p><h2>10. Cookies and Tracking</h2><p>We use cookies to enhance functionality, analyze usage, and deliver personalized content. You can manage cookie preferences via our cookie consent tool or browser settings. Disabling cookies may limit certain features of our Services. For details, see our Cookie Policy at <a href=\"http://www.salonmanager.com/cookie-policy\">www.salonmanager.com/cookie-policy</a>.</p><h2>11. Third-Party Links</h2><p>Our Services may contain links to third-party websites or services (e.g., payment processors, social media). We are not responsible for their privacy practices. Review their privacy policies before providing personal information.</p><h2>12. Changes to This Policy</h2><p>We may update this Privacy Policy to reflect changes in our practices or legal requirements. Updates will be posted on our website with the effective date. Significant changes will be communicated via email or in-app notifications. Continued use of our Services after changes constitutes acceptance of the updated policy.</p><h2>13. Contact Us</h2><p>If you have questions, concerns, or requests regarding this Privacy Policy or your personal data, please contact our Data Protection Officer:</p><p>&nbsp;</p><p>For GDPR-related inquiries, our EU representative can be reached at: <a href=\"mailto:eu.privacy@salonmanager.com\">eu.privacy@salonmanager.com</a>.</p><p>Thank you for trusting SalonManager with your personal information. We are dedicated to protecting your privacy while delivering exceptional salon management solutions.</p>','admin@gmail.com','2025-06-13 13:30:14','2025-06-13 13:30:14'),(5,'refund','<h2><strong>SalonManager Refund Policy</strong></h2><p><i><strong>Effective Date: June 13, 2025</strong></i></p><p>&nbsp;</p><p>At SalonManager (\"we,\" \"our,\" or \"us\"), we strive to provide exceptional salon management software and services to our users, including salon owners, staff, and their clients. This Refund Policy outlines the conditions under which refunds may be issued for payments made for our software subscriptions, services, or related transactions through our website (<a href=\"http://www.salonmanager.com/\">www.salonmanager.com</a>), mobile applications, or other platforms (collectively, the \"Services\"). By using our Services, you agree to the terms of this policy.</p><p>&nbsp;</p><h2><strong>1. Scope of This Policy</strong></h2><p>This Refund Policy applies to:</p><ul><li>Payments for SalonManager software subscriptions (e.g., monthly or annual plans).</li><li>Fees for additional services, such as premium features, setup assistance, or integrations.</li><li>Transactions processed through SalonManager’s payment system for salon clients (e.g., appointment deposits or service payments), where applicable.</li></ul><p>This policy does not cover third-party services (e.g., payment processors like Stripe or PayPal) or products purchased outside of SalonManager’s platform.</p><p>&nbsp;</p><h2><strong>2. Subscription Refunds</strong></h2><h3><strong>2.1 Trial Period</strong></h3><p>SalonManager offers a free trial period (typically 14 days) for new users to evaluate our software. No charges are applied during the trial, and no refund is necessary if you cancel before the trial ends. To cancel, follow the instructions in your account settings or contact support at <a href=\"mailto:support@salonmanager.com\">support@salonmanager.com</a>.</p><h3>2.2<strong> Monthly Subscriptions</strong></h3><ul><li>Monthly subscriptions are non-refundable after the billing cycle begins.</li><li>If you cancel your subscription, you will retain access to the Services until the end of the current billing period, but no partial refunds will be issued for unused time.</li><li>To cancel, log into your account and navigate to the billing section or contact our support team.</li></ul><h3>2.3 <strong>Annual Subscriptions</strong></h3><ul><li>Annual subscriptions include a 30-day money-back guarantee from the date of purchase. If you are not satisfied, contact us within 30 days to request a full refund.</li><li>After 30 days, annual subscriptions are non-refundable, but you may cancel to prevent auto-renewal at the end of the term. Access to the Services will continue until the subscription expires.</li><li>Refunds for annual subscriptions will be processed to the original payment method within 7-10 business days.</li></ul><h3>2.4 <strong>Auto-Renewal</strong></h3><p>Subscriptions automatically renew unless canceled before the renewal date. No refunds will be issued for auto-renewed subscriptions unless covered by the 30-day money-back guarantee for annual plans.</p><p>&nbsp;</p><h2><strong>3. Refunds for Additional Services</strong></h2><ul><li><strong>Premium Features or Add-Ons</strong>: Fees for optional features (e.g., advanced reporting, SMS notifications) are non-refundable once activated, as they are provided on a per-use or per-billing-cycle basis.</li><li><strong>Setup or Onboarding Assistance</strong>: Fees for one-time services, such as custom setup or training, are non-refundable once the service has been delivered or partially completed.</li><li><strong>Integrations</strong>: Fees for third-party integrations (e.g., payment gateways, marketing tools) are non-refundable, as they involve setup and access to external systems.</li><li>&nbsp;</li></ul><h2><strong>4. Client Transaction Refunds (Salon Clients)</strong></h2><p>For payments made by salon clients through SalonManager’s platform (e.g., for appointments or services):</p><ul><li>Refunds are subject to the salon’s own cancellation or refund policy, which is set by the salon owner and displayed during booking.</li><li>SalonManager processes refunds on behalf of the salon as instructed, deducting any applicable transaction fees charged by payment processors (e.g., Stripe, PayPal).</li><li>Clients must contact the salon directly to request a refund. SalonManager does not independently issue refunds for client transactions unless directed by the salon owner.</li><li>Refunded amounts will be returned to the original payment method within 5-10 business days, depending on the payment processor.</li><li>&nbsp;</li></ul><h2><strong>5. Non-Refundable Circumstances</strong></h2><p>Refunds will not be issued in the following cases:</p><ul><li>Failure to cancel a subscription before auto-renewal.</li><li>Dissatisfaction with the Services after the trial period or 30-day money-back guarantee (for annual plans).</li><li>Partial use of a billing cycle for monthly subscriptions.</li><li>Violation of our Terms of Service, including misuse of the platform or fraudulent activity.</li><li>Changes in pricing, promotions, or discounts after purchase.</li><li>Technical issues that are resolved promptly by our support team or are caused by user error, internet connectivity, or incompatible devices.</li><li>&nbsp;</li></ul><h2><strong>6. Exceptions</strong></h2><p>We may consider refund requests outside this policy on a case-by-case basis for exceptional circumstances (e.g., billing errors, service outages, or legal requirements). To request an exception, contact us at <a href=\"mailto:support@salonmanager.com\">support@salonmanager.com</a> with details of your situation. We reserve the right to approve or deny such requests at our discretion.</p><p>&nbsp;</p><h2><strong>7. How to Request a Refund</strong></h2><p>To request a refund:</p><ol><li>Contact our support team at <a href=\"mailto:support@salonmanager.com\">support@salonmanager.com</a> or through the helpdesk in your SalonManager account.</li><li>Provide your account details, payment confirmation, and reason for the refund request.</li><li>For salon client refunds, contact the salon directly, as they manage client transaction policies.</li></ol><p>We aim to respond to refund requests within 3-5 business days. Approved refunds will be processed to the original payment method within 7-10 business days, depending on the payment processor.</p><h2><strong>8. Chargebacks and Disputes</strong></h2><p>If you initiate a chargeback or payment dispute with your bank or payment provider without contacting us first, your SalonManager account may be suspended until the dispute is resolved. We encourage you to reach out to our support team to address any issues before filing a chargeback.</p><h2><strong>9. Changes to This Policy</strong></h2><p>We may update this Refund Policy to reflect changes in our practices or legal requirements. Updates will be posted on our website (<a href=\"http://www.salonmanager.com/refund-policy\">www.salonmanager.com/refund-policy</a>) with the effective date. Significant changes will be communicated via email or in-app notifications. Continued use of our Services after changes constitutes acceptance of the updated policy.</p><h2><strong>10. Contact Us</strong></h2><p>If you have questions, concerns, or requests regarding this Refund Policy, please contact us</p><p>&nbsp;</p><p><strong>SalonManager</strong></p><p>Thank you for choosing SalonManager. We are committed to providing transparent and fair refund practices to support your salon management needs.<br>&nbsp;</p>','admin@gmail.com','2025-06-13 13:34:30','2025-06-13 13:34:30'),(6,'terms','<h2>&nbsp;</h2><p>&nbsp;</p><p>Welcome to <strong>Salon Manager</strong> (“we,” “our,” or “us”). These Terms and Conditions govern your use of our platform and services, whether accessed via website, mobile app, or other means. By registering or using our services, you agree to these terms.</p><p>&nbsp;</p><h3><strong>1. Use of the Platform</strong></h3><p>You agree to use our platform only for managing salon operations such as appointments, customer details, staff scheduling, and reporting. You must be 18 years or older to register and use this service.</p><h3><strong>2. Account Registration</strong></h3><p>To access most features, you must create an account. You are responsible for maintaining the confidentiality of your login credentials and all activities under your account.</p><h3><strong>3. Subscription and Payments</strong></h3><p>Some features may require a paid subscription. By subscribing, you agree to pay all applicable fees and abide by the billing terms provided at the time of signup.</p><h3><strong>4. User Data and Content</strong></h3><p>You retain ownership of the content and client data you upload but grant us permission to store, process, and display it as needed to provide our service.</p><h3><strong>5. Prohibited Activities</strong></h3><p>You may not:</p><ul><li>Use the platform for illegal or unauthorized purposes.</li><li>Copy, modify, or reverse-engineer any part of the software.</li><li>Upload harmful code or content that infringes on others’ rights.</li></ul><h3><strong>6. Termination</strong></h3><p>We may suspend or terminate your account if you violate these terms or engage in harmful behavior on the platform.</p><h3><strong>7. Limitation of Liability</strong></h3><p>We are not liable for any indirect damages, data loss, or revenue loss arising from your use of our platform. Use is at your own risk.</p><h3><strong>8. Modifications</strong></h3><p>We reserve the right to update these terms. Continued use of the platform after changes are posted constitutes your acceptance.</p><h3><strong>9. Governing Law</strong></h3><p>These terms shall be governed by the laws of [Insert Country/State]. Any disputes will be resolved in local courts.</p>','admin@gmail.com','2025-06-13 13:37:08','2025-06-13 13:37:08');
/*!40000 ALTER TABLE `policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_settings`
--

DROP TABLE IF EXISTS `print_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `print_settings` (
  `tenant_id` int NOT NULL,
  `page_format` varchar(5) DEFAULT NULL,
  `header` varchar(2000) DEFAULT NULL,
  `footer` varchar(2000) DEFAULT NULL,
  `show_notes` tinyint(1) DEFAULT NULL,
  `is_enable_print` tinyint(1) DEFAULT NULL,
  `show_store_details` tinyint(1) DEFAULT NULL,
  `show_customer_details` tinyint(1) DEFAULT NULL,
  `print_token` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tenant_id`),
  CONSTRAINT `ps_tenantid_fk` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_settings`
--

LOCK TABLES `print_settings` WRITE;
/*!40000 ALTER TABLE `print_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `print_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qr_order_items`
--

DROP TABLE IF EXISTS `qr_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `status` enum('created','preparing','completed','cancelled','delivered') DEFAULT 'created',
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` varchar(255) DEFAULT NULL,
  `addons` mediumtext,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qr_order_items`
--

LOCK TABLES `qr_order_items` WRITE;
/*!40000 ALTER TABLE `qr_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `qr_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qr_orders`
--

DROP TABLE IF EXISTS `qr_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `delivery_type` varchar(90) DEFAULT NULL,
  `customer_type` enum('WALKIN','CUSTOMER') DEFAULT 'WALKIN',
  `customer_id` varchar(20) DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `status` enum('created','completed','cancelled') DEFAULT 'created',
  `payment_status` enum('pending','paid') DEFAULT 'pending',
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `tenantId` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qr_orders`
--

LOCK TABLES `qr_orders` WRITE;
/*!40000 ALTER TABLE `qr_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `qr_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refresh_tokens`
--

DROP TABLE IF EXISTS `refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_tokens` (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `refresh_token` varchar(500) NOT NULL,
  `device_ip` varchar(50) DEFAULT NULL,
  `device_name` varchar(255) DEFAULT NULL,
  `device_location` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `expiry` datetime DEFAULT NULL,
  `device_id` int NOT NULL AUTO_INCREMENT,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`device_id`,`username`,`refresh_token`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `refresh_tokens_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_tokens`
--

LOCK TABLES `refresh_tokens` WRITE;
/*!40000 ALTER TABLE `refresh_tokens` DISABLE KEYS */;
INSERT INTO `refresh_tokens` VALUES ('raja@gmail.com','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnRfaWQiOjE1LCJ1c2VybmFtZSI6InJhamFAZ21haWwuY29tIiwibmFtZSI6InJhamEiLCJyb2xlIjoiYWRtaW4iLCJzY29wZSI6bnVsbCwiaXNfYWN0aXZlIjowLCJpYXQiOjE3NDk3OTcwNTksImV4cCI6MTc1MjM4OTA1OSwiaXNzIjoibG9jYWxob3N0In0.0bKB9bcYIbY1uNnEu5O0nEgvio1LQNvmViOwEYktw80','::1','Microsoft Windows\nBrowser: Edge','','2025-06-13 12:14:19','2025-07-13 12:14:19',83,15),('salonmanager@gmail.com','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnRfaWQiOjE2LCJ1c2VybmFtZSI6InNhbG9ubWFuYWdlckBnbWFpbC5jb20iLCJuYW1lIjoiU2Fsb24iLCJyb2xlIjoiYWRtaW4iLCJzY29wZSI6bnVsbCwiaXNfYWN0aXZlIjoxLCJpYXQiOjE3NDk4MDIxOTAsImV4cCI6MTc1MjM5NDE5MCwiaXNzIjoibG9jYWxob3N0In0.cOZaIS5waitmsmt-yQ8DZWct8SH58LhFW-HetlPyyAQ','::1','Microsoft Windows\nBrowser: Chrome','','2025-06-13 13:39:50','2025-07-13 13:39:50',88,16);
/*!40000 ALTER TABLE `refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(20) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  `people_count` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `unique_code` varchar(20) DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_index` (`unique_code`) USING BTREE,
  KEY `INDEX` (`date`) USING BTREE,
  KEY `INDEX_CUSTOMER_SEARCH` (`customer_id`) USING BTREE,
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (13,'7485963254','2025-06-13 13:47:00',12,'booked','Mettig Purpose',3,'2025-06-13 13:48:03','2025-06-13 13:48:03','f6B0L7rWLa',16),(14,'9652324589','2025-06-13 13:54:00',13,'booked','Company Purpose',5,'2025-06-13 13:48:38','2025-06-13 13:48:38','BWmFxQ9xCH',16),(15,'8596325563','2025-06-13 13:56:00',12,'booked','Client Metting',3,'2025-06-13 13:50:29','2025-06-13 13:50:29','K92U3sXQ_W',16),(16,'7415263635','2025-06-13 13:45:00',13,'paid','Student meeting',4,'2025-06-13 13:50:58','2025-06-13 13:50:58','i5FwLaaeO3',16);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset_password_tokens`
--

DROP TABLE IF EXISTS `reset_password_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reset_password_tokens` (
  `username` varchar(255) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reset_password_tokens`
--

LOCK TABLES `reset_password_tokens` WRITE;
/*!40000 ALTER TABLE `reset_password_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `reset_password_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_details`
--

DROP TABLE IF EXISTS `store_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_details` (
  `store_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  `is_qr_menu_enabled` tinyint(1) DEFAULT '0',
  `unique_qr_code` varchar(255) DEFAULT NULL,
  `is_qr_order_enabled` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `tenant_id_pk` (`tenant_id`) USING BTREE,
  CONSTRAINT `store_details_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_details`
--

LOCK TABLES `store_details` WRITE;
/*!40000 ALTER TABLE `store_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_tables`
--

DROP TABLE IF EXISTS `store_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_tables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_title` varchar(100) DEFAULT NULL,
  `floor` varchar(50) DEFAULT NULL,
  `seating_capacity` smallint DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `store_tables_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_tables`
--

LOCK TABLES `store_tables` WRITE;
/*!40000 ALTER TABLE `store_tables` DISABLE KEYS */;
INSERT INTO `store_tables` VALUES (11,'Seat 2','4',5,14),(12,'Seat 1','1',4,16),(13,'Seat 2','2',5,16);
/*!40000 ALTER TABLE `store_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_history`
--

DROP TABLE IF EXISTS `subscription_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tenant_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `starts_on` datetime DEFAULT NULL,
  `expires_on` datetime DEFAULT NULL,
  `status` enum('updated','created','cancelled') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `subscription_history_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_history`
--

LOCK TABLES `subscription_history` WRITE;
/*!40000 ALTER TABLE `subscription_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `duration_months` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` text,
  `admin_username` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (1,'Monthly',3,149.00,'Monthly Suscription','admin@gmail.com',1,'2025-06-12 04:13:27','2025-06-12 04:13:33'),(2,'Monthly Subsciption',36,499.00,'3 Year ','admin@gmail.com',1,'2025-06-12 04:30:40','2025-06-12 04:30:40');
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `superadmins`
--

DROP TABLE IF EXISTS `superadmins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `superadmins` (
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `superadmins`
--

LOCK TABLES `superadmins` WRITE;
/*!40000 ALTER TABLE `superadmins` DISABLE KEYS */;
INSERT INTO `superadmins` VALUES ('admin@gmail.com','admin','Super Admin');
/*!40000 ALTER TABLE `superadmins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `type` enum('inclusive','exclusive','other') DEFAULT 'other',
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `taxes_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES (2,'Exclusive Tax',5,'exclusive',14),(3,'Exclusive ',5,'exclusive',16);
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenants`
--

DROP TABLE IF EXISTS `tenants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(95) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `subscription_id` varchar(255) DEFAULT NULL,
  `payment_customer_id` varchar(255) DEFAULT NULL,
  `subscription_start` datetime DEFAULT NULL,
  `subscription_end` datetime DEFAULT NULL,
  `subscription_duration_months` int DEFAULT NULL,
  `subscription_price` decimal(10,2) DEFAULT NULL,
  `subscription_duration_text` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenants`
--

LOCK TABLES `tenants` WRITE;
/*!40000 ALTER TABLE `tenants` DISABLE KEYS */;
INSERT INTO `tenants` VALUES (14,'Admin',1,'order_1749701674796','14','2025-06-12 09:45:11','2025-09-12 09:45:11',3,149.00,'3 months','2025-06-12 09:01:20'),(15,'raja',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-13 12:14:09'),(16,'Salon',1,'order_1749802135042','16','2025-06-13 13:39:31','2028-06-13 13:39:31',36,499.00,'3 years','2025-06-13 13:38:45');
/*!40000 ALTER TABLE `tenants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_sequences`
--

DROP TABLE IF EXISTS `token_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_sequences` (
  `tenant_id` int NOT NULL,
  `sequence_no` int DEFAULT NULL,
  `last_updated` date DEFAULT NULL,
  PRIMARY KEY (`tenant_id`),
  CONSTRAINT `token_sequences_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_sequences`
--

LOCK TABLES `token_sequences` WRITE;
/*!40000 ALTER TABLE `token_sequences` DISABLE KEYS */;
INSERT INTO `token_sequences` VALUES (14,3,'2025-06-12'),(16,10,'2025-06-13');
/*!40000 ALTER TABLE `token_sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(95) DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `photo` varchar(2000) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin@gmail.com','$2b$10$lbuvx/goQlxhaBVRw.DYSehTg7RtNc2AzBGafmXzSwL7ob3iE/fDG','Admin','admin',NULL,NULL,NULL,NULL,NULL,14),('ashu@gmail.com','$2b$10$L.zAmmcVQ1mSZi/h6KPbk.ynaCxJm10PtmRu896qWG7t6xzrcSX5i','Ashu','user',NULL,'Admin ','8541874720',NULL,'DASHBOARD,POS,CUSTOMER_DISPLAY,KITCHEN_DISPLAY',14),('raja@gmail.com','$2b$10$0nlxag6vyiLHjntDsoMbGe6yAHrXBHIe4uWgN8NofcMwkmkT4ijae','raja','admin',NULL,NULL,NULL,NULL,NULL,15),('salonmanager@gmail.com','$2b$10$0UUyZlk6Fzfsn/hGuyuMJ.14pICfhSPSoNG1g6v.DcSAPST31ip7u','Salon','admin',NULL,NULL,NULL,NULL,NULL,16);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-13 14:01:42
