/*Queries that provide answers to the questions from all projects.*/

--  To view table data/values

### Write queries for the following quests:

 SELECT * FROM animals ;

> Find all animals whose name ends in "mon":
 SELECT * FROM animals WHERE name LIKE '%mon';

> List the name of all animals born between 2016 and 2019:
 SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

> List the name of all animals that are neutered and have less than 3 escape attempts:
 SELECT name FROM animals WHERE neutered = B'1' AND (escape_attempts IS NULL OR escape_attempts < 3);

> List the date of birth of all animals named either "Agumon" or "Pikachu":
  SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

> List name and escape attempts of animals that weigh more than 10.5kg:
 SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

> Find all animals that are neutered:
 SELECT * FROM animals WHERE neutered = B'1';

> Find all animals not named Gabumon:
  SELECT * FROM animals WHERE name <> 'Gabumon';

>Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg):
  SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- UPDATE animals TABLE Queries PHASE TWO / TASK TWO:
> Adds new column to TABLE COMMAND:
  ALTER TABLE animals ADD COLUMN species VARCHAR(100);

> TRANSACTIONS COMMANDS:
-- Start the transaction
1. BEGIN;

-- Update the "species" column to 'unspecified'
UPDATE animals SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals; -- This shows the updated data

-- Roll back the transaction to revert the changes
ROLLBACK;

-- Verify that the "species" column has returned to its original state
SELECT * FROM animals; -- This shows the original data

2. UPDATE SPECIES COMMANDS:

- UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
- UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
- SELECT name, species FROM animals;
- -- Start the transaction
- BEGIN;

-- Update the "species" column to 'pokemon' for animals without a species
- UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Commit the transaction to make the changes permanent
- COMMIT;

-- Verify that the changes persist after the commit
- SELECT name, species FROM animals;

3. DELETE ALL RECORDS/DATA COMMANDS:
-- Start the transaction
- BEGIN;

-- Delete all records in the "animals" table
- DELETE FROM animals;

-- Roll back the transaction to revert the changes
- ROLLBACK;

-- Verify if all records in the "animals" table still exist
- SELECT COUNT(*) FROM animals;

4. DELETE ALL ANIMALS BORN AFTER JAN. 1, 2022 COMMANDS: 
-- Start the transaction
- BEGIN;

-- Delete all animals born after Jan 1st, 2022
- DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint in the transaction
- SAVEPOINT weight_update;

-- Update all animals' weight to be their weight multiplied by -1
- UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
- ROLLBACK TO weight_update;

-- Update all animals' weights that are negative to be their weight multiplied by -1
- UPDATE animals SET weight_kg = ABS(weight_kg);

-- Commit the transaction to make the final changes permanent
- COMMIT;

5. QUERY QUESTION:
- How many animals are there?
  SELECT COUNT(*) FROM animals;

- How many animals have never tried to escape?
  SELECT COUNT(*) FROM animals WHERE escape_attempts IS NULL OR escape_attempts = 0;

- What is the average weight of animals?
  SELECT AVG(weight_kg) FROM animals;

- Who escapes the most, neutered or not neutered animals?
  SELECT neutered, MAX(escape_attempts) as max_escape_attempts FROM animals GROUP BY neutered;

- What is the minimum and maximum weight of each type of animal?
  SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight FROM animals GROUP BY species;

- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
  SELECT species, AVG(escape_attempts) as avg_escape_attempts FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

-- To answer the questions using SQL JOINs queries:

1. What animals belong to Melody Pond?
  SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

2. List of all animals that are pokemon (their species is Pokemon).
  SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

3. List all owners and their animals, including those who don't own any animals.

SELECT o.full_name, a.name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;

4. How many animals are there per species?

SELECT s.name AS species, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

5. List all Digimon owned by Jennifer Orwell.

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

6. List all animals owned by Dean Winchester that haven't tried to escape.

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND (a.escape_attempts IS NULL OR a.escape_attempts = 0);

7. Who owns the most animals?

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;


-- VISITS QUERY 
Who was the last animal seen by William Tatcher?
SELECT a.name
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id) AS num_animals
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

List all vets and their specialties, including vets with no specialties:

SELECT v.name, COALESCE(v.name, 'No Specialty') AS specialty
FROM vets v
LEFT JOIN specializations s ON v.id = s.vet_id;

List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT a.name
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

What animal has the most visits to vets?

SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY COUNT(v.vet_id) DESC
LIMIT 1;

Who was Maisy Smith's first visit?

SELECT a.name
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

Details for the most recent visit: animal information, 
vet information, and the date of the visit.

SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
ORDER BY v.visit_date DESC
LIMIT 1;

How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) AS num_visits_without_specialty
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations s ON vt.id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL;

What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT a.name AS suggested_specialty
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
JOIN specializations s ON vt.id = s.vet_id AND a.species_id = s.species_id
WHERE vt.name = 'Maisy Smith'
GROUP BY a.name
ORDER BY COUNT(*) DESC
LIMIT 1;


