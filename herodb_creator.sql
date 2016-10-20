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
CREATE DATABASE IF NOT EXISTS titandb;

# Create User and assign Permisions
CREATE USER IF NOT EXISTS 'titanuser'@localhost IDENTIFIED BY 'Neutrin0R0cks!';
GRANT ALL ON titandb.* TO 'titanuser' IDENTIFIED BY 'Neutrin0R0cks!';

USE titandb;

# Drop Tables
DROP TABLE IF EXISTS heroworldevent;
DROP TABLE IF EXISTS hero;
DROP TABLE IF EXISTS bothero;
DROP TABLE IF EXISTS worldeventtype;
DROP TABLE IF EXISTS worldevent;
DROP TABLE IF EXISTS heroneutrinoaccounts;

#Drop Functions
DROP FUNCTION IF EXISTS randomizer;

# Tables   ------------------------------------------------------------------------
CREATE TABLE `hero` (

  `hero_id` int(11) NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`hero_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
  
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contains the Hero information';

CREATE TABLE `worldeventtype` (
  `idworldeventtype_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_text` varchar(45) NOT NULL,
  PRIMARY KEY (`idworldeventtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table contains the types of world events. It is used for tracking the events';

# Creates types of world events.
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Combat");
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Level");
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Goodsend");
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Calamity");
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Quest");
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Creep");
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Moster");
INSERT INTO `titandb`.`worldeventtype` (`type_text`) VALUES ("Item");


CREATE TABLE `worldevent` (
  `worldevent_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` VARCHAR(255),
  `event_text` text,
  `event_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`worldevent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='WorldEvent table contains the events happening in the world ';

CREATE TABLE `heroworldevent` (

  `heroworldevent_id` 	int(11) NOT NULL AUTO_INCREMENT,
  `hero_id` 			int(11) DEFAULT NULL,
  `worldevent_id` 		int(11) DEFAULT NULL,

  PRIMARY KEY (`heroworldevent_id`),
  KEY `heroworldevent_hero_hero_id_fk` (`hero_id`),
  KEY `heroworldevent_worldevent_worldevent_id_fk` (`worldevent_id`),

  CONSTRAINT `heroworldevent_hero_hero_id_fk` FOREIGN KEY (`hero_id`) REFERENCES `hero` (`hero_id`),
  CONSTRAINT `heroworldevent_worldevent_worldevent_id_fk` FOREIGN KEY (`worldevent_id`) REFERENCES `worldevent` (`worldevent_id`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='HeroWorldEvent is a Junction table that maps heros to world events ';

CREATE TABLE `bothero` (

  `hero_id` int(11) NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`hero_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
  
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contains the Bots Hero information';

CREATE TABLE `heroneutrinoaccounts` (
  `heroaccount` varchar(8) NOT NULL,
  `herousername` varchar(8) NOT NULL,
  `heropassword` varchar(8) NOT NULL,
  `used` int(1) NOT NULL
  
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table contains the neutrino hero auto generated accounts';


# Functions  ------------------------------------------------------------------------

DROP FUNCTION IF EXISTS randomizer;

DELIMITER $$
CREATE DEFINER=`titanuser`@`%` FUNCTION `randomizer`(
    pmin INTEGER,
    pmax INTEGER
) RETURNS int(11)
    NO SQL
    DETERMINISTIC
RETURN floor(pmin+RAND()*(pmax-pmin))$$
DELIMITER ;

DROP function if exists generate_fname;

DELIMITER $$
CREATE FUNCTION generate_fname () RETURNS varchar(255)
BEGIN
  RETURN ELT(FLOOR(1 + (RAND() * (100-1))), "James","Mary","John","Patricia","Robert","Linda","Michael","Barbara","William","Elizabeth","David","Jennifer","Richard","Maria","Charles","Susan","Joseph","Margaret","Thomas","Dorothy","Christopher","Lisa","Daniel","Nancy","Paul","Karen","Mark","Betty","Donald","Helen","George","Sandra","Kenneth","Donna","Steven","Carol","Edward","Ruth","Brian","Sharon","Ronald","Michelle","Anthony","Laura","Kevin","Sarah","Jason","Kimberly","Matthew","Deborah","Gary","Jessica","Timothy","Shirley","Jose","Cynthia","Larry","Angela","Jeffrey","Melissa","Frank","Brenda","Scott","Amy","Eric","Anna","Stephen","Rebecca","Andrew","Virginia","Raymond","Kathleen","Gregory","Pamela","Joshua","Martha","Jerry","Debra","Dennis","Amanda","Walter","Stephanie","Patrick","Carolyn","Peter","Christine","Harold","Marie","Douglas","Janet","Henry","Catherine","Carl","Frances","Arthur","Ann","Ryan","Joyce","Roger","Diane");
END$$

DELIMITER ;

DROP function if exists generate_lname;
DELIMITER $$
CREATE FUNCTION generate_lname () RETURNS varchar(255)
BEGIN
  RETURN ELT(FLOOR(1 + (RAND() * (100-1))), "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes");
END$$
DELIMITER ;

DROP function if exists generate_race;
DELIMITER $$
CREATE FUNCTION generate_race () RETURNS varchar(255)
BEGIN
  RETURN ELT(FLOOR(1 + (RAND() * (27-1))), "Elf","Dwarf","Goblin","Morlock","Half-Gnome","Hobbit","Gnome","Orc","Shade","White Walker","Hobbgoblin","Barbarian","Half-elf","Hafling","Half-Orc","Half-Giant","Giant","Drow","Half-Drow","Minotaur","Human","Dragonborn","Eladrin","Ogre","Half-Ogre","Vampire","Troll");
END$$
DELIMITER ;

DROP function if exists generate_class;
DELIMITER $$
CREATE FUNCTION generate_class () RETURNS varchar(255)
BEGIN
  RETURN ELT(FLOOR(1 + (RAND() * (19-1))), "Barbarian","Bard","Cleric","Druid","Figter","Mage","Wizard","Monk","Mistic","Paladin","Ranger","Sorcerer","Thief","Ninja","Warlock","Defiler","Shaman","Invoker","Psion");
END$$
DELIMITER ;


# Random Fantasy Title Generator by Jellyn
# view-source:http://core.binghamton.edu/~jandrews/random/randomtitles.html

DROP function if exists generate_title;
DELIMITER $$
CREATE FUNCTION generate_title () RETURNS varchar(255)
BEGIN
  SET @noum =  ELT(FLOOR(1 + (RAND() * (337-1))), "Dream", "Dreamer", "Dreams","Rainbow",
                          "Dreaming","Flight","Wings","Mist",
                          "Sky","Wind","Winter","Misty",
                          "Cloud","Fairy","Dragon","End",
                          "Beginning","Tale","Tales","Emperor",
                          "Prince","Princess","Willow","Birch","Petals",
                          "Destiny","Theft","Thief","Legend","Prophecy",
                          "Spark","Sparks","Stream","Streams","Waves",
                          "Sword","Darkness","Swords","Silence","Kiss",
                          "Butterfly","Shadow","Ring","Rings","Emerald",
                          "Storm","Storms","Mists","World","Worlds",
                          "Alien","Lord","Lords","Ship","Ships","Star",
                          "Stars","Force","Visions","Vision","Magic",
                          "Wizards","Wizard","Heart","Heat","Twins",
                          "Twilight","Moon","Moons","Planet","Shores",
                          "Pirates","Courage","Time","Academy",
                          "School","Rose","Roses","Stone","Stones",
                          "Sorcerer","Shard","Shards","Slave","Slaves",
                          "Servant","Servants","Serpent","Serpents",
                          "Snake","Soul","Souls","Savior","Spirit",
                          "Spirits","Voyage","Voyages","Voyager","Voyagers",
                          "Return","Legacy","Birth","Healer","Healing",
                          "Year","Years","Death","Dying","Luck","Elves",
                          "Tears","Touch","Son","Sons","Child","Children",
                          "Illusion","Sliver","Destruction","Crying","Weeping",
                          "Gift","Word","Words","Thought","Thoughts","Scent",
                          "Ice","Snow","Night","Silk","Guardian","Angel",
                          "Angels","Secret","Secrets","Search","Eye","Eyes",
                          "Danger","Game","Fire","Flame","Flames","Bride",
                          "Husband","Wife","Time","Flower","Flowers",
                          "Light","Lights","Door","Doors","Window","Windows",
                          "Bridge","Bridges","Ashes","Memory","Thorn",
                          "Thorns","Name","Names","Future","Past",
                          "History","Nothingness","Someone",
                          "Person","Man","Woman","Boy","Girl",
                          "Way","Mage","Witch","Witches","Curse",
                          "Talisman","Mirror","Mirrors","Jewel","Jewels",
                          "Firefly","Fireflies","Cross","Fantasy","Card",
                          "Cards","God","Gods","Goddess","Evil",
                          "Warrior","Warriors","Virgin","War","Battle",
                          "Journey","Brother","Brothers","Sister","Sisters",
                          "Grave","Voice","Voices","Fox","Lion","Wolf",
                          "Wolves","Bunny","Bird","Birds","Hero","Crown",
                          "Sand","Sun","Sunlight","Sands","Hope","Lust",
                          "Passion","Love","Hate","Wrath","Anger","Revenge",
                          "Need","Crossing","Passage","Rite","Rites","Crystal",
                          "Crystals","Cave","Caves","Cavern","Caverns","Island",
                          "Land","Lands","Ocean","Sea","Oceans","Seas","Desert",
                          "Deserts","Forest","Forests","Woods","Jungle","Jungles",
                          "Exile","Empire","Kingdom","City","Village","Garden","Fall",
                          "Spring","Eve","Dawn","Oath","Gold","Cities","Ally","Hand",
                          "Sign","Omen","Court","Courts","Unicorn","Pegasus","Griffon",
                          "Farewell","Tower","Towers","Heaven","Hell","Heavens",
                          "Hunt","Rebirth","Path","Dagger","Daggers","Knife","Knives",
                          "Tooth","Teeth","Bite","Promise","Price","Queen","King",
                          "Queens","Kings","Arrow","Arrows","Song","Singer","Dance",
                          "Dancer","Dances","Dancers","Torture","Lament","Pain",
                          "Assassin","Spy","Spies","Agony","Mistress","Tree",
                          "Trees","Master","Honor","Loyalty","Trust","Apprentice",
                          "Prison","Prisoner","Phoenix","Breath","Horn","Claw","Talon",
                          "Tail","Speaker","Eclipse","Scream","Screams","Revolution",
                          "Thrusting","Wraith","Phantom","Sheep");

    SET @adjective = ELT(FLOOR(1 + (RAND() * (122-1))), "Misty","Lost","Only","Last","First",
                            "Final","Missing","Shadowy","Seventh",
                            "Dark","Darkest","Silver","Silvery",
                            "Black","White","Hidden","Entwined","Invisible",
                            "Next","Seventh","Red","Green","Blue",
                            "Purple","Grey","Bloody","Emerald","Diamond",
                            "Frozen","Sharp","Delicious","Dangerous",
                            "Deep","Twinkling","Dwindling","Missing","Absent",
                            "Vacant","Cold","Hot","Burning","Forgotten",
                            "No","All","Which","What","Hard","Soft",
                            "Playful","Final","Evil","Scarlet","Chaste","Virgin",
                            "Strange","Silent", "Legendary","Golden","Magic",
                            "Mystic","Majestic","Magical","Mysterious","Eternal",
                            "Winged","Outer","Inner","Silken","Mystical",
                            "Crying","Weeping","Lonely","Crushed","Searching",
                            "Desperate","Yearning","Quick","Invincible","New",
                            "Old","Ancient","Aging","Dying","Living","Vengeful",
                            "Loving","Crystal","Crystalline","Wooden","Metal",
                            "Metallic","Marble","Stony","Rocky","Great","Royal",
                            "Noble","Wet","Dry","Bleeding","Piercing","Singing",
                            "Dancing","Painful","Wandering","Loyal","Trusting",
                            "Open","Closed","Locked","Free","Chained","Caged",
                            "Empty","Wilted","Lunar","Solar","Screaming","Dead",
                            "Shaking","Thrusting","Frantic");
  RETURN CONCAT('The ', @adjective, ' of ', @noum);

END$$
DELIMITER ;


# Stored Procedures     ------------------------------------------------------------------------


DROP PROCEDURE IF EXISTS hero_insert;

DELIMITER $$
CREATE DEFINER=`titanuser`@`%` PROCEDURE `hero_Insert`()
BEGIN

  #Set Hero Variables

  SET @hero_name = (SELECT CONCAT(generate_fname(),' ', generate_lname()) as hero_name);
  SET @player_name = (generate_fname());
  SET @player_lastname = (generate_lname());
  SET @email = (CONCAT(@player_name, '.', @player_lastname, randomizer(1,1000000),'@dell.com'));
  SET @twitter = (CONCAT('@', @player_name, '.', @player_lastname));
  SET @token = (SELECT UUID());
  SET @userpass = (SELECT UUID());
  SET @hero_level = (randomizer(1,5));
  SET @next_level_calc = (SELECT ROUND(600*(POW(1.16, @hero_level+1))) AS Level_Time);
  SET @next_level_calc2 = (SEC_TO_TIME((SELECT ROUND(600*(POW(1.16, @hero_level))) AS Level_Time)));
  SET @next_level  = (SELECT ADDTIME(NOW(), @next_level_calc2));

#SELECT @hero_level, @next_level_calc, @next_level_calc2, (Now()), @next_level;


INSERT INTO `titandb`.`hero`
(
  `hero_name`,
  `player_name`,
  `player_lastname`,
  `token`,
  `twitter`,
  `email`,
  `title`,
  `race`,
  `isAdmin`,
  `hero_level`,
  `hclass`,
  `ttl`,
  `userhost`,
  `hero_online`,
  `xpos`,
  `ypos`,
  `next_level`,
	weapon,
    tunic,
    shield,
    leggings,
    ring,
    gloves,
    boots,
    helm,
    charm,
    amulet,
    total_equipment
)

VALUES

(
  @hero_name,
  @player_name,
  @player_lastname,
  @token,
  @twitter,
  @email,
  generate_title(),
  generate_race(),
  0,
  @hero_level,
  generate_class(),
  @next_level_calc,
  0,
  1,
  randomizer(1,2),
  randomizer(1,2),
  @next_level,
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  0
  
);

SET @heroid = NULL;
SET @total_items = NULL;

# Getting HeroID to build up the Item and Penalty tables

SET @heroid = (SELECT hero_id FROM hero WHERE token = @token);


# Calculate Total Items for Gandalf
SET @total_items = (SELECT  weapon + tunic + shield + leggings + ring + gloves + boots + helm + charm + Amulet FROM hero WHERE hero_id = @heroid);

UPDATE hero SET total_equipment = @total_items WHERE hero_id = @heroid;



END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS create_heros;

DELIMITER $$
CREATE DEFINER=`titanuser`@`%` PROCEDURE `create_heros`(IN heronum INT)
BEGIN

    DECLARE count INT;
  SET count=0;

  BEGIN

    WHILE count < heronum DO

      call hero_insert();

      SET count=(count + 1);

    END WHILE;

END;


END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS bot_hero_insert;

DELIMITER $$
CREATE DEFINER=`titanuser`@`%` PROCEDURE `bot_hero_insert`()
BEGIN

  #Set Hero Variables

  SET @hero_name = (SELECT CONCAT(generate_fname(),' ', generate_lname()) as hero_name);
  SET @player_name = (generate_fname());
  SET @player_lastname = "BOT-O-Matic";
  SET @email = (CONCAT(@player_name, '.', @player_lastname, randomizer(1,1000000),'@dell.com'));
  SET @twitter = (CONCAT('@', @player_name, '.', @player_lastname));
  SET @token = (SELECT UUID());
  SET @userpass = (SELECT UUID());
  SET @hero_level = (randomizer(1,5));
  SET @next_level_calc = (SELECT ROUND(600*(POW(1.16, @hero_level+1))) AS Level_Time);
  SET @next_level_calc2 = (SEC_TO_TIME((SELECT ROUND(600*(POW(1.16, @hero_level))) AS Level_Time)));
  SET @next_level  = (SELECT ADDTIME(NOW(), @next_level_calc2));

#SELECT @hero_level, @next_level_calc, @next_level_calc2, (Now()), @next_level;


INSERT INTO `titandb`.`bothero`
(
  `hero_name`,
  `player_name`,
  `player_lastname`,
  `token`,
  `twitter`,
  `email`,
  `title`,
  `race`,
  `isAdmin`,
  `hero_level`,
  `hclass`,
  `ttl`,
  `userhost`,
  `hero_online`,
  `xpos`,
  `ypos`,
  `next_level`,
	weapon,
    tunic,
    shield,
    leggings,
    ring,
    gloves,
    boots,
    helm,
    charm,
    amulet,
    total_equipment
)

VALUES

(
  @hero_name,
  @player_name,
  @player_lastname,
  @token,
  @twitter,
  @email,
  generate_title(),
  generate_race(),
  0,
  @hero_level,
  generate_class(),
  @next_level_calc,
  0,
  1,
  randomizer(1,2),
  randomizer(1,2),
  @next_level,
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  randomizer(1,2),
  0
  
);

SET @heroid = NULL;
SET @total_items = NULL;

# Getting HeroID to build up the Item and Penalty tables

SET @heroid = (SELECT hero_id FROM bothero WHERE token = @token);


# Calculate Total Items for Gandalf
SET @total_items = (SELECT  weapon + tunic + shield + leggings + ring + gloves + boots + helm + charm + Amulet FROM bothero WHERE hero_id = @heroid);

UPDATE bothero SET total_equipment = @total_items WHERE hero_id = @heroid;



END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS create_bot_heros;

DELIMITER $$
CREATE DEFINER=`titanuser`@`%` PROCEDURE `create_bot_heros`(IN heronum INT)
BEGIN

    DECLARE count INT;
  SET count=0;

  BEGIN

    WHILE count < heronum DO

      call bot_hero_insert();

      SET count=(count + 1);

    END WHILE;

END;


END$$
DELIMITER ;



#load Neutrino accounts
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_000','hero_000','PUvi507V',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_001','hero_001','j96lEqLk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_002','hero_002','CX6OrryM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_003','hero_003','sSEeDx63',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_004','hero_004','g54aPu50',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_005','hero_005','rH7AYGaz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_006','hero_006','uttIK32g',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_007','hero_007','bmjMPwI0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_008','hero_008','4YKZEQzV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_009','hero_009','oqbQUy6j',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_010','hero_010','XNhy9jqc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_011','hero_011','QKstgRmT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_012','hero_012','1jC7vIXi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_013','hero_013','s5rkFoXr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_014','hero_014','6DK8zGnP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_015','hero_015','gbDb1UnM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_016','hero_016','lqqvceti',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_017','hero_017','CwxT5qLs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_018','hero_018','1rL3hwB5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_019','hero_019','1NTz3K8q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_020','hero_020','9KXl4DYl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_021','hero_021','sIUuOiRZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_022','hero_022','mIx0Wfo6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_023','hero_023','A0MLejDP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_024','hero_024','KEJloNZt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_025','hero_025','24WKkieO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_026','hero_026','ULR8XuUL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_027','hero_027','70xFR7ti',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_028','hero_028','MzLxDIi0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_029','hero_029','ZodoPcKX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_030','hero_030','mhr9AI7L',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_031','hero_031','L7atzbHi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_032','hero_032','10t4Ntk1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_033','hero_033','kqS7Rulr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_034','hero_034','FLFxNMi2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_035','hero_035','fNuJ4FJD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_036','hero_036','QV9dJgOo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_037','hero_037','mb8poiN7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_038','hero_038','Rd8MqmOA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_039','hero_039','fC3XPDkd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_040','hero_040','MCmEYH7L',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_041','hero_041','BfiSSkm9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_042','hero_042','xxmQvd5Y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_043','hero_043','J7TANqqs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_044','hero_044','yJ4nKG8t',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_045','hero_045','5QtZkpCX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_046','hero_046','HGIGYjIW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_047','hero_047','w9IWDEZs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_048','hero_048','0NPcVuaY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_049','hero_049','1OEITzb6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_050','hero_050','pfrpW2Ou',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_051','hero_051','deRpwsNH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_052','hero_052','OWvwhIbe',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_053','hero_053','sC5XnVFI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_054','hero_054','oOSPqWwl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_055','hero_055','YaHeb6Kk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_056','hero_056','hxiqSsgd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_057','hero_057','zyrn79Rs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_058','hero_058','ct6Imu6P',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_059','hero_059','FA43JI1Y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_060','hero_060','0YEKqIgD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_061','hero_061','nC9HQQ8n',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_062','hero_062','yGPWy3Nq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_063','hero_063','lS4JPJt4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_064','hero_064','HlemZ5z3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_065','hero_065','S22Lm3lJ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_066','hero_066','PJxLBQ2r',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_067','hero_067','tnzERGlJ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_068','hero_068','ChYOvR4Y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_069','hero_069','wRencUgO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_070','hero_070','tEYHgoIf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_071','hero_071','Z3FqdK42',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_072','hero_072','XurQsxQH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_073','hero_073','EFao6aNi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_074','hero_074','YhuGZMBh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_075','hero_075','6NJEGxVR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_076','hero_076','nsHiIz4I',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_077','hero_077','nL3HLUmQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_078','hero_078','gXECBV5G',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_079','hero_079','lCoaF5Nd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_080','hero_080','ciMES1RF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_081','hero_081','ie7fMuEb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_082','hero_082','CYOrDXXn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_083','hero_083','wADozGOl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_084','hero_084','k9UZL1AC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_085','hero_085','fmCzFnm9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_086','hero_086','BXVGXaWZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_087','hero_087','vD2IiL7D',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_088','hero_088','obDukIDl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_089','hero_089','phMCCKbB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_090','hero_090','KkxbYJbk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_091','hero_091','SNSHS9Up',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_092','hero_092','jUW2sWtN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_093','hero_093','LFTxdVcJ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_094','hero_094','s7lPR1F5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_095','hero_095','tN3LyQcF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_096','hero_096','JJTnyMj5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_097','hero_097','DZV14xxY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_098','hero_098','s9L2bPvm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_099','hero_099','JplQjw5p',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_100','hero_100','c1yYHkwk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_101','hero_101','ftiigqSZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_102','hero_102','N4RB3QKa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_103','hero_103','oQHEHT1w',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_104','hero_104','FqktmzCK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_105','hero_105','Am2N2AOt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_106','hero_106','QmJGBt0Q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_107','hero_107','qVJVsEU4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_108','hero_108','D5129yVr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_109','hero_109','gitGcg8G',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_110','hero_110','qmmqPhy4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_111','hero_111','TsTcDIVl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_112','hero_112','SakUPKkt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_113','hero_113','PHULpor8',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_114','hero_114','OVtm1oNC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_115','hero_115','reAtfxgp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_116','hero_116','iSjLmi3O',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_117','hero_117','GCy1tblX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_118','hero_118','ffMmg46o',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_119','hero_119','IBnNFUoR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_120','hero_120','hOECLScc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_121','hero_121','Aw1NNqzQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_122','hero_122','l3uim1M2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_123','hero_123','DTVrn5CI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_124','hero_124','lHCySORA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_125','hero_125','URmV8Gd9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_126','hero_126','mZMCTaZs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_127','hero_127','BqnmeSEk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_128','hero_128','nCOtP2v9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_129','hero_129','Qe7U8gFH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_130','hero_130','tgQNZR3l',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_131','hero_131','BqwWVMmo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_132','hero_132','HyuM8iz7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_133','hero_133','GQt94a5z',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_134','hero_134','h66yErEn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_135','hero_135','YXYOpxWk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_136','hero_136','lXLxE2Kq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_137','hero_137','ISg6viOn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_138','hero_138','Toe3P41I',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_139','hero_139','k19ot6Im',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_140','hero_140','sn9ZVw3q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_141','hero_141','hjlUT6Nt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_142','hero_142','UreyRNYs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_143','hero_143','XWfmRGfC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_144','hero_144','tR1SB7dO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_145','hero_145','KsqERnwy',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_146','hero_146','ZXQx8f3q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_147','hero_147','yu2YP4W1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_148','hero_148','i63Cz87K',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_149','hero_149','RA9ARpyz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_150','hero_150','FWMf5llT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_151','hero_151','AryX576o',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_152','hero_152','Ni6fI1Md',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_153','hero_153','EPpAb2mj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_154','hero_154','CMNAloCf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_155','hero_155','jZ672cxL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_156','hero_156','k2i7jAyj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_157','hero_157','V8km2ybY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_158','hero_158','Dq5Rl1IR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_159','hero_159','VkexPAPB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_160','hero_160','we8TPPWH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_161','hero_161','k5DYIzWf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_162','hero_162','HaZGJQGP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_163','hero_163','JJoRSbcS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_164','hero_164','BurGksAu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_165','hero_165','x6yBaK09',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_166','hero_166','swllTqt5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_167','hero_167','mOCZR4ZU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_168','hero_168','2VXBMzTE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_169','hero_169','h6cFXarx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_170','hero_170','vTcxX9X6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_171','hero_171','bKoStgFa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_172','hero_172','sPVmmvqO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_173','hero_173','86Gp66xC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_174','hero_174','UbfU6R7q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_175','hero_175','gFJhD9tu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_176','hero_176','NSWfrqQX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_177','hero_177','iBYAYnAH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_178','hero_178','RzUJZtph',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_179','hero_179','cQbGx9lH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_180','hero_180','P1NiihLv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_181','hero_181','88uxdtGR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_182','hero_182','JPjqDtm7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_183','hero_183','b6udS2nH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_184','hero_184','J3HMqVIr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_185','hero_185','qowzreVL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_186','hero_186','rX7mpbNG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_187','hero_187','hMKi3N5y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_188','hero_188','lZju51Ed',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_189','hero_189','nVJ4rTm0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_190','hero_190','3bIHm0TI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_191','hero_191','ZCJU5ZxE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_192','hero_192','pk2mU941',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_193','hero_193','m5WF3aJd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_194','hero_194','oVS7GOfG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_195','hero_195','f2CRhj6i',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_196','hero_196','4i1czz8q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_197','hero_197','7IyHEjdU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_198','hero_198','ndI1xZcs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_199','hero_199','i8hKuxoI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_200','hero_200','0rok4mWq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_201','hero_201','mu5Ub0gk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_202','hero_202','5DYbmucS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_203','hero_203','jazWtA7b',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_204','hero_204','8ywlJ4Z3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_205','hero_205','nw2EpCka',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_206','hero_206','CaMTpQbW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_207','hero_207','KSWzIKxf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_208','hero_208','P5GTuCHO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_209','hero_209','kpPfDqvV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_210','hero_210','Lhw2V5tP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_211','hero_211','jlFhfxUI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_212','hero_212','N1kITGKC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_213','hero_213','Q6k28uWN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_214','hero_214','UBrrwEnM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_215','hero_215','jIsvBzUF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_216','hero_216','pFCNDNln',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_217','hero_217','1Hio9Fzw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_218','hero_218','QGVk1ciu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_219','hero_219','XxEongBi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_220','hero_220','1BkUJ3jV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_221','hero_221','L1AyJXEk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_222','hero_222','3tvKV06K',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_223','hero_223','hCQbsYSc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_224','hero_224','KmgoHDOp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_225','hero_225','pbQb4aPj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_226','hero_226','5j41zhhT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_227','hero_227','leU5rfC6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_228','hero_228','Nn39VWt5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_229','hero_229','AyIHrwTq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_230','hero_230','1tHJs0zl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_231','hero_231','YihRMhDP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_232','hero_232','EYtfz60R',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_233','hero_233','x7ky1I2g',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_234','hero_234','KF8eT2gu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_235','hero_235','cJgkBRiM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_236','hero_236','9gddQU1X',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_237','hero_237','1mrs107d',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_238','hero_238','AYDkbsJp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_239','hero_239','zRtFmZWU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_240','hero_240','amHUA6Zu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_241','hero_241','bT8nDH1Q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_242','hero_242','hoxAOqFc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_243','hero_243','OsCIsqi3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_244','hero_244','PBzGfvQb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_245','hero_245','8NSE5qCE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_246','hero_246','G5RJuJEb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_247','hero_247','NGKjTsFb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_248','hero_248','2JNbRaWz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_249','hero_249','exTVsPCW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_250','hero_250','4ngtWL7u',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_251','hero_251','2ywIOzda',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_252','hero_252','woB8RWaA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_253','hero_253','BUXHhnCz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_254','hero_254','a6xdNhjF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_255','hero_255','NopKztkB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_256','hero_256','ozODdQOM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_257','hero_257','JiVaoO5u',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_258','hero_258','jyxJIrzh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_259','hero_259','3maMsHQX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_260','hero_260','XyeF3Glm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_261','hero_261','sNaJlsCq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_262','hero_262','JxlXu34x',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_263','hero_263','fCTZCsb8',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_264','hero_264','9SH3nbLq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_265','hero_265','J4zoZcN2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_266','hero_266','P13Jibh1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_267','hero_267','LUkRWb5X',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_268','hero_268','cp6CjTSH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_269','hero_269','t8QAtkSW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_270','hero_270','rFneOwTo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_271','hero_271','KbfXOYRR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_272','hero_272','ZeTABthd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_273','hero_273','Uio5Cjxf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_274','hero_274','04ehrSVR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_275','hero_275','nXUTwQWg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_276','hero_276','bYmXzg0b',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_277','hero_277','YQWTtQ2O',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_278','hero_278','iVyKpiMr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_279','hero_279','bMwBpVcg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_280','hero_280','s8ZM4bBe',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_281','hero_281','M81fsuQU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_282','hero_282','KA6CEbwE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_283','hero_283','mMMhlx6T',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_284','hero_284','KnYfszCq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_285','hero_285','hW8S8NEo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_286','hero_286','n3Kau7Qf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_287','hero_287','FlEXPwmD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_288','hero_288','cCSzJIUb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_289','hero_289','G46qqTuV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_290','hero_290','5i08paDF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_291','hero_291','paGtSkgz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_292','hero_292','VprEm0zk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_293','hero_293','pZTmgeZt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_294','hero_294','kZlwdt83',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_295','hero_295','z7hD6Ukj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_296','hero_296','Lhmwfan2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_297','hero_297','p1JxuJvz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_298','hero_298','ievNF0Es',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_299','hero_299','dRCw2WIn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_300','hero_300','jmvV9S1o',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_301','hero_301','EAVetFlV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_302','hero_302','D9wU3Ks0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_303','hero_303','roFYp4aM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_304','hero_304','pft9Ozgw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_305','hero_305','Au7xvuVo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_306','hero_306','X8ReuXmS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_307','hero_307','0vq3ZVXB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_308','hero_308','ID5EL5wD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_309','hero_309','NEUZp9BQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_310','hero_310','pN1dIB5O',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_311','hero_311','44ayrxxP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_312','hero_312','95F8I4Nc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_313','hero_313','vsbSgpuQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_314','hero_314','jiZHaFJF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_315','hero_315','iuEa0mU4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_316','hero_316','gtjhPesn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_317','hero_317','4ZxhDnpj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_318','hero_318','he6GQjFy',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_319','hero_319','WfciNtQ2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_320','hero_320','LSmv98Iv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_321','hero_321','AsVIDYVR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_322','hero_322','lrXA5Tou',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_323','hero_323','HPqCeFjE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_324','hero_324','6kSP0IHP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_325','hero_325','5ThWSpPG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_326','hero_326','L1jswDL9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_327','hero_327','CH2VreY6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_328','hero_328','mSoJURqj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_329','hero_329','l5p4xG8F',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_330','hero_330','JnE2akfA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_331','hero_331','B33UoFfS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_332','hero_332','60KQGSz6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_333','hero_333','ctRpY5Cb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_334','hero_334','R3AgaHMm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_335','hero_335','lbwIHAYS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_336','hero_336','ODFT0WGP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_337','hero_337','SUreGX4A',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_338','hero_338','r5fJm6B2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_339','hero_339','puv4eXrl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_340','hero_340','v4d7MNOM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_341','hero_341','yzU64dw1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_342','hero_342','Su5WqSUz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_343','hero_343','VC4W1gcH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_344','hero_344','nk7WHxyZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_345','hero_345','o9G5U6Af',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_346','hero_346','N8LDZjAZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_347','hero_347','QASfh6sd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_348','hero_348','rxnz7jzz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_349','hero_349','ukaOq5PL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_350','hero_350','1olmV7kk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_351','hero_351','gNHPbkug',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_352','hero_352','WcT4w0MF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_353','hero_353','m80oEiLz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_354','hero_354','5THPGtFq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_355','hero_355','ldMmJhzn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_356','hero_356','uAME0l0S',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_357','hero_357','rUum29V4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_358','hero_358','7cVqe8N7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_359','hero_359','l8HWSssI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_360','hero_360','TIWVvWXS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_361','hero_361','S1cBdf8m',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_362','hero_362','37azyKb6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_363','hero_363','LifuYFWY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_364','hero_364','gTmYDoTf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_365','hero_365','qUKUhiIx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_366','hero_366','tuapgWlc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_367','hero_367','V5SqCyeP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_368','hero_368','jSEdElGo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_369','hero_369','nqCfdN0e',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_370','hero_370','aB1pbJmo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_371','hero_371','6YqECteF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_372','hero_372','VritZIUj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_373','hero_373','Ki0V2CNC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_374','hero_374','0JJ2JCkb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_375','hero_375','iJmRJCa0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_376','hero_376','nG5Kzc5R',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_377','hero_377','e9A6xyzA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_378','hero_378','mo9vgPVO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_379','hero_379','3QcxEKt1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_380','hero_380','DisgPIJT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_381','hero_381','swr61KLv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_382','hero_382','uhsq0fEY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_383','hero_383','yB8AaBeT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_384','hero_384','JIbsJKYj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_385','hero_385','MmRCffVP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_386','hero_386','X554yqrd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_387','hero_387','RY83EBlR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_388','hero_388','YzwQludB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_389','hero_389','73z9yxrE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_390','hero_390','SOfck5aQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_391','hero_391','eKRMsGKA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_392','hero_392','9RrcUqjj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_393','hero_393','FqslztCN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_394','hero_394','g6nM9pHI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_395','hero_395','6NQiNXx0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_396','hero_396','Ave1P4lf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_397','hero_397','OiTsGRE4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_398','hero_398','JopeY0Op',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_399','hero_399','OaBodkw3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_400','hero_400','xUoLOA4t',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_401','hero_401','fvtYEBsG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_402','hero_402','xwArEQwf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_403','hero_403','yLgk23tX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_404','hero_404','pniN1JDd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_405','hero_405','WLZBF60s',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_406','hero_406','v1bd0Jsv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_407','hero_407','SNIVaeKT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_408','hero_408','Riu36wzG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_409','hero_409','OysvTIt0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_410','hero_410','Sw0dXGAm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_411','hero_411','G105m2mg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_412','hero_412','V3O67rSm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_413','hero_413','p4UI55Pt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_414','hero_414','SMvxWO6V',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_415','hero_415','EQ8sjUil',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_416','hero_416','1JPOVPsm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_417','hero_417','9CM4aFVi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_418','hero_418','A3TJj4Fx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_419','hero_419','reHFKYIM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_420','hero_420','AY3Y9MwQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_421','hero_421','YmVizNjQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_422','hero_422','bhx3qNUR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_423','hero_423','LxJzvymD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_424','hero_424','3Yh4AK5o',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_425','hero_425','cn0lqkF3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_426','hero_426','aM4pH0Jn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_427','hero_427','2ylTgw2o',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_428','hero_428','1CHUPOKW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_429','hero_429','giIM1S1d',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_430','hero_430','1JQg0eYF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_431','hero_431','tBGNfpEN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_432','hero_432','HqXdP4Aw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_433','hero_433','Snqp3kby',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_434','hero_434','TR1fo6cB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_435','hero_435','SOCsqOdy',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_436','hero_436','2WBFHIya',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_437','hero_437','BMDrO5id',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_438','hero_438','FkhHkkec',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_439','hero_439','AcCROE4U',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_440','hero_440','81iJ4IIS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_441','hero_441','RG4v6aL1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_442','hero_442','kyVCuQBY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_443','hero_443','2czx9xFy',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_444','hero_444','wIZIMAbb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_445','hero_445','JQof0sOx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_446','hero_446','ltQ0tvmt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_447','hero_447','NlpPzPYi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_448','hero_448','3Wh2Z98k',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_449','hero_449','8KLsugND',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_450','hero_450','SRvcKT64',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_451','hero_451','AjTqstb0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_452','hero_452','bdWdUlD8',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_453','hero_453','VjNlOE0a',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_454','hero_454','GC6Nmv2P',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_455','hero_455','QOauyOPJ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_456','hero_456','4lqsW1oO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_457','hero_457','Kv6zY7jH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_458','hero_458','hxhGP27x',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_459','hero_459','TnneZ4Ol',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_460','hero_460','IQdr3iip',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_461','hero_461','xe6he9KO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_462','hero_462','VPShdyDS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_463','hero_463','BIVT6Dql',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_464','hero_464','h9tMbsQt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_465','hero_465','dJI5iC9U',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_466','hero_466','rYT2dvN4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_467','hero_467','sz2pU56L',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_468','hero_468','nIlF0Y5C',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_469','hero_469','uzLuYbyp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_470','hero_470','Gfx4ayrR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_471','hero_471','2YL51ehX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_472','hero_472','sWr8ATPa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_473','hero_473','Xdhsawga',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_474','hero_474','AzMBnQaU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_475','hero_475','CLlzLZJi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_476','hero_476','sKneXeXz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_477','hero_477','ZZFrBNKg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_478','hero_478','1flmIjrt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_479','hero_479','LQNuh2Gd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_480','hero_480','VhXJPxtP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_481','hero_481','t92ECCZC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_482','hero_482','DQUwbrSx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_483','hero_483','i9hMp4Zd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_484','hero_484','3NUNPWPc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_485','hero_485','FLNgDCvg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_486','hero_486','9qXIlV6I',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_487','hero_487','KFuZkGlp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_488','hero_488','GURXYH1q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_489','hero_489','WNTqVdEj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_490','hero_490','8tqMUA6x',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_491','hero_491','z6VeOwOB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_492','hero_492','u7mzb0EC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_493','hero_493','wTuDVIDc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_494','hero_494','HSkf0i0V',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_495','hero_495','Vnx5QXJd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_496','hero_496','VcZxEN0g',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_497','hero_497','Ah9JD74V',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_498','hero_498','XbUp5qCU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_499','hero_499','X82UylNe',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_500','hero_500','nRcZy5Vh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_501','hero_501','0OonOnS5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_502','hero_502','gPjXGw8W',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_503','hero_503','QD6RTp0c',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_504','hero_504','bWyXywdK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_505','hero_505','kt6X4MXF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_506','hero_506','yptjSK95',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_507','hero_507','lU1lsR1Y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_508','hero_508','5DQLVvJY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_509','hero_509','EWb817mz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_510','hero_510','MDqRgUf8',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_511','hero_511','dNiWdrMa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_512','hero_512','YkP0S7XY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_513','hero_513','7qHcJeTU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_514','hero_514','TfJR1HWy',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_515','hero_515','UPMLIKSU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_516','hero_516','NcKOFJUY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_517','hero_517','IUxIqwy5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_518','hero_518','zHim9g8d',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_519','hero_519','gsS6zWyj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_520','hero_520','kyN3WlI2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_521','hero_521','Svr5fYsi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_522','hero_522','dx6G6PfN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_523','hero_523','GCo3RlOV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_524','hero_524','cbmh7hY7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_525','hero_525','6tHk6WVH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_526','hero_526','CZkfLtbQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_527','hero_527','5Dy5SsQC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_528','hero_528','eurawtul',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_529','hero_529','OF2vNVwX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_530','hero_530','zun5NEB7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_531','hero_531','f80LNF8U',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_532','hero_532','LOdFVFFA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_533','hero_533','qaJok6Wg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_534','hero_534','cPhH0uFm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_535','hero_535','KFZEjw3B',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_536','hero_536','HvAHoOb1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_537','hero_537','B7PgIXgf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_538','hero_538','AkpOMNB6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_539','hero_539','6aFXpG0W',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_540','hero_540','0N0911RB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_541','hero_541','6NQhnb9O',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_542','hero_542','CAIu3Vdg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_543','hero_543','5oRai3Dk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_544','hero_544','vrAZRaM5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_545','hero_545','EXiouvnh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_546','hero_546','shticlTN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_547','hero_547','QmuBxTy4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_548','hero_548','NwZVy5pD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_549','hero_549','ySD5jmq5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_550','hero_550','bieriqVN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_551','hero_551','xREfMnFT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_552','hero_552','PEpNKRtO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_553','hero_553','znWMYmf5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_554','hero_554','FCKxyEoK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_555','hero_555','8Ja8HGDc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_556','hero_556','BL6e5yFP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_557','hero_557','APqW5D55',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_558','hero_558','uvXjO8vN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_559','hero_559','4IOS2aBT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_560','hero_560','AXVn8PUj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_561','hero_561','NmyKse3u',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_562','hero_562','N7nc3deq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_563','hero_563','vPbwTkJq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_564','hero_564','rZbVx38H',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_565','hero_565','pslCtg3h',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_566','hero_566','zSjEB1rD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_567','hero_567','01WcITyq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_568','hero_568','CsCRNL4J',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_569','hero_569','qG12vfoh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_570','hero_570','3ae0OUXl',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_571','hero_571','EHPw3DtK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_572','hero_572','KYcaRuNG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_573','hero_573','Sa5FvTN3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_574','hero_574','xb5nCPxD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_575','hero_575','5A16ARuv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_576','hero_576','FOHFttkv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_577','hero_577','qGv1pAGt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_578','hero_578','3bUSVWG9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_579','hero_579','duAp7weS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_580','hero_580','NVZvJsdL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_581','hero_581','z7VEaZkH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_582','hero_582','sZmuZCZg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_583','hero_583','Z1OJJKXw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_584','hero_584','Zq6AqdjW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_585','hero_585','Nc7OmRDc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_586','hero_586','bg2E5Sb6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_587','hero_587','KGa1FhTZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_588','hero_588','NGmJ9LsX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_589','hero_589','YAh7hwsE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_590','hero_590','G5HR4XBe',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_591','hero_591','3wwRDdAv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_592','hero_592','VGYTN1rp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_593','hero_593','c4O1eSur',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_594','hero_594','SF3ldG5e',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_595','hero_595','vXxPwcVn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_596','hero_596','RTGZtW8w',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_597','hero_597','f3vdZ75r',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_598','hero_598','D2QrIqj2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_599','hero_599','uloYnYKv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_600','hero_600','w8yqHXsx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_601','hero_601','5RuwjroA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_602','hero_602','RPxbNx11',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_603','hero_603','V6qp9CJS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_604','hero_604','hn9pdtlD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_605','hero_605','oZszAcnQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_606','hero_606','KA3ya1ue',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_607','hero_607','hmgJ73xE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_608','hero_608','mZSW9f2I',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_609','hero_609','lt3xsCAw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_610','hero_610','ebbL2ydA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_611','hero_611','l2V5d5Jp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_612','hero_612','nSe1CfTr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_613','hero_613','tHb3Sp7C',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_614','hero_614','MBq9ECld',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_615','hero_615','yvmBtCuQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_616','hero_616','og3pleVu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_617','hero_617','i3FPX8uY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_618','hero_618','dliK3onf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_619','hero_619','VMm52Rs5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_620','hero_620','TfVl2dG3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_621','hero_621','16Yc2ztf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_622','hero_622','HDtQTvIm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_623','hero_623','Fv2rhxET',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_624','hero_624','547wKaoj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_625','hero_625','7UM6xcj4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_626','hero_626','cpYcTjL9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_627','hero_627','zH9kzY1P',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_628','hero_628','K6rfZkj3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_629','hero_629','qpOeEAY1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_630','hero_630','8zWVgaUT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_631','hero_631','1dkscWZ2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_632','hero_632','RsfAebJN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_633','hero_633','qVFHRt0q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_634','hero_634','4j2h0oFb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_635','hero_635','uXJ7K43e',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_636','hero_636','nDU9XQpj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_637','hero_637','z87C4MwK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_638','hero_638','24WYuPgT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_639','hero_639','sbkexnZ4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_640','hero_640','L1kWMKx5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_641','hero_641','H1HP9IXt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_642','hero_642','EFBVN3Af',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_643','hero_643','wDIdPMK6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_644','hero_644','WNo7LEQe',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_645','hero_645','RavK6MeE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_646','hero_646','pxsL2CUI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_647','hero_647','6Jp67mha',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_648','hero_648','HaGuOpYW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_649','hero_649','zhB4u4fI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_650','hero_650','VaXjvcfO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_651','hero_651','HgLRT0ZA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_652','hero_652','8RtIvxBr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_653','hero_653','KDEKT6Vh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_654','hero_654','d8YMltiJ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_655','hero_655','FQ2vy6Sp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_656','hero_656','sXkJudZw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_657','hero_657','wFz9aaD8',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_658','hero_658','uElNlkzw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_659','hero_659','TFYIGhKV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_660','hero_660','Q9XTkk1K',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_661','hero_661','jbPLIXOI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_662','hero_662','V30yhjjo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_663','hero_663','aJtDcTVM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_664','hero_664','nhEQWWrT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_665','hero_665','tXzXvD4K',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_666','hero_666','4F8zsw5N',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_667','hero_667','Gl3fKIMB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_668','hero_668','c5H7SFlg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_669','hero_669','8FZ97lyx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_670','hero_670','V3zsE2ta',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_671','hero_671','VSIXOaF6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_672','hero_672','LWN7gsmn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_673','hero_673','Juk8MNSn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_674','hero_674','VkjkfgEG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_675','hero_675','8HTphlbZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_676','hero_676','3qmiCG1i',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_677','hero_677','sjwaPop2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_678','hero_678','WogT5C2K',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_679','hero_679','SZV7SJe8',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_680','hero_680','7NI0ydcu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_681','hero_681','Zu7ZSwVE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_682','hero_682','37XVdRDt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_683','hero_683','f1Nav77x',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_684','hero_684','hPgLJzLI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_685','hero_685','niltV3dB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_686','hero_686','DJnsFB3a',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_687','hero_687','WHTK70U9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_688','hero_688','pcJ5wrAm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_689','hero_689','t2gOgEcX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_690','hero_690','iAmnzFod',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_691','hero_691','DBMa1DCt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_692','hero_692','NfI5EJCP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_693','hero_693','4aTSHvlj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_694','hero_694','ZHDhLieb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_695','hero_695','lhyGFxrb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_696','hero_696','xRxGwOSx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_697','hero_697','4TJ739XH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_698','hero_698','cuBS8m4d',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_699','hero_699','RyqJCDHt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_700','hero_700','g6oKqDwn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_701','hero_701','C0npXnSf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_702','hero_702','jMcJmRfh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_703','hero_703','ihjPAQbZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_704','hero_704','8GfnTkmF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_705','hero_705','DRuSUbHy',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_706','hero_706','aoJS8IKu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_707','hero_707','rJ1KYekY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_708','hero_708','Cyig0CWU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_709','hero_709','OZDR6Egu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_710','hero_710','lsyFv1Oq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_711','hero_711','s32RcKQd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_712','hero_712','8qXLRICL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_713','hero_713','dZTC5yDL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_714','hero_714','nfHSNGYq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_715','hero_715','u6eSSK9X',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_716','hero_716','Q96COqFR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_717','hero_717','zyDR0B40',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_718','hero_718','zmzBLdI6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_719','hero_719','Gu52Lt3S',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_720','hero_720','G1O1vR9k',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_721','hero_721','s8V7BSCh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_722','hero_722','Ke49FGAd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_723','hero_723','hZdTxMcV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_724','hero_724','WhtmlmC6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_725','hero_725','ZocvJotg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_726','hero_726','UFPDNUFW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_727','hero_727','aaBp2BSx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_728','hero_728','pOXtAQDe',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_729','hero_729','dcR4hjd3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_730','hero_730','0lGmNVRX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_731','hero_731','uuoz4HaG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_732','hero_732','1IfIMUse',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_733','hero_733','bhIM107I',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_734','hero_734','WZZmZ5PN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_735','hero_735','7lt5N4VN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_736','hero_736','i8vdihP7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_737','hero_737','1T9YaEYL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_738','hero_738','sSGUEXwa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_739','hero_739','MC6dKC5L',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_740','hero_740','L14PHGQF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_741','hero_741','bAWTxuvL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_742','hero_742','sxwOpebF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_743','hero_743','kNIc4wIM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_744','hero_744','DU6ROpwo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_745','hero_745','SubO5om0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_746','hero_746','1479LXfq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_747','hero_747','eKOfQbvM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_748','hero_748','253N8pM7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_749','hero_749','rhWAyf3Y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_750','hero_750','nyscX3nV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_751','hero_751','OVYVOJ7U',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_752','hero_752','MRospaiM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_753','hero_753','vvD7xiPa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_754','hero_754','p2BXnawO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_755','hero_755','IwW9TQUV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_756','hero_756','Qs7U57AO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_757','hero_757','2gwOj6WO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_758','hero_758','F0LTcypM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_759','hero_759','ll8JGC7q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_760','hero_760','fCn3obS3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_761','hero_761','ya7o7Axj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_762','hero_762','KYWWbIIa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_763','hero_763','qmvjcAGQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_764','hero_764','N31zKYxE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_765','hero_765','f7I2T3Vh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_766','hero_766','fyXjsTja',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_767','hero_767','wSBxLe90',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_768','hero_768','Of7Cl8Ko',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_769','hero_769','uwqpGllv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_770','hero_770','BDhpskPg',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_771','hero_771','Tahddk9W',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_772','hero_772','V5gvFqG8',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_773','hero_773','WauSn3Bi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_774','hero_774','JwoN6Us7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_775','hero_775','0A61KD3A',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_776','hero_776','vtSiPihV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_777','hero_777','K4IScKyM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_778','hero_778','T2AXM0Yz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_779','hero_779','zihnmr3g',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_780','hero_780','NkmAddPN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_781','hero_781','Rh0CGISq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_782','hero_782','3OOAOPns',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_783','hero_783','Sp1QL9nV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_784','hero_784','IOcjHgxV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_785','hero_785','8SbACjeO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_786','hero_786','dhWIwJgf',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_787','hero_787','bpDFtI7I',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_788','hero_788','ddUUalTh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_789','hero_789','aDoUY0XD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_790','hero_790','8li4wK0L',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_791','hero_791','sm4d2PKz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_792','hero_792','YfOf2XVD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_793','hero_793','7858Mwmc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_794','hero_794','EZqCqTDR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_795','hero_795','Bp7l6yfo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_796','hero_796','lOxPnMMd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_797','hero_797','hhq6oO00',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_798','hero_798','KSaoqf1T',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_799','hero_799','n9eTsWNM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_800','hero_800','xqMFFxD2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_801','hero_801','dsW8rXtm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_802','hero_802','cVEMoOqj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_803','hero_803','MJ6DtdYL',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_804','hero_804','aYvc0R55',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_805','hero_805','NWtngUJc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_806','hero_806','FDpnrR5O',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_807','hero_807','D6yIN06A',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_808','hero_808','45ghO64f',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_809','hero_809','LI9Xhp88',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_810','hero_810','tDaZ8RXP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_811','hero_811','O3Fz0j2A',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_812','hero_812','4spWYOHV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_813','hero_813','6Ujkham9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_814','hero_814','0rHHevJw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_815','hero_815','IGNu93yZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_816','hero_816','R032UYG2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_817','hero_817','nQ6cvoOd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_818','hero_818','bb52cAYY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_819','hero_819','2C08wiin',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_820','hero_820','50A5OD82',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_821','hero_821','Ig9ZDgAw',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_822','hero_822','B5y2KFYc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_823','hero_823','hIgSFoxx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_824','hero_824','7q25nHAt',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_825','hero_825','lnO2p8vE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_826','hero_826','Q2k70gmk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_827','hero_827','cdWpb6Nd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_828','hero_828','eaQfzNKh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_829','hero_829','9pu4xLl2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_830','hero_830','YneGJMWB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_831','hero_831','XhGuly6L',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_832','hero_832','ygYXYgKe',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_833','hero_833','voZ7TcKI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_834','hero_834','7dU7aesZ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_835','hero_835','aHr9i5lv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_836','hero_836','jTgbdChQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_837','hero_837','evPRpb9W',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_838','hero_838','rr2EeMCo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_839','hero_839','ak78ozis',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_840','hero_840','VnBKivw1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_841','hero_841','ksMyQ0cB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_842','hero_842','ZPVEqdy0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_843','hero_843','gfgotbuC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_844','hero_844','W2FYIAGY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_845','hero_845','GgkMeLEP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_846','hero_846','lvHgOebT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_847','hero_847','cfU2Iaqz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_848','hero_848','gIGYAEWS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_849','hero_849','8q3AzjFz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_850','hero_850','8v8hUsuc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_851','hero_851','vs7GY57y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_852','hero_852','5JGRlQte',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_853','hero_853','xlYwkJQF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_854','hero_854','8CTRpZSV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_855','hero_855','47DYibPW',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_856','hero_856','7fc8VTQE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_857','hero_857','BYDSLB1y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_858','hero_858','u45tYNv9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_859','hero_859','wMujBFNJ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_860','hero_860','cdUvXB7Q',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_861','hero_861','556EBLIn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_862','hero_862','r755oIvU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_863','hero_863','Zl8sJ7Ij',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_864','hero_864','d3dEBPfh',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_865','hero_865','mNgNMc7E',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_866','hero_866','A5gqjzSj',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_867','hero_867','T5jqofZn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_868','hero_868','oUYtDfoy',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_869','hero_869','TN722mEE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_870','hero_870','nls3XqKM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_871','hero_871','9tVkexyA',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_872','hero_872','Dhg8ke76',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_873','hero_873','E5FVNCdU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_874','hero_874','ysrUNPlD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_875','hero_875','IITG8rGx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_876','hero_876','o4fZzy4D',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_877','hero_877','ozVHn0Ii',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_878','hero_878','cswbzkgi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_879','hero_879','ILvKFpMv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_880','hero_880','4dqnhIqo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_881','hero_881','KmkfnZ9V',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_882','hero_882','YBrPIX0E',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_883','hero_883','3n2WeugG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_884','hero_884','9KTg9jPp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_885','hero_885','ct0Bh3so',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_886','hero_886','DWWH8SuE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_887','hero_887','1rlXUNkV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_888','hero_888','WQKsIVUz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_889','hero_889','dqZopUGE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_890','hero_890','Y53trpeb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_891','hero_891','xKgmq0qm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_892','hero_892','wbAvahAK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_893','hero_893','xSiZBRkm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_894','hero_894','FgsmcIAi',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_895','hero_895','f8jNshLp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_896','hero_896','SGP6VSfq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_897','hero_897','tQezAlDM',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_898','hero_898','xobNMeYv',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_899','hero_899','iCDABuM5',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_900','hero_900','zmYBYQ9E',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_901','hero_901','fv7rWQhK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_902','hero_902','N2wDzr2G',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_903','hero_903','pTj8wPIF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_904','hero_904','HD43sCJC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_905','hero_905','K25q4MeK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_906','hero_906','X3wJPObU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_907','hero_907','FcTTQAvV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_908','hero_908','Qee5YeDO',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_909','hero_909','yVbgDkMx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_910','hero_910','m2HBnwN7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_911','hero_911','HJGZ2RYE',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_912','hero_912','fr05QVTI',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_913','hero_913','B3bap2ul',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_914','hero_914','JGWkdZOD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_915','hero_915','gBZMF7hP',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_916','hero_916','U6LskoOB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_917','hero_917','OJPshOe0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_918','hero_918','L455ixQ3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_919','hero_919','RTvFj10o',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_920','hero_920','88OtI3y2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_921','hero_921','VpDkMP0N',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_922','hero_922','rcgHOwEu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_923','hero_923','ZnbehnPq',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_924','hero_924','w4D7kaKS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_925','hero_925','bmHgZwkK',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_926','hero_926','Qbb13BCc',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_927','hero_927','GCgw8GH0',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_928','hero_928','0IaehwKm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_929','hero_929','UnuUdnRB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_930','hero_930','cZlCTKj3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_931','hero_931','v9YT4ykH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_932','hero_932','HDWn6u6u',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_933','hero_933','Bg9gOuSd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_934','hero_934','tOFFKoYS',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_935','hero_935','vaU7NiZR',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_936','hero_936','l2wYmuuN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_937','hero_937','XNYvRZ5k',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_938','hero_938','1wlTQbZk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_939','hero_939','gFiDQgwQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_940','hero_940','uZxVrQ5x',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_941','hero_941','heZtLb1w',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_942','hero_942','CQeGMf8P',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_943','hero_943','rK4ZfXBC',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_944','hero_944','M2m1bIup',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_945','hero_945','O516tJzJ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_946','hero_946','JZEOodGn',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_947','hero_947','TuFPpksF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_948','hero_948','7TAmK7T2',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_949','hero_949','qnHQMUwX',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_950','hero_950','1oL26ETu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_951','hero_951','q3gz7wIH',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_952','hero_952','ifQBZ4Ul',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_953','hero_953','qgyNxBqm',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_954','hero_954','RrL0WZK4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_955','hero_955','SunqYYC4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_956','hero_956','NRBsZph9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_957','hero_957','J3AYOQLx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_958','hero_958','qJrhJlPT',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_959','hero_959','cbfRRJLd',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_960','hero_960','Sw6qFjDQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_961','hero_961','jNwvCpcx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_962','hero_962','XKc6vsxa',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_963','hero_963','hQJoGRgQ',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_964','hero_964','tj0Qy6jG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_965','hero_965','WR3iLz3Y',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_966','hero_966','mh18NVrz',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_967','hero_967','ScumIY8w',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_968','hero_968','MWOYHivr',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_969','hero_969','yLqKQylG',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_970','hero_970','7pFShHY3',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_971','hero_971','wkqT1Uxx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_972','hero_972','CeQGzO1Z',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_973','hero_973','kniFDAZp',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_974','hero_974','p3Of3I8J',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_975','hero_975','z7Ga07zk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_976','hero_976','MQ9oUSsV',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_977','hero_977','WHA3z7Bb',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_978','hero_978','mx4DWsS7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_979','hero_979','O5lBHLA1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_980','hero_980','uBDpuzSN',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_981','hero_981','jr8zuMQ6',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_982','hero_982','tBgYX85O',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_983','hero_983','7BIz8lZ7',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_984','hero_984','54ssxRXU',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_985','hero_985','z4RAKoh4',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_986','hero_986','oyC63tnu',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_987','hero_987','mz6ojsq1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_988','hero_988','M8cXptPo',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_989','hero_989','pJI1bpBs',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_990','hero_990','8CLGAe8t',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_991','hero_991','HuKUnMyF',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_992','hero_992','vAoSPAZk',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_993','hero_993','T54bAfzx',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_994','hero_994','P86voCbB',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_995','hero_995','fz6sz1YD',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_996','hero_996','jWSW6GGY',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_997','hero_997','qGc63NE9',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_998','hero_998','Owwbywo1',0);
INSERT INTO heroneutrinoaccounts(heroaccount,herousername,heropassword,used) values('hero_999','hero_999','j3lQbtWs',0);




