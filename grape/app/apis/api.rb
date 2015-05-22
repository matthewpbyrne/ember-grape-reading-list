require 'grape'
require 'grape-entity'
require 'json'
require 'warden-oauth2'

class API < Grape::API
  format :json
  content_type :json, 'application/json'
  default_format :json

  Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
  end
  use Warden::Manager do |config|
      config.scope_defaults :default,
      strategies: [:access_token],
      # Route to redirect to when warden.authenticate! returns a false answer.
      action: '/unauthenticated'
      config.failure_app = self
  end

  mount ArticleAPI => '/v1/articles'
  mount ArticleInteractionAPI => '/v1/article_interactions'
  mount TeamAPI => '/v1/teams'
  mount UserAPI => '/v1/users'
  mount OAuthAPI => '/v1/oauth'
end

