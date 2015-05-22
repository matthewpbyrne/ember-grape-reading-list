# +------------+-----------+-----------+---------+-------+-----+-----+
# |                           teams_users                            |
# +------------+-----------+-----------+---------+-------+-----+-----+
# | Column     | Ruby Type | DB Type   | Default | Null? | PK? | FK? |
# +------------+-----------+-----------+---------+-------+-----+-----+
# | id         | integer   | integer   |    -    |   N   |  Y  |  N  |
# | team_id    | integer   | integer   |    -    |   N   |  N  |  N  |
# | user_id    | integer   | integer   |    -    |   N   |  N  |  N  |
# | leader     | boolean   | Boolean   |    -    |   Y   |  N  |  N  |
# | created_at | datetime  | timestamp |    -    |   Y   |  N  |  N  |
# | updated_at | datetime  | timestamp |    -    |   Y   |  N  |  N  |
# +------------+-----------+-----------+---------+-------+-----+-----+

class TeamsUser < Sequel::Model
  plugin :timestamps

  many_to_one :team
  many_to_one :user

  dataset_module do
    def leaders
      where(:leader => true)
    end
  end
end
