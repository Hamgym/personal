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
) ENGINE=InnoDB AUTO_INCREMENT=538 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (104,'77'),(250,'AGF'),(263,'cama cafe'),(269,'Casa卡薩'),(89,'cheetos 奇多'),(156,'Coca-Cola 可口可樂'),(85,'Enaak'),(183,'Gemez Enaak'),(100,'Glico 格力高'),(272,'illy'),(103,'Julies 茱蒂絲'),(88,'KID-O'),(141,'KIRIN 麒麟'),(189,'Lay’s 樂事'),(255,'NESCAFE Dolce Gusto'),(251,'NESCAFE 雀巢咖啡'),(257,'Old Town舊街場'),(102,'orionjako'),(258,'STARBUCKS 星巴克'),(65,'UCC'),(187,'中祥'),(87,'五桔國際'),(145,'亞大T8銀耳'),(60,'伯朗'),(155,'伯朗咖啡'),(76,'來一客'),(96,'健康日誌'),(63,'光泉'),(188,'北田'),(137,'原萃'),(138,'台東初鹿'),(77,'台灣森永'),(71,'味味一品'),(181,'品客 Pringles'),(176,'多力多滋'),(64,'大醇豆'),(67,'天仁茗茶'),(179,'天六'),(90,'好麗友'),(72,'得意的一天'),(150,'悅氏'),(148,'愛之味'),(98,'旺旺'),(97,'明月豆腐'),(186,'本味誠現'),(58,'樂事'),(135,'每朝健康'),(73,'波蜜'),(82,'湛盧咖啡'),(99,'盛香珍'),(136,'福樂'),(84,'科學麵'),(26,'立頓'),(66,'紅牛'),(35,'純喫茶'),(158,'統一'),(56,'維力'),(270,'義大利金杯咖啡'),(83,'義美'),(94,'老協珍'),(93,'臻御行'),(1,'舒跑'),(80,'芝初'),(152,'苗栗南庄鄉農會'),(44,'茶裏王'),(81,'萬歲牌'),(252,'西雅圖'),(68,'開喜'),(59,'雀巢'),(147,'青森農協'),(86,'青鳥旅行'),(92,'高坑肉乾'),(46,'麥香'),(144,'黑松');
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
) ENGINE=InnoDB AUTO_INCREMENT=545 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (86,'休閒零食'),(66,'咖啡'),(79,'料理'),(73,'沖調'),(63,'泡麵'),(30,'玩具'),(84,'閒零食'),(6,'食品'),(262,'食品飲料'),(1,'飲料'),(65,'餅乾');
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
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lists`
--

LOCK TABLES `lists` WRITE;
/*!40000 ALTER TABLE `lists` DISABLE KEYS */;
INSERT INTO `lists` VALUES (3,2,'炸雞','麥當勞',0),(4,2,'冰淇淋','全家便利商店',0),(25,3,'立頓奶茶','600ml 五瓶',0),(122,3,'冰淇淋','全家便利商店',1),(134,2,'烤雞','costco',0),(191,1,'品客洋芋片','洋蔥酸奶',0),(195,1,'冰淇淋紅茶','五十嵐 特大杯',0),(196,1,'麥當勞','薯來堡 經典套餐',0),(199,1,'無敵大麥克','薯條加大',0),(202,6,'冰淇淋','去麥當勞或全家買',0),(204,1,'雞胸肉','一箱(10kg)',0),(208,2,'冰淇淋紅茶','五十嵐 兩杯',0);
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
  UNIQUE KEY `unique_product` (`category`,`brand`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,65,83,'義美天然取向蘇打餅225g(鮮蔥 紫菜 蘇打餅)','https://i3.momoshop.com.tw/1732770264/goodsimg/0013/490/206/13490206_OL.webp',0,0),(2,65,85,'韓式小雞麵(16gx30入)','https://i1.momoshop.com.tw/1698919007/goodsimg/0004/176/549/4176549_OL.webp',0,0),(3,65,86,'蒲光漫舞-16入經典蛋捲禮盒｜肉鬆蛋捲、芝麻沙沙、花生粒粒(送禮推薦 端午禮盒)','https://i3.momoshop.com.tw/1747973056/goodsimg/0011/332/601/11332601_OL.webp',0,0),(4,65,88,'三明治餅乾綜合風味歡樂包/奶油風味歡喜包(612g)','https://i4.momoshop.com.tw/1706850283/goodsimg/0012/511/368/12511368_OL.webp',80,1),(5,65,83,'義美清香檸檬夾心酥400g','https://i1.momoshop.com.tw/1693068653/goodsimg/0008/850/144/8850144_OL.webp',0,0),(6,65,98,'仙貝經濟包 350g/包(米果 全素 仙貝)','https://i3.momoshop.com.tw/1738895285/goodsimg/0009/917/310/9917310_OL.webp',0,0),(7,65,99,'餅乾量販包500g/包-斯娜普蛋酥/脆捲/蘇打餅/煎餅(內有獨立小包裝)','https://i3.momoshop.com.tw/1720574762/goodsimg/0002/743/997/2743997_OL.webp',0,0),(8,65,83,'起司取向蘇打餅乾袋裝(300公克)','https://i4.momoshop.com.tw/1692976545/goodsimg/0008/448/012/8448012_OL.webp',0,0),(9,65,103,'手提餅乾系列272g-300g(花生醬三明治/檸檬夾心/乳酪夾心)','https://i3.momoshop.com.tw/1692636979/goodsimg/0005/690/554/5690554_OL.webp',0,0),(10,65,98,'厚燒海苔經濟包 350g/包(米果 經典餅乾)','https://i2.momoshop.com.tw/1693174620/goodsimg/0009/978/633/9978633_OL.webp',0,0),(11,65,98,'米豆米果經濟包 350g/包(全素)','https://i4.momoshop.com.tw/1692637915/goodsimg/0005/742/278/5742278_OL.webp',0,0),(12,65,98,'旺仔雪餅經濟包 350g/包(仙貝 米果 經典懷舊餅乾)','https://i3.momoshop.com.tw/1692200828/goodsimg/0010/072/806/10072806_OL.webp',0,0),(13,65,83,'美味蘇打餅(原味192g/芝麻燕麥192g)','https://i4.momoshop.com.tw/1732856598/goodsimg/0004/323/153/4323153_OL.webp',0,0),(14,65,176,'多力多滋組合包系列(200g/袋)','https://i2.momoshop.com.tw/1741755666/goodsimg/0012/955/755/12955755_OL.webp',0,0),(15,65,83,'香濃花生夾心酥經濟包(400g)','https://i2.momoshop.com.tw/1721473443/goodsimg/0008/850/143/8850143_OL.webp',0,0),(16,65,86,'灌餡蛋捲旅行盒8入兩盒組(經典口味任選)','https://i4.momoshop.com.tw/1744595294/goodsimg/0012/964/918/12964918_OL.webp',0,0),(17,65,179,'14袋綜合豆果子餅乾3包組(341g/包)','https://i2.momoshop.com.tw/1747980077/goodsimg/0010/107/945/10107945_OL.webp',0,0),(18,65,86,'12入輕享禮盒-人氣經典蛋捲禮盒(原味肉鬆、花生粒粒)','https://i1.momoshop.com.tw/1744707719/goodsimg/0013/907/050/13907050_OL.webp',0,0),(19,65,181,'品客洋芋片任選口味(九入組)','https://i4.momoshop.com.tw/1746430650/goodsimg/0011/892/968/11892968_OL.webp',0,0),(20,65,104,'綜合享樂包_迷你新貴派/迷你巧菲斯(291.4g *包裝隨機出貨*)','https://i1.momoshop.com.tw/1717218351/goodsimg/0011/461/763/11461763_OL.webp',0,0),(21,65,183,'韓式小雞麵辣味672g(28gx24包/盒)','https://i2.momoshop.com.tw/1692721533/goodsimg/0006/519/989/6519989_OL.webp',0,0),(22,65,83,'狀元煎餅-花生(224公克)','https://i2.momoshop.com.tw/1692549395/goodsimg/0004/286/165/4286165_OL.webp',0,0),(23,65,85,'香辣小雞麵(14gx30包)','https://i4.momoshop.com.tw/1711083738/goodsimg/0004/958/798/4958798_OL.webp',0,0),(24,65,186,'大包/立袋裝(乳酥餅13入/濃可可酥餅12入/牛奶餅20入/燕麥餅20入/起司燕麥餅13入)','https://i4.momoshop.com.tw/1744866132/goodsimg/0011/023/001/11023001_OL.webp',0,0),(25,65,187,'蔥向第一餅 文昌帝君聯名版(300gx12包/箱)','https://i1.momoshop.com.tw/1745906588/goodsimg/0013/845/337/13845337_OL.webp',0,0),(26,65,188,'蒟蒻糙米捲-綜合口味(320g)','https://i4.momoshop.com.tw/1692548777/goodsimg/0004/239/186/4239186_OL.webp',0,0),(27,65,189,'樂事洋芋片隨手包(12g/50包)','https://i4.momoshop.com.tw/1740459691/goodsimg/0007/373/730/7373730_OL.webp',60,1),(28,65,189,'樂事意合組合包240g/袋','https://i4.momoshop.com.tw/1721610241/goodsimg/0010/025/059/10025059_OL.webp',0,0),(29,1,44,'日式無糖綠茶','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/5a1dd39d',0,0),(34,1,46,'阿薩姆紅茶','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/f7908086',0,0),(35,1,135,'無糖綠茶650mlx2箱(共48入 EX健康四認證)','https://i1.momoshop.com.tw/1746672068/goodsimg/0011/103/660/11103660_OL.webp',0,0),(36,1,136,'100%生乳保久乳200mlx2箱(共48入)','https://i4.momoshop.com.tw/1747099935/goodsimg/0010/414/667/10414667_OL.webp',0,0),(37,1,137,'無糖茶 寶特瓶系列580mlx24入/箱(無糖)','https://i3.momoshop.com.tw/1735621507/goodsimg/0011/103/128/11103128_OL.webp',0,0),(38,1,138,'原味保久乳200mlx24入/箱(100%生乳使用;牛乳/牛奶)','https://i4.momoshop.com.tw/1748056767/goodsimg/0010/558/277/10558277_OL.webp',0,0),(39,1,137,'無糖茶寶特瓶系列580ml x2箱(共48入;24入/箱)','https://i4.momoshop.com.tw/1744078892/goodsimg/0011/145/331/11145331_OL.webp',0,0),(40,1,46,'300mlx3箱(共72入;任選紅茶/奶茶/綠茶)','https://i1.momoshop.com.tw/1747187422/goodsimg/0011/402/824/11402824_OL.webp',100,1),(41,1,141,'生茶525mlx24入/箱','https://i1.momoshop.com.tw/1747619507/goodsimg/0011/041/099/11041099_OL.webp',0,0),(42,1,63,'全脂保久乳200mlx2箱(共48入;牛乳/牛奶)','https://i1.momoshop.com.tw/1747968034/goodsimg/0008/938/732/8938732_OL.webp',0,0),(43,1,137,'無糖冷萃茶 寶特瓶系列450mlx24入/箱(日式深蒸綠茶/金萱烏龍茶/蜜香紅茶/春笠青茶)','https://i3.momoshop.com.tw/1746238025/goodsimg/0007/517/628/7517628_OL.webp',0,0),(44,1,144,'FIN補給飲料 PKL300mlx3箱(共72入)','https://i4.momoshop.com.tw/1716267846/goodsimg/0005/617/109/5617109_OL.webp',0,0),(45,1,145,'冰糖原味白木耳露150gx24入/箱','https://i2.momoshop.com.tw/1747996130/goodsimg/0004/811/545/4811545_OL.webp',0,0),(46,1,135,'無糖綠茶650mlx24入/箱(EX健康四認證)','https://i2.momoshop.com.tw/1742788029/goodsimg/0011/027/133/11027133_OL.webp',0,0),(47,1,147,'希望之雫蘋果汁1000mlx6入','https://i1.momoshop.com.tw/1747623070/goodsimg/0012/858/393/12858393_OL.webp',0,0),(48,1,148,'純濃燕麥290mlx2箱(共48入)','https://i4.momoshop.com.tw/1747446290/goodsimg/0001/028/644/1028644_OL.webp',0,0),(49,1,83,'原味保久乳125mlx3箱(共72入)','https://i1.momoshop.com.tw/1747275631/goodsimg/0013/623/634/13623634_OL.webp',0,0),(50,1,150,'悅氏天然水6000mlx2入/箱','https://i1.momoshop.com.tw/1712123943/goodsimg/0005/312/563/5312563_OL.webp',0,0),(51,1,83,'原味保久乳125mlx2箱(共48入)','https://i3.momoshop.com.tw/1738834616/goodsimg/0011/650/005/11650005_OL.webp',0,0),(52,1,152,'有機黑木耳露350mlx24入/箱','https://i1.momoshop.com.tw/1747900297/goodsimg/0010/036/181/10036181_OL.webp',0,0),(53,1,144,'FIN補給飲料580mlx2箱(共48入)','https://i2.momoshop.com.tw/1723206302/goodsimg/0005/622/733/5622733_OL.webp',0,0),(54,1,83,'元氣無加糖/低糖豆奶系列250mlx3箱(共72入;豆奶/黑豆奶)','https://i1.momoshop.com.tw/1747712538/goodsimg/0009/487/127/9487127_OL.webp',0,0),(55,1,155,'伯朗咖啡240mlx2箱(共48入)','https://i4.momoshop.com.tw/1722696122/goodsimg/0004/912/836/4912836_OL.webp',0,0),(56,1,156,'易開罐250ml x24入/箱','https://i4.momoshop.com.tw/1693991626/goodsimg/0005/327/666/5327666_OL.webp',0,0),(57,1,63,'調味奶保久乳200mlx48入(任選巧克力/果汁/高鈣/低脂高鈣/蘋果/麥芽)','https://i4.momoshop.com.tw/1744192393/goodsimg/0012/030/236/12030236_OL.webp',0,0),(58,1,158,'陽光無加糖豆奶250mlx2箱(共48入)','https://i2.momoshop.com.tw/1747015885/goodsimg/0009/195/625/9195625_OL.webp',0,0),(59,1,156,'易開罐330ml x2箱(共48入;24入/箱)','https://i4.momoshop.com.tw/1692378402/goodsimg/0010/514/714/10514714_OL.webp',0,0),(60,1,44,'日式無糖綠茶600mlx24入/箱','https://i4.momoshop.com.tw/1735966944/goodsimg/0003/984/783/3984783_OL.webp',0,0),(61,1,1,'原味運動飲料鋁箔包 250mlx3箱(共72入-官方直營)','https://i3.momoshop.com.tw/1747986380/goodsimg/0007/882/947/7882947_OL.webp',0,0),(62,1,135,'熟藏紅茶-無糖650mlx24入/箱','https://i1.momoshop.com.tw/1735275712/goodsimg/0013/579/554/13579554_OL.webp',0,0),(63,66,82,'經典獨家．綜合風味 手沖精品濾掛式咖啡．任選2盒組(共72包;11gx36包/盒;共5種風味)','https://i3.momoshop.com.tw/1747995032/goodsimg/0013/704/397/13704397_OL.webp',0,0),(64,66,65,'職人咖啡豆綜合400g+10% *3包組增量版(曼巴、炭燒、橙韻各一包 期間限定)','https://i4.momoshop.com.tw/1747976496/goodsimg/0013/689/865/13689865_OL.webp',0,0),(65,66,65,'職人系列典藏/炭燒/法式風味濾掛式咖啡6盒','https://i1.momoshop.com.tw/1747893564/goodsimg/0013/267/164/13267164_OL.webp',0,0),(66,66,250,'即溶黑咖啡X6罐任選(80g/罐;金罐/柔順/醇厚/香醇)','https://i3.momoshop.com.tw/1747812600/goodsimg/0010/184/529/10184529_OL.webp',0,0),(67,66,251,'金牌微研磨咖啡紅利組120g+30g(任選)','https://i2.momoshop.com.tw/1740450793/goodsimg/0005/484/499/5484499_OL.webp',0,0),(68,66,252,'貝瑞斯塔二合一/三合一x2盒(100入/盒)','https://i1.momoshop.com.tw/1747188348/goodsimg/0010/728/247/10728247_OL.webp',0,0),(69,66,65,'職人系列典藏/炭燒/法式風味濾掛式咖啡6盒(共72入;8gx12入/盒;3種風味各2盒)','https://i1.momoshop.com.tw/1747976547/goodsimg/0008/986/416/8986416_OL.webp',0,0),(70,66,252,'貝瑞斯塔咖啡豆2包組(908g/包;共4磅;2種風味任選;中烘焙/深烘焙)','https://i3.momoshop.com.tw/1747894417/goodsimg/0011/973/628/11973628_OL.webp',0,0),(71,262,255,'多趣酷思 星巴克 STARBUCKS 膠囊咖啡 雀巢咖啡','https://i5.momoshop.com.tw/1748147248/goodsimg/TP000/1791/0000/019/TP00017910000019_O.webp',0,0),(72,66,65,'職人珈琲豆400gx4包(口味任選;金質炭燒/曼巴/橙韻)','https://i4.momoshop.com.tw/1747893586/goodsimg/0010/639/237/10639237_OL.webp',0,0),(73,66,257,'白咖啡4袋組(口味任選;15入/袋;共60入)','https://i4.momoshop.com.tw/1745716984/goodsimg/0004/716/943/4716943_OL.webp',0,0),(74,66,258,'特選系列-抹茶拿鐵4入x4盒組','https://i4.momoshop.com.tw/1747619959/goodsimg/0011/803/749/11803749_OL.webp',0,0),(75,66,251,'金牌微研磨咖啡補充包 120gx3包組','https://i3.momoshop.com.tw/1747719285/goodsimg/0009/277/141/9277141_OL.webp',0,0),(76,66,65,'冠軍監修綜合濾掛式咖啡x6盒組(10入/盒;蜜漬醇香/醇香果調/甘醇橙香;3種風味各2盒)','https://i1.momoshop.com.tw/1747966219/goodsimg/0013/897/459/13897459_OL.webp',0,0),(77,66,82,'莊園單品淺烘焙綜合．手沖精品濾掛式咖啡(共50入;11gx10入/盒;薇薇特/肯亞/瓜地/衣索/耶加各1)','https://i1.momoshop.com.tw/1748020007/goodsimg/0013/587/870/13587870_OL.webp',0,0),(78,66,155,'伯朗精選咖啡豆450克x4袋(口味任選:巴西聖多士/哥倫比亞/珍選/醇郁)','https://i4.momoshop.com.tw/1747626065/goodsimg/0013/329/336/13329336_OL.webp',0,0),(79,66,263,'尋豆師精選咖啡豆3包任選組(454g/包;風味任選;中焙堅果/深焙焦糖/中淺焙花香)','https://i2.momoshop.com.tw/1740448417/goodsimg/0008/532/502/8532502_OL.webp',0,0),(80,66,65,'117/114/芳醇即溶咖啡90gx12罐/箱(日本)','https://i1.momoshop.com.tw/1745821839/goodsimg/0013/558/264/13558264_OL.webp',0,0),(81,66,258,'特選系列-即溶咖啡4入/盒(口味任選)','https://i1.momoshop.com.tw/1747285319/goodsimg/0007/718/502/7718502_OL.webp',0,0),(82,66,251,'金牌微研磨咖啡紅利組120g+30g(任選3組)','https://i1.momoshop.com.tw/1740450847/goodsimg/0012/718/998/12718998_OL.webp',0,0),(83,66,258,'特選系列-白雪摩卡咖啡4盒組(共16入 口味任選；白雪摩卡/焦糖/香草)','https://i4.momoshop.com.tw/1747626360/goodsimg/0013/702/681/13702681_OL.webp',0,0),(84,66,258,'Nespresso精選膠囊10顆x5盒(任選 適用original系列咖啡機)','https://i2.momoshop.com.tw/1747719711/goodsimg/0011/897/420/11897420_OL.webp',0,0),(85,66,269,'世界莊園單品濾掛咖啡綜合100入(8gx25入)','https://i2.momoshop.com.tw/1747188380/goodsimg/0007/005/417/7005417_OL.webp',0,0),(86,66,270,'女王咖啡豆 深焙 3入組(共3包;250g/包;全羅馬最好喝的咖啡)','https://i4.momoshop.com.tw/1746686348/goodsimg/0011/182/176/11182176_OL.webp',0,0),(87,66,155,'伯朗精選咖啡豆450克x3袋(口味任選:巴西聖多士/哥倫比亞/珍選/醇郁)','https://i2.momoshop.com.tw/1741936535/goodsimg/0010/302/912/10302912_OL.webp',0,0),(88,66,272,'義大利咖啡豆  任選1罐(250g/罐; 中度烘焙咖啡豆/深度烘培/MOKA咖啡粉/低咖啡因/  任選1罐)','https://i3.momoshop.com.tw/1727341012/goodsimg/0012/760/652/12760652_OL.webp',0,0),(89,66,251,'金牌微研磨咖啡低咖啡因 80g/罐','https://i4.momoshop.com.tw/1741928621/goodsimg/0006/170/911/6170911_OL.webp',0,0),(90,66,250,'即溶黑咖啡9罐任選(80g/罐;金罐/柔順/醇厚/香醇)','https://i2.momoshop.com.tw/1738551541/goodsimg/0013/393/494/13393494_OL.webp',0,0),(91,86,77,'威德in果凍4盒-180gx6入/盒(口味任選-新舊包裝隨機出貨)','https://i4.momoshop.com.tw/1747881091/goodsimg/0011/304/485/11304485_OL.webp',0,0),(92,86,80,'8倍細高鈣黑芝麻粉380gx4罐(2025年節慶特別版)','https://i2.momoshop.com.tw/1747380158/goodsimg/0013/554/300/13554300_OL.webp',0,0),(93,86,81,'杏仁小魚(8gX10包/袋)','https://i3.momoshop.com.tw/1742619675/goodsimg/0004/681/770/4681770_OL.webp',87,3),(94,86,82,'經典獨家．綜合風味 手沖精品濾掛式咖啡．任選2盒組(共72包;11gx36包/盒;共5種風味)','https://i4.momoshop.com.tw/1747995032/goodsimg/0013/704/397/13704397_OL.webp',0,0),(95,86,83,'義美天然取向蘇打餅225g(鮮蔥 紫菜 蘇打餅)','https://i1.momoshop.com.tw/1732770264/goodsimg/0013/490/206/13490206_OL.webp',0,0),(96,86,84,'科學麵原味40gx5入 x2袋(共10入)','https://i4.momoshop.com.tw/1740570492/goodsimg/0013/749/806/13749806_OL.webp',0,0),(97,86,85,'韓式小雞麵(16gx30入)','https://i1.momoshop.com.tw/1698919007/goodsimg/0004/176/549/4176549_OL.webp',0,0),(98,86,86,'蒲光漫舞-16入經典蛋捲禮盒｜肉鬆蛋捲、芝麻沙沙、花生粒粒(送禮推薦 端午禮盒)','https://i2.momoshop.com.tw/1747973056/goodsimg/0011/332/601/11332601_OL.webp',0,0),(99,86,87,'綜合堅果500gx3包','https://i2.momoshop.com.tw/1747968150/goodsimg/0008/085/585/8085585_OL.webp',0,0),(100,86,88,'三明治餅乾綜合風味歡樂包/奶油風味歡喜包(612g)','https://i1.momoshop.com.tw/1706850283/goodsimg/0012/511/368/12511368_OL.webp',0,0),(101,86,89,'奇多隨口脆系列','https://i3.momoshop.com.tw/1741755667/goodsimg/0013/739/674/13739674_OL.webp',0,0),(102,86,90,'預感香烤洋芋片家庭號X4盒','https://i3.momoshop.com.tw/1746761133/goodsimg/0013/822/306/13822306_OL.webp',0,0),(103,86,86,'蒲光漫舞-12入經典蛋捲禮盒｜肉鬆蛋捲、芝麻沙沙、花生粒粒(送禮推薦 端午禮盒)','https://i4.momoshop.com.tw/1747027977/goodsimg/0011/332/602/11332602_OL.webp',0,0),(104,86,92,'牛or豬肉乾眾多口味任選3包(170g/包)','https://i2.momoshop.com.tw/1747105212/goodsimg/0013/149/241/13149241_OL.webp',0,0),(105,86,93,'量販大包裝 臻饌堅果任選2袋(綜合堅果/杏仁/腰果/核桃560g＆胡桃400g/夏威夷豆280g)','https://i4.momoshop.com.tw/1747986615/goodsimg/0013/317/110/13317110_OL.webp',80,3),(106,86,94,'熬雞精禮盒 常溫/14入(42ml/入 徐若瑄代言 送禮 禮盒)','https://i1.momoshop.com.tw/1724233297/goodsimg/0005/327/922/5327922_OL.webp',0,0),(107,86,83,'義美清香檸檬夾心酥400g','https://i1.momoshop.com.tw/1693068653/goodsimg/0008/850/144/8850144_OL.webp',0,0),(108,86,96,'洋芋脆餅量販包(408g)','https://i4.momoshop.com.tw/1740632565/goodsimg/0005/933/589/5933589_OL.webp',0,0),(109,86,97,'明月豆腐餅乾150g/包x5包(豆腐餅乾健康滋味在舌尖！)','https://i4.momoshop.com.tw/1747285299/goodsimg/0013/517/660/13517660_OL.webp',0,0),(110,86,98,'仙貝經濟包 350g/包(米果 全素 仙貝)','https://i1.momoshop.com.tw/1738895285/goodsimg/0009/917/310/9917310_OL.webp',0,0),(111,86,99,'餅乾量販包500g/包-斯娜普蛋酥/脆捲/蘇打餅/煎餅(內有獨立小包裝)','https://i4.momoshop.com.tw/1720574762/goodsimg/0002/743/997/2743997_OL.webp',0,0),(112,86,100,'官方直營 Pocky百奇 巧克力棒分享包(巧克力/草莓/牛奶)','https://i4.momoshop.com.tw/1728709485/goodsimg/0013/335/894/13335894_OL.webp',0,0),(113,86,83,'起司取向蘇打餅乾袋裝(300公克)','https://i2.momoshop.com.tw/1692976545/goodsimg/0008/448/012/8448012_OL.webp',0,0),(114,86,102,'韓國海苔96入組 3.5gx12入/包x8包','https://i4.momoshop.com.tw/1747884234/goodsimg/0010/112/878/10112878_OL.webp',0,0),(115,86,103,'手提餅乾系列272g-300g(花生醬三明治/檸檬夾心/乳酪夾心)','https://i3.momoshop.com.tw/1692636979/goodsimg/0005/690/554/5690554_OL.webp',0,0),(116,86,104,'乳加320g(迷你)','https://i1.momoshop.com.tw/1708491773/goodsimg/0004/526/534/4526534_OL.webp',0,0),(117,86,98,'厚燒海苔經濟包 350g/包(米果 經典餅乾)','https://i1.momoshop.com.tw/1693174620/goodsimg/0009/978/633/9978633_OL.webp',67,3),(118,86,94,'熬雞精禮盒 常溫/14入x2盒(42ml/入 徐若瑄代言 送禮 禮盒)','https://i4.momoshop.com.tw/1747126577/goodsimg/0005/348/265/5348265_OL.webp',40,2);
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
  UNIQUE KEY `unique_user_product` (`product_id`,`user_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `review_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,118,3,1,2,'不如買KFC來吃好嗎\r\n',NULL,0,'2025-05-28 16:30:03','2025-05-30 18:17:41'),(2,105,3,5,1,'已購買，小孩愛吃',NULL,0,'2025-05-28 16:30:48','2025-05-28 16:58:40'),(3,93,3,3,2,'已購買，小孩愛吃',NULL,0,'2025-05-28 16:39:07','2025-05-30 12:58:14'),(4,105,1,2,3,'太貴了QQQQ\r\n',NULL,0,'2025-05-28 16:39:59','2025-05-30 12:48:12'),(5,4,1,4,2,'已購買，小孩愛吃',NULL,0,'2025-05-28 16:42:45','2025-05-30 18:18:18'),(6,27,1,3,1,'空氣包\r\n',NULL,0,'2025-05-28 19:35:44','2025-05-30 18:18:23'),(7,93,1,5,1,'吃杏仁小魚補補腦','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/e6e5ff82',0,'2025-05-28 22:59:31','2025-05-30 12:58:42'),(8,117,1,5,3,'已購買，小孩愛吃',NULL,0,'2025-05-29 11:21:39','2025-05-30 12:56:30'),(9,40,6,5,3,'熟悉的麥香，最對味','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/6ebba356',1,'2025-05-29 12:26:24','2025-05-30 00:35:51'),(10,117,7,1,0,'已購買，小孩不愛',NULL,1,'2025-05-29 14:02:39','2025-05-29 14:02:39'),(11,105,2,5,1,'已購買，小孩愛吃','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/3dcc707c',0,'2025-05-30 07:03:54','2025-05-30 07:04:01'),(12,117,2,4,1,'已購買，小孩愛吃','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/3f0dbfaf',1,'2025-05-30 12:49:30','2025-05-30 12:56:25'),(13,93,2,5,0,'已購買，小孩愛吃','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/9c023eb5',0,'2025-05-30 12:58:26','2025-05-30 12:58:26'),(15,118,2,3,0,'買來送禮還行','https://d2j1hqbdhu9zhx.cloudfront.net/mygo/de441ac7',0,'2025-05-30 18:01:12','2025-05-30 18:01:12');
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
  UNIQUE KEY `unique_user_like` (`review_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_likes`
--

LOCK TABLES `review_likes` WRITE;
/*!40000 ALTER TABLE `review_likes` DISABLE KEYS */;
INSERT INTO `review_likes` VALUES (1,1,1,'2025-05-28 16:58:21'),(2,2,1,'2025-05-28 16:58:40'),(3,5,1,'2025-05-28 17:06:33'),(8,4,1,'2025-05-28 17:06:49'),(11,4,3,'2025-05-28 17:08:53'),(20,3,1,'2025-05-28 22:58:44'),(21,8,1,'2025-05-29 11:21:42'),(22,9,6,'2025-05-29 12:26:29'),(23,9,7,'2025-05-29 14:01:38'),(24,8,7,'2025-05-29 14:01:43'),(25,9,1,'2025-05-30 00:35:51'),(26,11,2,'2025-05-30 07:04:01'),(27,4,2,'2025-05-30 12:48:12'),(28,12,2,'2025-05-30 12:56:25'),(29,8,2,'2025-05-30 12:56:30'),(33,3,2,'2025-05-30 12:58:14'),(34,7,2,'2025-05-30 12:58:42'),(37,1,2,'2025-05-30 18:17:41'),(38,5,2,'2025-05-30 18:18:18'),(39,6,2,'2025-05-30 18:18:23');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'南霸天','abc@abc','$2b$12$RHQ./OD5jbQ0xU5ODuN2IeOt4vo0vs0fmdgvGhoAhyARcmctsCtpK'),(2,'慈父','pi@gmail.com','$2b$12$bUImym1w/tOTtGinyXwbRuIJb1NuQcwea5J.HDqBbvgydSYJdsgUu'),(3,'動物朋友','xyz@xyz','$2b$12$kvMbmozEnTgdoRh8.GaLOOcpXO1Z3F/5WFZm.rESmm/Kq6ONKNqE6'),(4,'牛頭人','wer@wer','$2b$12$jFW0gZSLoLHGTHJocoB9eeka1bMcxmWwF9KQ8Dcpf3NzjpCrqZIW2'),(6,'卡路里','pip@gmail.com','$2b$12$1/BT0KzlpS9/QiuembRYXux4mVjfMhjPqrF795z800rrIheZBO3Ie'),(7,'CoLa','pipi@gmail.com','$2b$12$pHwRWx2jN2ZwAwOlGVYVz.wX4qEWoD2mv40SB75Tko0Q/Uhi9CjdO'),(8,'北宋','pipiy@gmail.com','$2b$12$Z0I.QYQyxRN/cSXYXEEqReJ04FFW/UQt7DNFbKulrcU6mGYb.lDpm');
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

-- Dump completed on 2025-05-31  9:31:02
