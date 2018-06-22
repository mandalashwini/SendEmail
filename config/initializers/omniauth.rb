Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth'

provider :google_oauth2,"851460829618-sijk2l8pc20ptivbrfb6jnpsjpne68k6.apps.googleusercontent.com", "JXlmnJCAyDgYGorbY9vVyY0E"
    {
      name: 'google_oauth2',
      scope: 'email, https://mail.google.com/, https://www.googleapis.com/auth/contacts.readonly, https://www.googleapis.com/auth/pubsub'
      access_type: 'offline',
      prompt: 'select_account',
      image_aspect_ratio: 'original',
      image_size: 50,
      skip_jwt: true
    }
end