/*

SQLyog Ultimate v8.5 
MySQL - 5.5.23 : Database - zepk_kns_engine

*********************************************************************

*/



/*!40101 SET NAMES utf8 */;



/*!40101 SET SQL_MODE=''*/;



/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`zodino_pns_20_engine` /*!40100 DEFAULT CHARACTER SET utf8 */;







/*Table structure for table `argument` */



DROP TABLE IF EXISTS `argument`;



CREATE TABLE `argument` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.object.device.argument',
  `fk_device` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT 'int' COMMENT 'Тип значения (str, float, int, enum, bool, date, bytes)',
  `size` int(11) NOT NULL COMMENT 'Размер параметра в битах',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название параметра (рус)',
  `min` float DEFAULT NULL COMMENT 'Минимальное значение ',
  `max` float DEFAULT NULL COMMENT 'Максимальное значение',
  PRIMARY KEY (`id`),
  KEY `fk_device` (`fk_device`),
  CONSTRAINT `fk_argument_device` FOREIGN KEY (`fk_device`) REFERENCES `device` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Параметры устройства';



/*Data for the table `argument` */






/*Table structure for table `cell` */



DROP TABLE IF EXISTS `cell`;



CREATE TABLE `cell` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.object.cell',
  `fk_object` varchar(255) NOT NULL DEFAULT '',
  `fk_factor` varchar(255) DEFAULT NULL,
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название ячейки (рус)',
  PRIMARY KEY (`id`),
  KEY `fk_object` (`fk_object`),
  KEY `FK_cell` (`fk_factor`),
  CONSTRAINT `FK_cell` FOREIGN KEY (`fk_factor`) REFERENCES `factor` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_cell_object` FOREIGN KEY (`fk_object`) REFERENCES `object` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Ячейки';



/*Data for the table `cell` */






/*Table structure for table `cell_argument` */



DROP TABLE IF EXISTS `cell_argument`;



CREATE TABLE `cell_argument` (
  `fk_cell` varchar(255) NOT NULL DEFAULT '',
  `fk_argument` varchar(255) DEFAULT '',
  KEY `fk_cell` (`fk_cell`),
  KEY `fk_argument` (`fk_argument`),
  CONSTRAINT `fk_cell_argument_argument` FOREIGN KEY (`fk_argument`) REFERENCES `argument` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_cell_argument_cell` FOREIGN KEY (`fk_cell`) REFERENCES `cell` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Связь ячеек и параметров устр';



/*Data for the table `cell_argument` */






/*Table structure for table `channel` */



DROP TABLE IF EXISTS `channel`;



CREATE TABLE `channel` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.Номер канала',
  `ptype` varchar(50) NOT NULL DEFAULT 'ictp' COMMENT 'Тип протокола (ictp, xmlda)',
  `ctype` varchar(50) NOT NULL DEFAULT 'gsm' COMMENT 'Тип связи (gsm, com, xmlda)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Каналы связи';



/*Data for the table `channel` */






/*Table structure for table `cmd_event` */



DROP TABLE IF EXISTS `cmd_event`;



