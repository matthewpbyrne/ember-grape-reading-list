# +-------------+-----------+--------------+---------+-------+-----+-----+
# |                               tenants                                |
# +-------------+-----------+--------------+---------+-------+-----+-----+
# | Column      | Ruby Type | DB Type      | Default | Null? | PK? | FK? |
# +-------------+-----------+--------------+---------+-------+-----+-----+
# | id          | integer   | integer      |    -    |   N   |  Y  |  N  |
# | name        | string    | varchar(255) |    -    |   N   |  N  |  N  |
# | domain_name | string    | varchar(255) |    -    |   N   |  N  |  N  |
# | created_at  | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# | updated_at  | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# +-------------+-----------+--------------+---------+-------+-----+-----+

class Tenant < Sequel::Model
  plugin :timestamps
  
  one_to_many :users
  one_to_many :teams

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end

  def self.current_id
    if (Thread.current[:tenant_id] &&
         !Thread.current[:tenant_id].is_a?(Integer))
      Thread.current[:tenant_id] = nil
    end
    Thread.current[:tenant_id]
  end
end
