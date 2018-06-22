Rails.application.routes.draw do
  
  root 'home#index'
  get 'home/index'
  post 'home/send_email' , to: 'home#send_email', as: 'send'
  match 'auth/callback',to: 'home#create',:via =>[:get,:post], as: 'google_connect'
  get 'auth/failure', to: redirect('/')
  get 'home/gmail_login', to: 'home#gmail_login' , as: 'gmail_uri'
 
end
