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

--  <<<<<-------Questions Below: Query multiple tables--------->>>> ;
--What animals belong to Melody Pond?
SELECT name, full_name AS owner FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';
--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name AS animal_type 
FROM animals JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';
--List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name AS owner_name, name AS animal_name
FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;
--How many animals are there per species?
SELECT species.name AS species_name, COUNT(species_id) AS animals_per_specie
FROM species RIGHT JOIN animals ON species_id = species.id
GROUP BY species.name;
--List all Digimon owned by Jennifer Orwell.
SELECT species.name AS animal_type, owners.full_name AS owner_name, animals.name AS animal_name
FROM animals FULL JOIN owners ON owner_id = owners.id 
             FULL JOIN species ON species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name  AS animal_name, owners.full_name AS owner_name, animals.scape_attempts
FROM animals FULL JOIN owners ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.scape_attempts = 0;
--Who owns the most animals?
SELECT owners.full_name AS owner_name, COUNT(animals.name) AS animals_per_owner
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
HAVING COUNT(animals.name) = (
    SELECT MAX(animal_count)
    FROM (
        SELECT owner_id, COUNT(name) AS animal_count
        FROM animals
        GROUP BY owner_id
    ) AS animal_counts_subquery
);
---->> Lesson: Add "Join table" for visits start here <<----
--Who was the last animal seen by William Thatcher?
SELECT vets.name AS veterinarian, animals.name AS last_animal, visits.visits_dates AS last_visit
FROM vets JOIN visits ON vets.id = visits.vets_id
          JOIN animals ON visits.animals_id = animals.id
WHERE vets.name = 'William Tatcher' AND visits.visits_dates = (
    SELECT MAX(visits_dates) AS last_visit
    FROM vets JOIN visits ON visits.vets_id = vets.id
    WHERE vets.name = 'William Tatcher'
    GROUP BY vets.name
);
--How many different animals did Stephanie Mendez see?
SELECT vets.name AS veterinarian,COUNT(animals.name) AS diferent_animals_seen
FROM vets JOIN visits ON vets_id = vets.id
          JOIN animals ON animals_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;
--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name AS specialties
FROM vets FULL JOIN specializations ON vets_id = vets.id
          FULL JOIN species ON species_id = species.id;
--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name, vets.name AS veterinarian, visits_dates
FROM animals JOIN visits ON animals_id = animals.id
             JOIN vets ON vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits_dates > '2020-04-01' AND visits_dates < '2020-08-30'
;
--What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(visits.visits_dates) AS number_of_visits
FROM animals JOIN visits ON animals.id = animals_id
GROUP BY animal_name
HAVING COUNT(visits.visits_dates)  = (
    SELECT MAX(visit_count)
    FROM (
        SELECT animals_id, COUNT(visits_dates) AS visit_count
        FROM visits
        GROUP BY animals_id
    ) AS visit_counts_sub_query
)
;
--Who was Maisy Smith's first visit?
SELECT vets.name AS veterinarian, animals.name AS animal_name, visits.visits_dates 
FROM vets JOIN visits ON vets.id = visits.vets_id
          JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Maisy Smith' AND visits.visits_dates = (
    SELECT  visit_date 
    FROM (
        SELECT vets.name, MIN(visits.visits_dates) AS visit_date
        FROM vets JOIN visits on vets.id = visits.vets_id
        WHERE vets.name = 'Maisy Smith'
        GROUP BY vets.name
    ) AS date_sub_query
)
;
--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, 
       date_of_birth, 
       scape_attempts, 
       neutered, 
       weight_kg, 
       species.name AS species,
       owners.full_name AS owner_name,
       vets.name AS vets_name,
       vets.age AS vets_age,
       vets.date_of_graduation AS vets_date_of_graduation,
       visits_dates
FROM animals JOIN species ON animals.species_id = species.id
             JOIN owners ON animals.owner_id = owners.id
             JOIN visits ON animals.id = visits.animals_id
             JOIN vets ON vets.id = visits.vets_id
WHERE visits_dates = (
    SELECT MAX(visits_dates) 
    FROM visits
)
;
--How many visits were with a vet that did not specialize in that animal's species?
--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
---->> Lesson: Add "Join table" for visits Ends here <<----
