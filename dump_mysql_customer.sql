SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `customer` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `customer` ;

-- -----------------------------------------------------
-- Table `customer`.`status_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`status_type` ;

CREATE  TABLE IF NOT EXISTS `customer`.`status_type` (
  `st_id` VARCHAR(4) NOT NULL ,
  `st_name` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`st_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`zip_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`zip_code` ;

CREATE  TABLE IF NOT EXISTS `customer`.`zip_code` (
  `zc_code` VARCHAR(12) NOT NULL ,
  `zc_town` VARCHAR(80) NOT NULL ,
  `zc_div` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`zc_code`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`address` ;

CREATE  TABLE IF NOT EXISTS `customer`.`address` (
  `ad_id` INT NOT NULL ,
  `ad_line1` VARCHAR(80) NULL ,
  `ad_line2` VARCHAR(80) NULL ,
  `ad_zc_code` VARCHAR(12) NOT NULL ,
  `ad_ctry` VARCHAR(80) NULL ,
  PRIMARY KEY (`ad_id`) ,
  INDEX `fk_zip_code` (`ad_zc_code` ASC) ,
  CONSTRAINT `fk_zip_code`
    FOREIGN KEY (`ad_zc_code` )
    REFERENCES `customer`.`zip_code` (`zc_code` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`customer` ;

CREATE  TABLE IF NOT EXISTS `customer`.`customer` (
  `c_id` INT NOT NULL ,
  `c_tax_id` VARCHAR(20) NOT NULL ,
  `c_st_id` VARCHAR(4) NOT NULL ,
  `c_l_name` VARCHAR(25) NOT NULL ,
  `c_f_name` VARCHAR(20) NOT NULL ,
  `c_m_name` CHAR(1) NULL ,
  `c_gndr` CHAR(1) NULL ,
  `c_tier` ENUM('1','2','3') NOT NULL ,
  `c_dob` DATETIME NOT NULL ,
  `c_ad_id` INT NOT NULL ,
  `c_ctry_1` VARCHAR(3) NULL ,
  `c_area_1` VARCHAR(3) NULL ,
  `c_local_1` VARCHAR(10) NULL ,
  `c_ext_1` VARCHAR(5) NULL ,
  `c_ctry_2` VARCHAR(3) NULL ,
  `c_area_2` VARCHAR(3) NULL ,
  `c_local_2` VARCHAR(10) NULL ,
  `c_ext_2` VARCHAR(5) NULL ,
  `c_ctry_3` VARCHAR(3) NULL ,
  `c_area_3` VARCHAR(3) NULL ,
  `c_local_3` VARCHAR(10) NULL ,
  `c_ext_3` VARCHAR(5) NULL ,
  `c_email_1` VARCHAR(50) NULL ,
  `c_email_2` VARCHAR(50) NULL ,
  PRIMARY KEY (`c_id`) ,
  INDEX `fk_status_type` (`c_st_id` ASC) ,
  INDEX `fk_address` (`c_ad_id` ASC) ,
  CONSTRAINT `fk_status_type`
    FOREIGN KEY (`c_st_id` )
    REFERENCES `customer`.`status_type` (`st_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address`
    FOREIGN KEY (`c_ad_id` )
    REFERENCES `customer`.`address` (`ad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`broker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`broker` ;

CREATE  TABLE IF NOT EXISTS `customer`.`broker` (
  `b_id` INT NOT NULL ,
  `b_st_id` VARCHAR(4) NOT NULL ,
  `b_name` VARCHAR(49) NOT NULL ,
  `b_num_trades` INT(9) NOT NULL ,
  `b_comm_total` DOUBLE NOT NULL ,
  PRIMARY KEY (`b_id`) ,
  INDEX `fk_status_type` (`b_st_id` ASC) ,
  CONSTRAINT `fk_status_type`
    FOREIGN KEY (`b_st_id` )
    REFERENCES `customer`.`status_type` (`st_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`customer_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`customer_account` ;

CREATE  TABLE IF NOT EXISTS `customer`.`customer_account` (
  `ca_id` INT NOT NULL ,
  `ca_b_id` INT NOT NULL ,
  `ca_c_id` INT NOT NULL ,
  `ca_name` VARCHAR(50) NULL ,
  `ca_tax_st` ENUM('0','1','2') NOT NULL ,
  `ca_bal` DOUBLE NOT NULL ,
  PRIMARY KEY (`ca_id`) ,
  INDEX `fk_customer_ident` (`ca_c_id` ASC) ,
  INDEX `fk_broker` (`ca_b_id` ASC) ,
  CONSTRAINT `fk_customer_ident`
    FOREIGN KEY (`ca_c_id` )
    REFERENCES `customer`.`customer` (`c_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_broker`
    FOREIGN KEY (`ca_b_id` )
    REFERENCES `customer`.`broker` (`b_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`account_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`account_permission` ;

CREATE  TABLE IF NOT EXISTS `customer`.`account_permission` (
  `ap_ca_id` INT NOT NULL ,
  `ap_tax_id` VARCHAR(20) NOT NULL ,
  `ap_acl` VARCHAR(4) NOT NULL ,
  `ap_l_name` VARCHAR(25) NOT NULL ,
  `ap_f_name` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`ap_ca_id`, `ap_tax_id`) ,
  INDEX `fk_customer_account` (`ap_ca_id` ASC) ,
  CONSTRAINT `fk_customer_account`
    FOREIGN KEY (`ap_ca_id` )
    REFERENCES `customer`.`customer_account` (`ca_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`taxrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`taxrate` ;

CREATE  TABLE IF NOT EXISTS `customer`.`taxrate` (
  `tx_id` VARCHAR(4) NOT NULL ,
  `tx_name` VARCHAR(50) NOT NULL ,
  `tx_rate` DOUBLE NOT NULL ,
  PRIMARY KEY (`tx_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`customer_taxrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`customer_taxrate` ;

CREATE  TABLE IF NOT EXISTS `customer`.`customer_taxrate` (
  `cx_tx_id` VARCHAR(4) NOT NULL ,
  `cx_c_id` INT NOT NULL ,
  PRIMARY KEY (`cx_tx_id`, `cx_c_id`) ,
  INDEX `fk_customer_ident` (`cx_c_id` ASC) ,
  INDEX `fk_taxrate` (`cx_tx_id` ASC) ,
  CONSTRAINT `fk_customer_ident`
    FOREIGN KEY (`cx_c_id` )
    REFERENCES `customer`.`customer` (`c_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxrate`
    FOREIGN KEY (`cx_tx_id` )
    REFERENCES `customer`.`taxrate` (`tx_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`watch_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`watch_list` ;

CREATE  TABLE IF NOT EXISTS `customer`.`watch_list` (
  `wl_id` INT NOT NULL ,
  `wl_c_id` INT NOT NULL ,
  PRIMARY KEY (`wl_id`) ,
  INDEX `fk_customer_ident` (`wl_c_id` ASC) ,
  CONSTRAINT `fk_customer_ident`
    FOREIGN KEY (`wl_c_id` )
    REFERENCES `customer`.`customer` (`c_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`exchange`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`exchange` ;

