
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8 ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `patients`
-- Hold information about patients, 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patients` (
  `patient_id` INT AUTO_INCREMENT NOT NULL ,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `age` INT UNSIGNED NOT NULL,
  `sex` VARCHAR(45) NOT NULL,
  `patient_history` VARCHAR(255) NULL,
  PRIMARY KEY (`patient_id`),
  CONSTRAINT Unique_Patient_Email UNIQUE (first_name,last_name,email))
ENGINE = InnoDB;

INSERT INTO patients (first_name, last_name, email, phone_number, age, sex)
VALUES("Joy", "George", "jayg@gmail.com", "234-976-321", 32, "female" );
INSERT INTO patients (first_name, last_name, email, phone_number, age, sex)
VALUES("Dan", "Ojo", "dojo@gmail.com", "234-297-324", 39, "male" );
SELECT * FROM patients;


-- -----------------------------------------------------
-- Table `physicians`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `physicians` (
  `physician_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `sex` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `specialty` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`physician_id`),
  CONSTRAINT Unique_Physician_Email UNIQUE (first_name,last_name,email))
ENGINE = InnoDB;

INSERT INTO physicians (physician_id, first_name, last_name, age, sex, phone, email, specialty)
VALUES (1, "Sam", "John", 50 , "male", "234-890-234" ,"samjo@yahoo.com","Dentist" );
INSERT INTO physicians (physician_id, first_name, last_name, age, sex, phone, email, specialty)
VALUES (2, "Ngozi", "Ibe", 33 , "female", "234-777-211" ,"ngi@yahoo.com","GP" );
SELECT * FROM physicians;

drop table prescription_total;
-- -----------------------------------------------------
-- Table `prescription_total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prescription_total` (
  `prescription_total_id` INT AUTO_INCREMENT NOT NULL,
  `patient_patient_id` INT NOT NULL,
  `physicians_physician_id` INT NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `date_time` DATETIME NOT NULL,
  `discount_percent` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`prescription_total_id`),
  CONSTRAINT `fk_prescription_patient1`
    FOREIGN KEY (`patient_patient_id`)
    REFERENCES `patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_physicians1`
    FOREIGN KEY (`physicians_physician_id`)
    REFERENCES `physicians` (`physician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO prescription_total (patient_patient_id,physicians_physician_id,total,date_time,discount_percent)
VALUE (1,2,10.2, "2022-03-30 14:59:36",20);
INSERT INTO prescription_total (patient_patient_id,physicians_physician_id,total,date_time,discount_percent)
VALUE (2,1,15, "2022-03-31 14:59:36",0);
SELECT * FROM prescription_total;

-- -----------------------------------------------------
-- Table `appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appointments` (
  `appointment_id` INT AUTO_INCREMENT NOT NULL,
  `patient_patient_id` INT NOT NULL,
  `physicians_physician_id` INT NOT NULL,
  `time_start` DATETIME NOT NULL,
  `time_end` DATETIME NOT NULL,
  PRIMARY KEY (`appointment_id`),
  CONSTRAINT `fk_appointments_patient`
    FOREIGN KEY (`patient_patient_id`)
    REFERENCES `patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointments_physicians1`
    FOREIGN KEY (`physicians_physician_id`)
    REFERENCES `physicians` (`physician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT CHK_DATETIME CHECK (time_start < time_end))
ENGINE = InnoDB;

INSERT INTO appointments (patient_patient_id, physicians_physician_id, time_start, time_end)
VALUES (2,2,"2022-03-30 14:29:36", "2022-03-30 14:59:36" );
INSERT INTO appointments (patient_patient_id, physicians_physician_id, time_start, time_end)
VALUES (1,1,"2022-03-29 12:29:36", "2022-03-29 13:59:36" );
SELECT * FROM appointments;


-- -----------------------------------------------------
-- Table `drugs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugs` (
  `drug_id` INT AUTO_INCREMENT NOT NULL,
  `drug_name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `dosage_form` VARCHAR(45) NULL,
  `route_of_admission` VARCHAR(45) NULL,
  `strength` VARCHAR(45) NULL,
  PRIMARY KEY (`drug_id`))
ENGINE = InnoDB;

INSERT INTO drugs (drug_name, price, dosage_form, route_of_admission, strength)
VALUES ("Flagyl", 10.05, "100mg", "Perscribed", "Effective" );
INSERT INTO drugs (drug_name, price, dosage_form, route_of_admission, strength)
VALUES ("Cough Syrup", 20.5, "50mg", "Requested", "Drowsy" );
SELECT * FROM drugs;

-- -----------------------------------------------------
-- Table `ambulances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ambulances` (
  `ambulance_id` INT NOT NULL,
  `is_available` TINYTEXT NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `liscense_plate` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ambulance_id`))
