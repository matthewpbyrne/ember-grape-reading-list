require 'helper'

class API::TeamAPITest < MiniTest::Test
  include Rack::Test::Methods

  def setup
    @user    = create :user
    login @user
  end

  def test_create
    article = create :article
    assert_difference 'ArticleInteraction.count' do
      post 'v1/article_interactions/',
        { 'article_interaction' => {
          'read'       => 'true',
          'user_id'    => @user.id,
          'article_id' => article.id }
        },  :format => 'json'
    end
  end

  def test_update
    article = create :article
    interaction = create(:article_interaction,
                         :user_id    => @user.id,
                         :article_id => article.id,
                         :read       => false)

    assert_difference 'ArticleInteraction.read.count' do
      put "v1/article_interactions/#{interaction.id}",
        { 'article_interaction' => { 'read' => 'true' } }, :format => 'json'
    end
  end
end
