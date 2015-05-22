Sequel.migration do
  up do
    create_table(:teams_users) do
      primary_key :id
      foreign_key :team_id, :null=>false
      foreign_key :user_id, :null=>false
      Boolean :leader, :default=>false
      DateTime :created_at
      DateTime :updated_at
      index :team_id
      index :user_id
    end
  end

  down do
    drop_table(:teams_users)
  end
end
