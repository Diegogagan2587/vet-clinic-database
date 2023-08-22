/* Database schema to keep the structure of entire database. */
-- 1. First we create the new data base
     -- createdb vet_clinic;

-- 2. Then we Create the new Table;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    scape_attempts INT, 
    neutered BOOLEAN,
    weight_kg DECIMAL(16,3)
);
