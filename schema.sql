/* Database schema to keep the structure of entire database. */

/* Create database */
CREATE DATABASE vet_clinic ;

-- connect database 
\c vet_clinic

/* create animals' table */
 CREATE TABLE animals(
    id                 INT GENERATED BY DEFAULT AS IDENTITY,
    name               VARCHAR(100) NOT NULL,
    date_of_birth      DATE NOT NULL,
    escape_attempts    INT,
    neutered           BIT,
    weight_kg          DECIMAL) ;

   ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- create owners table 
CREATE TABLE owners(id SERIAL PRIMARY KEY, full_name VARCHAR(100), age INT);

-- create species table 
CREATE TABLE species(id SERIAL PRIMARY KEY, name VARCHAR(100));

-- MODIFY THE animals TABLE

-- Step 1: Remove the current PRIMARY KEY constraint from the "id" column
ALTER TABLE animals DROP CONSTRAINT animals_pkey;

-- Step 2: Add a new PRIMARY KEY constraint to the "id" column and set it as auto-incremented
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;

-- Step 3: Remove the "species" column
ALTER TABLE animals DROP COLUMN species;

-- Step 4: Add a new column "species_id" as a foreign key referencing the "species" table
ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);

-- Step 5: Add a new column "owner_id" as a foreign key referencing the "owners" table
ALTER TABLE animals ADD COLUMN owner_id INT, ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);


-- TASK FOUR: 
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-- ADD PRIMARY KEY TO ANIMALS TABLE 
ALTER TABLE animals ADD PRIMARY KEY (id);

-- Create the "visits" table for the many-to-many relationship between "animals" and "vets"
CREATE TABLE visits (
    vet_id INT,
    animal_id INT,
    date_of_visit DATE,
    PRIMARY KEY (vet_id, animal_id, date_of_visit),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

