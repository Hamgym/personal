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
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (44,'77'),(4,'AGF'),(16,'cama cafe'),(21,'Casa卡薩'),(72,'Coca-Cola 可口可樂'),(28,'Enaak'),(45,'Gemez Enaak'),(24,'illy'),(35,'Julies 茱蒂絲'),(30,'KID-O'),(57,'KIRIN 麒麟'),(51,'Lay’s 樂事'),(5,'NESCAFE 雀巢咖啡'),(10,'Old Town舊街場'),(11,'STARBUCKS 星巴克'),(2,'UCC'),(49,'中祥'),(61,'亞大T8銀耳'),(15,'伯朗咖啡'),(58,'光泉'),(50,'北田'),(54,'原萃'),(55,'台東初鹿'),(43,'品客 Pringles'),(40,'多力多滋'),(66,'悅氏'),(64,'愛之味'),(32,'旺旺'),(48,'本味誠現'),(53,'每朝健康'),(1,'湛盧咖啡'),(33,'盛香珍'),(74,'統一'),(154,'美朝健康'),(22,'義大利金杯咖啡'),(27,'義美'),(77,'舒跑'),(68,'苗栗南庄鄉農會'),(76,'茶裏王'),(6,'西雅圖'),(63,'青森農協'),(29,'青鳥旅行'),(60,'黑松');
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
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'咖啡'),(53,'飲料'),(27,'餅乾');
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
  `product_id` int DEFAULT NULL,
  `item` varchar(255) NOT NULL,
  `specs` varchar(255) NOT NULL,
  `bought` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_item` (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `lists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `lists_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lists`
--

