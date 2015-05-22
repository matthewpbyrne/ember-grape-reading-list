Sequel.migration do
  up do
    create_table(:teams) do
      primary_key :id
      foreign_key :tenant_id, :null=>false
      String :name, :null=>false
      DateTime :created_at
      DateTime :updated_at
      index :tenant_id      
    end
  end

  down do
    drop_table(:teams)
  end
end
