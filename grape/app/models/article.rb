# +------------+-----------+--------------+---------+-------+-----+-----+
# |                              articles                               |
# +------------+-----------+--------------+---------+-------+-----+-----+
# | Column     | Ruby Type | DB Type      | Default | Null? | PK? | FK? |
# +------------+-----------+--------------+---------+-------+-----+-----+
# | id         | integer   | integer      |    -    |   N   |  Y  |  N  |
# | url        | string    | varchar(255) |    -    |   N   |  N  |  N  |
# | created_at | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# | updated_at | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# +------------+-----------+--------------+---------+-------+-----+-----+

class Article < Sequel::Model
  plugin :timestamps
  
  one_to_many :article_interactions
  one_to_many :article_listings
end