LOCK TABLES `lists` WRITE;
/*!40000 ALTER TABLE `lists` DISABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_product` (`category`,`brand`,`name`),
  KEY `brand` (`brand`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`brand`) REFERENCES `brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,1,'經典獨家．綜合風味','https://i3.momoshop.com.tw/1747995032/goodsimg/0013/704/397/13704397_OL.webp'),(2,1,2,'職人咖啡豆綜合','https://i4.momoshop.com.tw/1747976496/goodsimg/0013/689/865/13689865_OL.webp'),(3,1,2,'職人系列典藏/炭燒/法式風味濾掛式咖啡','https://i1.momoshop.com.tw/1747893564/goodsimg/0013/267/164/13267164_OL.webp'),(4,1,4,'即溶黑咖啡X','https://i3.momoshop.com.tw/1747812600/goodsimg/0010/184/529/10184529_OL.webp'),(5,1,5,'金牌微研磨咖啡紅利組','https://i2.momoshop.com.tw/1740450793/goodsimg/0005/484/499/5484499_OL.webp'),(6,1,6,'貝瑞斯塔二合一/三合一x','https://i1.momoshop.com.tw/1747188348/goodsimg/0010/728/247/10728247_OL.webp'),(8,1,6,'貝瑞斯塔咖啡豆','https://i3.momoshop.com.tw/1747894417/goodsimg/0011/973/628/11973628_OL.webp'),(9,1,2,'職人珈琲豆','https://i4.momoshop.com.tw/1747893586/goodsimg/0010/639/237/10639237_OL.webp'),(10,1,10,'白咖啡','https://i4.momoshop.com.tw/1745716984/goodsimg/0004/716/943/4716943_OL.webp'),(11,1,11,'特選系列-抹茶拿鐵','https://i4.momoshop.com.tw/1747619959/goodsimg/0011/803/749/11803749_OL.webp'),(12,1,5,'金牌微研磨咖啡補充包','https://i3.momoshop.com.tw/1747719285/goodsimg/0009/277/141/9277141_OL.webp'),(13,1,2,'冠軍監修綜合濾掛式咖啡x','https://i1.momoshop.com.tw/1747966219/goodsimg/0013/897/459/13897459_OL.webp'),(14,1,1,'莊園單品淺烘焙綜合．手沖精品濾掛式咖啡','https://i1.momoshop.com.tw/1748020007/goodsimg/0013/587/870/13587870_OL.webp'),(15,1,15,'伯朗精選咖啡豆','https://i4.momoshop.com.tw/1747626065/goodsimg/0013/329/336/13329336_OL.webp'),(16,1,16,'尋豆師精選咖啡豆','https://i2.momoshop.com.tw/1740448417/goodsimg/0008/532/502/8532502_OL.webp'),(17,1,11,'特選系列-即溶咖啡','https://i1.momoshop.com.tw/1747285319/goodsimg/0007/718/502/7718502_OL.webp'),(19,1,11,'特選系列-白雪摩卡咖啡','https://i4.momoshop.com.tw/1747626360/goodsimg/0013/702/681/13702681_OL.webp'),(20,1,11,'Nespresso精選膠囊','https://i2.momoshop.com.tw/1747719711/goodsimg/0011/897/420/11897420_OL.webp'),(21,1,21,'世界莊園單品濾掛咖啡綜合','https://i2.momoshop.com.tw/1747188380/goodsimg/0007/005/417/7005417_OL.webp'),(22,1,22,'女王咖啡豆','https://i4.momoshop.com.tw/1746686348/goodsimg/0011/182/176/11182176_OL.webp'),(24,1,24,'義大利咖啡豆','https://i3.momoshop.com.tw/1727341012/goodsimg/0012/760/652/12760652_OL.webp'),(25,1,5,'金牌微研磨咖啡低咖啡因','https://i4.momoshop.com.tw/1741928621/goodsimg/0006/170/911/6170911_OL.webp'),(26,1,4,'即溶黑咖啡','https://i2.momoshop.com.tw/1738551541/goodsimg/0013/393/494/13393494_OL.webp'),(27,27,27,'義美天然取向蘇打餅','https://i3.momoshop.com.tw/1732770264/goodsimg/0013/490/206/13490206_OL.webp'),(28,27,28,'韓式小雞麵','https://i1.momoshop.com.tw/1698919007/goodsimg/0004/176/549/4176549_OL.webp'),(29,27,29,'蒲光漫舞-','https://i3.momoshop.com.tw/1747973056/goodsimg/0011/332/601/11332601_OL.webp'),(30,27,30,'三明治餅乾綜合風味歡樂包/奶油風味歡喜包','https://i4.momoshop.com.tw/1706850283/goodsimg/0012/511/368/12511368_OL.webp'),(31,27,27,'義美清香檸檬夾心酥','https://i1.momoshop.com.tw/1693068653/goodsimg/0008/850/144/8850144_OL.webp'),(32,27,32,'仙貝經濟包','https://i3.momoshop.com.tw/1738895285/goodsimg/0009/917/310/9917310_OL.webp'),(33,27,33,'餅乾量販包','https://i3.momoshop.com.tw/1720574762/goodsimg/0002/743/997/2743997_OL.webp'),(34,27,27,'起司取向蘇打餅乾袋裝','https://i4.momoshop.com.tw/1692976545/goodsimg/0008/448/012/8448012_OL.webp'),(35,27,35,'手提餅乾系列','https://i3.momoshop.com.tw/1692636979/goodsimg/0005/690/554/5690554_OL.webp'),(36,27,32,'厚燒海苔經濟包','https://i2.momoshop.com.tw/1693174620/goodsimg/0009/978/633/9978633_OL.webp'),(37,27,32,'米豆米果經濟包','https://i4.momoshop.com.tw/1692637915/goodsimg/0005/742/278/5742278_OL.webp'),(38,27,32,'旺仔雪餅經濟包','https://i3.momoshop.com.tw/1692200828/goodsimg/0010/072/806/10072806_OL.webp'),(39,27,27,'美味蘇打餅','https://i4.momoshop.com.tw/1732856598/goodsimg/0004/323/153/4323153_OL.webp'),(40,27,40,'多力多滋組合包系列','https://i2.momoshop.com.tw/1741755666/goodsimg/0012/955/755/12955755_OL.webp'),(41,27,27,'香濃花生夾心酥經濟包','https://i2.momoshop.com.tw/1721473443/goodsimg/0008/850/143/8850143_OL.webp'),(42,27,29,'灌餡蛋捲旅行盒','https://i4.momoshop.com.tw/1744595294/goodsimg/0012/964/918/12964918_OL.webp'),(43,27,43,'品客洋芋片任選口味','https://i4.momoshop.com.tw/1746430650/goodsimg/0011/892/968/11892968_OL.webp'),(44,27,44,'綜合享樂包_迷你新貴派/迷你巧菲斯','https://i1.momoshop.com.tw/1717218351/goodsimg/0011/461/763/11461763_OL.webp'),(45,27,45,'韓式小雞麵辣味','https://i2.momoshop.com.tw/1692721533/goodsimg/0006/519/989/6519989_OL.webp'),(46,27,27,'狀元煎餅-花生','https://i2.momoshop.com.tw/1692549395/goodsimg/0004/286/165/4286165_OL.webp'),(47,27,28,'香辣小雞麵','https://i4.momoshop.com.tw/1711083738/goodsimg/0004/958/798/4958798_OL.webp'),(48,27,48,'大包/立袋裝','https://i4.momoshop.com.tw/1744866132/goodsimg/0011/023/001/11023001_OL.webp'),(49,27,49,'蔥向第一餅','https://i1.momoshop.com.tw/1745906588/goodsimg/0013/845/337/13845337_OL.webp'),(50,27,50,'蒟蒻糙米捲-綜合口味','https://i4.momoshop.com.tw/1692548777/goodsimg/0004/239/186/4239186_OL.webp'),(51,27,51,'樂事洋芋片隨手包','https://i4.momoshop.com.tw/1740459691/goodsimg/0007/373/730/7373730_OL.webp'),(52,27,51,'樂事意合組合包','https://i4.momoshop.com.tw/1721610241/goodsimg/0010/025/059/10025059_OL.webp'),(53,53,54,'無糖茶','https://i3.momoshop.com.tw/1735621507/goodsimg/0011/103/128/11103128_OL.webp'),(54,53,55,'原味保久乳','https://i4.momoshop.com.tw/1748056767/goodsimg/0010/558/277/10558277_OL.webp'),(55,53,54,'無糖茶寶特瓶系列','https://i4.momoshop.com.tw/1744078892/goodsimg/0011/145/331/11145331_OL.webp'),(56,53,57,'生茶','https://i1.momoshop.com.tw/1747619507/goodsimg/0011/041/099/11041099_OL.webp'),(57,53,58,'全脂保久乳','https://i1.momoshop.com.tw/1747968034/goodsimg/0008/938/732/8938732_OL.webp'),(58,53,54,'無糖冷萃茶','https://i3.momoshop.com.tw/1746238025/goodsimg/0007/517/628/7517628_OL.webp'),(59,53,60,'FIN補給飲料','https://i4.momoshop.com.tw/1716267846/goodsimg/0005/617/109/5617109_OL.webp'),(60,53,61,'冰糖原味白木耳露','https://i2.momoshop.com.tw/1747996130/goodsimg/0004/811/545/4811545_OL.webp'),(61,53,63,'希望之雫蘋果汁','https://i1.momoshop.com.tw/1747623070/goodsimg/0012/858/393/12858393_OL.webp'),(62,53,64,'純濃燕麥','https://i4.momoshop.com.tw/1747446290/goodsimg/0001/028/644/1028644_OL.webp'),(63,53,27,'原味保久乳','https://i1.momoshop.com.tw/1747275631/goodsimg/0013/623/634/13623634_OL.webp'),(64,53,66,'悅氏天然水','https://i1.momoshop.com.tw/1712123943/goodsimg/0005/312/563/5312563_OL.webp'),(66,53,68,'有機黑木耳露','https://i1.momoshop.com.tw/1747900297/goodsimg/0010/036/181/10036181_OL.webp'),(68,53,27,'元氣無加糖/低糖豆奶系列','https://i1.momoshop.com.tw/1747712538/goodsimg/0009/487/127/9487127_OL.webp'),(69,53,15,'伯朗咖啡','https://i4.momoshop.com.tw/1722696122/goodsimg/0004/912/836/4912836_OL.webp'),(70,53,72,'易開罐','https://i4.momoshop.com.tw/1693991626/goodsimg/0005/327/666/5327666_OL.webp'),(71,53,58,'調味奶保久乳','https://i4.momoshop.com.tw/1744192393/goodsimg/0012/030/236/12030236_OL.webp'),(72,53,74,'陽光無加糖豆奶','https://i2.momoshop.com.tw/1747015885/goodsimg/0009/195/625/9195625_OL.webp'),(74,53,76,'日式無糖綠茶','https://i4.momoshop.com.tw/1735966944/goodsimg/0003/984/783/3984783_OL.webp'),(75,53,77,'原味運動飲料鋁箔包','https://i3.momoshop.com.tw/1747986380/goodsimg/0007/882/947/7882947_OL.webp'),(76,53,154,'綠茶','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/4d70af0d'),(77,53,154,'無糖紅茶','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/18111c82');
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
  `comment` text NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_anonymous` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_product_user` (`product_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `review_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,76,1,5,'已購買，小孩愛吃','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/650b0679',0,'2025-06-18 13:41:30');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_review_user` (`review_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_likes_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `review` (`id`),
  CONSTRAINT `review_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_likes`
--

LOCK TABLES `review_likes` WRITE;
/*!40000 ALTER TABLE `review_likes` DISABLE KEYS */;
INSERT INTO `review_likes` VALUES (1,1,1);
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
INSERT INTO `user` VALUES (1,'Guest','test@test','$2b$12$QCaDceH7t0SBzxTWlcrVseqAyxL/rDrvvi0dOxfHO57zTw7/3SM/S');
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

-- Dump completed on 2025-06-18 13:46:03
