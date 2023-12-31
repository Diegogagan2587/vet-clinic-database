/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth,  weight_kg, neutered, scape_attempts)
VALUES ('Agumon', '2020-02-03', 10.23,true, 0);

INSERT INTO animals (name, date_of_birth,  weight_kg, neutered, scape_attempts)
VALUES ('Gabumon', '2018-11-15', 8,true, 2);

INSERT INTO animals (name, date_of_birth,  weight_kg, neutered, scape_attempts)
VALUES ('Pikachu', '2021-01-07', 15.04,false, 1);

INSERT INTO animals (name, date_of_birth,  weight_kg, neutered, scape_attempts)
VALUES ('Devimon', '2017-05-12', 11,true, 5);
-- query and update animals table lesson starts here;
INSERT INTO animals (name, date_of_birth, weight_kg, neutered,scape_attempts)
VALUES ('Charmander','2020-02-08',-11,false,0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered,scape_attempts)
VALUES ('Plantmon','2021-11-15',-5.7,true,2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered,scape_attempts)
VALUES ('Squirtle','1993-04-02',-12.13,false,3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered,scape_attempts)
VALUES ('Angemon','2005-06-12',-45,true,1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered,scape_attempts)
VALUES ('Boarmon','2005-06-07',20.4,true,7);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered,scape_attempts)
VALUES ('Blossom','1998-10-13',17,true,3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered,scape_attempts)
VALUES ('Ditto','2022-05-14',22,true,4);

---->> Lesson: Query multiple tables starts here <<----
INSERT INTO owners ( full_name, age)
VALUES ('Sam Smith ',34),
       ('Jennifer Orwell',19),
       ('Bob',45),
       ('Melody Pond',77),
       ('Dean Winchester ',14),
       ('Jodie Whittaker',38);

INSERT INTO species (name) 
VALUES ('Pokemon'),('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon%';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
SELECT * FROM animals;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon','Boarmon');

---->> Lesson: Query multiple tables ends here <<----
---->> Lesson: Add "Join table" for visits start here <<----
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
       ('Maisy Smith', 26, '2019-01-17'),
       ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vets_id, species_id)
VALUES (1,1),
       (3,2),
       (3,1),
       (4,2);

INSERT INTO visits (animals_id, vets_id, visits_dates)
VALUES (12,1,'2020-05-24'),
       (12,3,'2020-06-22'),
       (13,4,'2021-02-02'),
       (14,2,'2020-01-05'),
       (14,2,'2020-03-08'),
       (14,2,'2020-05-14'),
       (15,3,'2021-05-04'),
       (16,4,'2021-02-24'),
       (17,2,'2019-12-21'),
       (17,1,'2020-08-10'),
       (17,2,'2021-04-07'),
       (18,3,'2019-09-29'),
       (19,4,'2020-10-03'),
       (19,4,'2020-11-04'),
       (20,2,'2019-01-24'),
       (20,2,'2019-05-15'),
       (20,2,'2020-02-27'),
       (20,2,'2020-08-03'),
       (21,3,'2020-05-24'),
       (21,1,'2021-01-11');
---->> Lesson: Add "Join table" for visits Ends here <<----