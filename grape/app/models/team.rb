# +------------+-----------+--------------+---------+-------+-----+-----+
# |                                teams                                |
# +------------+-----------+--------------+---------+-------+-----+-----+
# | Column     | Ruby Type | DB Type      | Default | Null? | PK? | FK? |
# +------------+-----------+--------------+---------+-------+-----+-----+
# | id         | integer   | integer      |    -    |   N   |  Y  |  N  |
# | tenant_id  | integer   | integer      |    -    |   N   |  N  |  N  |
# | name       | string    | varchar(255) |    -    |   N   |  N  |  N  |
# | created_at | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# | updated_at | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# +------------+-----------+--------------+---------+-------+-----+-----+

class Team < Sequel::Model

  plugin :timestamps

  many_to_one :tenant
  one_to_many :article_listings
  one_to_many :teams_users
  many_to_many :users, :through => :teams_users

  dataset_module do
    def tenanted
      where(:tenant_id => Tenant.current_id)
    end
  end

  def article_interactions
    ArticleInteraction.where(article_id: article_listings.map(&:article_id))
      .where(user_id: users.map(&:id))
  end

  def leaders
    teams_users_dataset.leaders.map(&:user)
  end
end
