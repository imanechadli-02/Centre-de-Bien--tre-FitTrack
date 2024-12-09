-- creation de la base de donnee
CREATE DATABASE fitnessmanagement;
use fitnessmanagement;
--  creation de la table members
CREATE TABLE members (
    member_id INT(11) NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('male', 'female', 'other') NOT NULL,
    date_of_birth DATE,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    PRIMARY KEY (member_id)
);

-- creation de la table rooms
CREATE TABLE rooms(
    room_id INT(11) NOT NULL AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL,
    room_type ENUM('cardio', 'weight', 'Studio') NOT NULL,
    capacity INT(11),
    PRIMARY KEY (room_id)
);

-- creation de la table memberships

CREATE TABLE memberships (
    membership_id INT(11) NOT NULL AUTO_INCREMENT,
    member_id INT(11) NOT NULL,
    room_id INT(11) NOT NULL,
    start_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    PRIMARY KEY (membership_id)
);

-- creation de la table departments

CREATE TABLE departments (
    department_id INT(11) NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(50),
    location VARCHAR(100),
    PRIMARY KEY (department_id)
);

-- creation de la table trainers 

CREATE TABLE trainers (
    trainer_id INT(11) NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialisation VARCHAR(50) NOT NULL,
    department_id INT(11),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    PRIMARY KEY (trainer_id)
);


-- creation de la table appointments 

CREATE TABLE appointments (
    appointment_id INT(11) NOT NULL AUTO_INCREMENT,
    appointment_date DATE NOT NULL,
    appointmeent_time TIME NOT NULL,
    trainer_id INT(11) NOT NULL,
    member_id INT(11) NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    PRIMARY KEY (appointment_id)
);

-- creation de la table workout_plans 

CREATE TABLE workout_plans (
    plan_id INT(11) NOT NULL AUTO_INCREMENT,
    member_id INT(11) NOT NULL,
    trainer_id INT(11) NOT NULL,
    instructions VARCHAR(255),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    PRIMARY KEY (plan_id)
);

