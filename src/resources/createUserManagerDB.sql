DROP DATABASE IF EXISTS test;

CREATE DATABASE test DEFAULT CHARACTER SET 'utf8';

USE test;

CREATE TABLE IF NOT EXISTS `test`.`users` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45),
  `age` INT,
  `isAdmin` BIT,
  `createdDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`));


INSERT INTO users (name, age, isAdmin, createdDate) 
VALUES ('Henry', 28, 0, now()),
('Alexander', 22, 1, now()),
('Nadja', 29, 1, now()),
('Michael', 35, 0, now()),
('John', 6, 0, now()),
('Patrick', 19, 1, now()), 
('Alex', 29, 1, now()),
('Silvia', 25, 0, now()),
('Nadja', 33, 1, now()),
('Alexander', 42, 0, now()), 
('Peter', 70, 1, now()),
('Steven', 37, 0, now()),
('Jennifer', 21, 1, now()),
('Nadja', 50, 0, now()),
('Alex', 61, 1, now()),
('Lucas', 45, 1, now()),
('Roger', 30, 0, now()),
('William', 45, 0, now()),
('John', 66, 1, now()),
('Lucas', 40, 1, now()),
('Alex', 31, 0, now()),
('Edward', 27, 1, now()),
('David', 51, 0, now()),
('Marco', 54, 0, now()),
('John', 65, 0, now());