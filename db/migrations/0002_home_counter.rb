Sequel.migration do
  up do
    create_table(:counters) do
      primary_key :id
      Integer :counter, default: 0
      DateTime :created_at
	    DateTime :updated_at
    end
  end

  down do
    drop_table(:counters)
  end
end
