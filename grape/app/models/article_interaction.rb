# +------------+-----------+-----------+---------+-------+-----+-----+
# |                       article_interactions                       |
# +------------+-----------+-----------+---------+-------+-----+-----+
# | Column     | Ruby Type | DB Type   | Default | Null? | PK? | FK? |
# +------------+-----------+-----------+---------+-------+-----+-----+
# | id         | integer   | integer   |    -    |   N   |  Y  |  N  |
# | article_id | integer   | integer   |    -    |   N   |  N  |  N  |
# | user_id    | integer   | integer   |    -    |   N   |  N  |  N  |
# | read       | boolean   | Boolean   |    -    |   Y   |  N  |  N  |
# | created_at | datetime  | timestamp |    -    |   Y   |  N  |  N  |
# | updated_at | datetime  | timestamp |    -    |   Y   |  N  |  N  |
# +------------+-----------+-----------+---------+-------+-----+-----+

class ArticleInteraction < Sequel::Model
  plugin :timestamps
  
  many_to_one :article
  many_to_one :user
  
  dataset_module do
    def read
      where(:read => true)
    end

    def unread
      where(:read => false)
    end
  end
end
