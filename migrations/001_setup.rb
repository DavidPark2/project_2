Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key :id
      String :name
      String :email
      String :password
    end
    create_table(:weathers) do
      primary_key :id
      String :location
      String :temperature
    end
  end
end

# -- CREATE DATABASE weathers_website;
# -- \c weathers
# -- CREATE TABLE accounts (id SERIAL PRIMARY KEY, name VARCHAR(20), email VARCHAR(20), password VARCHAR(255));
# -- CREATE TABLE weathers (id SERIAL PRIMARY KEY, location VARCHAR(255), temperature VARCHAR(255));
