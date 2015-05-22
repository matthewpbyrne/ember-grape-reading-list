require 'grape-active_model_serializers'
require 'rack/cors'
require 'require_all'

require_all 'config'
require_all 'app'

use Rack::Cors do
  allow do
    origins '*'
    resource '/*', :headers => :any, :methods => [:get, :post, :options, :put]
  end
end

run API
