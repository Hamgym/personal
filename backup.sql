-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: mygo
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (97,'77'),(56,'AGF'),(69,'cama cafe'),(74,'Casa卡薩'),(20,'Coca-Cola 可口可樂'),(81,'Enaak'),(98,'Gemez Enaak'),(77,'illy'),(88,'Julies 茱蒂絲'),(83,'KID-O'),(5,'KIRIN 麒麟'),(104,'Lay’s 樂事'),(61,'NESCAFE Dolce Gusto'),(57,'NESCAFE 雀巢咖啡'),(63,'Old Town舊街場'),(64,'STARBUCKS 星巴克'),(54,'UCC'),(102,'中祥'),(9,'亞大T8銀耳'),(19,'伯朗咖啡'),(6,'光泉'),(103,'北田'),(2,'原萃'),(3,'台東初鹿'),(96,'品客 Pringles'),(93,'多力多滋'),(14,'悅氏'),(12,'愛之味'),(85,'旺旺'),(101,'本味誠現'),(1,'每朝健康'),(53,'湛盧咖啡'),(86,'盛香珍'),(22,'統一'),(75,'義大利金杯咖啡'),(13,'義美'),(25,'舒跑'),(16,'苗栗南庄鄉農會'),(24,'茶裏王'),(58,'西雅圖'),(11,'青森農協'),(82,'青鳥旅行'),(210,'麥香'),(8,'黑松');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (53,'咖啡'),(61,'食品飲料'),(1,'飲料'),(80,'餅乾');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lists`
--

DROP TABLE IF EXISTS `lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `item` varchar(255) NOT NULL,
  `specs` varchar(255) NOT NULL,
  `bought` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `lists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lists`
--

