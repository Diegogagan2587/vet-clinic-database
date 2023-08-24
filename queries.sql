/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
--List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered AND scape_attempts < 3;
--List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
--List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, scape_attempts FROM animals WHERE weight_kg < 10.5;
--Find all animals that are neutered.
SELECT * FROM animals WHERE neutered;
--Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';
--Find all animals with a weight between 10.4kg and 17.3kg 
--(including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
/*
Inside a transaction update the animals table by setting the species column to unspecified.
 Verify that change was made. Then roll back the change and verify that the species columns 
 went back to the state before the transaction.
*/
--Start the Transactions
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;

SELECT species FROM animals;

BEGIN TRANSACTION;
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'Pokemon' WHERE species IS NULL;
SELECT species FROM animals;
COMMIT;

SELECT species FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT save1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO save1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
--   <<<<<-----------------Questions Below---------------------->>>> ;
-- How many animals are there?
SELECT COUNT(*) AS animals_in_total FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(scape_attempts) AS animals_never_tried_scape FROM animalS WHERE scape_attempts < 1;
-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(scape_attempts) AS total_scape_attempts, AVG(scape_attempts) AS average_scapes 
FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(scape_attempts) AS average_scapes_attempts 
FROM animals 
WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-01-01'
GROUP BY species;

