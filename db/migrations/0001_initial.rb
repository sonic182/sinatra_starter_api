Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :first_name, size: 100
      String :last_name, size: 80
      String :username, size: 16, unique: true
      String :encrypted_password, size: 254
      Integer :count, default: 0
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:artists)
  end
end