LOCK TABLES `lists` WRITE;
/*!40000 ALTER TABLE `lists` DISABLE KEYS */;
INSERT INTO `lists` VALUES (46,1,'測試商品','全家',0);
/*!40000 ALTER TABLE `lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` int NOT NULL,
  `brand` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `percent` tinyint DEFAULT '0',
  `review` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_product` (`category`,`brand`,`name`),
  KEY `brand` (`brand`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`brand`) REFERENCES `brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,53,53,'經典獨家．綜合風味','https://i3.momoshop.com.tw/1747995032/goodsimg/0013/704/397/13704397_OL.webp',0,0),(2,53,54,'職人咖啡豆綜合','https://i4.momoshop.com.tw/1747976496/goodsimg/0013/689/865/13689865_OL.webp',0,0),(3,53,54,'職人系列典藏/炭燒/法式風味濾掛式咖啡','https://i1.momoshop.com.tw/1747893564/goodsimg/0013/267/164/13267164_OL.webp',0,0),(4,53,56,'即溶黑咖啡X','https://i3.momoshop.com.tw/1747812600/goodsimg/0010/184/529/10184529_OL.webp',0,0),(5,53,57,'金牌微研磨咖啡紅利組','https://i2.momoshop.com.tw/1740450793/goodsimg/0005/484/499/5484499_OL.webp',0,0),(6,53,58,'貝瑞斯塔二合一/三合一x','https://i1.momoshop.com.tw/1747188348/goodsimg/0010/728/247/10728247_OL.webp',0,0),(8,53,58,'貝瑞斯塔咖啡豆','https://i3.momoshop.com.tw/1747894417/goodsimg/0011/973/628/11973628_OL.webp',0,0),(9,53,54,'職人珈琲豆','https://i4.momoshop.com.tw/1747893586/goodsimg/0010/639/237/10639237_OL.webp',0,0),(10,53,63,'白咖啡','https://i4.momoshop.com.tw/1745716984/goodsimg/0004/716/943/4716943_OL.webp',0,0),(11,53,64,'特選系列-抹茶拿鐵','https://i4.momoshop.com.tw/1747619959/goodsimg/0011/803/749/11803749_OL.webp',0,0),(12,53,57,'金牌微研磨咖啡補充包','https://i3.momoshop.com.tw/1747719285/goodsimg/0009/277/141/9277141_OL.webp',0,0),(13,53,54,'冠軍監修綜合濾掛式咖啡x','https://i1.momoshop.com.tw/1747966219/goodsimg/0013/897/459/13897459_OL.webp',0,0),(14,53,53,'莊園單品淺烘焙綜合．手沖精品濾掛式咖啡','https://i1.momoshop.com.tw/1748020007/goodsimg/0013/587/870/13587870_OL.webp',0,0),(15,53,19,'伯朗精選咖啡豆','https://i4.momoshop.com.tw/1747626065/goodsimg/0013/329/336/13329336_OL.webp',0,0),(16,53,69,'尋豆師精選咖啡豆','https://i2.momoshop.com.tw/1740448417/goodsimg/0008/532/502/8532502_OL.webp',0,0),(17,53,64,'特選系列-即溶咖啡','https://i1.momoshop.com.tw/1747285319/goodsimg/0007/718/502/7718502_OL.webp',0,0),(19,53,64,'特選系列-白雪摩卡咖啡','https://i4.momoshop.com.tw/1747626360/goodsimg/0013/702/681/13702681_OL.webp',0,0),(20,53,64,'Nespresso精選膠囊','https://i2.momoshop.com.tw/1747719711/goodsimg/0011/897/420/11897420_OL.webp',0,0),(21,53,74,'世界莊園單品濾掛咖啡綜合','https://i2.momoshop.com.tw/1747188380/goodsimg/0007/005/417/7005417_OL.webp',0,0),(22,53,75,'女王咖啡豆','https://i4.momoshop.com.tw/1746686348/goodsimg/0011/182/176/11182176_OL.webp',0,0),(24,53,77,'義大利咖啡豆','https://i3.momoshop.com.tw/1727341012/goodsimg/0012/760/652/12760652_OL.webp',0,0),(25,53,57,'金牌微研磨咖啡低咖啡因','https://i4.momoshop.com.tw/1741928621/goodsimg/0006/170/911/6170911_OL.webp',0,0),(26,53,56,'即溶黑咖啡','https://i2.momoshop.com.tw/1738551541/goodsimg/0013/393/494/13393494_OL.webp',0,0),(27,80,13,'義美天然取向蘇打餅','https://i3.momoshop.com.tw/1732770264/goodsimg/0013/490/206/13490206_OL.webp',0,0),(28,80,81,'韓式小雞麵','https://i1.momoshop.com.tw/1698919007/goodsimg/0004/176/549/4176549_OL.webp',0,0),(29,80,82,'蒲光漫舞-','https://i3.momoshop.com.tw/1747973056/goodsimg/0011/332/601/11332601_OL.webp',0,0),(30,80,83,'三明治餅乾綜合風味歡樂包/奶油風味歡喜包','https://i4.momoshop.com.tw/1706850283/goodsimg/0012/511/368/12511368_OL.webp',0,0),(31,80,13,'義美清香檸檬夾心酥','https://i1.momoshop.com.tw/1693068653/goodsimg/0008/850/144/8850144_OL.webp',0,0),(32,80,85,'仙貝經濟包','https://i3.momoshop.com.tw/1738895285/goodsimg/0009/917/310/9917310_OL.webp',0,0),(33,80,86,'餅乾量販包','https://i3.momoshop.com.tw/1720574762/goodsimg/0002/743/997/2743997_OL.webp',0,0),(34,80,13,'起司取向蘇打餅乾袋裝','https://i4.momoshop.com.tw/1692976545/goodsimg/0008/448/012/8448012_OL.webp',0,0),(35,80,88,'手提餅乾系列','https://i3.momoshop.com.tw/1692636979/goodsimg/0005/690/554/5690554_OL.webp',0,0),(36,80,85,'厚燒海苔經濟包','https://i2.momoshop.com.tw/1693174620/goodsimg/0009/978/633/9978633_OL.webp',0,0),(37,80,85,'米豆米果經濟包','https://i4.momoshop.com.tw/1692637915/goodsimg/0005/742/278/5742278_OL.webp',0,0),(38,80,85,'旺仔雪餅經濟包','https://i3.momoshop.com.tw/1692200828/goodsimg/0010/072/806/10072806_OL.webp',0,0),(39,80,13,'美味蘇打餅','https://i4.momoshop.com.tw/1732856598/goodsimg/0004/323/153/4323153_OL.webp',0,0),(40,80,93,'多力多滋組合包系列','https://i2.momoshop.com.tw/1741755666/goodsimg/0012/955/755/12955755_OL.webp',0,0),(41,80,13,'香濃花生夾心酥經濟包','https://i2.momoshop.com.tw/1721473443/goodsimg/0008/850/143/8850143_OL.webp',0,0),(42,80,82,'灌餡蛋捲旅行盒','https://i4.momoshop.com.tw/1744595294/goodsimg/0012/964/918/12964918_OL.webp',0,0),(43,80,96,'品客洋芋片任選口味','https://i4.momoshop.com.tw/1746430650/goodsimg/0011/892/968/11892968_OL.webp',0,0),(44,80,97,'綜合享樂包_迷你新貴派/迷你巧菲斯','https://i1.momoshop.com.tw/1717218351/goodsimg/0011/461/763/11461763_OL.webp',0,0),(45,80,98,'韓式小雞麵辣味','https://i2.momoshop.com.tw/1692721533/goodsimg/0006/519/989/6519989_OL.webp',0,0),(46,80,13,'狀元煎餅-花生','https://i2.momoshop.com.tw/1692549395/goodsimg/0004/286/165/4286165_OL.webp',0,0),(47,80,81,'香辣小雞麵','https://i4.momoshop.com.tw/1711083738/goodsimg/0004/958/798/4958798_OL.webp',0,0),(48,80,101,'大包/立袋裝','https://i4.momoshop.com.tw/1744866132/goodsimg/0011/023/001/11023001_OL.webp',0,0),(49,80,102,'蔥向第一餅','https://i1.momoshop.com.tw/1745906588/goodsimg/0013/845/337/13845337_OL.webp',0,0),(50,80,103,'蒟蒻糙米捲-綜合口味','https://i4.momoshop.com.tw/1692548777/goodsimg/0004/239/186/4239186_OL.webp',0,0),(51,80,104,'樂事洋芋片隨手包','https://i4.momoshop.com.tw/1740459691/goodsimg/0007/373/730/7373730_OL.webp',60,1),(52,80,104,'樂事意合組合包','https://i4.momoshop.com.tw/1721610241/goodsimg/0010/025/059/10025059_OL.webp',0,0),(53,1,1,'無糖綠茶','https://i1.momoshop.com.tw/1746672068/goodsimg/0011/103/660/11103660_OL.webp',0,0),(54,1,2,'無糖茶','https://i3.momoshop.com.tw/1735621507/goodsimg/0011/103/128/11103128_OL.webp',0,0),(55,1,3,'原味保久乳','https://i4.momoshop.com.tw/1748056767/goodsimg/0010/558/277/10558277_OL.webp',0,0),(56,1,2,'無糖茶寶特瓶系列','https://i4.momoshop.com.tw/1744078892/goodsimg/0011/145/331/11145331_OL.webp',0,0),(57,1,5,'生茶','https://i1.momoshop.com.tw/1747619507/goodsimg/0011/041/099/11041099_OL.webp',0,0),(58,1,6,'全脂保久乳','https://i1.momoshop.com.tw/1747968034/goodsimg/0008/938/732/8938732_OL.webp',0,0),(59,1,2,'無糖冷萃茶','https://i3.momoshop.com.tw/1746238025/goodsimg/0007/517/628/7517628_OL.webp',0,0),(60,1,8,'FIN補給飲料','https://i4.momoshop.com.tw/1716267846/goodsimg/0005/617/109/5617109_OL.webp',0,0),(61,1,9,'冰糖原味白木耳露','https://i2.momoshop.com.tw/1747996130/goodsimg/0004/811/545/4811545_OL.webp',0,0),(63,1,11,'希望之雫蘋果汁','https://i1.momoshop.com.tw/1747623070/goodsimg/0012/858/393/12858393_OL.webp',0,0),(64,1,12,'純濃燕麥','https://i4.momoshop.com.tw/1747446290/goodsimg/0001/028/644/1028644_OL.webp',0,0),(65,1,13,'原味保久乳','https://i1.momoshop.com.tw/1747275631/goodsimg/0013/623/634/13623634_OL.webp',0,0),(66,1,14,'悅氏天然水','https://i1.momoshop.com.tw/1712123943/goodsimg/0005/312/563/5312563_OL.webp',0,0),(68,1,16,'有機黑木耳露','https://i1.momoshop.com.tw/1747900297/goodsimg/0010/036/181/10036181_OL.webp',0,0),(70,1,13,'元氣無加糖/低糖豆奶系列','https://i1.momoshop.com.tw/1747712538/goodsimg/0009/487/127/9487127_OL.webp',0,0),(71,1,19,'伯朗咖啡','https://i4.momoshop.com.tw/1722696122/goodsimg/0004/912/836/4912836_OL.webp',0,0),(72,1,20,'易開罐','https://i4.momoshop.com.tw/1693991626/goodsimg/0005/327/666/5327666_OL.webp',0,0),(73,1,6,'調味奶保久乳','https://i4.momoshop.com.tw/1744192393/goodsimg/0012/030/236/12030236_OL.webp',0,0),(74,1,22,'陽光無加糖豆奶','https://i2.momoshop.com.tw/1747015885/goodsimg/0009/195/625/9195625_OL.webp',0,0),(76,1,24,'日式無糖綠茶','https://i4.momoshop.com.tw/1735966944/goodsimg/0003/984/783/3984783_OL.webp',0,0),(77,1,25,'原味運動飲料鋁箔包','https://i3.momoshop.com.tw/1747986380/goodsimg/0007/882/947/7882947_OL.webp',0,0),(78,1,1,'熟藏紅茶-無糖','https://i1.momoshop.com.tw/1735275712/goodsimg/0013/579/554/13579554_OL.webp',0,0),(79,1,210,'阿薩姆紅茶','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/f09ef3b2',100,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` tinyint NOT NULL,
  `likes` int unsigned NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_anonymous` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_product_user` (`product_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `review_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,51,1,3,1,'已購買，小孩愛吃，就是空氣多了些。','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/9805e957',0,'2025-05-31 11:14:28','2025-05-31 11:14:59'),(2,79,1,5,1,'熟悉的麥香，最對味','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/c5102850',1,'2025-05-31 11:18:34','2025-05-31 13:09:29');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_likes`
--

DROP TABLE IF EXISTS `review_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `review_id` int NOT NULL,
  `user_id` int NOT NULL,
  `liked_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_review_user` (`review_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_likes_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `review` (`id`),
  CONSTRAINT `review_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_likes`
--

LOCK TABLES `review_likes` WRITE;
/*!40000 ALTER TABLE `review_likes` DISABLE KEYS */;
INSERT INTO `review_likes` VALUES (1,1,1,'2025-05-31 11:14:59'),(2,2,1,'2025-05-31 13:09:29');
/*!40000 ALTER TABLE `review_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'測試帳號','test@test','$2b$12$DWKRNkjW/CCOu1rNRKot/e1FTM2IwwYOF9.FpX2X34Uio8vhOybDu');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-31 17:55:44
