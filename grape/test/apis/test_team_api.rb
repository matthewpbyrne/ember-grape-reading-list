require 'helper'

class API::TeamAPITest < MiniTest::Test
  include Rack::Test::Methods

  def setup
    @user  = create :user
    @teams = create_list :team, 3
    @user.stubs(:teams).returns @teams
    login @user
  end

  def test_team_index
    get '/v1/teams/'
    assert last_response.ok?
    assert_equal 3, JSON.parse(last_response.body)['teams'].count
  end

  def test_team_show
    last = @teams.last
    get "/v1/teams/#{last.id}"
    resp = { 'team' => last.to_hash.stringify_keys }
    # This is a hack, but SQLite does not play nice with created_at
    assert_equal resp['team']['id'], JSON.parse(last_response.body)['team']['id']
  end

  def test_team_creation
    assert_difference 'Team.count' do
      post 'v1/teams/', { 'name' => 'New Team' }, :format => 'json'
    end
  end

  def test_membership_creation
    user_2 = create :user, :tenant_id => @user.tenant_id
    team   = @teams.last
    assert_difference 'TeamsUser.count' do
      post "/v1/teams/#{team.id}/memberships/", { 'user_id' => user_2.id }
    end
  end

  def test_article_listings
    article = create :article
    team    = @teams.last
    assert_difference 'team.article_listings_dataset.count' do
      post "/v1/teams/#{team.id}/article_listings/",
        { 'article_listing' =>  { 'article_id' => article.id,
                                  'comment'    => 'Some Text' } }
    end
  end
end
