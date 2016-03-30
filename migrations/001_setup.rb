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
      String :date
      String :location
      String :current_temperature
      String :summary
      String :rain
      String :tomorrow_max_temperature
      String :tomorrow_min_temperature
    end
  end
end
