Rails.application.config.middleware.use OmniAuth::Builder do
provider :google_oauth2,"327439696465-nmi9jr6o566l0iappo30ib1ojvehjcd6.apps.googleusercontent.com", "J43P8vawdFbi3okt6WWOoR96"
    {
      name: 'google_oauth2',
      scope: 'email profile https://mail.google.com/',
      access_type: 'offline',
      prompt: 'select_account',
      image_aspect_ratio: 'original',
      image_size: 50,
      skip_jwt: true
    }
end