-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema social_network
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema social_network
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `social_network` DEFAULT CHARACTER SET utf8 ;
USE `social_network` ;

-- -----------------------------------------------------
-- Table `social_network`.`MESSAGE_STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social_network`.`MESSAGE_STATUS` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_network`.`USER_STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social_network`.`USER_STATUS` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_network`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social_network`.`USER` (
  `id` INT NOT NULL,
  `mail` VARCHAR(255) NOT NULL,
  `passwd` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `status_user_fk_idx` (`status` ASC),
  CONSTRAINT `status_user_fk`
    FOREIGN KEY (`status`)
    REFERENCES `social_network`.`USER_STATUS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_network`.`USERS_RELATIONSHIPS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social_network`.`USERS_RELATIONSHIPS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner_id` INT NOT NULL,
  `friend_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`owner_id` ASC),
  INDEX `friend_relationship_fk_idx` (`friend_id` ASC),
  INDEX `status_relationship_fk_idx` (`status` ASC),
  CONSTRAINT `owner_relationship_fk`
    FOREIGN KEY (`owner_id`)
    REFERENCES `social_network`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `friend_relationship_fk`
    FOREIGN KEY (`friend_id`)
    REFERENCES `social_network`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_relationship_fk`
    FOREIGN KEY (`status`)
    REFERENCES `social_network`.`USER_STATUS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_network`.`MESSAGES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social_network`.`MESSAGES` (
  `id` INT NOT NULL,
  `owner_id` INT NULL,
  `status` INT NULL,
  `message` LONGTEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `recipient_id` INT NULL,
  `authorization` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `owner_message_fk_idx` (`owner_id` ASC),
  INDEX `recipient_message_fk_idx` (`recipient_id` ASC),
  INDEX `status_message_fk_idx` (`status` ASC),
  CONSTRAINT `owner_message_fk`
    FOREIGN KEY (`owner_id`)
    REFERENCES `social_network`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `recipient_message_fk`
    FOREIGN KEY (`recipient_id`)
    REFERENCES `social_network`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_message_fk`
    FOREIGN KEY (`status`)
    REFERENCES `social_network`.`MESSAGE_STATUS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_network`.`REPLIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `social_network`.`REPLIES` (
  `id` INT NOT NULL,
  `owner_id` INT NULL,
  `recipient_id` INT NULL,
  `status` INT NULL,
  `authorization` INT NULL,
  `message` LONGTEXT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `message_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `owner_reply_fk_idx` (`owner_id` ASC),
  INDEX `recipient_reply_fk_idx` (`recipient_id` ASC),
  INDEX `status_reply_fk_idx` (`status` ASC),
  INDEX `message_reply_fk_idx` (`message_id` ASC),
  CONSTRAINT `owner_reply_fk`
    FOREIGN KEY (`owner_id`)
    REFERENCES `social_network`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `recipient_reply_fk`
    FOREIGN KEY (`recipient_id`)
    REFERENCES `social_network`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_reply_fk`
    FOREIGN KEY (`status`)
    REFERENCES `social_network`.`MESSAGE_STATUS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `message_reply_fk`
    FOREIGN KEY (`message_id`)
    REFERENCES `social_network`.`MESSAGES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE USER 'sf4' IDENTIFIED BY 'sf4';

GRANT SELECT ON TABLE `social_network`.* TO 'sf4';
GRANT SELECT, INSERT, TRIGGER ON TABLE `social_network`.* TO 'sf4';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `social_network`.* TO 'sf4';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
