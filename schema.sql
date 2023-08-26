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

ALTER TABLE animals ADD species VARCHAR(100);

---->> Lesson: Query multiple tables start here <<----

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250),
    age INT,
    PRIMARY KEY (id)
);


CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY (id)
);


ALTER TABLE animals ADD CONSTRAINT animalsPrimaryKey PRIMARY KEY (id);--make sure id in animals is primary key

ALTER TABLE animals DROP species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

---->> Lesson: Query multiple tables ends here <<----
---->> Lesson: Add "Join table" for visits start here <<----
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);
---->> Lesson: Add "Join table" for visits Ends here <<----
