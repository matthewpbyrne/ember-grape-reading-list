Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      foreign_key :tenant_id
      String :name, :null=>false
      String :email, :null=>false
      String :password_digest, :null=>false
      String :auth_token
      Boolean :admin, :default=>false
      DateTime :auth_token_generated_at
      DateTime :last_active_at
      DateTime :created_at
      DateTime :updated_at
      index :email
    end
  end

  down do
    drop_table(:users)
  end
end
