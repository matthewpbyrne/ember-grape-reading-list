require 'helper'

class API::UserAPITest < MiniTest::Test
  include Rack::Test::Methods

  def setup
    @user       = create :user
    @colleagues = create_list :user, 3, :tenant_id => @user.tenant_id

    tenant_id   = create(:tenant).id
    @rivals     = create_list :user, 10, :tenant_id => tenant_id
    login @user
  end

  def test_user_index
    get '/v1/users/'
    assert last_response.ok?
    assert_equal 4, JSON.parse(last_response.body)['users'].count
  end
end
