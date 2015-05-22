# +-------------------------+-----------+--------------+---------+-------+-----+-----+
# |                                      users                                       |
# +-------------------------+-----------+--------------+---------+-------+-----+-----+
# | Column                  | Ruby Type | DB Type      | Default | Null? | PK? | FK? |
# +-------------------------+-----------+--------------+---------+-------+-----+-----+
# | id                      | integer   | integer      |    -    |   N   |  Y  |  N  |
# | tenant_id               | integer   | integer      |    -    |   Y   |  N  |  N  |
# | name                    | string    | varchar(255) |    -    |   N   |  N  |  N  |
# | email                   | string    | varchar(255) |    -    |   N   |  N  |  N  |
# | password_digest         | string    | varchar(255) |    -    |   N   |  N  |  N  |
# | auth_token              | string    | varchar(255) |    -    |   Y   |  N  |  N  |
# | admin                   | boolean   | Boolean      |    -    |   Y   |  N  |  N  |
# | auth_token_generated_at | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# | last_active_at          | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# | created_at              | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# | updated_at              | datetime  | timestamp    |    -    |   Y   |  N  |  N  |
# +-------------------------+-----------+--------------+---------+-------+-----+-----+

class User < Sequel::Model
  plugin :secure_password
  plugin :timestamps

  many_to_one :tenant
  one_to_many :teams_users
  many_to_many :teams, :through => :teams_users
  one_to_many :article_interactions

  def before_save
    if auth_token.blank?
      self.auth_token              = generate_authentication_token
      self.auth_token_generated_at = Time.now
    end
  end

  def interactions_read
    article_interactions_dataset.read
  end

  def is_team_leader? team
    team.leaders.include? self
  end

  # attr_accessor :id, :name, :age

  # def entity
  #   Entity.new(self)
  # end

  # class Entity < Grape::Entity
  #   expose :id, :name, :age
  # end

  def generate_authentication_token
    loop do
      token = SecureRandom.base64(24)
      break token unless User.where(auth_token: token).first
    end
  end
  private :generate_authentication_token
end
