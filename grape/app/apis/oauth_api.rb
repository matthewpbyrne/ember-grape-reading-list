class OAuthAPI < Grape::API
  post '/token' do
    u = User.find email: params[:username]
    puts params.inspect

    if u.present? && u.authenticate(params[:password])
      token = u.auth_token
    end
    x = {
      access_token: token, # 'youhavenoprivacyandnosecrets',
      token_type: 'bearer',
      user_id: u.id
    }
    puts x.inspect
    x
  end
end
