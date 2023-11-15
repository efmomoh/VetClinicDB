/* Populate database with sample data. */

-- Insert values into the animals table 
INSERT INTO animals (name, date_of_birth, neutered, weight_kg) VALUES ('Agumon', '2020-02-10', B'1', '10.23');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2020-11-15', 2, B'1', '8');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, B'0', '15.04');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, B'0', '15.04');

-- Populate animals table with new records
-- Insert single record/row :
 INSERT INTO animals (name, date_of_birth, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', B'1', '-11');

--  Insert Multiple records/data/rows: 

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', '2', B'1', '-5.7'), ('Squirtle', '1993-04-02', '3', B'0', '-12.13'), ('Angemon', '2005-06-12', '1', B'1', '-45'), ('Boarmon', '2005-06-07', '7', B'1', '20.4'), ('Blossom', '1998-10-13', '3', B'1', '17'), ('Ditto', '2022-05-14', '4', B'1', '22');


-- Insert records into the owners table:
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert data into the species table:
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Update animals to set species_id based on the name
UPDATE animals
SET species_id = (
  CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
  END
);

-- Update animals to set owner_id based on owner information
UPDATE animals
SET owner_id = (
  CASE
    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  END
);


-- VISITS TASK :
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) VALUES
(1, 1),  -- William Tatcher specialized in Pokemon
(3, 1),  -- Stephanie Mendez specialized in Pokemon
(3, 2),  -- Stephanie Mendez specialized in Digimon
(4, 2);  -- Jack Harkness specialized in Digimon

INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
(1, 1, '2020-05-24'),    -- Agumon visited William Tatcher
(3, 1, '2020-07-22'),    -- Agumon visited Stephanie Mendez
(4, 2, '2021-02-02'),    -- Gabumon visited Jack Harkness
(2, 3, '2020-01-05'),    -- Pikachu visited Maisy Smith
(2, 3, '2020-03-08'),    -- Pikachu visited Maisy Smith
(2, 3, '2020-05-14'),    -- Pikachu visited Maisy Smith
(3, 4, '2021-05-04'),    -- Devimon visited Stephanie Mendez
(4, 5, '2021-02-24'),    -- Charmander visited Jack Harkness
(1, 6, '2019-12-21'),    -- Plantmon visited William Tatcher
(1, 6, '2020-08-10'),    -- Plantmon visited William Tatcher
(2, 6, '2021-04-07'),    -- Plantmon visited Maisy Smith
(3, 7, '2019-09-29'),    -- Squirtle visited Stephanie Mendez
(4, 8, '2020-10-03'),    -- Angemon visited Jack Harkness
(4, 8, '2020-11-04'),    -- Angemon visited Jack Harkness
(2, 9, '2019-01-24'),    -- Boarmon visited Maisy Smith
(2, 9, '2019-05-15'),    -- Boarmon visited Maisy Smith
(2, 9, '2020-02-27'),    -- Boarmon visited Maisy Smith
(2, 9, '2020-08-03'),    -- Boarmon visited Maisy Smith
(3, 10, '2020-05-24'),   -- Blossom visited Stephanie Mendez
(1, 10, '2021-01-11');   -- Blossom visited William Tatcher

