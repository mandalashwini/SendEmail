class Access_token

      def self.find_redirect_url
      require 'signet/oauth_2/client'
      @client = Signet::OAuth2::Client.new(
      :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
      :token_credential_uri =>  'https://www.googleapis.com/oauth2/v3/token',
      :client_id => '851460829618-h4upoo5b8v7qdfhpsf3n1h90u1rahpe7.apps.googleusercontent.com',
      :client_secret => '-i5VM884fngsEVmzpA7aCi4Q',
      :scope => 'email profile https://mail.google.com/ https://www.googleapis.com/auth/gmail.modify https://www.googleapis.com/auth/gmail.compose https://www.googleapis.com/auth/gmail.readonly https://www.googleapis.com/auth/gmail.metadata',
      :redirect_uri => 'http://localhost:3000/auth/callback'
    )
    
      end
      def self.get_username(access_token)
        @response=JSON.parse(RestClient.get "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=#{access_token}")
        @response["email"]
      end
     
end