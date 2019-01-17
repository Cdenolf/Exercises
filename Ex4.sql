-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Ex4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Ex4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ex4` ;
USE `Ex4` ;

-- -----------------------------------------------------
-- Table `Ex4`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Students` (
  `Student_Number` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Birth_Date` VARCHAR(45) NULL,
  `Sex` ENUM("M", "F") NULL,
  `Trajectory_id` INT(11) NOT NULL,
  PRIMARY KEY (`Student_Number`),
  UNIQUE INDEX `Trajectory_id_UNIQUE` (`Trajectory_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Course_of_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Course_of_student` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Student_id` INT(11) NOT NULL,
  `Course_id` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Course_of_student_1_idx` (`Student_id` ASC) VISIBLE,
  UNIQUE INDEX `Student_id_UNIQUE` (`Student_id` ASC) VISIBLE,
  UNIQUE INDEX `Course_id_UNIQUE` (`Course_id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_of_student_1`
    FOREIGN KEY (`Student_id`)
    REFERENCES `Ex4`.`Students` (`Student_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Trajectories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Trajectories` (
  `Tr_id` INT(11) NOT NULL,
  `Trajectory` VARCHAR(45) NULL,
  CONSTRAINT `fk_Trajectories_1`
    FOREIGN KEY (`Tr_id`)
    REFERENCES `Ex4`.`Students` (`Trajectory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Courses` (
  `ID` INT NOT NULL,
  `Course` VARCHAR(45) NULL,
  `Credits` INT(10) NULL,
  CONSTRAINT `FK1`
    FOREIGN KEY (`ID`)
    REFERENCES `Ex4`.`Course_of_student` (`Course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Doctor` (
  `idDoctor` INT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT(12) UNSIGNED NULL,
  `Salary` INT(12) UNSIGNED NULL,
  PRIMARY KEY (`idDoctor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Medical` (
  `idMedical` INT(12) NOT NULL,
  `Overtime_rate` INT NULL,
  PRIMARY KEY (`idMedical`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Specialist` (
  `idSpecialist` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  `Doctor_id` INT(12) NOT NULL,
  `Overtime_id` INT(12) NOT NULL,
  PRIMARY KEY (`idSpecialist`),
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `Overtime_id_UNIQUE` (`Overtime_id` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_1`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `Ex4`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Specialist_2`
    FOREIGN KEY (`Overtime_id`)
    REFERENCES `Ex4`.`Medical` (`idMedical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`idPatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Date` DATE NULL,
  `Time` VARCHAR(45) NULL,
  `Doctor_id` INT(12) NOT NULL,
  `Patient_id` INT(12) NOT NULL,
  PRIMARY KEY (`idAppointment`),
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_1`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `Ex4`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_2`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `Ex4`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Payment` (
  `idPayment` INT(12) NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` ENUM("Cash", "Debit", "Credit") NULL,
  PRIMARY KEY (`idPayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Bill` (
  `idBill` INT(12) NOT NULL,
  `Total` INT NULL,
  `Doctor_id` INT(12) NOT NULL,
  PRIMARY KEY (`idBill`),
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_1`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `Ex4`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ex4`.`Crossref_payment_bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ex4`.`Crossref_payment_bill` (
  `idCrossref_payment_bill` INT NOT NULL,
  `Payment_id` INT(12) NOT NULL,
  `Bill_id` INT(12) NOT NULL,
  PRIMARY KEY (`idCrossref_payment_bill`),
  UNIQUE INDEX `Payment_id_UNIQUE` (`Payment_id` ASC) VISIBLE,
  UNIQUE INDEX `Bill_id_UNIQUE` (`Bill_id` ASC) VISIBLE,
  CONSTRAINT `fk_Crossref_payment_bill_1`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `Ex4`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Crossref_payment_bill_2`
    FOREIGN KEY (`Bill_id`)
    REFERENCES `Ex4`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
