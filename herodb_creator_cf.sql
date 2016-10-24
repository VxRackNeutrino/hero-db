/******************************
** File: TitanDB_Creator.sql
** Name: Titan's game Database
** Desc: Creates the Titan's game database
** Auth: Patrick Butler Monterde
** Date: 09/19/2016
**************************
** Change History
**************************
** PR   Date	     Author    Description
** --   --------   -------   ------------------------------------
** 1    09/19/2016 PBM       Created
** 2    10/04/2016 PBM		 Updated Create statement and required fields
** 3    10/19/2016 PBM		 Create tables for Bots and Neutrino
*******************************/

# Creating the TitanDB
# CREATE DATABASE IF NOT EXISTS titandb;

# Create User and assign Permisions
# CREATE USER IF NOT EXISTS 'titanuser'@localhost IDENTIFIED BY 'Neutrin0R0cks!';
# GRANT ALL ON titandb.* TO 'titanuser' IDENTIFIED BY 'Neutrin0R0cks!';

# Tables   ------------------------------------------------------------------------
CREATE TABLE `hero` (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hero_name` varchar(255) DEFAULT NULL,
  `player_name` varchar(255) DEFAULT NULL,
  `player_lastname` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `race` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) DEFAULT NULL,
  `hero_level` int(11) DEFAULT NULL,
  `hclass` varchar(255) DEFAULT NULL,
  `ttl` int(11) DEFAULT NULL,
  `userhost` varchar(255) DEFAULT NULL,
  `hero_online` tinyint(1) DEFAULT NULL,
  `xpos` int(11) DEFAULT NULL,
  `ypos` int(11) DEFAULT NULL,
  `next_level` datetime DEFAULT NULL,
  `weapon` int(11) DEFAULT NULL,
  `tunic` int(11) DEFAULT NULL,
  `shield` int(11) DEFAULT NULL,
  `leggings` int(11) DEFAULT NULL,
  `ring` int(11) DEFAULT NULL,
  `gloves` int(11) DEFAULT NULL,
  `boots` int(11) DEFAULT NULL,
  `helm` int(11) DEFAULT NULL,
  `charm` int(11) DEFAULT NULL,
  `amulet` int(11) DEFAULT NULL,
  `total_equipment` int(11) DEFAULT NULL,
  `hero_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contains the Hero information';

CREATE TABLE `worldeventtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_text` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table contains the types of world events. It is used for tracking the events';

# Creates types of world events.
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Combat");
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Level");
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Goodsend");
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Calamity");
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Quest");
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Creep");
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Moster");
INSERT INTO `worldeventtype` (`type_text`) VALUES ("Item");


CREATE TABLE `worldevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` VARCHAR(255),
  `event_text` TEXT,
  `event_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='WorldEvent table contains the events happening in the world ';

CREATE TABLE `heroworldevent` (

  `id` 	int(11) NOT NULL AUTO_INCREMENT,
  `hero_id` 			int(11) DEFAULT NULL,
  `worldevent_id` 		int(11) DEFAULT NULL,

  PRIMARY KEY (`id`),
  KEY `heroworldevent_hero_hero_id_fk` (`hero_id`),
  KEY `heroworldevent_worldevent_worldevent_id_fk` (`id`),

  CONSTRAINT `heroworldevent_hero_hero_id_fk` FOREIGN KEY (`id`) REFERENCES `hero` (`id`),
  CONSTRAINT `heroworldevent_worldevent_worldevent_id_fk` FOREIGN KEY (`id`) REFERENCES `worldevent` (`id`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='HeroWorldEvent is a Junction table that maps heros to world events ';


CREATE TABLE `heroneutrinoaccounts` (
  `id` 	int(11) NOT NULL AUTO_INCREMENT,
  `heroaccount` varchar(8) NOT NULL,
  `herousername` varchar(8) NOT NULL,
  `heropassword` varchar(8) NOT NULL,
  `used` int(1) NOT NULL,

  PRIMARY KEY (`id`)

 ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table contains the neutrino hero auto generated accounts';
