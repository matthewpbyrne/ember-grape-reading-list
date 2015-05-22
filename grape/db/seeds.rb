require 'faker'
require 'require_all'

require_all 'config'
require_all 'app'

ARTICLES_COUNT              = 100
ARTICLE_INTERACTIONS_COUNT  = 25
ARTICLE_LISTINGS_COUNT      = 12
MEMBERSHIP_COUNT            = 4
TEAM_COUNT                  = 3
TENANT_COUNT                = 3
USER_COUNT                  = 4

#### Tenants ####
0.upto(TENANT_COUNT) do |i|
  name   = Faker::Company.name
  domain = Faker::Internet.domain_name
  Tenant.create :name => name, :domain_name => domain
end
puts "#{Tenant.count} tenants created"

#### Users ####
tenant = Tenant.first
user = User.create :tenant_id => tenant.id,
            :name => 'Joe Regular',
            :email => "joe@#{tenant.domain_name}",
            :password => 'password',
            :password_confirmation => 'password'


Tenant.each do |t|
  0.upto(USER_COUNT) do
    first_name     = Faker::Name.first_name
    last_name      = Faker::Name.last_name
    name           = first_name + " " + last_name
    email          = "#{first_name.downcase}@#{t.domain_name}"
    password       = Faker::Internet.password
    last_active_at = Faker::Time.between(1.month.ago, Time.now)

    User.create :tenant_id => t.id,
                :name => name,
                :email => email,
                :password => password,
                :password_confirmation => password,
                :last_active_at => last_active_at
  end
end
puts "#{User.count} users created"

#### Teams ####
Tenant.each do |t|
  0.upto(TEAM_COUNT) do
    name = Faker::Commerce.department 2
    Team.create :tenant_id => t.id,
                :name => name
  end
end
puts "#{Team.count} teams created"

#### Memberships ####
Team.each do |team|
  users = team.tenant.users
  0.upto(MEMBERSHIP_COUNT) do |i|
    user = users.sample
    leader = (i == 0 ? true : false )
    TeamsUser
      .find_or_create(:user_id => user.id,
                      :team_id => team.id){ |a| a.leader = leader }
  end
end
puts "#{TeamsUser.count} memberships created"

#### Articles ####
0.upto(ARTICLES_COUNT) do
  url = Faker::Internet.url
  Article.create :url => url
end
puts "#{Article.count} article created"

#### ArticleInteractions ####
User.each do |user|
  0.upto(ARTICLE_INTERACTIONS_COUNT) do
    article = Article.all.sample
    ArticleInteraction
      .find_or_create(:article_id => article.id,
                      :user_id => user.id){ |a| a.read = true }
  end
end
puts "#{ArticleInteraction.count} article_interactions created"

#### ArticleListings ####
Team.each do |team|
  0.upto(ARTICLE_LISTINGS_COUNT) do
    article = Article.all.sample
    comment = Faker::Lorem.sentence
    ArticleListing
      .find_or_create(:article_id => article.id,
                      :team_id => team.id){ |a| a.comment = comment }
  end
end
puts "#{ArticleListing.count} article_listings created"

admin = User.create :name => 'John Superpower',
                    :email => 'admin@reader.com',
                    :password => 'password',
                    :password_confirmation => 'password',
                    :admin => true

user = User.first
puts "Example regular user: #{user.name} (u: #{user.email}, p: password)"
puts "Admin user created: #{admin.name} (u: #{admin.email}, p: #{admin.password})"
