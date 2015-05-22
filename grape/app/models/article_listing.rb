# +------------+-----------+--------------+---------+-------+-----+-----+
# |                          article_listings                           |
# +------------+-----------+--------------+---------+-------+-----+-----+
# | Column     | Ruby Type | DB Type      | Default | Null? | PK? | FK? |
# +------------+-----------+--------------+---------+-------+-----+-----+
# | id         | integer   | integer      |    -    |   N   |  Y  |  N  |
# | article_id | integer   | integer      |    -    |   N   |  N  |  N  |
# | team_id    | integer   | integer      |    -    |   N   |  N  |  N  |
# | comment    | string    | varchar(255) |    -    |   Y   |  N  |  N  |
# | created_at | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# | updated_at | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# +------------+-----------+--------------+---------+-------+-----+-----+

class ArticleListing < Sequel::Model
  plugin :timestamps
  
  many_to_one :article
  many_to_one :team  
end
