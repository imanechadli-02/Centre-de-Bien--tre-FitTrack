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


-- remplir la table members

INSERT INTO members (first_name, last_name, gender, date_of_birth, phone_number, email) VALUES
('Emma', 'Watson', 'female', '1995-04-15', '0987654321', 'emma.watson@example.com'),
('Chris', 'Evans', 'male', '1985-06-13', '1122334455', 'chris.evans@example.com'),
('Sophia', 'Lopez', 'female', '2000-01-25', '6677889900', NULL),
('Jordan', 'Smith', 'other', '2002-09-19', '7788990011', 'jordan.smith@example.com');

-- remplir la table rooms

INSERT INTO rooms (room_number, room_type, capacity) VALUES
('R001', 'cardio', 20),
('R002', 'weight', 15),
('R003', 'Studio', 30),
('R004', 'cardio', 25),
('R005', 'weight', 10);


-- remplir la table memberships

INSERT INTO memberships (member_id, room_id, start_date) VALUES
(1, 1, '2024-01-01'),
(2, 3, '2024-02-15'),
(3, 2, '2024-03-20'),
(4, 4, '2024-04-05');


-- remplir la table departments


INSERT INTO departments (department_name, location) VALUES
('Cardio', 'First Floor'),
('Weight Training', 'Second Floor'),
('Yoga and Pilates', 'Third Floor'),
('Swimming', 'Basement');

-- remplir la table trainers

INSERT INTO trainers (first_name, last_name, specialisation, department_id) VALUES
('John', 'Doe', 'Cardio Training', 1),
('Sarah', 'Lee', 'Weight Lifting', 2),
('Michael', 'Brown', 'Yoga', 3),
('Anna', 'White', 'Swimming Coach', 4),
('David', 'Black', 'Strength Training', 2),
('Adam', 'Robert', 'musculation ', 3);

-- remplir la table appointments

INSERT INTO appointments (appointment_date, appointmeent_time, trainer_id, member_id) VALUES
('2024-01-10', '09:00:00', 1, 2),
('2024-01-12', '10:00:00', 2, 1),
('2024-01-15', '11:30:00', 3, 4),
('2024-01-18', '08:00:00', 4, 3);

-- remplir la table workout_plans

INSERT INTO workout_plans (member_id, trainer_id, instructions) VALUES
(1, 1, '30 minutes cardio daily, plus light stretching'),
(2, 2, 'Weight lifting thrice a week with increasing intensity'),
(3, 3, 'Yoga and flexibility exercises every morning'),
(4, 4, 'Swimming 5 laps every alternate day');






-- 1/ Opérations CRUD : Insérer un nouveau membre
INSERT INTO members (first_name, last_name, gender, date_of_birth, phone_number, email) VALUES
('Alex', 'Johnson', 'male', '1990-07-15', '1234567890', NULL);

-- 2/ Instruction SELECT : Récupérer tous les départements

SELECT department_name, location FROM departments;

-- 3/ Clause ORDER BY : Trier les membres par date de naissance

SELECT * FROM members 
ORDER BY date_of_birth ;


-- 4/ Filtrer les membres uniques par sexe (DISTINCT)

SELECT DISTINCT gender FROM members;

-- 5/ Clause LIMIT : Obtenir les 3 premiers entraîneurs

SELECT * FROM trainers
LIMIT 3;


-- 6/ Clause WHERE : Membres nés après 2000
SELECT * FROM members 
WHERE date_of_birth >= '2001-01-01';

-- 7/ Opérateurs Logiques : Entraîneurs dans des départements spécifiques
SELECT * FROM trainers
WHERE specialisation='musculation ' OR specialisation='Cardio Training';

-- 8/ Opérateurs Spéciaux : Vérifier des plages de dates

SELECT * FROM memberships 
WHERE start_date BETWEEN '2024-12-1' AND '2024-12-7';
  
-- 9/ Expressions Conditionnelles : Nommer les catégories d'âge des membres

SELECT *,
       CASE 
           WHEN date_of_birth < '2006-01-01' THEN 'Junior'
           WHEN date_of_birth BETWEEN '1974-01-01' AND '2006-01-01' THEN 'Adulte'
           WHEN date_of_birth > '1974-01-01' THEN 'Senior'
           ELSE 'Non défini'
       END AS age_category
FROM members;

-- 10/ Fonctions d'Agrégation : Nombre total de rendez-vous

SELECT COUNT(*)  FROM appointments;

-- 11/ COUNT avec GROUP BY : Nombre d'entraîneurs par département


SELECT department_name, COUNT(trainer_id) 
FROM departments 
JOIN trainers  ON departments.department_id = trainers.department_id
GROUP BY department_name;

-- 12/ AVG : Âge moyen des membres

SELECT AVG(YEAR(CURDATE()) - YEAR(date_of_birth)) 
FROM members;

-- 13/ MAX : Dernier rendez-vous

SELECT MAX(appointment_date)
FROM appointments;

-- 14/ SUM : Total des abonnements par salle

INSERT INTO memberships (member_id, room_id, start_date) VALUES
(5, 1 , '2024-5-11');

DESCRIBE memberships;


SELECT COUNT(member_id), room_id
FROM memberships
GROUP BY room_id;

-- 15/ Contraintes : Vérifier les membres sans e-mail

SELECT * FROM members 
WHERE email IS NULL;

-- 16/ Jointure : Liste des rendez-vous avec noms des entraîneurs et membres

SELECT appointment_id,
    appointment_date,
    appointmeent_time,
    t.first_name AS trainer_first_name,
    t.last_name AS trainer_last_name, 
    m.first_name AS member_first_name, 
    m.last_name AS member_last_name 
    FROM appointments as a
INNER JOIN trainers as t
ON a.trainer_id = t.trainer_id
INNER JOIN members as m
ON a.member_id = m.member_id

-- 17/ DELETE : Supprimer les rendez-vous avant 2024
DELETE FROM appointments 
WHERE appointment_date < '2024-01-12';

-- 18/ UPDATE : Modifier un département

UPDATE departments
SET department_name = 'force et conditionnement'
WHERE department_name = 'Cardio';

-- 19/ Clause HAVING : Membres par sexe avec au moins 2 entrées
select gender from members
GROUP BY gender
HAVING COUNT(gender) >=2;

-- 20/ Créer une vue : Abonnements actifs

CREATE VIEW `Abonnements actifs` AS
SELECT * FROM appointments;