-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 03, 2020 at 07:18 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `serverdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(25) COLLATE cp1251_general_cs NOT NULL,
  `password` varchar(250) COLLATE cp1251_general_cs NOT NULL,
  `gpci` varchar(40) COLLATE cp1251_general_cs NOT NULL DEFAULT '0.0.0.0',
  `regip` varchar(16) COLLATE cp1251_general_cs NOT NULL DEFAULT '0.0.0.0',
  `regdate` date NOT NULL,
  `regtime` time NOT NULL DEFAULT '00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_cs;

-- --------------------------------------------------------

--
-- Table structure for table `account_login_logs`
--

CREATE TABLE `account_login_logs` (
  `name` varchar(24) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `actors`
--

CREATE TABLE `actors` (
  `id` int(11) NOT NULL,
  `modelid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT 'Konstantine',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `posAngle` float NOT NULL DEFAULT '0',
  `health` float UNSIGNED NOT NULL DEFAULT '0',
  `invulnerability` int(11) NOT NULL DEFAULT '0',
  `virtualworld` int(11) NOT NULL DEFAULT '0',
  `interiorid` int(11) NOT NULL DEFAULT '0',
  `animLib` varchar(50) NOT NULL DEFAULT 'NONE',
  `animName` varchar(50) NOT NULL DEFAULT 'NONE',
  `animDelta` float NOT NULL DEFAULT '0',
  `animLoop` int(11) NOT NULL DEFAULT '0',
  `animLockX` int(11) NOT NULL DEFAULT '0',
  `animLockY` int(11) NOT NULL DEFAULT '0',
  `animFreeze` int(11) NOT NULL DEFAULT '0',
  `animTime` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE `administrators` (
  `adminName` varchar(25) COLLATE cp1251_general_cs NOT NULL,
  `adminPassword` varchar(32) COLLATE cp1251_general_cs NOT NULL,
  `adminIP` varchar(16) COLLATE cp1251_general_cs NOT NULL,
  `adminLevel` int(11) NOT NULL,
  `issueDate` datetime NOT NULL,
  `issuedBy` varchar(25) COLLATE cp1251_general_cs NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_cs;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_bankcash_log`
--

CREATE TABLE `administrator_bankcash_log` (
  `issuerName` varchar(24) NOT NULL,
  `playerName` varchar(24) NOT NULL,
  `date` datetime NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_ban_logs`
--

CREATE TABLE `administrator_ban_logs` (
  `adminName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `reason` varchar(24) NOT NULL,
  `date` datetime NOT NULL,
  `unBanDate` datetime NOT NULL,
  `wasSilent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_cash_log`
--

CREATE TABLE `administrator_cash_log` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_ipban_logs`
--

CREATE TABLE `administrator_ipban_logs` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `bannedIP` varchar(16) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `unbanDate` datetime DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_jail_logs`
--

CREATE TABLE `administrator_jail_logs` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL,
  `jailTime` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_kick_logs`
--

CREATE TABLE `administrator_kick_logs` (
  `adminName` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `playerName` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `reason` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL,
  `wasSilent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_logins`
--

CREATE TABLE `administrator_logins` (
  `adminName` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `ip` varchar(16) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `status` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_mutelogs`
--

CREATE TABLE `administrator_mutelogs` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL,
  `reason` varchar(24) NOT NULL,
  `muteTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_recruitment`
--

CREATE TABLE `administrator_recruitment` (
  `name` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `level` int(11) NOT NULL,
  `recruitedBy` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_suspension`
--

CREATE TABLE `administrator_suspension` (
  `adminName` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `suspendedBy` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_unbanip_logs`
--

CREATE TABLE `administrator_unbanip_logs` (
  `playerIP` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `issuedBy` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_unban_logs`
--

CREATE TABLE `administrator_unban_logs` (
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL,
  `issuedBy` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `reason` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_unjail_logs`
--

CREATE TABLE `administrator_unjail_logs` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_unmute_logs`
--

CREATE TABLE `administrator_unmute_logs` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL,
  `reason` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_unwarn_logs`
--

CREATE TABLE `administrator_unwarn_logs` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL,
  `reason` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_warn_logs`
--

CREATE TABLE `administrator_warn_logs` (
  `issuerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `date` datetime NOT NULL,
  `reason` varchar(24) NOT NULL,
  `wasSilent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `house_data`
--

CREATE TABLE `house_data` (
  `houseID` int(11) NOT NULL,
  `houseOwner` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `housePrice` int(11) NOT NULL,
  `houseInterior` int(11) NOT NULL,
  `houseType` int(11) NOT NULL,
  `houseTypeLimit` int(11) NOT NULL,
  `houseMaintenanceFee` int(11) NOT NULL,
  `houseEntrancePickupID` int(11) NOT NULL,
  `houseEntrancePosX` float NOT NULL,
  `houseEntrancePosY` float NOT NULL,
  `houseEntrancePosZ` float NOT NULL,
  `houseEntranceVirtualWorld` int(11) NOT NULL,
  `houseEntranceInteriorID` int(11) NOT NULL,
  `houseExitPosX` float NOT NULL,
  `houseExitPosY` float NOT NULL,
  `houseExitPosZ` float NOT NULL,
  `houseExitVirtualWorld` int(11) NOT NULL,
  `houseExitInteriorID` int(11) NOT NULL,
  `houseSpawnPosX` float NOT NULL,
  `houseSpawnPosY` float NOT NULL,
  `houseSpawnPosZ` float NOT NULL,
  `houseSpawnPosAngle` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `job_skills`
--

CREATE TABLE `job_skills` (
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL DEFAULT 'None',
  `LSConstruction` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labels`
--

CREATE TABLE `labels` (
  `id` int(11) NOT NULL,
  `text` varchar(128) NOT NULL DEFAULT 'None',
  `textColour` varchar(50) NOT NULL DEFAULT '0xFFFFFFFF',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `drawDistance` float NOT NULL DEFAULT '0',
  `testLOS` int(11) NOT NULL DEFAULT '0',
  `virtualworld` int(11) NOT NULL DEFAULT '0',
  `interiorid` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mapicons`
--

CREATE TABLE `mapicons` (
  `id` int(11) NOT NULL,
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `colour` varchar(10) NOT NULL DEFAULT '0xFFFFFFFF',
  `virtualworld` int(11) NOT NULL DEFAULT '0',
  `interiorid` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pickups`
--

CREATE TABLE `pickups` (
  `id` int(11) NOT NULL,
  `entranceModel` int(11) NOT NULL DEFAULT '0',
  `entranceType` int(11) NOT NULL DEFAULT '0',
  `entranceX` float NOT NULL DEFAULT '0',
  `entranceY` float NOT NULL DEFAULT '0',
  `entranceZ` float NOT NULL DEFAULT '0',
  `entranceVirtualworld` int(11) NOT NULL DEFAULT '0',
  `entranceInteriorid` int(11) NOT NULL DEFAULT '0',
  `entranceLabel` varchar(128) NOT NULL DEFAULT 'none',
  `exitModel` int(11) NOT NULL DEFAULT '0',
  `exitType` tinyint(4) NOT NULL DEFAULT '0',
  `exitX` float NOT NULL DEFAULT '0',
  `exitY` float NOT NULL DEFAULT '0',
  `exitZ` float NOT NULL DEFAULT '0',
  `exitVirtualworld` int(11) NOT NULL DEFAULT '0',
  `exitInteriorid` int(11) NOT NULL DEFAULT '0',
  `exitLabel` varchar(128) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `player_data`
--

CREATE TABLE `player_data` (
  `name` varchar(25) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL DEFAULT 'NONE',
  `gender` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `skin` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `level_exp` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `level_expPoint` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `donatorRank` int(11) NOT NULL DEFAULT '0',
  `cash` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `bankCash` int(11) DEFAULT '0',
  `paycheck` int(11) DEFAULT '0',
  `passengerLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `motorcycleLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `publicServiceLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `commercialLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `waterLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pilotLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `gunLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `businessLicense` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `paydayTime` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pistolSkill` int(11) NOT NULL DEFAULT '0',
  `silencedPistolSkill` int(11) NOT NULL DEFAULT '0',
  `desertEagleSkill` int(11) NOT NULL DEFAULT '0',
  `shotgunSkill` int(11) NOT NULL DEFAULT '0',
  `sawnOffSkill` int(11) NOT NULL DEFAULT '0',
  `Spaz12Skill` int(11) DEFAULT '0',
  `microUziSkill` int(11) NOT NULL DEFAULT '0',
  `mp5Skill` int(11) NOT NULL DEFAULT '0',
  `ak47Skill` int(11) NOT NULL DEFAULT '0',
  `m4Skill` int(11) NOT NULL DEFAULT '0',
  `sniperRifleSkill` int(11) NOT NULL DEFAULT '0',
  `spawn_pos_x` float NOT NULL DEFAULT '0',
  `spawn_pos_y` float NOT NULL DEFAULT '0',
  `spawn_pos_z` float NOT NULL DEFAULT '0',
  `spawn_pos_angle` float NOT NULL DEFAULT '0',
  `spawn_virtualworld` int(11) NOT NULL DEFAULT '0',
  `spawn_interiorid` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `player_restrictions`
--

CREATE TABLE `player_restrictions` (
  `playerName` varchar(24) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL,
  `muteTime` int(11) NOT NULL DEFAULT '0',
  `jailTime` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `server_weapon_multiplier_data`
--

CREATE TABLE `server_weapon_multiplier_data` (
  `9mm_ammo` int(11) NOT NULL DEFAULT '35',
  `9mm_skill` int(11) NOT NULL DEFAULT '1',
  `silenced_pistol_ammo` int(11) NOT NULL DEFAULT '20',
  `silenced_pistol_skill` int(11) NOT NULL DEFAULT '1',
  `desert_eagle_ammo` int(11) NOT NULL DEFAULT '16',
  `desert_eagle_skill` int(11) NOT NULL DEFAULT '1',
  `shotgun_ammo` int(11) NOT NULL DEFAULT '13',
  `shotgun_skill` int(11) NOT NULL DEFAULT '1',
  `sawn_off_ammo` int(11) NOT NULL DEFAULT '23',
  `sawn_off_skill` int(11) NOT NULL DEFAULT '1',
  `micro_uzi_skill` int(11) NOT NULL DEFAULT '60',
  `micro_uzi_ammo` int(11) NOT NULL DEFAULT '1',
  `mp5_ammo` int(11) NOT NULL DEFAULT '24',
  `mp5_skill` int(11) NOT NULL DEFAULT '1',
  `ak47_ammo` int(11) NOT NULL DEFAULT '30',
  `ak47_skill` int(11) NOT NULL DEFAULT '1',
  `m4_ammo` int(11) NOT NULL DEFAULT '30',
  `m4_skill` int(11) NOT NULL DEFAULT '1',
  `sniper_rifle_ammo` int(11) NOT NULL DEFAULT '16',
  `sniper_rifle_skill` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `actors`
--
ALTER TABLE `actors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `administrators`
--
ALTER TABLE `administrators`
  ADD PRIMARY KEY (`adminName`,`adminIP`);

--
-- Indexes for table `administrator_ban_logs`
--
ALTER TABLE `administrator_ban_logs`
  ADD PRIMARY KEY (`playerName`);

--
-- Indexes for table `job_skills`
--
ALTER TABLE `job_skills`
  ADD UNIQUE KEY `playerName` (`playerName`);

--
-- Indexes for table `labels`
--
ALTER TABLE `labels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mapicons`
--
ALTER TABLE `mapicons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pickups`
--
ALTER TABLE `pickups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_data`
--
ALTER TABLE `player_data`
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `player_restrictions`
--
ALTER TABLE `player_restrictions`
  ADD UNIQUE KEY `playerName` (`playerName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `actors`
--
ALTER TABLE `actors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `labels`
--
ALTER TABLE `labels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mapicons`
--
ALTER TABLE `mapicons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pickups`
--
ALTER TABLE `pickups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
