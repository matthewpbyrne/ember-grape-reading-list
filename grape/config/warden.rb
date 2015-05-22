Warden::Strategies.add(:access_token) do
  def valid?
    # Very basic validation here
    request.env["HTTP_ACCESS_TOKEN"].is_a?(String)
  end

  def authenticate!
    access_token = request.env["HTTP_ACCESS_TOKEN"]
    u = User.find :auth_token => access_token
    u.nil? ? fail!("Could not log in") : success!(u)
    u
  end
end
