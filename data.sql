/* Populate database with sample data. */
-- Insert values into the table 
INSERT INTO animals (name, date_of_birth, neutered, weight_kg) VALUES ('Agumon', '2020-02-10', B'1', '10.23');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2020-11-15', 2, B'1', '8');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, B'0', '15.04');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, B'0', '15.04');

-- Populate table with new records
-- Insert single record/row :
 INSERT INTO animals (name, date_of_birth, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', B'1', '-11');

--  Insert Multiple records/data/rows: 

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', '2', B'1', '-5.7'), ('Squirtle', '1993-04-02', '3', B'0', '-12.13'), ('Angemon', '2005-06-12', '1', B'1', '-45'), ('Boarmon', '2005-06-07', '7', B'1', '20.4'), ('Blossom', '1998-10-13', '3', B'1', '17'), ('Ditto', '2022-05-14', '4', B'1', '22');

