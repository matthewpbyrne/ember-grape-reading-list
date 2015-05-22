class UserAPI < Grape::API
  helpers AuthHelpers

  before do
    authenticate!
  end

  # TODO: Redact auth tokens!!!
  get '/' do
    users = current_user.tenant.users
    { users: users }
  end

  get ':id', requirements: { id: /[0-9]*/ } do
    user = User.find id: params[:id]
    { user: user }
  end

  get '/*' do
    { message: 'Garbage In, Garbage Out' }
    # redirect "/notfound"
  end
end

