-- DATABASE CREATE
DROP DATABASE IF EXISTS `project`;
CREATE DATABASE `project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

-- DATABASE USE

use project;

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';
flush privileges;

-- TABLES CREATE

CREATE TABLE `patient` (
  `p_name` varchar(15) NOT NULL,
  `p_gend` varchar(10) NOT NULL,
  `age` int NOT NULL,
  `address` varchar(45) NOT NULL,
  `p_id` int NOT NULL AUTO_INCREMENT,
  `p_pwd` varchar(10) NOT NULL,
  `p_mail` varchar(45) NOT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `doctor` (
  `d_name` varchar(15) NOT NULL,
  `d_gend` varchar(10) NOT NULL,
  `spec` varchar(15) NOT NULL,
  `d_id` int NOT NULL AUTO_INCREMENT,
  `d_pwd` varchar(10) NOT NULL,
  `d_mail` varchar(45) NOT NULL,
  `d_stat` varchar(5) DEFAULT 'Yes',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `room` (
  `room_no` int NOT NULL AUTO_INCREMENT,
  `r_stat` varchar(5) DEFAULT 'Yes',
  PRIMARY KEY (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `appointment` (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `a_dt` date NOT NULL,
  `a_tm` int NOT NULL,
  `p_id` int DEFAULT NULL,
  `d_id` int DEFAULT NULL,
  `room_no` int NOT NULL,
  PRIMARY KEY (`a_id`),
  UNIQUE KEY `a_UNIQUE` (`a_dt`,`a_tm`,`room_no`) /*!80000 INVISIBLE */,
  UNIQUE KEY `a_UNIQUE1` (`a_dt`,`a_tm`,`d_id`),
  KEY `p_id_idx` (`p_id`),
  KEY `d_id_idx` (`d_id`),
  KEY `clinic_no_idx` (`room_no`),
  CONSTRAINT `p_id` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`),
  CONSTRAINT `room_no` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `medical_info` (
  `medical_conditions` varchar(45) NOT NULL,
  PRIMARY KEY (`medical_conditions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `medrecords` (
  `p_id` int NOT NULL,
  `bgrp` varchar(3) NOT NULL,
  `vacc` int DEFAULT NULL,
  `medications` varchar(3) NOT NULL,
  `medical_conditions` varchar(45) NOT NULL,
  PRIMARY KEY (`medical_conditions`,`p_id`),
  KEY `p_id_mr_idx` (`p_id`),
  CONSTRAINT `mr_medicond` FOREIGN KEY (`medical_conditions`) REFERENCES `medical_info` (`medical_conditions`),
  CONSTRAINT `p_id_mr` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `bill` (
  `b_id` int NOT NULL AUTO_INCREMENT,
  `amount` int NOT NULL,
  `d_id` int DEFAULT NULL,
  PRIMARY KEY (`b_id`),
  KEY `d_id_bill_idx` (`d_id`),
  CONSTRAINT `d_id_bill` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `staff` (
  `s_id` int NOT NULL AUTO_INCREMENT,
  `room_no` int DEFAULT NULL,
  `s_type` varchar(10) NOT NULL,
  `s_name` varchar(45) NOT NULL,
  PRIMARY KEY (`s_id`),
  KEY `room_no_s_idx` (`room_no`),
  CONSTRAINT `room_no_s` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `admin` (
  `admin_username` varchar(45) NOT NULL,
  `admin_pwd` varchar(45) NOT NULL,
  PRIMARY KEY (`admin_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- SPECIFIC UPDATE QUERIES

-- Patient wants to update his email-id and password details.
/*
UPDATE `project`.`patient`
SET
`p_pwd` = input_password,
`p_mail` = input_mail
WHERE `p_id` = input_patient_ID;
*/

-- Doctor wants to update his email-id and password details.
/*
UPDATE `project`.`doctor`
SET
`d_pwd` = input_password,
`d_mail` = input_mail
WHERE `d_id` = input_doctor_ID;
*/

-- Staff’s allotted room needs to be changed. 
/*
UPDATE `project`.`staff`
SET
`room_no` = updated_room
WHERE `s_id` = input_staff_ID;
*/

-- A patient needs to reschedule his appointment.
/*
UPDATE `project`.`appointment`
SET
`a_dt` = new_date,
`a_tm` = new_time
WHERE `a_id` = input_appointment_ID;
*/

-- Doctor needs to add medicine charges to consultation fees to update the billing amount.
/*
UPDATE `project`.`bill`
SET
`amount` = new_amount
WHERE `b_id` = input_bill_ID; 
*/

-- Admin wants to update room status to available
/*
UPDATE `project`.`room`
SET
`r_stat` = new_status
WHERE `room_no` = input_room_no;
*/

-- SPECIFIC DELETE QUERIES

 
-- The admin needs to delete doctors entry, giving the doctor ID
/*
DELETE FROM `project`.`doctor`
WHERE `project`.`doctor`.`d_id` = input_doctor_ID;
*/
-- A patient wants to cancel his appointment
-- on that date, at that time, with the respective patient ID
/*
DELETE FROM `project`.`appointment`
WHERE `project`.`appointment`.`a_dt` = input_date 
AND `project`.`appointment`.`a_tm` = input_tm
AND `project`.`appointment`.`p_id` = input_patient_ID;
*/

-- Admin wants to delete a room, because it would not be available
/*
DELETE FROM `project`.`room`
WHERE `project`.`room`.`room_no` = input_room_no;
*/

-- The admin wants to delete entry of this particular staff member.
/*
DELETE FROM `project`.`staff`
WHERE `project`.`staff`.`s_id` = input_staff_ID;
*/

-- QUERIES

-- Query to find all available rooms for appointments

SELECT room_no,r_stat
FROM room
WHERE r_stat='yes';


-- Query to find the number of doctors available for each specializations

SELECT spec as 'Specialization', count(d_id) as 'No. of Doctors'
FROM doctor
GROUP BY spec;


-- VIEWS

-- View to get a table of mail and password details of registered patients

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project`.`p_login` AS
    SELECT 
        `project`.`patient`.`p_mail` AS `p_mail`,
        `project`.`patient`.`p_pwd` AS `p_pwd`
    FROM
        `project`.`patient`
    ORDER BY `project`.`patient`.`p_id`;

-- View to get a table of mail and password details of registered doctors

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project`.`d_login` AS
    SELECT 
        `project`.`doctor`.`d_mail` AS `d_mail`,
        `project`.`doctor`.`d_pwd` AS `d_pwd`
    FROM
        `project`.`doctor`
    ORDER BY `project`.`doctor`.`d_id`;

-- View to get a table of availabilty of doctors with their specialization and status

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `doc_status` AS
    SELECT 
        `d`.`d_id` AS `d_id`,
        `d`.`d_name` AS `d_name`,
        `d`.`spec` AS `spec`,
        `a`.`a_id` AS `a_id`,
        `d`.`d_stat` AS `d_stat`
    FROM
        (`doctor` `d`
        LEFT JOIN `appointment` `a` ON ((`d`.`d_id` = `a`.`d_id`)))
    ORDER BY `d`.`d_id`;

-- View to get a table of vaccination status of all registered patients

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project`.`vacc_status` AS
    SELECT 
        `p`.`p_id` AS `p_id`,
        `p`.`p_name` AS `p_name`,
        `p`.`p_gend` AS `p_gend`,
        `p`.`age` AS `age`,
        `mr`.`vacc` AS `Vaccination Status`,
        `mr`.`bgrp` AS `bgrp`
    FROM
        (`project`.`patient` `p`
        JOIN `project`.`medrecords` `mr` ON ((`p`.`p_id` = `mr`.`p_id`)))
    WHERE
        (`mr`.`vacc` IN (1 , 2))
    ORDER BY `p`.`p_id`;
    
    
-- View to get a table of all patients, doctors associated with a room

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `room_work` AS
    SELECT 
        `s`.`room_no` AS `room_no`,
        `a`.`p_id` AS `p_id`,
        `p`.`p_name` AS `p_name`,
        `a`.`d_id` AS `d_id`,
        `d`.`d_name` AS `d_name`,
        `s`.`s_id` AS `s_id`,
        `s`.`s_name` AS `s_name`,
        `s`.`s_type` AS `s_type`
    FROM
        (((`appointment` `a`
        JOIN `staff` `s` ON ((`a`.`room_no` = `s`.`room_no`)))
        JOIN `patient` `p` ON ((`p`.`p_id` = `a`.`p_id`)))
        JOIN `doctor` `d` ON ((`d`.`d_id` = `a`.`d_id`)))
    ORDER BY `a`.`room_no`;


-- View to get a table of all bills, corresponding patient, doctor and appointment details

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `bills` AS
    SELECT 
        `b`.`b_id` AS `b_id`,
        `p`.`p_id` AS `p_id`,
        `p`.`p_name` AS `p_name`,
        `d`.`d_id` AS `d_id`,
        `d`.`d_name` AS `d_name`,
        `a`.`a_dt` AS `a_dt`,
        `a`.`a_tm` AS `a_tm`,
        `b`.`amount` AS `amount`
    FROM
        (((`bill` `b`
        JOIN `doctor` `d` ON ((`b`.`d_id` = `d`.`d_id`)))
        JOIN `appointment` `a` ON ((`a`.`d_id` = `d`.`d_id`)))
        JOIN `patient` `p` ON ((`a`.`p_id` = `p`.`p_id`)));


-- PROCEDURES

-- To insert an appointment

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `a_insert`(IN adt DATE, IN atm INT, IN pid INT, IN did INT, IN rno INT)
BEGIN
INSERT INTO `project`.`appointment`
(
`a_dt`,
`a_tm`,
`p_id`,
`d_id`,
`room_no`)
VALUES
(adt,atm,pid,did,rno);
END$$
DELIMITER ;


-- To insert a bill

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bill_insert`(IN amt INT, IN did INT)
BEGIN
INSERT INTO `project`.`bill`
(
`amount`,
`d_id`)
VALUES
(amt,did);
END$$
DELIMITER ;

-- To insert a doctor

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `d_insert`(IN dname VARCHAR(15), IN dgender VARCHAR(10), IN spec VARCHAR(15), IN dpwd VARCHAR(10), IN dmail VARCHAR(45))
BEGIN
INSERT INTO `project`.`doctor`
(`d_name`,
`d_gend`,
`spec`,
`d_pwd`,
`d_mail`)
VALUES
(dname,dgender,spec,dpwd,dmail);
END$$
DELIMITER ;

-- To insert a patient

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insert`(IN pname VARCHAR(15), IN pgender VARCHAR(10), IN age INT, IN paddr VARCHAR(45), IN ppwd VARCHAR(10),IN pmail VARCHAR(45))
BEGIN
INSERT INTO `project`.`patient`
(`p_name`,
`p_gend`,
`age`,
`address`,
`p_pwd`,
`p_mail`
)
VALUES
(pname,pgender,age,paddr,ppwd,pmail);
END$$
DELIMITER ;

-- To insert a room

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `room_insert`(IN rno INT, IN rstat VARCHAR(5))
BEGIN
INSERT INTO `project`.`room`
(`room_no`,
`r_stat`)
VALUES
(rno,rstat);

END$$
DELIMITER ;

-- To insert a staff member

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `s_insert`(IN rno INT, IN stype VARCHAR(10), IN sname VARCHAR(45))
BEGIN
INSERT INTO `project`.`staff`
(
`room_no`,
`s_type`,
`s_name`)
VALUES
(rno,stype,sname);

END$$
DELIMITER ;

-- To insert medical record for a patient

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `medrec_insert`(IN pid INT, IN bg VARCHAR(3), IN vacc INT, IN medic VARCHAR(3), IN medcond VARCHAR(45))
BEGIN
INSERT INTO `project`.`medrecords`
(`p_id`,
`bgrp`,
`vacc`,
`medications`,
`medical_conditions`)
VALUES
(pid,bg,vacc,medic,medcond);


END$$
DELIMITER ;


-- To insert a medical info

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `medinfo_insert`(IN medcond VARCHAR(45))
BEGIN
INSERT INTO `project`.`medical_info`
(`medical_conditions`)
VALUES
(medcond);

END$$
DELIMITER ;


-- Procedure to get a list of doctors of a particular input specialization and their details and status

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `choose_doc_spec`(IN dspec VARCHAR(15))
BEGIN
SELECT distinct(d_id), d_name, d_gend, spec, d_stat
FROM doctor
WHERE d_stat='yes'
AND dspec=spec;
END$$
DELIMITER ;


-- Procedure to get a list of previous appointments with the respective patient and doctor

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `previous_appointments`(IN pid INT, IN did INT)
BEGIN
SELECT a_dt,a_tm,p_id,d_id,room_no
FROM appointment
WHERE p_id=pid
AND d_id=did
ORDER BY a_id ASC;
END$$
DELIMITER ;



-- Procedure to find the history of that patient with different specialization doctors in our hospital 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `hosp_patient_hist`(IN pid INT)
BEGIN
SELECT p.p_id, p.p_name, d.d_id, d.d_name, d.spec, a.a_dt, a.a_tm
FROM patient p join appointment a join doctor d
ON p.p_id=a.p_id and d.d_id=a.d_id
WHERE p.p_id=pid
ORDER BY a.a_id ASC;
END$$
DELIMITER ;



-- Procedure to find the history of a doctor of all the patients he has treated on

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `hosp_doc_hist`(IN did INT)
BEGIN
SELECT d.d_id,d.d_name, p.p_id, p.p_name, a.a_dt, a.a_tm
FROM patient p join appointment a join doctor d
ON p.p_id=a.p_id and d.d_id=a.d_id
WHERE d.d_id=did
ORDER BY a.a_id ASC;
END$$
DELIMITER ;


-- TRANSACTIONS

-- Transaction to book an appointment

/*
START TRANSACTION;
SELECT distinct(d.d_id),d.d_name,d.spec
FROM doctor d left join appointment a
ON d.d_id=a.d_id
WHERE d.d_id NOT IN(
	SELECT d_id
    FROM appointment
    WHERE a_dt=date
    AND a_tm=time)
AND d.spec=’input_specialization’;
    
SELECT distinct(room_no)
FROM appointment
WHERE room_no NOT IN(
	SELECT room_no
    FROM appointment
    WHERE a_dt=date
    AND a_tm=time);

CALL a_insert(date,time,patient_id,choosen_doc,choosen_room);

-- Trigger of doc_status_change is called

-- Trigger of status_delete is called

COMMIT;
*/

-- TRIGGERS

-- To add GST to bill amount

DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `add_GST` BEFORE INSERT ON `bill` FOR EACH ROW BEGIN
SET NEW.amount = NEW.amount*1.18;
END;
$$
DELIMITER ;

-- To change status of room and doctor before booking of an appointment

DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `doc_status_change` BEFORE INSERT ON `appointment` FOR EACH ROW BEGIN
UPDATE doctor SET doctor.d_stat='No'
WHERE doctor.d_id=NEW.d_id;
UPDATE room SET room.r_stat='No'
WHERE room.room_no=NEW.room_no;
END;
$$
DELIMITER ;


-- To change status of room and doctor after deleting of an appointment

DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `status_delete` AFTER DELETE ON `appointment` FOR EACH ROW BEGIN
UPDATE doctor SET doctor.d_stat='Yes'
WHERE doctor.d_id=OLD.d_id;
UPDATE room SET room.r_stat='Yes'
WHERE room.room_no=OLD.room_no;
END;
$$
DELIMITER ;

-- Some changes required-- 

START TRANSACTION;
INSERT INTO `project`.`patient`
(`p_name`,`p_gend`,`age`,`address`,`p_id`,`p_pwd`,`p_mail`)
VALUES
('Anish','Male',12,'Raghushanti Society',1000,'anish179','anish17@gmail.com');
CALL p_insert('Rani','Female',24,'Raja Society','rani69','rani@yahoo.com');
CALL p_insert('Ram','Male',82,'SRCC road','ramroxx','ram@hotmail.com');
CALL p_insert('Sachin','Male',71,'Mumbai street','sachinsuxx','noreply@xxx.com');
CALL p_insert('Shreya','Female',21,'Pilani gaon','shreyas','shrey@f.com');
CALL p_insert('Hans','Male',26,'Gokululdham soc','hansraj','h@i.com');
CALL p_insert('Radha','Female',21,'Imperial soc','radhas','ra@dha.com');
COMMIT;


START TRANSACTION;
INSERT INTO `project`.`doctor`
(`d_name`,`d_gend`,`spec`,`d_id`,`d_pwd`,`d_mail`)
VALUES
('Narendra','Male','Ortho',2000,'pranam17','narendra@gmail.com');
CALL d_insert('Nimbol','Male','General','nimbroxx','nim@bo.com');
CALL d_insert('Tejomoy','Male','Neuro','tejo131','tejomoy@gmail.com');
CALL d_insert('Mitali','Female','Dentist','mitaliop','mitali@hotmail.com');
CALL d_insert('Tanmoy','Male','Opthalmo','moytan','moy@tan.com');
CALL d_insert('Ramesh','Male','Homeopathy','ramesh12','esh@ram.com');
CALL d_insert('Shruti','Female','General','shruti00','shr@uti.com');
CALL d_insert('Ila','Female','Dentist','ilailu','ila@ilu.com');
CALL d_insert('sidhi','female','Neuro','sid66','sid@hi.com');
CALL d_insert('Rakesh','Male','Opthalmo','nishu','ni@shu.com');
CALL d_insert('Nisha','Female','Homeopathy','nishas','nisha@coolram.com');
CALL d_insert('Lokmanya','Male','Ortho','lokop','lokop@gmail.com');

COMMIT;


START TRANSACTION;
INSERT INTO `project`.`medical_info`
(`medical_conditions`)
VALUES
('Cold and cough'),('Corona'),('Stomach ache'),('Toothache'),
('Headache'),('Ebola'),('Malaria'),('Typhoid'),('Dengue'),
('Influenza'),('Rabies'),('Scurvy');
CALL medinfo_insert('Heart attack');
CALL medinfo_insert('Tuberculosis');
CALL medinfo_insert('Brain Tumor');
COMMIT;


START TRANSACTION;
CALL medrec_insert(1001,'B+',1,'Yes','Cold and cough');
CALL medrec_insert(1003,'AB+',2,'Yes','Corona');
CALL medrec_insert(1002,'O+',1,'No','stomach ache');
CALL medrec_insert(1006,'A-',2,'No','toothache');
COMMIT;


START TRANSACTION;
CALL `project`.`room_insert`(5102,'yes');
CALL room_insert(1233,'yes');
CALL room_insert(2204,'yes');
call room_insert(6101,'yes');
call room_insert(6102,'yes');
call room_insert(6153,'yes');
call room_insert(5105,'yes');
COMMIT;



START TRANSACTION;
INSERT INTO `project`.`appointment`
(`a_id`,`a_dt`,`a_tm`,`p_id`,`d_id`,`room_no`)
VALUES
(150,'2022-11-16',15,1003,2005,5102);
call a_insert('2022-11-16',7,1002,2000,2204);
call a_insert('2022-11-16',8,1004,2002,1233);
call a_insert('2021-10-12',12,1005,2006,2204);
call a_insert('2021-10-12',12,1000,2004,6153);
call a_insert('2021-05-05',11,1001,2007,6102);
COMMIT;


START TRANSACTION;
INSERT INTO `project`.`bill`
(`b_id`,`amount`,`d_id`)
VALUES
(9000,1200,2002);
CALL bill_insert(1600,2003);
CALL bill_insert(2500,2006);
CALL bill_insert(999,2000);
COMMIT;


START TRANSACTION;
INSERT INTO `project`.`staff`
(`s_id`,`room_no`,`s_type`,`s_name`)
VALUES
(1000,5102,'wardboy','ramu');
CALL s_insert(1233,'nurse','gita');
CALL s_insert(5105,'paramedic','john');
COMMIT;


INSERT INTO `project`.`admin`
(`admin_username`,
`admin_pwd`)
VALUES
('admin','123');

-- END