Sequel.migration do
  up do
    create_table(:article_interactions) do
      primary_key :id
      foreign_key :article_id, :null=>false
      foreign_key :user_id, :null=>false
      Boolean :read, :default=>false
      DateTime :created_at
      DateTime :updated_at
      index :article_id
      index :user_id
    end
  end

  down do
    drop_table(:article_interactions)
  end
end
