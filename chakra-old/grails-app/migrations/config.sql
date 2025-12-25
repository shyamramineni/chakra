-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.20


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema chakra
--

CREATE DATABASE IF NOT EXISTS chakra;
USE chakra;

--
-- Temporary table structure for view `join1`
--
DROP TABLE IF EXISTS `join1`;
DROP VIEW IF EXISTS `join1`;
CREATE TABLE `join1` (
  `authority` varchar(255),
  `user_id` bigint(20)
);

--
-- Definition of table `cage_design`
--

DROP TABLE IF EXISTS `cage_design`;
CREATE TABLE `cage_design` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_design` varchar(255) NOT NULL,
  `double_bottom_centre_included` bit(1) NOT NULL,
  `no_of_birds_per_cage_double_box` decimal(19,2) NOT NULL,
  `no_of_birds_per_cage_single_box` decimal(19,2) NOT NULL,
  `no_of_partitions_per_sheet_length` decimal(19,2) NOT NULL,
  `no_of_single_bottoms_per_sheet` decimal(19,2) NOT NULL,
  `sheet_length` decimal(19,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `bottom_depth` decimal(19,2) NOT NULL,
  `cage_front` decimal(19,2) NOT NULL,
  `cage_height` decimal(19,2) NOT NULL,
  `top_depth` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_design`
--

/*!40000 ALTER TABLE `cage_design` DISABLE KEYS */;
INSERT INTO `cage_design` (`id`,`version`,`cage_design`,`double_bottom_centre_included`,`no_of_birds_per_cage_double_box`,`no_of_birds_per_cage_single_box`,`no_of_partitions_per_sheet_length`,`no_of_single_bottoms_per_sheet`,`sheet_length`,`description`,`bottom_depth`,`cage_front`,`cage_height`,`top_depth`) VALUES 
 (1,4,'Layer 15\" X 12\" 3 Birds ',0x01,'3.00','3.00','12.00','3.00','15.00',NULL,'12.00','15.00','15.00','12.00'),
 (2,1,'Layer 17\" X 15\" 4 Birds ',0x00,'4.00','4.00','11.00','2.00','15.58',NULL,'15.00','17.00','15.00','15.00'),
 (3,1,'Layer 15\" X 18\" 4 Birds ',0x00,'4.00','4.00','12.00','2.00','15.00',NULL,'18.00','15.00','15.00','18.00'),
 (4,1,'Layer 15\" X 12\"/18\" 334 Birds ',0x00,'4.00','3.00','12.00','2.00','15.00',NULL,'12.00','15.00','15.00','18.00'),
 (5,1,'Layer 17\"X14\" 4Birds',0x00,'4.00','4.00','11.00','2.00','15.58',NULL,'14.00','17.00','15.00','14.00'),
 (6,1,'Layer 18\"X14\" 4birds 2.25Pitch',0x00,'4.00','4.00','10.00','2.00','15.00',NULL,'14.00','18.00','15.00','14.00'),
 (7,1,'Layer 18\"X14\" 4Birds 2\"Pitch',0x00,'4.00','4.00','10.00','2.00','15.00',NULL,'14.00','18.00','15.00','14.00');
/*!40000 ALTER TABLE `cage_design` ENABLE KEYS */;


--
-- Definition of table `cage_design_sheet_spec_formula`
--

DROP TABLE IF EXISTS `cage_design_sheet_spec_formula`;
CREATE TABLE `cage_design_sheet_spec_formula` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_design_id` bigint(20) NOT NULL,
  `formula` varchar(255) NOT NULL,
  `sheet_specification_id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAAF56320444E1384` (`sheet_specification_id`),
  KEY `FKAAF56320E3175CFC` (`cage_design_id`),
  CONSTRAINT `FKAAF56320444E1384` FOREIGN KEY (`sheet_specification_id`) REFERENCES `sheet_specification` (`id`),
  CONSTRAINT `FKAAF56320E3175CFC` FOREIGN KEY (`cage_design_id`) REFERENCES `cage_design` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_design_sheet_spec_formula`
--

/*!40000 ALTER TABLE `cage_design_sheet_spec_formula` DISABLE KEYS */;
INSERT INTO `cage_design_sheet_spec_formula` (`id`,`version`,`cage_design_id`,`formula`,`sheet_specification_id`,`description`) VALUES 
 (1,0,1,'((cageLength/sheetLength)*fulls)',1,''),
 (2,0,1,'((cageLength/sheetLength)*fulls)',2,''),
 (3,1,1,'(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)',3,''),
 (4,7,1,'(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))/noOfSingleBottomsPerSheet)',4,''),
 (5,6,1,'((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs))',5,''),
 (6,5,1,'((((cageLength/sheetLength)*fulls)*2*noOfPartitionsPerSheetLength)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength))',6,''),
 (7,0,2,'((cageLength/sheetLength)*fulls)',11,''),
 (8,0,2,'((cageLength/sheetLength)*fulls)',12,''),
 (9,1,2,'(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)',13,''),
 (10,1,2,'(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))/noOfSingleBottomsPerSheet)',14,''),
 (12,1,2,'((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs))',15,''),
 (13,1,2,'((((cageLength/sheetLength)*fulls)*2*noOfPartitionsPerSheetLength)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength))',6,''),
 (14,0,2,'(((cageLength/sheetLength)*fulls)/4)',18,''),
 (15,0,3,'((cageLength/sheetLength)*fulls) ',7,''),
 (16,0,3,'((cageLength/sheetLength)*fulls)',17,''),
 (17,0,3,'(((cageLength/sheetLength)*fulls)/4) ',10,''),
 (18,0,3,'(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)',19,''),
 (19,1,3,'(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))/noOfSingleBottomsPerSheet)',20,''),
 (20,1,3,'((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs))',9,''),
 (21,2,3,'((((cageLength/sheetLength)*fulls)*2*noOfPartitionsPerSheetLength)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength))',6,''),
 (22,0,4,'((cageLength/sheetLength)*fulls) ',7,''),
 (23,0,4,'((cageLength/sheetLength)*fulls)',8,''),
 (24,0,4,'(((cageLength/sheetLength)*fulls)/4)',10,''),
 (25,0,4,'(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)',3,''),
 (26,1,4,'(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))/noOfSingleBottomsPerSheet)',4,''),
 (27,2,4,'((((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+((1+noOfCuttingsInShed)*((((tiers-1)*2)*fulls)+(tiers*halfs))))',5,''),
 (28,3,4,'((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(1+noOfCuttingsInShed)*(2*fulls))',9,''),
 (29,1,4,'((((cageLength/sheetLength)*fulls)*2*noOfPartitionsPerSheetLength)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength))',6,''),
 (30,1,5,'((cageLength/sheetLength)*fulls)',21,''),
 (31,0,5,'((cageLength/sheetLength)*fulls)',22,''),
 (32,1,5,'(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)',23,''),
 (33,0,5,'(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))/noOfSingleBottomsPerSheet)',24,''),
 (34,0,5,'((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs))',25,''),
 (35,1,5,'((((cageLength/sheetLength)*fulls)*2*noOfPartitionsPerSheetLength)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength))',6,''),
 (36,0,6,'((cageLength/sheetLength)*fulls)',26,''),
 (37,2,6,'((cageLength/sheetLength)*fulls)',27,''),
 (38,0,6,'(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)',28,''),
 (39,0,6,'(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))/noOfSingleBottomsPerSheet)',29,''),
 (40,0,6,'((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs))',25,''),
 (41,0,6,'((((cageLength/sheetLength)*fulls)*2*noOfPartitionsPerSheetLength)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength))',6,''),
 (42,0,7,'((cageLength/sheetLength)*fulls)',26,''),
 (43,0,7,'((cageLength/sheetLength)*fulls)',30,''),
 (44,0,7,'(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)',31,''),
 (45,0,7,'(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))/noOfSingleBottomsPerSheet)',29,''),
 (46,0,7,'(((cageLength/sheetLength)*fulls)/4)',10,''),
 (47,0,7,'((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs))',25,''),
 (48,0,7,'((((cageLength/sheetLength)*fulls)*2*noOfPartitionsPerSheetLength)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength))',6,''),
 (49,0,6,'(((cageLength/sheetLength)*fulls)/4)',10,''),
 (50,0,5,'(((cageLength/sheetLength)*fulls)/4)',18,'');
/*!40000 ALTER TABLE `cage_design_sheet_spec_formula` ENABLE KEYS */;


--
-- Definition of table `cage_part_price`
--

