Sequel.migration do
  up do
    create_table(:articles) do
      primary_key :id
      String :url, :null=>false    
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:articles)
  end
end
