CREATE DATABASE weathers_website;
\c weathers
CREATE TABLE accounts (id SERIAL PRIMARY KEY, name VARCHAR(20), email VARCHAR(20), password VARCHAR(255));
CREATE TABLE weathers (id SERIAL PRIMARY KEY, location VARCHAR(255), temperature VARCHAR(255));
