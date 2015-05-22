Sequel.migration do
  up do
    create_table(:tenants) do
      primary_key :id
      String :name, :null=>false
      String :domain_name, :null=>false
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:tenants)
  end
end
