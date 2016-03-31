Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key :id
      String :username
      String :email
      String :password
    end
    create_table(:weathers) do
      primary_key :id
      String :area
    end
  end
end
