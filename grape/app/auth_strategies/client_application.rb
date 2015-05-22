class ClientApplication
  # REQUIRED
  def self.locate(client_id, client_secret = nil)
    puts 'ClientApplication.locate'
    puts client_id
    puts client_secret
    # Should return a client application matching the client_id
    # provided, but should ONLY match client_secret if it is
    # provided.
  end

  # OPTIONAL
  def scope?(scope)
    puts 'ClientApplication.scope'
    puts scope
    # True if the client should be able to access the scope passed
    # (usually a symbol) without having an access token.
  end
end