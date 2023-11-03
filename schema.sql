/* Database schema to keep the structure of entire database. */

/* Create database */
CREATE DATABASE vet_clinic ;

-- connect database 
\c vet_clinic

/* create table */
 CREATE TABLE animals(
vet_clinic(# id                 INT GENERATED BY DEFAULT AS IDENTITY,
vet_clinic(# name               VARCHAR(100) NOT NULL,
vet_clinic(# date_of_birth      DATE NOT NULL,
vet_clinic(# escape_attempts    INT,
vet_clinic(# neutered           BIT,
vet_clinic(# weight_kg          DECIMAL) ;