ENGINE = InnoDB;

INSERT INTO ambulances (ambulance_id, is_available, model, liscense_plate, phone_number)
VALUES (1,"Yes", "Hiace", "CA-123-ON","234-366-098");
INSERT INTO ambulances (ambulance_id, is_available, model, liscense_plate, phone_number)
VALUES (2,"No", "Honda", "CA-942-OT","234-987-012");
SELECT * FROM ambulances;

-- -----------------------------------------------------
-- Table `payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payments` (
  `paymentd_id` INT AUTO_INCREMENT NOT NULL,
  `payment_method_name` VARCHAR(45) NOT NULL,
  `prescription_total_prescription_total_id` INT NOT NULL,
  `date_time` DATETIME NOT NULL,
  `amount_paid` DECIMAL(10,2) NULL,
  PRIMARY KEY (`paymentd_id`),
  CONSTRAINT `fk_payments_prescription_total1`
    FOREIGN KEY (`prescription_total_prescription_total_id`)
    REFERENCES `prescription_total` (`prescription_total_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO payments (payment_method_name,prescription_total_prescription_total_id,date_time,amount_paid)
VALUES ("Credit card",1,"2022-03-30 14:59:36",10.2);
INSERT INTO payments (payment_method_name,prescription_total_prescription_total_id,date_time,amount_paid)
VALUES ("Cash",2,"2022-03-31 14:59:36",12);
SELECT * FROM payments;

-- -----------------------------------------------------
-- Table `emergency_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `emergency_services` (
  `emergency_services_id` INT AUTO_INCREMENT NOT NULL,
  `patients_patient_id` INT NOT NULL,
  `ambulances_ambulance_id` INT NOT NULL,
  `date_time` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`emergency_services_id`),
  CONSTRAINT `fk_emergency_services_patients1`
    FOREIGN KEY (`patients_patient_id`)
    REFERENCES `patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emergency_services_ambulances1`
    FOREIGN KEY (`ambulances_ambulance_id`)
    REFERENCES `ambulances` (`ambulance_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO emergency_services (patients_patient_id,ambulances_ambulance_id,date_time,address)
VALUE (1,1,'2022-03-30 14:59:36','11 Richmond Road');
INSERT INTO emergency_services (patients_patient_id,ambulances_ambulance_id,date_time,address)
VALUE (1,1,'2022-03-28 14:59:36','12 Richmond Road');
SELECT * FROM emergency_services;

drop table prescriptions;
-- -----------------------------------------------------
-- Table `prescriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prescriptions` (
  `prescription_id` INT AUTO_INCREMENT NOT NULL,
  `prescription_prescription_id` INT NOT NULL,
  `drugs_drug_id` INT NOT NULL,
  `amount` INT UNSIGNED NOT NULL,
  `amount_per_day` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`prescription_id`),
  CONSTRAINT `fk_prescriptions_prescription1`
    FOREIGN KEY (`prescription_prescription_id`)
    REFERENCES `prescription_total` (`prescription_total_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescriptions_drugs1`
    FOREIGN KEY (`drugs_drug_id`)
    REFERENCES `drugs` (`drug_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT CHK_Amount CHECK (amount > amount_per_day))
ENGINE = InnoDB;

INSERT INTO prescriptions (prescription_prescription_id,drugs_drug_id,amount,amount_per_day)
VALUES (1,1,12,3);
INSERT INTO prescriptions (prescription_prescription_id,drugs_drug_id,amount,amount_per_day)
VALUES (1,2,4,1);
SELECT * FROM prescriptions;

-- -----------------------------------------------------
-- Table `treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treatment` (
  `treatment_id` INT AUTO_INCREMENT NOT NULL,
  `patients_patient_id` INT NOT NULL,
  `physicians_physician_id` INT NOT NULL,
  `reasons` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`treatment_id`),
  CONSTRAINT `fk_treatment_patients1`
    FOREIGN KEY (`patients_patient_id`)
    REFERENCES `patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_treatment_physicians1`
    FOREIGN KEY (`physicians_physician_id`)
    REFERENCES `physicians` (`physician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO treatment (patients_patient_id,physicians_physician_id,reasons,description)
VALUES (1,2,"Foot pain","Patient came in with a serve pain in her foot");
INSERT INTO treatment (patients_patient_id,physicians_physician_id,reasons,description)
VALUES (2,1,"Eye pain","Patient's eyes have sign of discoloration");
SELECT * FROM treatment;
