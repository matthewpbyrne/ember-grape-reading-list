module AuthHelpers
  extend Grape::API::Helpers

  def authenticate!
    @current_user = env['warden'].authenticate!(:access_token)
    Tenant.current_id = @current_user.tenant_id
    @current_user
  end

  def current_user
    @current_user
  end
end
