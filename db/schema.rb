Sequel.migration do
  change do
    create_table(:counters) do
      primary_key :id
      Integer :counter, :default=>0
      DateTime :created_at
      DateTime :updated_at
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:users) do
      primary_key :id
      String :first_name, :size=>100
      String :last_name, :size=>80
      String :username, :size=>16
      String :encrypted_password, :size=>254
      Integer :count, :default=>0
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
