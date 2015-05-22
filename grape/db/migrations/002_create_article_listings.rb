Sequel.migration do
  up do
    create_table(:article_listings) do
      primary_key :id
      foreign_key :article_id, :null=>false
      foreign_key :team_id, :null=>false
      String :comment
      DateTime :created_at
      DateTime :updated_at
      index :article_id
      index :team_id
    end
  end

  down do
    drop_table(:article_interactions)
  end
end
