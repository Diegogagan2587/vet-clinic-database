/* Database schema to keep the structure of entire database. */
-- 1. First we create the new data base
     -- createdb vet_clinic;

-- 2. Then we Create the new Table;

CREATE TABLE animals (
    id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    scape_attempts INT, 
    neutered BIT,
    weight_kg DECIMAL(16,3);
);
