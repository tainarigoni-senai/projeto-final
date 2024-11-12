CREATE DATABASE  IF NOT EXISTS `gestao_hoteleira` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestao_hoteleira`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: gestao_hoteleira
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acomodacao`
--

DROP TABLE IF EXISTS `acomodacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acomodacao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `valor_diaria` float(9,2) NOT NULL DEFAULT '0.00',
  `limite_hospedes` int NOT NULL DEFAULT '1',
  `descricao` text,
  `id_funcionario_responsavel` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acomodacao_funcionario_fk_idx` (`id_funcionario_responsavel`),
  CONSTRAINT `acomodacao_funcionario_fk` FOREIGN KEY (`id_funcionario_responsavel`) REFERENCES `funcionario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acomodacao`
--

LOCK TABLES `acomodacao` WRITE;
/*!40000 ALTER TABLE `acomodacao` DISABLE KEYS */;
INSERT INTO `acomodacao` VALUES (1,'Suíte com cozinha',300.00,3,'Ideal para casal',2),(2,'Chalé Família',500.00,5,'Ideal para família',2);
/*!40000 ALTER TABLE `acomodacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pessoa` int NOT NULL,
  `fidelidade` tinyint(1) NOT NULL DEFAULT '0',
  `observacao` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pessoa_UNIQUE` (`id_pessoa`),
  KEY `cliente_pessoa_idx` (`id_pessoa`),
  CONSTRAINT `cliente_pessoa_fk` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,3,0,NULL),(2,4,1,'Cliente muito bom');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pessoa` int NOT NULL,
  `cargo` varchar(100) NOT NULL,
  `salario` float(9,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pessoa_UNIQUE` (`id_pessoa`),
  KEY `funcionario_pessoa_fk_idx` (`id_pessoa`),
  CONSTRAINT `funcionario_pessoa_fk` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,1,'Serviços Gerais',3000.00),(2,2,'Camareira',2500.00);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacote`
--

DROP TABLE IF EXISTS `pacote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pacote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_acomodacao` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `qtd_diarias` int NOT NULL DEFAULT '1',
  `valor_total` float(9,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `pacote_acomodacao_fk_idx` (`id_acomodacao`),
  CONSTRAINT `pacote_acomodacao_fk` FOREIGN KEY (`id_acomodacao`) REFERENCES `acomodacao` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacote`
--

LOCK TABLES `pacote` WRITE;
/*!40000 ALTER TABLE `pacote` DISABLE KEYS */;
INSERT INTO `pacote` VALUES (1,1,'Reveillon',3,2000.00),(2,1,'Baixa Temporada',2,400.00);
/*!40000 ALTER TABLE `pacote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_completo` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `documento` varchar(30) NOT NULL,
  `pais` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'João Costa Oliveira','1970-01-10','123','Brasil','SC','Tubarão'),(2,'Beatriz Martínez García','1964-05-15','364','Argentina','SF','Buenos Aires'),(3,'Pedro Silva Oliveira','1952-09-20','378','Brasil','MG','Rio de Janeiro'),(4,'Ana Rodrigues Souza','1977-02-14','481','Brasil','SP','São Paulo');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_acomodacao` int NOT NULL,
  `id_cliente_responsavel` int NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  `valor_total` float(9,2) DEFAULT '0.00',
  `qtd_hospedes` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `reserva_cliente_fk_idx` (`id_cliente_responsavel`),
  KEY `reserva_acomodacao_fk_idx` (`id_acomodacao`),
  CONSTRAINT `reserva_acomodacao_fk` FOREIGN KEY (`id_acomodacao`) REFERENCES `acomodacao` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserva_cliente_fk` FOREIGN KEY (`id_cliente_responsavel`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,1,1,'2024-09-30','2024-10-01',300.00,2),(2,2,1,'2024-12-10','2024-12-15',2000.00,4);
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-11 13:52:01