DROP TABLE IF EXISTS `cage_part_price`;
CREATE TABLE `cage_part_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_part_spec_formula_id` bigint(20) NOT NULL,
  `price` decimal(19,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `end_date` datetime NOT NULL,
  `start_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK86B42460CF673E02` (`cage_part_spec_formula_id`),
  CONSTRAINT `FK86B42460CF673E02` FOREIGN KEY (`cage_part_spec_formula_id`) REFERENCES `cage_part_spec_formula` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_part_price`
--

/*!40000 ALTER TABLE `cage_part_price` DISABLE KEYS */;
INSERT INTO `cage_part_price` (`id`,`version`,`cage_part_spec_formula_id`,`price`,`description`,`end_date`,`start_date`) VALUES 
 (1,0,1,'40.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (2,0,3,'41.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (3,0,5,'41.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (4,0,7,'40.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (5,0,9,'60.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (6,0,10,'61.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (7,0,12,'60.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (8,0,11,'61.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (9,0,13,'60.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (10,0,14,'40.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (11,0,15,'177.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (12,0,16,'15.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (13,0,17,'10.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (14,0,18,'60.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (15,0,19,'40.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (16,0,20,'440.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (17,0,21,'15.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (18,0,22,'7.70','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (19,0,23,'27.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (20,0,24,'10.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (21,0,25,'11.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (22,0,26,'1.30','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (23,0,27,'3.50','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (24,0,28,'3.50','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (25,0,29,'9600.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (26,0,30,'82.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (27,0,31,'57.40','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (28,0,32,'220.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (29,0,33,'120.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (30,0,34,'75.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (31,0,35,'70.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (32,0,36,'100.00','','2012-03-01 00:00:00','2012-03-01 00:00:00'),
 (33,0,37,'75.00','','2012-03-01 00:00:00','2012-03-01 00:00:00');
/*!40000 ALTER TABLE `cage_part_price` ENABLE KEYS */;


--
-- Definition of table `cage_part_spec_formula`
--

DROP TABLE IF EXISTS `cage_part_spec_formula`;
CREATE TABLE `cage_part_spec_formula` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_part_spec_name` varchar(255) NOT NULL,
  `formula` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_part_spec_formula`
--

/*!40000 ALTER TABLE `cage_part_spec_formula` DISABLE KEYS */;
INSERT INTO `cage_part_spec_formula` (`id`,`version`,`cage_part_spec_name`,`formula`,`description`) VALUES 
 (1,0,'M.S Flat ','((cageLength/17.75*((tiers*halfs)+(tiers*fulls*2)))*5.9)  ',''),
 (3,0,'Angle 22 X 3 MM ','((cageLength*(fulls*2+halfs)/17.75)*6)  ',''),
 (5,0,'Angle 35 X 5 MM ','((((cageLength/5+1)*fulls)*2/17.75)*14.5)  ',''),
 (7,0,'Stands M.S 3 TIER 3 BIRDS ','(((cageLength/5+1)*fulls)*7.5)  ',''),
 (9,0,'Galvanised M.S Flat ','((cageLength/17.75*((tiers*halfs)+(tiers*fulls*2)))*5.9)  ',''),
 (10,0,'Galvanised Angle 22 X 3 MM ','((cageLength*(fulls*2+halfs)/17.75)*6)  ',''),
 (11,0,'Galvanised Angle 35 X 5 MM ','((((cageLength/5+1)*fulls)*2/17.75)*14.5)  ',''),
 (12,0,'Galvanised Stands M.S 3 TIER 3 BIRDS ','(((cageLength/5+1)*fulls)*7.5)  ',''),
 (13,3,'Alu. Brackets galvanized ','(((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+((1+noOfCuttingsInShed)*(((tiers*2)*fulls)+((tiers*1)*halfs))))/3)',''),
 (14,3,'Alu. Brackets RedOxide Coated ','(((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+((1+noOfCuttingsInShed)*(((tiers*2)*fulls)+((tiers*1)*halfs))))/3)',''),
 (15,0,'Alu. Feeder 12\"18\'LONG ','(((cageLength*((tiers*halfs)+(tiers*fulls*2)))/18)*2.35)  ',''),
 (16,0,'Alu. Feeder Ends ','(((tiers*halfs)+(tiers*fulls*2))*2) ',''),
 (17,0,'Alu. Feeder Bending ','((cageLength*((tiers*halfs)+(tiers*fulls*2)))/18)  ',''),
 (18,4,'Plastic Brackets galvanized ','(((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+((1+noOfCuttingsInShed)*(((tiers*2)*fulls)+((tiers*1)*halfs))))/3)',''),
 (19,4,'Plastic Brackets RedOxide Coated ','(((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+((1+noOfCuttingsInShed)*(((tiers*2)*fulls)+((tiers*1)*halfs))))/3)',''),
 (20,0,'CHAKRA P.V.C FEEDER ','((cageLength*((tiers*halfs)+(tiers*fulls*2)))/18)  ',''),
 (21,0,'Plastic Feeder Ends ','(((tiers*halfs)+(tiers*fulls*2))*2) ',''),
 (22,0,'Plastic Feeder Joints ','(((tiers*halfs)+(tiers*fulls*2))*2) ',''),
 (23,0,'Teflan tapes ','((((cageLength*((tiers*halfs)+(tiers*fulls*2)))*3/1.25/3)+cageLength*((tiers*halfs)+(tiers*fulls*2)))/300)  ',''),
 (24,0,'Nipples & Saddles CL4 ','((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs)) ',''),
 (25,0,'Nipples & Saddles CL10 ','((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs)) ',''),
 (26,0,'drilling,solution & saddle fixing ','((((cageLength/sheetLength)*fulls)*noOfPartitionsPerSheetLength*2)+(((cageLength/sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/sheetLength)*halfs*tiers))*noOfPartitionsPerSheetLength)+(1+noOfCuttingsInShed)*((tiers*2)*fulls)+((tiers*1)*halfs)) ',''),
 (27,1,'Joint couplers ','(((((cageLength/sheetLength)*fulls)*2)+(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers))-((tiers*2*fulls*(1+noOfCuttingsInShed))+2)) ',''),
 (28,1,'coupler/reducers ','((tiers*2*fulls*(1+noOfCuttingsInShed))+2) ',''),
 (29,1,'Flushing Unit ','(noOfCuttingsInShed +1) ',''),
 (30,0,'Nipple pipes square(Chakra)15\' ','((((cageLength/sheetLength)*fulls)*2)+(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)) ',''),
 (31,0,'Nipple pipes Round 20mm(Chakra)15\' ','((((cageLength/sheetLength)*fulls)*2)+(((cageLength/sheetLength)*fulls*(tiers-1)*2))+((cageLength/sheetLength)*halfs*tiers)) ',''),
 (32,0,'Weld Rods used at factory ','(((cageLength/5+1)*fulls)*0.0666666666666667)  ',''),
 (33,0,'Redoxide ','((cageLength*((tiers*halfs)+(tiers*fulls*2)))*2.75/375)  ',''),
 (34,0,'GI Wire 18 g ','((cageLength*((tiers*halfs)+(tiers*fulls*2)))*2.75/1200)  ',''),
 (35,0,'GI Wire 16 g ','((cageLength*((tiers*halfs)+(tiers*fulls*2)))*2.75/800)  ',''),
 (36,0,'Rivits -Big ','((((cageLength*((tiers*halfs)+(tiers*fulls*2)))*2.75/6)+cageLength*((tiers*halfs)+(tiers*fulls*2)))/400) ',''),
 (37,0,'Rivits -Small ','(((cageLength*((tiers*halfs)+(tiers*fulls*2)))/18)*5/600) ','');
/*!40000 ALTER TABLE `cage_part_spec_formula` ENABLE KEYS */;


--
-- Definition of table `cage_part_specification`
--

DROP TABLE IF EXISTS `cage_part_specification`;
CREATE TABLE `cage_part_specification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_part_specification` varchar(255) NOT NULL,
  `cage_part_type_id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4A41AD1A282034E9` (`cage_part_type_id`),
  CONSTRAINT `FK4A41AD1A282034E9` FOREIGN KEY (`cage_part_type_id`) REFERENCES `cage_part_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_part_specification`
--

/*!40000 ALTER TABLE `cage_part_specification` DISABLE KEYS */;
INSERT INTO `cage_part_specification` (`id`,`version`,`cage_part_specification`,`cage_part_type_id`,`description`) VALUES 
 (1,1,'Paint Coated',1,''),
 (2,0,'Galvanised',1,''),
 (3,1,'Chakra Plastic Feeders Galvanized Brackets',2,''),
 (4,1,'Chakra Plastic Feeders Paint Coated Brackets',2,''),
 (5,2,'Aluminium 12\" Feeders Galvanized Brackets',2,''),
 (6,2,'Aluminium 12\" Feeders Paint Coated Brackets',2,''),
 (7,3,'Chakra 22mm Square',3,NULL),
 (10,4,'Chakra 20mm Round',3,NULL),
 (11,1,'MISC Materials & Fabrication',4,''),
 (12,1,'CL4 Nipple',6,NULL),
 (13,1,'CL10',6,NULL);
/*!40000 ALTER TABLE `cage_part_specification` ENABLE KEYS */;


--
-- Definition of table `cage_part_specification_cage_part_spec_formula`
--

DROP TABLE IF EXISTS `cage_part_specification_cage_part_spec_formula`;
CREATE TABLE `cage_part_specification_cage_part_spec_formula` (
  `cage_part_specification_cage_part_spec_formula_list_id` bigint(20) DEFAULT NULL,
  `cage_part_spec_formula_id` bigint(20) DEFAULT NULL,
  KEY `FK54C64EB0CF673E02` (`cage_part_spec_formula_id`),
  KEY `FK54C64EB0AAEE79B8` (`cage_part_specification_cage_part_spec_formula_list_id`),
  CONSTRAINT `FK54C64EB0AAEE79B8` FOREIGN KEY (`cage_part_specification_cage_part_spec_formula_list_id`) REFERENCES `cage_part_specification` (`id`),
  CONSTRAINT `FK54C64EB0CF673E02` FOREIGN KEY (`cage_part_spec_formula_id`) REFERENCES `cage_part_spec_formula` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_part_specification_cage_part_spec_formula`
--

/*!40000 ALTER TABLE `cage_part_specification_cage_part_spec_formula` DISABLE KEYS */;
INSERT INTO `cage_part_specification_cage_part_spec_formula` (`cage_part_specification_cage_part_spec_formula_list_id`,`cage_part_spec_formula_id`) VALUES 
 (2,9),
 (2,10),
 (2,11),
 (2,12),
 (3,18),
 (3,20),
 (3,21),
 (3,22),
 (4,19),
 (4,20),
 (4,21),
 (4,22),
 (5,13),
 (5,15),
 (5,16),
 (5,17),
 (6,14),
 (6,15),
 (6,16),
 (6,17),
 (11,32),
 (11,33),
 (11,34),
 (11,35),
 (11,36),
 (11,37),
 (1,1),
 (1,3),
 (1,5),
 (1,7),
 (7,23),
 (7,27),
 (7,28),
 (7,29),
 (7,30),
 (10,23),
 (10,27),
 (10,28),
 (10,29),
 (10,31),
 (12,24),
 (12,26),
 (13,25),
 (13,26);
/*!40000 ALTER TABLE `cage_part_specification_cage_part_spec_formula` ENABLE KEYS */;


--
-- Definition of table `cage_part_type`
--

DROP TABLE IF EXISTS `cage_part_type`;
CREATE TABLE `cage_part_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_part_type` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_part_type`
--

/*!40000 ALTER TABLE `cage_part_type` DISABLE KEYS */;
INSERT INTO `cage_part_type` (`id`,`version`,`cage_part_type`,`description`) VALUES 
 (1,0,'Structure Frames',''),
 (2,0,'Feeding System',''),
 (3,2,'Watering System Pipe',NULL),
 (4,0,'Misc.',''),
 (5,0,'Mesh ','xyz'),
 (6,1,'Watering System Nipple',NULL);
/*!40000 ALTER TABLE `cage_part_type` ENABLE KEYS */;


--
-- Definition of table `corder`
--

DROP TABLE IF EXISTS `corder`;
CREATE TABLE `corder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `balance` decimal(19,2) NOT NULL,
  `cage_design_id` bigint(20) NOT NULL,
  `cage_length` decimal(19,2) NOT NULL,
  `cage_part_cost` decimal(19,2) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `cost` decimal(19,2) NOT NULL,
  `cost_per_bird` decimal(19,2) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `delivery_date` datetime NOT NULL,
  `double_box` decimal(19,2) DEFAULT NULL,
  `fulls` decimal(19,2) NOT NULL,
  `halfs` decimal(19,2) NOT NULL,
  `last_edited_by_id` bigint(20) DEFAULT NULL,
  `last_edited_date` datetime DEFAULT NULL,
  `mesh_cost` decimal(19,2) DEFAULT NULL,
  `no_of_birds` decimal(19,2) NOT NULL,
  `no_of_cuttings_in_shed` decimal(19,2) NOT NULL,
  `no_of_sheds` decimal(19,2) NOT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `payment_due_date` datetime NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `quotation_id` bigint(20) NOT NULL,
  `shipping_status` varchar(255) NOT NULL,
  `single_box` decimal(19,2) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `tax` decimal(19,2) NOT NULL,
  `taxation_id` bigint(20) NOT NULL,
  `tiers` decimal(19,2) NOT NULL,
  `total_cost` decimal(19,2) NOT NULL,
  `wire_brand_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAF414CCBEE58B9A3` (`taxation_id`),
  KEY `FKAF414CCBFF80FD6C` (`last_edited_by_id`),
  KEY `FKAF414CCB39213646` (`wire_brand_id`),
  KEY `FKAF414CCB2EDD5C95` (`quotation_id`),
  KEY `FKAF414CCBE3175CFC` (`cage_design_id`),
  KEY `FKAF414CCBDA2CD5E2` (`created_by_id`),
  KEY `FKAF414CCB5ADA1CC7` (`customer_id`),
  CONSTRAINT `FKAF414CCB2EDD5C95` FOREIGN KEY (`quotation_id`) REFERENCES `quotation` (`id`),
  CONSTRAINT `FKAF414CCB39213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FKAF414CCB5ADA1CC7` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FKAF414CCBDA2CD5E2` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKAF414CCBE3175CFC` FOREIGN KEY (`cage_design_id`) REFERENCES `cage_design` (`id`),
  CONSTRAINT `FKAF414CCBEE58B9A3` FOREIGN KEY (`taxation_id`) REFERENCES `taxation` (`id`),
  CONSTRAINT `FKAF414CCBFF80FD6C` FOREIGN KEY (`last_edited_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `corder`
--

/*!40000 ALTER TABLE `corder` DISABLE KEYS */;
INSERT INTO `corder` (`id`,`version`,`balance`,`cage_design_id`,`cage_length`,`cage_part_cost`,`comments`,`cost`,`cost_per_bird`,`created_by_id`,`created_date`,`customer_id`,`delivery_date`,`double_box`,`fulls`,`halfs`,`last_edited_by_id`,`last_edited_date`,`mesh_cost`,`no_of_birds`,`no_of_cuttings_in_shed`,`no_of_sheds`,`order_id`,`payment_due_date`,`payment_status`,`quotation_id`,`shipping_status`,`single_box`,`status`,`tax`,`taxation_id`,`tiers`,`total_cost`,`wire_brand_id`) VALUES 
 (1,1,'563965.35',1,'200.00','0.00','Created By admin 01/06/12-11:56\n','537109.85','39.16',1,'2012-06-01 11:56:43',1,'2012-07-02 00:00:00','53.33','4.00','2.00',1,'2012-06-01 11:56:44','537109.85','14400.00','2.00','1.00','ORD010612115643','2012-06-18 00:00:00','DUE',1,'NEW','293.33','CONFIRMED','26855.49',1,'3.00','563965.35',1),
 (2,1,'1160045.87',3,'500.00','0.00','Created By admin 01/06/12-02:32\n','1104805.59','36.25',1,'2012-06-01 14:32:23',1,'2012-08-01 00:00:00','133.33','4.00','2.00',1,'2012-06-01 14:32:23','1104805.59','32000.00','2.00','1.00','ORD010612023223','2012-07-01 00:00:00','DUE',2,'NEW','400.00','CONFIRMED','55240.28',1,'2.00','1160045.87',1),
 (3,1,'371616.91',1,'300.00','0.00','Created By admin 01/06/12-02:35\n','353920.86','43.01',1,'2012-06-01 14:35:41',1,'2012-06-01 00:00:00','40.00','2.00','2.00',1,'2012-06-01 14:35:41','353920.86','8640.00','2.00','1.00','ORD010612023541','2012-06-01 00:00:00','DUE',3,'NEW','160.00','CONFIRMED','17696.04',1,'2.00','371616.91',2);
/*!40000 ALTER TABLE `corder` ENABLE KEYS */;


--
-- Definition of table `corder_cage_parts`
--

DROP TABLE IF EXISTS `corder_cage_parts`;
CREATE TABLE `corder_cage_parts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_part_spec_formula_id` bigint(20) DEFAULT NULL,
  `corder_id` bigint(20) NOT NULL,
  `cost_of_cage_part` decimal(19,2) DEFAULT NULL,
  `no_of_cage_parts` decimal(19,2) DEFAULT NULL,
  `price_of_each_cage_part` decimal(19,2) DEFAULT NULL,
  `corder_cage_parts_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFF2B66911E07B2DD` (`corder_id`),
  KEY `FKFF2B6691CF673E02` (`cage_part_spec_formula_id`),
  CONSTRAINT `FKFF2B66911E07B2DD` FOREIGN KEY (`corder_id`) REFERENCES `corder` (`id`),
  CONSTRAINT `FKFF2B6691CF673E02` FOREIGN KEY (`cage_part_spec_formula_id`) REFERENCES `cage_part_spec_formula` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `corder_cage_parts`
--

/*!40000 ALTER TABLE `corder_cage_parts` DISABLE KEYS */;
/*!40000 ALTER TABLE `corder_cage_parts` ENABLE KEYS */;


--
-- Definition of table `corder_mesh_parts`
--

DROP TABLE IF EXISTS `corder_mesh_parts`;
CREATE TABLE `corder_mesh_parts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `corder_id` bigint(20) NOT NULL,
  `mesh_cost` decimal(19,2) DEFAULT NULL,
  `no_of_mesh_parts` decimal(19,2) NOT NULL,
  `sheet_specification_id` bigint(20) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  `wire_price` decimal(19,2) NOT NULL,
  `corder_mesh_parts_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK585C5A0239213646` (`wire_brand_id`),
  KEY `FK585C5A021E07B2DD` (`corder_id`),
  KEY `FK585C5A02444E1384` (`sheet_specification_id`),
  CONSTRAINT `FK585C5A021E07B2DD` FOREIGN KEY (`corder_id`) REFERENCES `corder` (`id`),
  CONSTRAINT `FK585C5A0239213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK585C5A02444E1384` FOREIGN KEY (`sheet_specification_id`) REFERENCES `sheet_specification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `corder_mesh_parts`
--

/*!40000 ALTER TABLE `corder_mesh_parts` DISABLE KEYS */;
INSERT INTO `corder_mesh_parts` (`id`,`version`,`corder_id`,`mesh_cost`,`no_of_mesh_parts`,`sheet_specification_id`,`wire_brand_id`,`wire_price`,`corder_mesh_parts_idx`) VALUES 
 (1,0,1,'178200.00','293.33',3,1,'75.00',0),
 (2,0,1,'132880.00','97.78',4,1,'75.00',1),
 (3,0,1,'109755.00','4878.00',5,1,'75.00',2),
 (4,0,1,'60800.00','53.33',1,1,'75.00',3),
 (5,0,1,'18000.00','4800.00',6,1,'75.00',4),
 (6,0,1,'37480.00','53.33',2,1,'75.00',5),
 (7,0,2,'265716.00','8052.00',9,1,'75.00',0),
 (8,0,2,'278700.00','400.00',19,1,'75.00',1),
 (9,0,2,'38000.00','33.33',10,1,'75.00',2),
 (10,0,2,'146800.00','133.33',7,1,'75.00',3),
 (11,0,2,'30000.00','8000.00',6,1,'75.00',4),
 (12,0,2,'228000.00','200.00',20,1,'75.00',5),
 (13,0,2,'117600.00','133.33',17,1,'75.00',6),
 (14,0,3,'11959.20','2880.00',6,2,'83.05',0),
 (15,0,3,'80259.52','53.33',4,2,'83.05',1),
 (16,0,3,'107632.80','160.00',3,2,'83.05',2),
 (17,0,3,'31127.14','40.00',2,2,'83.05',3),
 (18,0,3,'50494.40','40.00',1,2,'83.05',4),
 (19,0,3,'72452.82','2908.00',5,2,'83.05',5);
/*!40000 ALTER TABLE `corder_mesh_parts` ENABLE KEYS */;


--
-- Definition of table `corder_payment`
--

DROP TABLE IF EXISTS `corder_payment`;
CREATE TABLE `corder_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `corder_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `last_edited_by_id` bigint(20) DEFAULT NULL,
  `last_edited_date` datetime DEFAULT NULL,
  `payment_amount` decimal(19,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `corder_payments_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1F252A92FF80FD6C` (`last_edited_by_id`),
  KEY `FK1F252A921E07B2DD` (`corder_id`),
  KEY `FK1F252A92DA2CD5E2` (`created_by_id`),
  KEY `FK1F252A925ADA1CC7` (`customer_id`),
  CONSTRAINT `FK1F252A921E07B2DD` FOREIGN KEY (`corder_id`) REFERENCES `corder` (`id`),
  CONSTRAINT `FK1F252A925ADA1CC7` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK1F252A92DA2CD5E2` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK1F252A92FF80FD6C` FOREIGN KEY (`last_edited_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `corder_payment`
--

/*!40000 ALTER TABLE `corder_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `corder_payment` ENABLE KEYS */;


--
-- Definition of table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `fax` varchar(255) NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` (`id`,`version`,`address`,`company_name`,`customer_id`,`customer_name`,`email`,`fax`,`mobile_number`,`phone_number`,`comments`) VALUES 
 (1,0,'Teeparu','UKI','CUS010612115507','Raghu','raghu@gmail.com','23456','9866315545','04027642537','Created By admin 01/06/12-11:55\n');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;


--
-- Definition of table `enquiry`
--

DROP TABLE IF EXISTS `enquiry`;
CREATE TABLE `enquiry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `assigned_id` bigint(20) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `enquiry_date` datetime NOT NULL,
  `enquiry_id` varchar(255) DEFAULT NULL,
  `last_edited_by_id` bigint(20) DEFAULT NULL,
  `last_edited_date` datetime DEFAULT NULL,
  `source` varchar(9) NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA0F99CC3FF80FD6C` (`last_edited_by_id`),
  KEY `FKA0F99CC3DA2CD5E2` (`created_by_id`),
  KEY `FKA0F99CC3CDA93922` (`assigned_id`),
  KEY `FKA0F99CC35ADA1CC7` (`customer_id`),
  CONSTRAINT `FKA0F99CC35ADA1CC7` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FKA0F99CC3CDA93922` FOREIGN KEY (`assigned_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKA0F99CC3DA2CD5E2` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKA0F99CC3FF80FD6C` FOREIGN KEY (`last_edited_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enquiry`
--

/*!40000 ALTER TABLE `enquiry` DISABLE KEYS */;
INSERT INTO `enquiry` (`id`,`version`,`assigned_id`,`comments`,`created_by_id`,`created_date`,`customer_id`,`enquiry_date`,`enquiry_id`,`last_edited_by_id`,`last_edited_date`,`source`,`status`) VALUES 
 (1,1,NULL,'QUO010612115600 01/06/12-11:56\n',1,'2012-06-01 11:55:44',1,'2012-06-01 00:00:00','ENQ010612115544',1,'2012-06-01 11:56:00','In Person','NEW'),
 (2,0,2,'Created By admin 02/06/12-01:26',1,'2012-06-02 13:26:36',1,'2012-06-02 00:00:00','ENQ020612012636',NULL,NULL,'In Person','ASSIGNED'),
 (3,0,2,'Created By admin 02/06/12-02:07',1,'2012-06-02 14:07:32',1,'2012-06-02 00:00:00','ENQ020612020732',NULL,NULL,'In Person','ASSIGNED'),
 (4,1,NULL,'QUO040612121318 04/06/12-12:13\n',1,'2012-06-04 11:11:06',1,'2012-06-04 00:00:00','ENQ040612111106',1,'2012-06-04 12:13:18','In Person','REALIZED'),
 (5,0,2,'Created By admin 04/06/12-11:52',1,'2012-06-04 11:52:29',1,'2012-06-04 00:00:00','ENQ040612115229',NULL,NULL,'In Person','ASSIGNED'),
 (6,3,2,'TestCreated By admin 04/06/12-05:30\r\nTest2\r\nTest1 Edited By admin 04/06/12-05:32\r\n Edited By admin 04/06/12-05:33\r\nTest3 Edited By admin 04/06/12-05:33\n',1,'2012-06-04 17:30:52',1,'2012-06-04 00:00:00','ENQ040612053052',1,'2012-06-04 17:33:56','In Person','ASSIGNED');
/*!40000 ALTER TABLE `enquiry` ENABLE KEYS */;


--
-- Definition of table `enquiry_cage_part_type`
--

DROP TABLE IF EXISTS `enquiry_cage_part_type`;
CREATE TABLE `enquiry_cage_part_type` (
  `enquiry_cage_part_type_list_id` bigint(20) DEFAULT NULL,
  `cage_part_type_id` bigint(20) DEFAULT NULL,
  KEY `FK62F303F282034E9` (`cage_part_type_id`),
  KEY `FK62F303F6422BDB1` (`enquiry_cage_part_type_list_id`),
  CONSTRAINT `FK62F303F282034E9` FOREIGN KEY (`cage_part_type_id`) REFERENCES `cage_part_type` (`id`),
  CONSTRAINT `FK62F303F6422BDB1` FOREIGN KEY (`enquiry_cage_part_type_list_id`) REFERENCES `enquiry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enquiry_cage_part_type`
--

/*!40000 ALTER TABLE `enquiry_cage_part_type` DISABLE KEYS */;
INSERT INTO `enquiry_cage_part_type` (`enquiry_cage_part_type_list_id`,`cage_part_type_id`) VALUES 
 (1,2),
 (2,5),
 (3,5),
 (4,2),
 (5,5),
 (6,5);
/*!40000 ALTER TABLE `enquiry_cage_part_type` ENABLE KEYS */;


--
-- Definition of table `enquiry_job`
--

DROP TABLE IF EXISTS `enquiry_job`;
CREATE TABLE `enquiry_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enquiry_job`
--

/*!40000 ALTER TABLE `enquiry_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `enquiry_job` ENABLE KEYS */;


--
-- Definition of table `machine`
--

DROP TABLE IF EXISTS `machine`;
CREATE TABLE `machine` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `machine_name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `machine`
--

/*!40000 ALTER TABLE `machine` DISABLE KEYS */;
INSERT INTO `machine` (`id`,`version`,`machine_name`,`description`) VALUES 
 (1,0,'M1',''),
 (2,0,'M2',''),
 (3,0,'M3','');
/*!40000 ALTER TABLE `machine` ENABLE KEYS */;


--
-- Definition of table `notification`
--

DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL,
  `notif_display` bit(1) NOT NULL,
  `notif_msg` varchar(255) NOT NULL,
  `notif_type` varchar(255) NOT NULL,
  `notif_url` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notification`
--

/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` (`id`,`version`,`created_date`,`email`,`error_message`,`notif_display`,`notif_msg`,`notif_type`,`notif_url`,`phone_number`,`user_name`) VALUES 
 (1,1,'2012-06-04 11:52:29',NULL,NULL,0x00,'ENQ040612115229 RECEIVED ENQUIRY WILL BE ATTENDED BY admin','SMS',NULL,'9866315545',NULL),
 (2,0,'2012-06-04 11:52:29',NULL,NULL,0x01,'NEW ENQUIRY','APP','<a href=\"/Chakra/enquiry/show/5\">ENQ040612115229</a>',NULL,'sales'),
 (3,1,'2012-06-04 17:30:52',NULL,NULL,0x00,'ENQ040612053052 RECEIVED ENQUIRY WILL BE ATTENDED BY admin','SMS',NULL,'9866315545',NULL),
 (4,0,'2012-06-04 17:30:52',NULL,NULL,0x01,'NEW ENQUIRY','APP','<a href=\"/Chakra/enquiry/show/6\">ENQ040612053052</a>',NULL,'sales');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;


--
-- Definition of table `price`
--

DROP TABLE IF EXISTS `price`;
CREATE TABLE `price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `effective_date` datetime NOT NULL,
  `price` decimal(19,2) NOT NULL,
  `sheet_specification_id` bigint(20) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65FB14939213646` (`wire_brand_id`),
  KEY `FK65FB149444E1384` (`sheet_specification_id`),
  CONSTRAINT `FK65FB14939213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK65FB149444E1384` FOREIGN KEY (`sheet_specification_id`) REFERENCES `sheet_specification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `price`
--

/*!40000 ALTER TABLE `price` DISABLE KEYS */;
/*!40000 ALTER TABLE `price` ENABLE KEYS */;


--
-- Definition of table `production_reporting`
--

DROP TABLE IF EXISTS `production_reporting`;
CREATE TABLE `production_reporting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `edited_date` datetime DEFAULT NULL,
  `last_edited_by` varchar(255) DEFAULT NULL,
  `machine_id` bigint(20) NOT NULL,
  `sheet_specifcation_id` bigint(20) NOT NULL,
  `stock_manufactured_time` datetime NOT NULL,
  `total_quantity` decimal(19,2) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9087DE2839213646` (`wire_brand_id`),
  KEY `FK9087DE28E478C8DD` (`sheet_specifcation_id`),
  KEY `FK9087DE28D1111F11` (`machine_id`),
  CONSTRAINT `FK9087DE2839213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK9087DE28D1111F11` FOREIGN KEY (`machine_id`) REFERENCES `machine` (`id`),
  CONSTRAINT `FK9087DE28E478C8DD` FOREIGN KEY (`sheet_specifcation_id`) REFERENCES `sheet_specification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `production_reporting`
--

/*!40000 ALTER TABLE `production_reporting` DISABLE KEYS */;
INSERT INTO `production_reporting` (`id`,`version`,`comments`,`created_by`,`created_date`,`edited_date`,`last_edited_by`,`machine_id`,`sheet_specifcation_id`,`stock_manufactured_time`,`total_quantity`,`wire_brand_id`) VALUES 
 (1,5,'Created By admin-01/06/12-08:52\r\n<br>Edited By admin-01/06/12-08:54\n','admin','2012-06-01 08:52:51','2012-06-01 08:54:24','admin',1,2,'2012-06-01 00:00:00','20.00',1),
 (2,1,'Created By admin-01/06/12-12:59\n','admin','2012-06-01 12:59:28','2012-06-01 12:59:28','admin',1,1,'2012-06-01 00:00:00','10.00',1),
 (3,1,'Created By admin-03/06/12-06:13\n','admin','2012-06-03 18:13:53','2012-06-03 18:13:53','admin',1,1,'2012-06-03 00:00:00','10.00',1);
/*!40000 ALTER TABLE `production_reporting` ENABLE KEYS */;


--
-- Definition of table `production_reporting_wire_weight`
--

DROP TABLE IF EXISTS `production_reporting_wire_weight`;
CREATE TABLE `production_reporting_wire_weight` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `diameter` decimal(19,2) NOT NULL,
  `production_reporting_id` bigint(20) NOT NULL,
  `weight` decimal(19,2) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  `wire_consumption_date` datetime NOT NULL,
  `wire_receipt_reporting_id` bigint(20) NOT NULL,
  `production_reporting_wire_weight_list_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9A101FDBB43EBA8A` (`wire_receipt_reporting_id`),
  KEY `FK9A101FDB39213646` (`wire_brand_id`),
  KEY `FK9A101FDB10ED16B5` (`production_reporting_id`),
  CONSTRAINT `FK9A101FDB10ED16B5` FOREIGN KEY (`production_reporting_id`) REFERENCES `production_reporting` (`id`),
  CONSTRAINT `FK9A101FDB39213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK9A101FDBB43EBA8A` FOREIGN KEY (`wire_receipt_reporting_id`) REFERENCES `wire_receipt_reporting` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `production_reporting_wire_weight`
--

/*!40000 ALTER TABLE `production_reporting_wire_weight` DISABLE KEYS */;
INSERT INTO `production_reporting_wire_weight` (`id`,`version`,`diameter`,`production_reporting_id`,`weight`,`wire_brand_id`,`wire_consumption_date`,`wire_receipt_reporting_id`,`production_reporting_wire_weight_list_idx`) VALUES 
 (2,0,'3.00',1,'187.43',1,'2012-06-01 00:00:00',5,0),
 (3,0,'2.50',2,'151.97',1,'2012-06-01 00:00:00',4,0),
 (4,0,'2.50',3,'151.97',1,'2012-06-03 00:00:00',4,0);
/*!40000 ALTER TABLE `production_reporting_wire_weight` ENABLE KEYS */;


--
-- Definition of table `quotation`
--

DROP TABLE IF EXISTS `quotation`;
CREATE TABLE `quotation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_length` decimal(19,2) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `fulls` decimal(19,2) NOT NULL,
  `halfs` decimal(19,2) NOT NULL,
  `last_edited_by_id` bigint(20) DEFAULT NULL,
  `last_edited_date` datetime DEFAULT NULL,
  `no_of_cuttings_in_shed` decimal(19,2) NOT NULL,
  `no_of_sheds` decimal(19,2) NOT NULL,
  `quotation_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `tiers` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA771958CFF80FD6C` (`last_edited_by_id`),
  KEY `FKA771958CDA2CD5E2` (`created_by_id`),
  KEY `FKA771958C5ADA1CC7` (`customer_id`),
  CONSTRAINT `FKA771958C5ADA1CC7` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FKA771958CDA2CD5E2` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKA771958CFF80FD6C` FOREIGN KEY (`last_edited_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation`
--

/*!40000 ALTER TABLE `quotation` DISABLE KEYS */;
INSERT INTO `quotation` (`id`,`version`,`cage_length`,`comments`,`created_by_id`,`created_date`,`customer_id`,`fulls`,`halfs`,`last_edited_by_id`,`last_edited_date`,`no_of_cuttings_in_shed`,`no_of_sheds`,`quotation_id`,`status`,`tiers`) VALUES 
 (1,3,'200.00','ORD010612115643 01/06/12-11:56\n',1,'2012-06-01 11:56:00',1,'4.00','2.00',1,'2012-06-03 18:50:04','2.00','1.00','QUO010612115600','CANCELLED','3.00'),
 (2,2,'500.00','ORD010612023223 01/06/12-02:32\n',1,'2012-06-01 14:31:38',1,'4.00','2.00',1,'2012-06-01 14:32:23','2.00','1.00','QUO010612023138','REALIZED','2.00'),
 (3,2,'300.00','ORD010612023541 01/06/12-02:35\n',1,'2012-06-01 14:35:26',1,'2.00','2.00',1,'2012-06-01 14:35:41','2.00','1.00','QUO010612023526','REALIZED','2.00'),
 (4,1,'300.00','Created By admin 04/06/12-12:13\n',1,'2012-06-04 12:13:18',1,'4.00','2.00',NULL,'2012-06-04 23:08:00','2.00','1.00','QUO040612121318','EXPIRED','2.00');
/*!40000 ALTER TABLE `quotation` ENABLE KEYS */;


--
-- Definition of table `quotation_cage_part`
--

DROP TABLE IF EXISTS `quotation_cage_part`;
CREATE TABLE `quotation_cage_part` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_part_spec_formula_id` bigint(20) DEFAULT NULL,
  `cost_of_cage_part` decimal(19,2) DEFAULT NULL,
  `no_of_cage_parts` decimal(19,2) DEFAULT NULL,
  `price_of_each_cage_part` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKABC169A3CF673E02` (`cage_part_spec_formula_id`),
  CONSTRAINT `FKABC169A3CF673E02` FOREIGN KEY (`cage_part_spec_formula_id`) REFERENCES `cage_part_spec_formula` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_cage_part`
--

/*!40000 ALTER TABLE `quotation_cage_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation_cage_part` ENABLE KEYS */;


--
-- Definition of table `quotation_cage_part_model`
--

DROP TABLE IF EXISTS `quotation_cage_part_model`;
CREATE TABLE `quotation_cage_part_model` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_design_id` bigint(20) DEFAULT NULL,
  `cage_part_cost` decimal(19,2) DEFAULT NULL,
  `cost_per_bird` decimal(19,2) DEFAULT NULL,
  `no_of_birds` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDC36C18DE3175CFC` (`cage_design_id`),
  CONSTRAINT `FKDC36C18DE3175CFC` FOREIGN KEY (`cage_design_id`) REFERENCES `cage_design` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_cage_part_model`
--

/*!40000 ALTER TABLE `quotation_cage_part_model` DISABLE KEYS */;
INSERT INTO `quotation_cage_part_model` (`id`,`version`,`cage_design_id`,`cage_part_cost`,`cost_per_bird`,`no_of_birds`) VALUES 
 (1,0,1,'0.00','0.00','14400.00'),
 (2,0,3,'0.00','0.00','32000.00'),
 (3,0,1,'0.00','0.00','8640.00');
/*!40000 ALTER TABLE `quotation_cage_part_model` ENABLE KEYS */;


--
-- Definition of table `quotation_cage_part_model_quotation_cage_part`
--

DROP TABLE IF EXISTS `quotation_cage_part_model_quotation_cage_part`;
CREATE TABLE `quotation_cage_part_model_quotation_cage_part` (
  `quotation_cage_part_model_quotation_cage_parts_id` bigint(20) DEFAULT NULL,
  `quotation_cage_part_id` bigint(20) DEFAULT NULL,
  `quotation_cage_parts_idx` int(11) DEFAULT NULL,
  KEY `FK875B6FF146D01E0D` (`quotation_cage_part_id`),
  CONSTRAINT `FK875B6FF146D01E0D` FOREIGN KEY (`quotation_cage_part_id`) REFERENCES `quotation_cage_part` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_cage_part_model_quotation_cage_part`
--

/*!40000 ALTER TABLE `quotation_cage_part_model_quotation_cage_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation_cage_part_model_quotation_cage_part` ENABLE KEYS */;


--
-- Definition of table `quotation_mesh_model`
--

DROP TABLE IF EXISTS `quotation_mesh_model`;
CREATE TABLE `quotation_mesh_model` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_design_id` bigint(20) DEFAULT NULL,
  `cost_per_bird` decimal(19,2) DEFAULT NULL,
  `double_box` decimal(19,2) DEFAULT NULL,
  `mesh_cost` decimal(19,2) DEFAULT NULL,
  `no_of_birds` decimal(19,2) DEFAULT NULL,
  `single_box` decimal(19,2) DEFAULT NULL,
  `wire_brand_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK25789EEA39213646` (`wire_brand_id`),
  KEY `FK25789EEAE3175CFC` (`cage_design_id`),
  CONSTRAINT `FK25789EEA39213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK25789EEAE3175CFC` FOREIGN KEY (`cage_design_id`) REFERENCES `cage_design` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_mesh_model`
--

/*!40000 ALTER TABLE `quotation_mesh_model` DISABLE KEYS */;
INSERT INTO `quotation_mesh_model` (`id`,`version`,`cage_design_id`,`cost_per_bird`,`double_box`,`mesh_cost`,`no_of_birds`,`single_box`,`wire_brand_id`) VALUES 
 (1,0,1,'37.30','53.33','537115.00','14400.00','293.33',1),
 (2,0,3,'34.53','133.33','1104816.00','32000.00','400.00',1),
 (3,0,1,'40.96','40.00','353925.88','8640.00','160.00',2);
/*!40000 ALTER TABLE `quotation_mesh_model` ENABLE KEYS */;


--
-- Definition of table `quotation_mesh_model_quotation_mesh_part`
--

DROP TABLE IF EXISTS `quotation_mesh_model_quotation_mesh_part`;
CREATE TABLE `quotation_mesh_model_quotation_mesh_part` (
  `quotation_mesh_model_quotation_mesh_parts_id` bigint(20) DEFAULT NULL,
  `quotation_mesh_part_id` bigint(20) DEFAULT NULL,
  `quotation_mesh_parts_idx` int(11) DEFAULT NULL,
  KEY `FK2FB8573DE9B14EF` (`quotation_mesh_part_id`),
  CONSTRAINT `FK2FB8573DE9B14EF` FOREIGN KEY (`quotation_mesh_part_id`) REFERENCES `quotation_mesh_part` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_mesh_model_quotation_mesh_part`
--

/*!40000 ALTER TABLE `quotation_mesh_model_quotation_mesh_part` DISABLE KEYS */;
INSERT INTO `quotation_mesh_model_quotation_mesh_part` (`quotation_mesh_model_quotation_mesh_parts_id`,`quotation_mesh_part_id`,`quotation_mesh_parts_idx`) VALUES 
 (1,1,0),
 (1,2,1),
 (1,3,2),
 (1,4,3),
 (1,5,4),
 (1,6,5),
 (2,7,0),
 (2,8,1),
 (2,9,2),
 (2,10,3),
 (2,11,4),
 (2,12,5),
 (2,13,6),
 (3,14,0),
 (3,15,1),
 (3,16,2),
 (3,17,3),
 (3,18,4),
 (3,19,5);
/*!40000 ALTER TABLE `quotation_mesh_model_quotation_mesh_part` ENABLE KEYS */;


--
-- Definition of table `quotation_mesh_part`
--

DROP TABLE IF EXISTS `quotation_mesh_part`;
CREATE TABLE `quotation_mesh_part` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `edited_date` datetime DEFAULT NULL,
  `last_edited_by` varchar(255) DEFAULT NULL,
  `no_of_mesh_parts` decimal(19,2) DEFAULT NULL,
  `sheet_specification_id` bigint(20) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  `wire_price` decimal(19,2) DEFAULT NULL,
  `mesh_cost` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK95DBC41239213646` (`wire_brand_id`),
  KEY `FK95DBC412444E1384` (`sheet_specification_id`),
  CONSTRAINT `FK95DBC41239213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK95DBC412444E1384` FOREIGN KEY (`sheet_specification_id`) REFERENCES `sheet_specification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_mesh_part`
--

/*!40000 ALTER TABLE `quotation_mesh_part` DISABLE KEYS */;
INSERT INTO `quotation_mesh_part` (`id`,`version`,`created_by`,`created_date`,`edited_date`,`last_edited_by`,`no_of_mesh_parts`,`sheet_specification_id`,`wire_brand_id`,`wire_price`,`mesh_cost`) VALUES 
 (1,0,'admin','2012-06-01 11:56:00',NULL,NULL,'293.33',3,1,'75.00','178200.00'),
 (2,0,'admin','2012-06-01 11:56:00',NULL,NULL,'97.78',4,1,'75.00','132880.00'),
 (3,0,'admin','2012-06-01 11:56:00',NULL,NULL,'4878.00',5,1,'75.00','109755.00'),
 (4,0,'admin','2012-06-01 11:56:00',NULL,NULL,'53.33',1,1,'75.00','60800.00'),
 (5,0,'admin','2012-06-01 11:56:00',NULL,NULL,'4800.00',6,1,'75.00','18000.00'),
 (6,0,'admin','2012-06-01 11:56:00',NULL,NULL,'53.33',2,1,'75.00','37480.00'),
 (7,0,'admin','2012-06-01 14:31:38',NULL,NULL,'8052.00',9,1,'75.00','265716.00'),
 (8,0,'admin','2012-06-01 14:31:38',NULL,NULL,'400.00',19,1,'75.00','278700.00'),
 (9,0,'admin','2012-06-01 14:31:38',NULL,NULL,'33.33',10,1,'75.00','38000.00'),
 (10,0,'admin','2012-06-01 14:31:38',NULL,NULL,'133.33',7,1,'75.00','146800.00'),
 (11,0,'admin','2012-06-01 14:31:38',NULL,NULL,'8000.00',6,1,'75.00','30000.00'),
 (12,0,'admin','2012-06-01 14:31:38',NULL,NULL,'200.00',20,1,'75.00','228000.00'),
 (13,0,'admin','2012-06-01 14:31:38',NULL,NULL,'133.33',17,1,'75.00','117600.00'),
 (14,0,'admin','2012-06-01 14:35:26',NULL,NULL,'2880.00',6,2,'83.05','11959.20'),
 (15,0,'admin','2012-06-01 14:35:26',NULL,NULL,'53.33',4,2,'83.05','80259.52'),
 (16,0,'admin','2012-06-01 14:35:26',NULL,NULL,'160.00',3,2,'83.05','107632.80'),
 (17,0,'admin','2012-06-01 14:35:26',NULL,NULL,'40.00',2,2,'83.05','31127.14'),
 (18,0,'admin','2012-06-01 14:35:26',NULL,NULL,'40.00',1,2,'83.05','50494.40'),
 (19,0,'admin','2012-06-01 14:35:26',NULL,NULL,'2908.00',5,2,'83.05','72452.82');
/*!40000 ALTER TABLE `quotation_mesh_part` ENABLE KEYS */;


--
-- Definition of table `quotation_model`
--

DROP TABLE IF EXISTS `quotation_model`;
CREATE TABLE `quotation_model` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_design_id` bigint(20) NOT NULL,
  `cost` decimal(19,2) NOT NULL,
  `cost_per_bird` decimal(19,2) NOT NULL,
  `no_of_birds` decimal(19,2) NOT NULL,
  `quotation_cage_part_model_id` bigint(20) DEFAULT NULL,
  `quotation_mesh_model_id` bigint(20) DEFAULT NULL,
  `tax` decimal(19,2) NOT NULL,
  `taxation_id` bigint(20) NOT NULL,
  `total_cost` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK25669AB6EE58B9A3` (`taxation_id`),
  KEY `FK25669AB691BC2D00` (`quotation_cage_part_model_id`),
  KEY `FK25669AB658E5ABA5` (`quotation_mesh_model_id`),
  KEY `FK25669AB6E3175CFC` (`cage_design_id`),
  CONSTRAINT `FK25669AB658E5ABA5` FOREIGN KEY (`quotation_mesh_model_id`) REFERENCES `quotation_mesh_model` (`id`),
  CONSTRAINT `FK25669AB691BC2D00` FOREIGN KEY (`quotation_cage_part_model_id`) REFERENCES `quotation_cage_part_model` (`id`),
  CONSTRAINT `FK25669AB6E3175CFC` FOREIGN KEY (`cage_design_id`) REFERENCES `cage_design` (`id`),
  CONSTRAINT `FK25669AB6EE58B9A3` FOREIGN KEY (`taxation_id`) REFERENCES `taxation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_model`
--

/*!40000 ALTER TABLE `quotation_model` DISABLE KEYS */;
INSERT INTO `quotation_model` (`id`,`version`,`cage_design_id`,`cost`,`cost_per_bird`,`no_of_birds`,`quotation_cage_part_model_id`,`quotation_mesh_model_id`,`tax`,`taxation_id`,`total_cost`) VALUES 
 (1,0,1,'537115.00','39.16','14400.00',1,1,'26855.75',1,'563970.75'),
 (2,0,3,'1104816.00','36.25','32000.00',2,2,'55240.80',1,'1160056.80'),
 (3,0,1,'353925.88','43.01','8640.00',3,3,'17696.29',1,'371622.17');
/*!40000 ALTER TABLE `quotation_model` ENABLE KEYS */;


--
-- Definition of table `quotation_models`
--

DROP TABLE IF EXISTS `quotation_models`;
CREATE TABLE `quotation_models` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cage_design_id` bigint(20) NOT NULL,
  `cost` decimal(19,3) NOT NULL,
  `no_of_birds` decimal(19,2) NOT NULL,
  `quotation_mesh_model_id` bigint(20) NOT NULL,
  `tax` decimal(19,3) NOT NULL,
  `taxation_id` bigint(20) NOT NULL,
  `total_cost` decimal(19,3) NOT NULL,
  `cost_per_bird` decimal(19,2) NOT NULL,
  `double_box` decimal(19,2) NOT NULL,
  `single_box` decimal(19,2) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK876CBC7DEE58B9A3` (`taxation_id`),
  KEY `FK876CBC7D58E5ABA5` (`quotation_mesh_model_id`),
  KEY `FK876CBC7DE3175CFC` (`cage_design_id`),
  KEY `FK876CBC7D39213646` (`wire_brand_id`),
  CONSTRAINT `FK876CBC7D39213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK876CBC7D58E5ABA5` FOREIGN KEY (`quotation_mesh_model_id`) REFERENCES `quotation_mesh_model` (`id`),
  CONSTRAINT `FK876CBC7DE3175CFC` FOREIGN KEY (`cage_design_id`) REFERENCES `cage_design` (`id`),
  CONSTRAINT `FK876CBC7DEE58B9A3` FOREIGN KEY (`taxation_id`) REFERENCES `taxation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_models`
--

/*!40000 ALTER TABLE `quotation_models` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation_models` ENABLE KEYS */;


--
-- Definition of table `quotation_models_quotation_cage_part`
--

DROP TABLE IF EXISTS `quotation_models_quotation_cage_part`;
CREATE TABLE `quotation_models_quotation_cage_part` (
  `quotation_models_quotation_cage_parts_id` bigint(20) DEFAULT NULL,
  `quotation_cage_part_id` bigint(20) DEFAULT NULL,
  `quotation_cage_parts_idx` int(11) DEFAULT NULL,
  KEY `FKB53692E146D01E0D` (`quotation_cage_part_id`),
  CONSTRAINT `FKB53692E146D01E0D` FOREIGN KEY (`quotation_cage_part_id`) REFERENCES `quotation_cage_part` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `quotation_models_quotation_cage_part`
--

/*!40000 ALTER TABLE `quotation_models_quotation_cage_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation_models_quotation_cage_part` ENABLE KEYS */;


--
-- Definition of table `quotation_quotation_model`
--

DROP TABLE IF EXISTS `quotation_quotation_model`;
CREATE TABLE `quotation_quotation_model` (
  `quotation_quotation_models_id` bigint(20) DEFAULT NULL,
  `quotation_model_id` bigint(20) DEFAULT NULL,
  `quotation_models_idx` int(11) DEFAULT NULL,
  KEY `FK7B14EE0378E2BAC6` (`quotation_model_id`),
  CONSTRAINT `FK7B14EE0378E2BAC6` FOREIGN KEY (`quotation_model_id`) REFERENCES `quotation_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_quotation_model`
--

/*!40000 ALTER TABLE `quotation_quotation_model` DISABLE KEYS */;
INSERT INTO `quotation_quotation_model` (`quotation_quotation_models_id`,`quotation_model_id`,`quotation_models_idx`) VALUES 
 (1,1,0),
 (2,2,0),
 (3,3,0);
/*!40000 ALTER TABLE `quotation_quotation_model` ENABLE KEYS */;


--
-- Definition of table `quotation_quotation_models`
--

DROP TABLE IF EXISTS `quotation_quotation_models`;
CREATE TABLE `quotation_quotation_models` (
  `quotation_quotation_models_id` bigint(20) DEFAULT NULL,
  `quotation_models_id` bigint(20) DEFAULT NULL,
  `quotation_models_idx` int(11) DEFAULT NULL,
  KEY `FKE788D2D0A37D914E` (`quotation_models_id`),
  CONSTRAINT `FKE788D2D0A37D914E` FOREIGN KEY (`quotation_models_id`) REFERENCES `quotation_models` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quotation_quotation_models`
--

/*!40000 ALTER TABLE `quotation_quotation_models` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation_quotation_models` ENABLE KEYS */;


--
-- Definition of table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `authority` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authority` (`authority`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`,`version`,`authority`) VALUES 
 (3,0,'ROLE_ADMIN'),
 (4,0,'ROLE_SALES'),
 (5,0,'ROLE_PRODMANAGER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


--
-- Definition of table `sheet_description`
--

DROP TABLE IF EXISTS `sheet_description`;
CREATE TABLE `sheet_description` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `sheet_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sheet_description`
--

/*!40000 ALTER TABLE `sheet_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `sheet_description` ENABLE KEYS */;


--
-- Definition of table `sheet_specification`
--

DROP TABLE IF EXISTS `sheet_specification`;
CREATE TABLE `sheet_specification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cross_wire_diameter` decimal(19,2) NOT NULL,
  `length` decimal(19,2) NOT NULL,
  `line_wire_diameter1` decimal(19,2) NOT NULL,
  `line_wire_diameter2` decimal(19,2) NOT NULL,
  `no_of_line_wires1` decimal(19,2) NOT NULL,
  `no_of_line_wires2` decimal(19,2) NOT NULL,
  `pitch` decimal(19,2) NOT NULL,
  `projection` decimal(19,2) NOT NULL,
  `sheet_name` varchar(255) NOT NULL,
  `sheet_weight` decimal(19,2) NOT NULL,
  `width` decimal(19,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sheet_spec_id` varchar(255) NOT NULL,
  `factory_pitch` varchar(255) NOT NULL,
  `no_of_cross_wires` decimal(19,2) NOT NULL,
  `textual` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sheet_specification`
--

/*!40000 ALTER TABLE `sheet_specification` DISABLE KEYS */;
INSERT INTO `sheet_specification` (`id`,`version`,`cross_wire_diameter`,`length`,`line_wire_diameter1`,`line_wire_diameter2`,`no_of_line_wires1`,`no_of_line_wires2`,`pitch`,`projection`,`sheet_name`,`sheet_weight`,`width`,`description`,`sheet_spec_id`,`factory_pitch`,`no_of_cross_wires`,`textual`) VALUES 
 (1,23,'2.50','180.00','2.50','0.00','29.00','0.00','1.00','0.75','Double Bottom(Center Partition)','15.20','58.00',NULL,'LB26 ','12\" 12Gaps ','181.00','.75/3X3\"/8X1.5\"/8X1.5\"/3X3\"/1/5X3\"/.75'),
 (2,5,'3.00','180.00','3.00','0.00','15.00','0.00','2.14','0.25','Double Top','9.37','48.00',NULL,'LC26 ','15\" 7gaps','85.11','.25/5/6/1/4X3\"/4X3\"/1/6/5/.25'),
 (3,6,'3.00','180.00','3.00','2.50','12.00','3.00','2.14','0.25','Single Top','8.10','39.00',NULL,'LC01 ','15\" 7gaps','85.11','.25/5/6/1/4X3\"/4X3\"/3X1\"/.25'),
 (4,4,'2.50','180.00','2.50','0.00','36.00','0.00','1.00','0.75','Single Bottom(3 piece)','18.12','65.00',NULL,'LB101 ','12\" 12Gaps ','181.00','.75/3X3\"/8X1.5\"/1/8X1.5\"/3X3\"/1/3X3\"/8X1.5\"/.75'),
 (5,4,'2.50','12.00','2.50','0.00','7.00','0.00','1.00','0.50','Partition 12\"','0.30','16.50',NULL,'LP26 ','12\" 12Gaps ','13.00','.75/4X3\"/2\"/5\"/2\"/4X3\"/.75'),
 (6,3,'3.50','2.14','3.50','0.00','2.00','0.00','2.14','0.63','Gates','0.05','8.00',NULL,'LD01 ','','2.00',''),
 (7,3,'2.50','180.00','2.50','0.00','31.00','0.00','1.00','0.75','Double Bottom','14.68','54.00',NULL,'LB27','12\" 12Gaps ','181.00','.75/3X3\"/12X1.5\"/12X1.5\"/3X3\"/.75'),
 (8,5,'3.00','180.00','3.00','0.00','19.00','0.00','2.14','0.25','Double Top','11.76','60.00',NULL,'LC33','15\" 7gaps','85.11','.25/5/6/1/6X3\"/6X3\"/1/6/5/.25'),
 (9,3,'2.50','18.00','2.50','0.00','7.00','0.00','1.00','0.50','Partitions 18\"','0.44','16.50',NULL,'LP27','12\" 12Gaps ','19.00','.75/4X3\"/2\"/5\"/2\"/4X3\"/.75'),
 (10,3,'2.50','180.00','2.50','0.00','24.00','0.00','1.00','0.75','Centre Partition','15.20','63.00',NULL,'LP01','12\" 12Gaps ','181.00','.75/5X3\"/1/5X3\"/1/5X3\"/1/5X3\"/.75'),
 (11,3,'2.50','187.00','2.50','0.00','27.00','0.00','1.00','0.75','Double Bottom','13.64','48.00',NULL,'LB28','12\" 12Gaps ','188.00','.75/3X3\"/10X1.5\"/10X1.5\"/3X3\"/.75'),
 (12,3,'3.00','187.00','3.00','0.00','17.00','0.00','2.13','0.25','Double Top','11.00','54.00',NULL,'LC28','17\" 8gaps','88.79','.25/5/6/1/5X3\"/5X3\"/1/6/5/.25'),
 (13,3,'3.00','187.00','3.00','2.50','13.00','3.00','2.13','0.25','Single Top','9.05','42.00',NULL,'LC03','17\" 8gaps','88.79','.25/5/6/1/5X3\"/4X3\"/3X1\"/.25'),
 (14,3,'2.50','187.00','2.50','0.00','28.00','0.00','1.00','0.75','Single Bottom','14.00','49.00',NULL,'LB103','12\" 12Gaps ','188.00','.75/3X3\"/10X1.5\"/1/10X1.5\"/3X3\"/.75'),
 (15,5,'2.50','15.00','2.50','0.00','7.00','0.00','1.00','0.50','Partitions 15\"','0.37','16.50',NULL,'LP28','12\" 12Gaps ','16.00','.75/4X3\"/2\"/5\"/2\"/4X3\"/.75'),
 (17,6,'3.00','180.00','3.00','0.00','19.00','0.00','2.14','0.25','Double Top','11.76','60.00',NULL,'LC33','15\" 7gaps','85.11','.25/5/6/1/6X3\"/6X3\"/1/6/5/.25'),
 (18,3,'2.50','187.00','2.50','0.00','24.00','0.00','1.00','0.75','Centre Partition 187\"','15.78','63.00',NULL,'LP02','12\" 12Gaps ','188.00','.75/5X3\"/1/5X3\"/1/5X3\"/1/5X3\"/.75'),
 (19,3,'3.00','180.00','3.00','2.50','14.00','3.00','2.14','0.25','Single Top','9.29','45.00',NULL,'LC27','15\" 7gaps','85.11','.25/5/6/1/6X3\"/4X3\"/3X1\"/.25'),
 (20,3,'2.50','180.00','0.00','2.50','0.00','32.00','1.00','0.75','Single Bottom(2 Piece)   ','15.20','55.00',NULL,'LB102','12\" 12Gaps ','181.00','.75/3X3\"/12X1.5\"/1/12X1.5\"/3X3\"/.75'),
 (21,8,'2.50','187.00','2.50','0.00','27.00','0.00','1.00','0.75','Double Bottom','13.29','46.00',NULL,'LB29','12\" 12Gaps ','188.00','.75/3X3\"/2/9X1.5\"/9X1.5\"/2/3X3\"/.75'),
 (22,3,'3.00','187.00','3.00','0.00','17.00','0.00','2.13','0.25','Double top','10.76','52.00',NULL,'LC29','17\" 8gaps','88.79','.25/5/6/1/2/4X3\"/4X3\"/2/1/6/5/.25'),
 (23,7,'3.00','187.00','3.00','2.50','13.00','3.00','2.13','0.25','Single top','8.93','41.00',NULL,'LC04','17\" 8gaps','88.79','.25/5/6/1/2/4X3\"/4X3\"/3X1\"/.25'),
 (24,7,'2.50','187.00','2.50','0.00','26.00','0.00','1.00','0.75','Single Bottom','13.64','49.00',NULL,'LB104','12\" 12Gaps ','188.00','.75/3X3\"/2/8X1.5\"/1/8X1.5\"/2/3X3\"/.75'),
 (25,3,'2.50','14.00','2.50','0.00','7.00','0.00','1.00','0.50','Partitions 14\"','0.35','16.50',NULL,'LP29','12\" 12Gaps ','15.00','.75/4X3\"/2\"/5\"/2\"/4X3\"/.75'),
 (26,3,'2.50','180.00','2.50','0.00','25.00','0.00','1.00','0.75','Double Bottom','12.45','46.00',NULL,'LB30','12\" 12Gaps ','181.00','.75/3X3\"/2/8X1.5\"/8X1.5\"/2/3X3\"/.75'),
 (27,5,'3.00','180.00','3.00','0.00','17.00','0.00','2.25','0.25','Double Top','10.04','52.00',NULL,'LC30','18\" 8Gaps','81.00','.25/5/6/1/2/4X3\"/4X3\"/2/1/6/5/.25'),
 (28,3,'3.00','180.00','3.00','2.50','13.00','3.00','2.25','0.25','Single top','8.35','41.00',NULL,'LC05','18\" 8Gaps','81.00','.25/5/6/1/2/4X3\"/4X3\"/3X1\"/.25'),
 (29,4,'2.50','180.00','2.50','0.00','26.00','0.00','1.00','0.75','Single Bottom','13.14','49.00',NULL,'LB105','12\" 12Gaps ','181.00','.75/3X3\"/2/8X1.5\"/1/8X1.5\"/2/3X3\"/.75'),
 (30,3,'3.00','180.00','3.00','0.00','17.00','0.00','2.00','0.25','Double Top','10.75','52.00',NULL,'LC31','18\" 9Gaps','91.00','.25/5/6/1/2/4X3\"/4X3\"/2/1/6/5/.25'),
 (31,3,'3.00','180.00','3.00','2.50','13.00','3.00','2.00','0.25','Single Top','8.91','41.00',NULL,'LC06','18\" 9Gaps','91.00','.25/5/6/1/2/4X3\"/4X3\"/3X1\"/.25');
/*!40000 ALTER TABLE `sheet_specification` ENABLE KEYS */;


--
-- Definition of table `sms`
--

DROP TABLE IF EXISTS `sms`;
CREATE TABLE `sms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sms`
--

/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;


--
-- Definition of table `smsservice`
--

DROP TABLE IF EXISTS `smsservice`;
CREATE TABLE `smsservice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `smsservice`
--

/*!40000 ALTER TABLE `smsservice` DISABLE KEYS */;
/*!40000 ALTER TABLE `smsservice` ENABLE KEYS */;


--
-- Definition of table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `availability_status` bit(1) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_edited_by_id` bigint(20) DEFAULT NULL,
  `last_edited_date` datetime DEFAULT NULL,
  `machine_id` bigint(20) NOT NULL,
  `no_of_in_stock` decimal(19,2) NOT NULL,
  `no_of_manufactured` decimal(19,2) NOT NULL,
  `sheet_spec_id` bigint(20) NOT NULL,
  `stock_id` varchar(255) DEFAULT NULL,
  `stock_manufactured_time` datetime NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK68AF716FF80FD6C` (`last_edited_by_id`),
  KEY `FK68AF71639213646` (`wire_brand_id`),
  KEY `FK68AF716C892E80C` (`sheet_spec_id`),
  KEY `FK68AF716DA2CD5E2` (`created_by_id`),
  KEY `FK68AF716D1111F11` (`machine_id`),
  CONSTRAINT `FK68AF71639213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`),
  CONSTRAINT `FK68AF716C892E80C` FOREIGN KEY (`sheet_spec_id`) REFERENCES `sheet_specification` (`id`),
  CONSTRAINT `FK68AF716D1111F11` FOREIGN KEY (`machine_id`) REFERENCES `machine` (`id`),
  CONSTRAINT `FK68AF716DA2CD5E2` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK68AF716FF80FD6C` FOREIGN KEY (`last_edited_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock`
--

/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` (`id`,`version`,`availability_status`,`comments`,`created_by_id`,`created_date`,`last_edited_by_id`,`last_edited_date`,`machine_id`,`no_of_in_stock`,`no_of_manufactured`,`sheet_spec_id`,`stock_id`,`stock_manufactured_time`,`wire_brand_id`) VALUES 
 (9,0,0x01,NULL,1,'2012-05-31 17:07:23',NULL,NULL,1,'10.00','10.00',1,'ST310512050723','2012-05-31 00:00:00',1),
 (10,0,0x01,NULL,1,'2012-05-31 18:37:10',NULL,NULL,1,'10.00','10.00',1,'ST310512063710','2012-05-31 00:00:00',1),
 (11,0,0x01,NULL,1,'2012-05-31 18:39:24',NULL,NULL,1,'10.00','10.00',1,'ST310512063924','2012-05-31 00:00:00',1),
 (12,0,0x01,NULL,1,'2012-05-31 21:26:31',NULL,NULL,1,'20.00','20.00',1,'ST310512092631','2012-05-31 00:00:00',1),
 (13,0,0x01,NULL,1,'2012-05-31 22:55:48',NULL,NULL,1,'10.00','10.00',1,'ST310512105548','2012-05-31 00:00:00',1),
 (14,0,0x01,NULL,1,'2012-05-31 23:11:20',NULL,NULL,1,'10.00','10.00',1,'ST310512111120','2012-05-31 00:00:00',1),
 (15,0,0x01,NULL,1,'2012-06-01 08:52:51',NULL,NULL,1,'10.00','10.00',2,'ST010612085251','2012-06-01 00:00:00',1),
 (16,0,0x01,NULL,1,'2012-06-01 12:59:28',NULL,NULL,1,'10.00','10.00',1,'ST010612125928','2012-06-01 00:00:00',1),
 (17,0,0x01,NULL,1,'2012-06-03 18:13:53',NULL,NULL,1,'10.00','10.00',1,'ST030612061353','2012-06-03 00:00:00',1);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;


--
-- Definition of table `stock_order`
--

DROP TABLE IF EXISTS `stock_order`;
CREATE TABLE `stock_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `corder_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_edited_by_id` bigint(20) DEFAULT NULL,
  `last_edited_date` datetime DEFAULT NULL,
  `stock_id` bigint(20) NOT NULL,
  `stock_for_order` decimal(19,2) NOT NULL,
  `stock_order_block_time` datetime NOT NULL,
  `stock_order_items_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCE6CB8E5FF80FD6C` (`last_edited_by_id`),
  KEY `FKCE6CB8E51E07B2DD` (`corder_id`),
  KEY `FKCE6CB8E5161A665F` (`stock_id`),
  KEY `FKCE6CB8E5DA2CD5E2` (`created_by_id`),
  CONSTRAINT `FKCE6CB8E5161A665F` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`id`),
  CONSTRAINT `FKCE6CB8E51E07B2DD` FOREIGN KEY (`corder_id`) REFERENCES `corder` (`id`),
  CONSTRAINT `FKCE6CB8E5DA2CD5E2` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKCE6CB8E5FF80FD6C` FOREIGN KEY (`last_edited_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock_order`
--

/*!40000 ALTER TABLE `stock_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_order` ENABLE KEYS */;


--
-- Definition of table `taxation`
--

DROP TABLE IF EXISTS `taxation`;
CREATE TABLE `taxation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `percent` decimal(19,2) NOT NULL,
  `taxation` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `taxation`
--

/*!40000 ALTER TABLE `taxation` DISABLE KEYS */;
INSERT INTO `taxation` (`id`,`version`,`description`,`percent`,`taxation`) VALUES 
 (1,0,NULL,'5.00','AP VAT'),
 (2,0,NULL,'9.00','CST'),
 (3,0,NULL,'5.00','CST against FORM \'C\''),
 (4,0,NULL,'0.00','Export');
/*!40000 ALTER TABLE `taxation` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `account_expired` bit(1) NOT NULL,
  `account_locked` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_expired` bit(1) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`,`version`,`account_expired`,`account_locked`,`enabled`,`password`,`password_expired`,`username`) VALUES 
 (1,0,0x00,0x00,0x01,'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',0x00,'admin'),
 (2,2,0x00,0x00,0x01,'e04eb29020eaa961e99d3162635e9fe9585c5a1121bd88784c1378aa8837195c',0x00,'sales'),
 (3,2,0x00,0x00,0x01,'9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',0x00,'test'),
 (4,0,0x00,0x00,0x01,'94aac673a10a006e89402f21b37711832b0be3aa6b6b82fc21a7919ba5c70576',0x00,'prodmanager'),
 (5,2,0x00,0x00,0x01,'188d79be2c98f9df67c9a6386a445c844a2ca70fe6da3710350fd84a04cd975e',0x00,'sales1'),
 (6,0,0x00,0x00,0x00,'540971d68e16cd531dbfc68b5ee8871b0042b4f03ec181d93765f78db50666a3',0x00,'sales2');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


--
-- Definition of table `user_cage_part_type`
--

DROP TABLE IF EXISTS `user_cage_part_type`;
CREATE TABLE `user_cage_part_type` (
  `user_cage_part_type_list_id` bigint(20) DEFAULT NULL,
  `cage_part_type_id` bigint(20) DEFAULT NULL,
  KEY `FKB558F037282034E9` (`cage_part_type_id`),
  KEY `FKB558F037DD5A544A` (`user_cage_part_type_list_id`),
  CONSTRAINT `FKB558F037282034E9` FOREIGN KEY (`cage_part_type_id`) REFERENCES `cage_part_type` (`id`),
  CONSTRAINT `FKB558F037DD5A544A` FOREIGN KEY (`user_cage_part_type_list_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_cage_part_type`
--

/*!40000 ALTER TABLE `user_cage_part_type` DISABLE KEYS */;
INSERT INTO `user_cage_part_type` (`user_cage_part_type_list_id`,`cage_part_type_id`) VALUES 
 (2,5);
/*!40000 ALTER TABLE `user_cage_part_type` ENABLE KEYS */;


--
-- Definition of table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `FK143BF46AB7E57A25` (`role_id`),
  KEY `FK143BF46A5D103E05` (`user_id`),
  CONSTRAINT `FK143BF46A5D103E05` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK143BF46AB7E57A25` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role`
--

/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`role_id`,`user_id`) VALUES 
 (3,1),
 (3,3),
 (4,2),
 (4,3),
 (4,5),
 (4,6),
 (5,4);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;


--
-- Definition of table `wire_brand`
--

DROP TABLE IF EXISTS `wire_brand`;
CREATE TABLE `wire_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `wire_brand` varchar(255) NOT NULL,
  `wire_price` decimal(19,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wire_brand`
--

/*!40000 ALTER TABLE `wire_brand` DISABLE KEYS */;
INSERT INTO `wire_brand` (`id`,`version`,`wire_brand`,`wire_price`,`description`) VALUES 
 (1,0,'TATA','0.00',''),
 (2,0,'CWI','0.00',''),
 (3,0,'Millenium','0.00','');
/*!40000 ALTER TABLE `wire_brand` ENABLE KEYS */;


--
-- Definition of table `wire_price`
--

DROP TABLE IF EXISTS `wire_price`;
CREATE TABLE `wire_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `conversion` decimal(19,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `end_date` datetime NOT NULL,
  `freight_handling_per_metric_ton` decimal(19,2) NOT NULL,
  `price` decimal(19,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `wastage` decimal(19,2) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  `wire_price` decimal(19,2) NOT NULL,
  `wire_price_trending` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK27CC8D0F39213646` (`wire_brand_id`),
  CONSTRAINT `FK27CC8D0F39213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wire_price`
--

/*!40000 ALTER TABLE `wire_price` DISABLE KEYS */;
INSERT INTO `wire_price` (`id`,`version`,`conversion`,`description`,`end_date`,`freight_handling_per_metric_ton`,`price`,`start_date`,`wastage`,`wire_brand_id`,`wire_price`,`wire_price_trending`) VALUES 
 (1,2,'12.00',NULL,'2012-06-15 00:00:00','1.00','78.92','2012-06-02 00:00:00','0.65',1,'64.50','1.00'),
 (2,0,'12.00',NULL,'2012-06-15 00:00:00','1.00','82.84','2012-06-02 00:00:00','0.68',2,'68.37','1.00'),
 (3,2,'12.00',NULL,'2012-06-15 00:00:00','1.00','87.00','2012-06-02 00:00:00','0.72',3,'72.47','1.00');
/*!40000 ALTER TABLE `wire_price` ENABLE KEYS */;


--
-- Definition of table `wire_receipt_reporting`
--

DROP TABLE IF EXISTS `wire_receipt_reporting`;
CREATE TABLE `wire_receipt_reporting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `availability_status` bit(1) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `edited_date` datetime DEFAULT NULL,
  `last_edited_by` varchar(255) DEFAULT NULL,
  `purchase_date` datetime NOT NULL,
  `weight_in_stock` decimal(19,2) NOT NULL,
  `weight_purchased` decimal(19,2) NOT NULL,
  `wire_brand_id` bigint(20) NOT NULL,
  `wire_diameter` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF1282FAD39213646` (`wire_brand_id`),
  CONSTRAINT `FKF1282FAD39213646` FOREIGN KEY (`wire_brand_id`) REFERENCES `wire_brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wire_receipt_reporting`
--

/*!40000 ALTER TABLE `wire_receipt_reporting` DISABLE KEYS */;
INSERT INTO `wire_receipt_reporting` (`id`,`version`,`availability_status`,`comments`,`created_by`,`created_date`,`edited_date`,`last_edited_by`,`purchase_date`,`weight_in_stock`,`weight_purchased`,`wire_brand_id`,`wire_diameter`) VALUES 
 (4,35,0x01,'Created By admin-31/05/12-05:06\n','admin','2012-05-31 17:06:32','2012-06-03 18:13:53','admin','2012-05-31 00:00:00','9103.07','5000.00',1,'2.50'),
 (5,3,0x01,'Created By admin-31/05/12-05:06\n','admin','2012-05-31 17:06:52','2012-06-01 08:54:24','admin','2012-05-31 00:00:00','4812.57','5000.00',1,'3.00'),
 (6,0,0x01,'Created By admin-31/05/12-05:07\n','admin','2012-05-31 17:07:08',NULL,NULL,'2012-05-31 00:00:00','5000.00','5000.00',1,'3.50');
/*!40000 ALTER TABLE `wire_receipt_reporting` ENABLE KEYS */;


--
-- Definition of view `join1`
--

DROP TABLE IF EXISTS `join1`;
DROP VIEW IF EXISTS `join1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `join1` AS select `r`.`authority` AS `authority`,`u`.`user_id` AS `user_id` from (`role` `r` join `user_role` `u` on((`u`.`role_id` = `r`.`id`)));



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
