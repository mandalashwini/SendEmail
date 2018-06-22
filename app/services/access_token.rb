class Access_token

   require 'signet/oauth_2/client'
  client = Signet::OAuth2::Client.new(
  :authorization_uri => 'https://accounts.google.com/signin/oauth2/auth',
  :token_credential_uri =>  'https://www.googleapis.com/oauth2/v3/token',
  :client_id => '851460829618-sijk2l8pc20ptivbrfb6jnpsjpne68k6.apps.googleusercontent.com',
  :client_secret => 'JXlmnJCAyDgYGorbY9vVyY0E',
  :scope => 'email profile',
  :redirect_uri => 'http://localhost:3000'
)
puts "client=>#{client.inspect}"

#client.code = request.query['code']
#puts "token---->",client.fetch_access_token!

#require 'oauth2'
 # client = OAuth2::Client.new('851460829618-sijk2l8pc20ptivbrfb6jnpsjpne68k6.apps.googleusercontent.com', 'client_secret', 'localhost:3000')
  #puts "------------>",client.inpsect
end