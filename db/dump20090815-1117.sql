-- MySQL dump 10.13  Distrib 5.1.34, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: finanze_development
-- ------------------------------------------------------
-- Server version	5.1.34-1ubuntu1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Stipendio','2009-08-14 20:34:37','2009-08-14 20:34:37');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `bancomat` tinyint(1) DEFAULT NULL,
  `ufficio` tinyint(1) DEFAULT NULL,
  `buoni` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
INSERT INTO `expenses` VALUES (25,'Pranzo Locanda',0,'Cibo',0,1,1,'2009-07-21 17:15:19','2009-07-21 17:15:19','2009-07-21'),(26,'Focaccia',-1.3,'Cibo',0,0,0,'2009-07-21 17:15:52','2009-07-21 17:15:52','2009-07-21'),(27,'Pranzo terme Premia',-15,'Cibo',0,0,0,'2009-07-21 17:17:06','2009-07-21 17:17:06','2009-06-21'),(28,'Ingresso terme Premia',-20,'Altro',0,0,0,'2009-07-21 17:17:27','2009-07-21 17:17:27','2009-06-21'),(29,'Pranzo osteriaccia',-10,'Cibo',0,1,0,'2009-07-21 17:17:49','2009-07-21 17:21:16','2009-06-22'),(30,'Pranzo Kebab',-1,'Cibo',0,1,1,'2009-07-21 17:24:01','2009-07-21 17:24:01','2009-06-23'),(31,'Pranzo pizza Santa Maria',0,'Cibo',0,1,2,'2009-07-21 17:24:40','2009-07-21 17:24:40','2009-06-24'),(32,'Benza scooter (1.329 euro al litro)',-5.17,'Benza',1,0,0,'2009-07-21 17:25:27','2009-07-21 17:29:12','2009-06-25'),(33,'Scarpe nike total 90',-37,'Altro',1,0,0,'2009-07-21 17:26:13','2009-07-21 17:26:13','2009-06-28'),(34,'Mostra Milano Scapigliatura',-8,'Altro',0,0,0,'2009-07-21 17:26:39','2009-07-21 17:26:39','2009-06-28'),(35,'Cena con Ele in Duomo',-26,'Cibo',0,0,0,'2009-07-21 17:27:04','2009-07-21 17:27:04','2009-06-28'),(36,'Da Ele per autobus',6,'Altro',0,0,0,'2009-07-21 17:27:25','2009-07-21 17:27:25','2009-06-28'),(37,'Decathlon',-20,'Altro',0,0,0,'2009-07-21 17:27:56','2009-07-21 17:27:56','2009-06-28'),(38,'Pranzo Osteriaccia',-0.2,'Cibo',0,1,1,'2009-07-21 17:28:17','2009-07-21 17:28:17','2009-06-29'),(39,'Pranzo pizza cinese',-1,'Cibo',0,1,2,'2009-07-21 17:28:36','2009-07-21 17:28:36','2009-06-30'),(46,'Pranzo osteriaccia',0,'Cibo',0,1,2,'2009-07-22 17:20:35','2009-07-22 17:20:35','2009-07-01'),(47,'Pranzo kebab',-1.2,'Cibo',0,1,1,'2009-07-22 17:20:35','2009-07-22 17:20:35','2009-07-02'),(48,'Le scienze',-3.9,'Altro',0,0,0,'2009-07-22 17:20:35','2009-07-22 17:20:35','2009-07-02'),(49,'Esselunga',-9.32,'Cibo',0,0,0,'2009-07-22 17:22:42','2009-07-22 17:22:42','2009-07-04'),(50,'Spesa pranzo conad',-5.9,'Cibo',0,0,0,'2009-07-22 17:22:42','2009-07-22 17:22:42','2009-07-06'),(51,'Prenotazione campo tennis',-13,'Altro',0,0,0,'2009-07-22 17:22:42','2009-07-22 17:22:42','2009-07-06'),(52,'Prelievo bancomat',-150,'Prelievo bancomat',1,0,0,'2009-07-22 17:22:42','2009-07-22 17:22:42','2009-07-07'),(53,'Prelievo bancomat',150,'Prelievo bancomat',0,0,0,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-07'),(54,'Birra a birrificio lambrate',-4.5,'Cibo',0,0,0,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-07'),(55,'Gelato con ele',-5,'Cibo',0,0,0,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-08'),(56,'Pranzo s. maria',-0.8,'Cibo',0,1,2,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-08'),(57,'Pranzo s. maria',0,'Cibo',0,1,2,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-07'),(58,'Spesa conad ombrello e coca cola',-5.9,'Altro',0,0,0,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-08'),(59,'Prenotazione campo tennis',-13,'Altro',0,0,0,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-09'),(60,'Dampyr',-2.7,'Altro',0,0,0,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-09'),(61,'Solange',-30,'Cibo',0,0,0,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-10'),(62,'Pranzo kebab',0,'Cibo',0,1,2,'2009-07-22 17:26:27','2009-07-22 17:26:27','2009-07-10'),(63,'Benza',-55,'Benza',1,0,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-11'),(64,'Dvd recorder',-149,'Elettronica',1,0,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-11'),(65,'Terme di premia',-20,'Altro',0,0,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-12'),(66,'Pranzo agriturismo premia',-36,'Cibo',0,0,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-12'),(67,'Pizza ufficio',-6,'Cibo',0,1,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-13'),(68,'Prelievo bancomat',-150,'Prelievo bancomat',1,0,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-14'),(69,'Prelievo bancomat',150,'Prelievo bancomat',0,0,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-14'),(70,'Pranzo jappo e buono di jacopo',-14.8,'Cibo',0,1,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-15'),(71,'Focaccia',-1.5,'Cibo',0,0,0,'2009-07-22 17:31:32','2009-07-22 17:31:32','2009-07-15'),(72,'Borsello + regalo xa',-48,'Abbigliamento',1,0,0,'2009-07-22 17:31:32','2009-08-05 17:18:52','2009-07-18'),(73,'Pranzo Locanda',-6.5,'Cibo',0,1,0,'2009-07-22 17:32:57','2009-07-23 06:36:36','2009-07-20'),(75,'Pranzo jappo',0,'Cibo',0,1,2,'2009-07-23 06:16:16','2009-07-23 06:16:16','2009-07-22'),(76,'Pranzo locanda',-4.8,'Cibo',0,1,0,'2009-07-23 06:38:24','2009-07-23 06:38:24','2009-07-16'),(77,'Pranzo locanda',-4.8,'Cibo',0,1,0,'2009-07-23 06:38:24','2009-07-23 06:38:24','2009-07-17'),(78,'Pranzo kebab',-1.6,'Cibo',0,1,2,'2009-07-23 12:36:54','2009-07-23 12:36:54','2009-07-23'),(79,'Agriturismo battignana',-120,'Cibo',1,0,0,'2009-07-27 06:08:17','2009-07-27 06:08:17','2009-07-26'),(80,'Da ele per agriturismo',50,'Cibo',0,0,0,'2009-07-27 06:08:17','2009-07-27 06:08:17','2009-07-26'),(81,'Focaccia e caffè',-2.3,'Cibo',0,0,0,'2009-07-27 07:52:09','2009-07-27 07:52:09','2009-07-27'),(82,'Pranzo locanda',-1.3,'Cibo',0,1,1,'2009-07-27 17:05:44','2009-07-27 17:05:44','2009-07-27'),(83,'Pizza ufficio',0,'Cibo',0,1,1,'2009-07-29 06:10:36','2009-07-29 06:10:50','2009-07-28'),(84,'Abbonamento treno e metro',-80,'Altro',1,0,0,'2009-07-29 06:23:59','2009-07-29 06:23:59','2009-07-28'),(85,'Brioche',-0.75,'Cibo',0,0,0,'2009-07-29 07:10:46','2009-07-29 07:10:46','2009-07-29'),(86,'Ricarica postepay',-50,'Prelievo bancomat',0,0,0,'2009-07-30 05:49:58','2009-07-30 05:49:58','2009-07-29'),(87,'Pranzo jappo',-10,'Cibo',0,1,0,'2009-07-30 05:49:58','2009-07-30 05:49:58','2009-07-29'),(88,'Pranzo teatro',-1,'Cibo',0,1,2,'2009-07-30 12:19:15','2009-07-30 12:19:15','2009-07-30'),(89,'Pranzo locanda',-0.7,'Cibo',0,1,1,'2009-07-31 16:34:00','2009-07-31 16:34:00','2009-07-31'),(90,'Hard disk 1tb mio',-69.9,'Elettronica',1,0,0,'2009-08-03 05:58:35','2009-08-03 05:58:35','2009-08-01'),(91,'Hard disk 1tb xa + chiavetta usb',-75,'Elettronica',1,0,0,'2009-08-03 05:58:35','2009-08-03 05:58:35','2009-08-01'),(92,'Le scienze, linux pro',-10,'Altro',0,0,0,'2009-08-03 05:59:47','2009-08-03 05:59:47','2009-07-31'),(93,'Pranzo taverna',-3.2,'Cibo',0,1,1,'2009-08-03 16:59:05','2009-08-03 16:59:05','2009-08-03'),(94,'Stipendio',1180,'Stipendio',1,1,0,'2009-08-03 17:26:25','2009-08-05 17:19:18','2009-07-30'),(95,'Pranzo kebab',-1.6,'Cibo',0,1,1,'2009-08-05 07:19:20','2009-08-05 07:19:20','2009-08-04'),(96,'Revisione auto',-100,'Auto',0,0,0,'2009-08-05 07:20:47','2009-08-05 17:17:21','2009-08-04'),(97,'Regalo mamma',-60,'Altro',0,0,0,'2009-08-05 07:20:47','2009-08-05 07:20:47','2009-08-04'),(98,'Prelievo bancomat',-250,'Prelievo bancomat',1,0,0,'2009-08-05 07:20:47','2009-08-05 07:20:47','2009-08-04'),(99,'Prelievo bancomat',250,'Prelievo bancomat',0,0,0,'2009-08-05 07:20:47','2009-08-05 07:20:47','2009-08-04'),(100,'Pizza ufficio',0,'Cibo',0,1,1,'2009-08-05 11:07:33','2009-08-05 17:16:36','2009-08-05'),(101,'Basco beige',-18,'Abbigliamento',0,0,0,'2009-08-05 15:48:58','2009-08-05 17:18:06','2009-08-04'),(102,'Benza scooter',-4.8,'Benza',0,0,0,'2009-08-06 09:43:07','2009-08-06 09:43:07','2009-08-06'),(103,'Focaccia',-2.3,'Cibo',0,0,0,'2009-08-07 07:27:24','2009-08-07 07:27:24','2009-08-07'),(104,'Gazzetta',-1,'Altro',0,0,0,'2009-08-07 07:27:25','2009-08-07 07:27:25','2009-08-07'),(105,'Spesa gigante',-46,'Altro',1,0,0,'2009-08-10 11:52:42','2009-08-10 11:52:42','2009-08-08'),(106,'Cena solange con ele',-20,'Cibo',1,0,0,'2009-08-10 11:52:42','2009-08-10 11:52:42','2009-08-09'),(107,'Pizza ufficio',-1,'Cibo',0,1,1,'2009-08-10 11:52:42','2009-08-10 11:52:42','2009-08-10'),(108,'Cuffie ipod + volanti wii ele',-35,'Elettronica',0,0,0,'2009-08-11 06:47:25','2009-08-11 06:47:25','2009-08-10'),(109,'Pizza bottega',0,'Cibo',0,1,2,'2009-08-12 06:28:35','2009-08-12 06:28:35','2009-08-11'),(110,'Pizza ufficio',0,'Cibo',0,1,1,'2009-08-13 16:02:07','2009-08-13 16:02:07','2009-08-12'),(111,'Panzerotti ufficio',0,'Cibo',0,1,1,'2009-08-13 16:02:30','2009-08-13 16:02:30','2009-08-13'),(112,'Focaccia ufficio',0,'Cibo',0,1,1,'2009-08-14 15:09:02','2009-08-14 15:09:02','2009-08-14');
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090714170636'),('20090714170717'),('20090814194259'),('20090814194945');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-08-15  9:17:58
