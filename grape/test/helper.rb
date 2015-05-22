require 'active_support/testing/assertions'
require 'factory_girl'
require 'grape'
require 'json'
require 'minitest/autorun'
require "minitest/unit"
require "mocha/mini_test"
require 'rack/test'
require 'require_all'
require 'yaml'

ENV['RACK_ENV'] = 'test'
require_all 'config'
require_all 'app'

require 'factories'
require 'factorygirl-sequel'


class Minitest::Test
  include ActiveSupport::Testing::Assertions
  include FactoryGirl::Syntax::Methods
  include Warden::Test::Helpers
  
  alias_method :_original_run, :run

  def app
    API
  end

  def login user
    Grape::Endpoint.before_each do |endpoint|
      endpoint.stubs(:authenticate!).returns user
      endpoint.stubs(:current_user).returns user
    end
    Tenant.stubs(:current_id).returns user.tenant_id
  end

  def run(*args, &block)
    result = nil
    Sequel::Model.db.transaction(:rollback => :always, :auto_savepoint=>true) do
      result = _original_run(*args, &block)
    end
    result
  end
  
  def setup
    Warden.test_mode!
  end
  
  def teardown
    Warden.test_reset!
  end
  
  def assert_change(what)
    old = what.call
    yield
    assert_not_equal old, what.call
  end

  def assert_no_change(what)
    old = what.call
    yield
    assert_equal old, what.call
  end  
end