CREATE  TABLE IF NOT EXISTS `customer`.`exchange` (
  `ex_id` VARCHAR(6) NOT NULL ,
  `ex_name` VARCHAR(100) NOT NULL ,
  `ex_num_symb` INT(6) NOT NULL ,
  `ex_open` INT(4) NOT NULL ,
  `ex_close` INT(4) NOT NULL ,
  `ex_desc` VARCHAR(150) NOT NULL ,
  `ex_ad_id` INT NOT NULL ,
  PRIMARY KEY (`ex_id`) ,
  INDEX `fk_address` (`ex_ad_id` ASC) ,
  CONSTRAINT `fk_address`
    FOREIGN KEY (`ex_ad_id` )
    REFERENCES `customer`.`address` (`ad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`sector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`sector` ;

CREATE  TABLE IF NOT EXISTS `customer`.`sector` (
  `sc_id` VARCHAR(2) NOT NULL ,
  `sc_name` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`sc_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`industry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`industry` ;

CREATE  TABLE IF NOT EXISTS `customer`.`industry` (
  `in_id` VARCHAR(2) NOT NULL ,
  `in_name` VARCHAR(50) NOT NULL ,
  `in_sc_id` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`in_id`) ,
  INDEX `fk_sector` (`in_sc_id` ASC) ,
  CONSTRAINT `fk_sector`
    FOREIGN KEY (`in_sc_id` )
    REFERENCES `customer`.`sector` (`sc_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`company` ;

CREATE  TABLE IF NOT EXISTS `customer`.`company` (
  `co_id` INT NOT NULL ,
  `co_st_id` VARCHAR(4) NOT NULL ,
  `co_name` VARCHAR(60) NOT NULL ,
  `co_in_id` VARCHAR(2) NOT NULL ,
  `co_sp_rate` VARCHAR(4) NOT NULL ,
  `co_ceo` VARCHAR(46) NOT NULL ,
  `co_ad_id` INT NOT NULL ,
  `co_desc` VARCHAR(150) NOT NULL ,
  `co_open_date` DATETIME NOT NULL ,
  PRIMARY KEY (`co_id`) ,
  INDEX `fk_status_type` (`co_st_id` ASC) ,
  INDEX `fk_address` (`co_ad_id` ASC) ,
  INDEX `fk_industry` (`co_in_id` ASC) ,
  CONSTRAINT `fk_status_type`
    FOREIGN KEY (`co_st_id` )
    REFERENCES `customer`.`status_type` (`st_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address`
    FOREIGN KEY (`co_ad_id` )
    REFERENCES `customer`.`address` (`ad_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_industry`
    FOREIGN KEY (`co_in_id` )
    REFERENCES `customer`.`industry` (`in_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`security`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`security` ;

CREATE  TABLE IF NOT EXISTS `customer`.`security` (
  `s_symb` VARCHAR(15) NOT NULL ,
  `s_issue` VARCHAR(6) NOT NULL ,
  `s_st_id` VARCHAR(4) NOT NULL ,
  `s_name` VARCHAR(70) NOT NULL ,
  `s_ex_id` VARCHAR(6) NOT NULL ,
  `s_co_id` INT NOT NULL ,
  `s_num_out` INT NOT NULL ,
  `s_start_date` DATETIME NOT NULL ,
  `s_exch_date` DATETIME NOT NULL ,
  `s_pe` DOUBLE NOT NULL ,
  `s_52_wk_high` DOUBLE NOT NULL ,
  `s_52_wk_high_date` DATETIME NOT NULL ,
  `s_52_wk_low` DOUBLE NOT NULL ,
  `s_52_wk_low_date` DATETIME NOT NULL ,
  `s_dividend` DOUBLE NOT NULL ,
  `securitycol` VARCHAR(45) NOT NULL ,
  `securitycol1` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`s_symb`) ,
  INDEX `fk_status_type` (`s_st_id` ASC) ,
  INDEX `fk_exchange` (`s_ex_id` ASC) ,
  INDEX `fk_company` (`s_co_id` ASC) ,
  CONSTRAINT `fk_status_type`
    FOREIGN KEY (`s_st_id` )
    REFERENCES `customer`.`status_type` (`st_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exchange`
    FOREIGN KEY (`s_ex_id` )
    REFERENCES `customer`.`exchange` (`ex_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company`
    FOREIGN KEY (`s_co_id` )
    REFERENCES `customer`.`company` (`co_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`.`watch_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer`.`watch_item` ;

CREATE  TABLE IF NOT EXISTS `customer`.`watch_item` (
  `wi_wl_id` INT NOT NULL ,
  `wi_s_symb` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`wi_wl_id`) ,
  INDEX `fk_watch_list` (`wi_wl_id` ASC) ,
  INDEX `fk_security` (`wi_s_symb` ASC) ,
  CONSTRAINT `fk_watch_list`
    FOREIGN KEY (`wi_wl_id` )
    REFERENCES `customer`.`watch_list` (`wl_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security`
    FOREIGN KEY (`wi_s_symb` )
    REFERENCES `customer`.`security` (`s_symb` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