CREATE TABLE `cmd_event` (
  `fk_event` varchar(255) NOT NULL,
  `fk_command` varchar(255) DEFAULT '',
  `arg_list` varchar(255) NOT NULL DEFAULT '' COMMENT 'Аргументы (argument=const, argument=[component.property])',
  KEY `fk_event` (`fk_event`),
  KEY `fk_command` (`fk_command`),
  CONSTRAINT `fk_cmd_event_command` FOREIGN KEY (`fk_command`) REFERENCES `command` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_cmd_event_event` FOREIGN KEY (`fk_event`) REFERENCES `event` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Связь событий и команд';



/*Data for the table `cmd_event` */






/*Table structure for table `command` */



DROP TABLE IF EXISTS `command`;



CREATE TABLE `command` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.object.device.command',
  `fk_object` varchar(255) NOT NULL DEFAULT '',
  `fk_device` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT 'none' COMMENT 'Тип команды (none, sys, alm, sta)',
  `access` varchar(50) NOT NULL DEFAULT 'work' COMMENT 'Тип доступа (work, alm, sys)',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название команды (рус)',
  PRIMARY KEY (`id`),
  KEY `fk_object` (`fk_object`),
  KEY `fk_device` (`fk_device`),
  CONSTRAINT `fk_command_device` FOREIGN KEY (`fk_device`) REFERENCES `device` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_command_object` FOREIGN KEY (`fk_object`) REFERENCES `object` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Команды';



/*Data for the table `command` */






/*Table structure for table `command_param` */



DROP TABLE IF EXISTS `command_param`;



CREATE TABLE `command_param` (
  `fk_command` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название атрибута (devt, devn, code)',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'Значение атрибута',
  KEY `fk_command` (`fk_command`),
  CONSTRAINT `fl_command_param_command` FOREIGN KEY (`fk_command`) REFERENCES `command` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Атрибуты команды';



/*Data for the table `command_param` */






/*Table structure for table `component` */



DROP TABLE IF EXISTS `component`;



CREATE TABLE `component` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.policy.component',
  `fk_policy` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'component',
  PRIMARY KEY (`id`),
  KEY `fk_policy` (`fk_policy`),
  CONSTRAINT `fk_component_policy` FOREIGN KEY (`fk_policy`) REFERENCES `policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Компоненты';



/*Data for the table `component` */






/*Table structure for table `device` */



DROP TABLE IF EXISTS `device`;



CREATE TABLE `device` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.object.device',
  `fk_object` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(50) DEFAULT '' COMMENT 'Тип устройства (plg)',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название устройства (рус)',
  PRIMARY KEY (`id`),
  KEY `fk_object` (`fk_object`),
  CONSTRAINT `fk_device_object` FOREIGN KEY (`fk_object`) REFERENCES `object` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Устройства';



/*Data for the table `device` */






/*Table structure for table `enum_value` */



DROP TABLE IF EXISTS `enum_value`;



CREATE TABLE `enum_value` (
  `fk_argument` varchar(255) NOT NULL DEFAULT '',
  `value` int(11) NOT NULL COMMENT 'Значение',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название (рус)',
  KEY `fk_argument` (`fk_argument`),
  CONSTRAINT `fk_enum_value_argument` FOREIGN KEY (`fk_argument`) REFERENCES `argument` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Значения перечислений';



/*Data for the table `enum_value` */



/*Table structure for table `event` */



DROP TABLE IF EXISTS `event`;



CREATE TABLE `event` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.policy.component.event',
  `fk_policy` varchar(255) NOT NULL DEFAULT '',
  `fk_component` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT 'cmd' COMMENT 'Тип события (cmd, jmp)',
  `name` varchar(50) NOT NULL DEFAULT 'OnClick' COMMENT 'Название события (onClick, OnMouseDown)',
  PRIMARY KEY (`id`),
  KEY `fk_policy` (`fk_policy`),
  KEY `fk_component` (`fk_component`),
  CONSTRAINT `fk_event_component` FOREIGN KEY (`fk_component`) REFERENCES `component` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_policy` FOREIGN KEY (`fk_policy`) REFERENCES `policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='События';



/*Data for the table `event` */






/*Table structure for table `factor` */



DROP TABLE IF EXISTS `factor`;



CREATE TABLE `factor` (
  `id` varchar(255) NOT NULL COMMENT 'project.object.id',
  `fk_object` varchar(255) NOT NULL,
  `value` float unsigned NOT NULL COMMENT 'Значение коэффициента',
  `descr` varchar(255) NOT NULL COMMENT 'Описание коэффициента',
  PRIMARY KEY (`id`),
  KEY `fk_object` (`fk_object`),
  CONSTRAINT `FK_factor` FOREIGN KEY (`fk_object`) REFERENCES `object` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*Data for the table `factor` */



/*Table structure for table `in_argument` */



DROP TABLE IF EXISTS `in_argument`;



CREATE TABLE `in_argument` (
  `fk_command` varchar(255) NOT NULL DEFAULT '',
  `fk_argument` varchar(255) DEFAULT '',
  `offset` int(10) unsigned NOT NULL COMMENT 'Смещение в битах',
  KEY `fk_command` (`fk_command`),
  KEY `fk_argument` (`fk_argument`),
  CONSTRAINT `FK_in_argument_argument` FOREIGN KEY (`fk_argument`) REFERENCES `argument` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_in_argument_command` FOREIGN KEY (`fk_command`) REFERENCES `command` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Входные аргументы команды';



/*Data for the table `in_argument` */






/*Table structure for table `jmp_event` */



DROP TABLE IF EXISTS `jmp_event`;



CREATE TABLE `jmp_event` (
  `fk_event` varchar(255) NOT NULL,
  `fk_policy` varchar(255) DEFAULT '',
  KEY `fk_event` (`fk_event`),
  KEY `fk_jmp_event_policy` (`fk_policy`),
  CONSTRAINT `fk_jmp_event_event` FOREIGN KEY (`fk_event`) REFERENCES `event` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jmp_event_policy` FOREIGN KEY (`fk_policy`) REFERENCES `policy` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Связь событий и переходов';



/*Data for the table `jmp_event` */



/*Table structure for table `menu` */



DROP TABLE IF EXISTS `menu`;



CREATE TABLE `menu` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.count (count генерируется в пределах проекта)',
  `parent` varchar(255) DEFAULT NULL COMMENT 'project.count',
  `fk_project` varchar(255) NOT NULL DEFAULT '',
  `fk_policy` varchar(255) DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'wnd' COMMENT 'Тип меню (wnd, dlg, m-wnd, i-menu, sep)',
  `descr` varchar(255) NOT NULL COMMENT 'Название пункта меню (''-'' для разделителя)',
  PRIMARY KEY (`id`),
  KEY `fk_policy` (`fk_policy`),
  KEY `fk_project` (`fk_project`),
  CONSTRAINT `FK_menu_policy` FOREIGN KEY (`fk_policy`) REFERENCES `policy` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_menu_project` FOREIGN KEY (`fk_project`) REFERENCES `project` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Меню';



/*Data for the table `menu` */



 



/*Table structure for table `object` */



DROP TABLE IF EXISTS `object`;



CREATE TABLE `object` (
  `id` varchar(255) NOT NULL COMMENT 'project.object',
  `fk_project` varchar(255) NOT NULL,
  `fk_channel` varchar(255) NOT NULL,
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название объекта (рус)',
  `cs` varchar(2083) DEFAULT NULL COMMENT 'Строка соединения. url при использовании XML-DA канала связи',
  `type` int(10) unsigned DEFAULT NULL COMMENT 'Тип объекта (пока не используется)',
  PRIMARY KEY (`id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_channel` (`fk_channel`),
  CONSTRAINT `FK_object_channel` FOREIGN KEY (`fk_channel`) REFERENCES `channel` (`id`),
  CONSTRAINT `fk_object_project` FOREIGN KEY (`fk_project`) REFERENCES `project` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Объекты';



/*Data for the table `object` */



 



/*Table structure for table `out_argument` */



DROP TABLE IF EXISTS `out_argument`;



CREATE TABLE `out_argument` (
  `fk_command` varchar(255) NOT NULL DEFAULT '',
  `fk_argument` varchar(255) DEFAULT '',
  `offset` int(10) unsigned NOT NULL COMMENT 'Смещение в битах',
  KEY `fk_command` (`fk_command`),
  KEY `fk_argument` (`fk_argument`),
  CONSTRAINT `FK_out_argument_argument` FOREIGN KEY (`fk_argument`) REFERENCES `argument` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_out_argument_command` FOREIGN KEY (`fk_command`) REFERENCES `command` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Выходные аргументы команды';



/*Data for the table `out_argument` */



 



/*Table structure for table `policy` */



DROP TABLE IF EXISTS `policy`;



CREATE TABLE `policy` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.policy',
  `fk_project` varchar(255) NOT NULL DEFAULT '',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название поведения (рус)',
  `form` mediumblob NOT NULL COMMENT 'Форма',
  `type` varchar(50) NOT NULL DEFAULT 'dlg' COMMENT 'Тип: dlg(диалог), single(форма)',
  PRIMARY KEY (`id`),
  KEY `fk_project` (`fk_project`),
  CONSTRAINT `fk_policy_project` FOREIGN KEY (`fk_project`) REFERENCES `project` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Поведения';



/*Data for the table `policy` */






/*Table structure for table `project` */



DROP TABLE IF EXISTS `project`;



CREATE TABLE `project` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT 'Название проекта (рус)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Проекты';



/*Data for the table `project` */



 



/*Table structure for table `property` */



DROP TABLE IF EXISTS `property`;



CREATE TABLE `property` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'project.policy.component.property',
  `fk_policy` varchar(255) NOT NULL DEFAULT '',
  `fk_component` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'property',
  `formula` blob NOT NULL COMMENT 'Формула',
  PRIMARY KEY (`id`),
  KEY `fk_policy` (`fk_policy`),
  KEY `fk_component` (`fk_component`),
  CONSTRAINT `fk_property_component` FOREIGN KEY (`fk_component`) REFERENCES `component` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_property_policy` FOREIGN KEY (`fk_policy`) REFERENCES `policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Свойства';



/*Data for the table `property` */



 



/*Table structure for table `property_cell` */



DROP TABLE IF EXISTS `property_cell`;



CREATE TABLE `property_cell` (
  `fk_property` varchar(255) NOT NULL,
  `fk_cell` varchar(255) DEFAULT NULL,
  KEY `fk_property` (`fk_property`),
  KEY `fk_cell` (`fk_cell`),
  CONSTRAINT `fk_property_cell_cell` FOREIGN KEY (`fk_cell`) REFERENCES `cell` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_property_cell_property` FOREIGN KEY (`fk_property`) REFERENCES `property` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Связь ячеек и свойств';



/*Data for the table `property_cell` */



 



/*Table structure for table `xmlda_item` */



DROP TABLE IF EXISTS `xmlda_item`;



CREATE TABLE `xmlda_item` (
  `fk_argument` varchar(255) NOT NULL,
  `name` varchar(1000) DEFAULT NULL,
  KEY `fk_argument` (`fk_argument`),
  CONSTRAINT `fk_item_argument` FOREIGN KEY (`fk_argument`) REFERENCES `argument` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='Связь OPC переменных и аргументов';



/*Data for the table `xmlda_item` */



 



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

