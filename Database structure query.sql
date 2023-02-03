-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blockbuster` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `blockbuster` ;

-- -----------------------------------------------------
-- Table `blockbuster`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`actor` (
  `actor_id` INT NOT NULL,
  `first_name` VARCHAR(100) NULL DEFAULT NULL,
  `last_name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`language` (
  `language_id` INT NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`film` (
  `film_id` INT NOT NULL,
  `title` VARCHAR(100) NULL DEFAULT NULL,
  `description` VARCHAR(1000) NULL DEFAULT NULL,
  `rental_duration` VARCHAR(100) NULL DEFAULT NULL,
  `rental_rate` VARCHAR(100) NULL DEFAULT NULL,
  `length` VARCHAR(100) NULL DEFAULT NULL,
  `replacement_cost` VARCHAR(100) NULL DEFAULT NULL,
  `rating` VARCHAR(100) NULL DEFAULT NULL,
  `special_features.deleted_scenes` CHAR(1) NULL DEFAULT NULL,
  `special_features.commentaries` CHAR(1) NULL DEFAULT NULL,
  `special_features.behind_the_scenes` CHAR(1) NULL DEFAULT NULL,
  `special_features.trailers` CHAR(1) NULL DEFAULT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`film_id`, `language_id`),
  INDEX `fk_film_language1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `blockbuster`.`language` (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`inventory` (
  `inventory_id` INT NOT NULL,
  `store_id` VARCHAR(45) NULL DEFAULT NULL,
  `film_id` INT NOT NULL,
  PRIMARY KEY (`inventory_id`, `film_id`),
  INDEX `fk_inventory_film1_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`old_hdd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`old_hdd` (
  `actor_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`actor_id`, `film_id`, `category_id`),
  INDEX `fk_actor_has_film_film1_idx` (`film_id` ASC) VISIBLE,
  INDEX `fk_actor_has_film_actor_idx` (`actor_id` ASC) VISIBLE,
  INDEX `fk_old_hdd_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_actor_has_film_actor`
    FOREIGN KEY (`actor_id`)
    REFERENCES `blockbuster`.`actor` (`actor_id`),
  CONSTRAINT `fk_actor_has_film_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`film_id`),
  CONSTRAINT `fk_old_hdd_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `blockbuster`.`category` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`rental` (
  `rental_id` INT NOT NULL,
  `rental_date` VARCHAR(45) NULL DEFAULT NULL,
  `customer_id` VARCHAR(45) NOT NULL,
  `return_date` VARCHAR(45) NULL DEFAULT NULL,
  `staff_id` VARCHAR(45) NULL DEFAULT NULL,
  `inventory_id` INT NOT NULL,
  `rental_time` VARCHAR(45) NULL,
  `days_rented` VARCHAR(45) NULL,
  PRIMARY KEY (`rental_id`, `customer_id`, `inventory_id`),
  INDEX `fk_rental_inventory1_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_inventory1`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `blockbuster`.`inventory` (`inventory_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
