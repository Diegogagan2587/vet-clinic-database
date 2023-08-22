/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
--List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE 