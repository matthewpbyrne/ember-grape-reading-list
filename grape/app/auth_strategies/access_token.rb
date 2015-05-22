class AccessToken
  # REQUIRED
  def self.locate(token_string)
    puts 'AccessToken locate:'
    puts token_string
    # Should return an access token matching the string provided.
    # Note that you MAY include expired access tokens in the result
    # of this method so long as you implement an instance #expired?
    # method.
    
  end

  # OPTIONAL
  def expired?
    puts 'AccessToken expired:'
    # True if the access token has reached its expiration.
  end

  # OPTIONAL
  def scope?(scope)
    puts 'AccessToken scope?'
    puts scope
    # True if the scope passed in (usually a symbol) has been authorized
    # for this access token.
  end
end
