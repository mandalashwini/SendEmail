class Access_token

      def self.find_redirect_url
      require 'signet/oauth_2/client'
      client = Signet::OAuth2::Client.new(
      :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
      :token_credential_uri =>  'https://www.googleapis.com/oauth2/v3/token',
      :client_id => '851460829618-h4upoo5b8v7qdfhpsf3n1h90u1rahpe7.apps.googleusercontent.com',
      :client_secret => '-i5VM884fngsEVmzpA7aCi4Q',
      :scope => 'email profile https://mail.google.com/',
      :redirect_uri => 'http://localhost:3000/auth/callback'
    )
    puts "client=>#{client.inspect}"
   
    authorization = client.authorization_uri.to_s
    authorization

    #client.code = request.query['code']
    #puts "token---->",client.fetch_access_token!

    #require 'oauth2'
    # client = OAuth2::Client.new('851460829618-sijk2l8pc20ptivbrfb6jnpsjpne68k6.apps.googleusercontent.com', 'client_secret', 'localhost:3000')
      #puts "------------>",client.inpsect
      end

      def self.get_client_info
        
      end
end