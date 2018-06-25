class HomeController < ApplicationController
  def index
  end
  def create  
=begin #  render plain: request.env['omniauth.auth'].inspect
   # redirect_to home_index_path
    auth_hash=request.env['omniauth.auth']
    # session[:id]=User.id
    if auth_hash.present?
          authDetails = auth_hash.credentials
          refresh_token=(authDetails.refresh_token.present?) ? authDetails.refresh_token : nil
          token=(authDetails.token.present?) ? authDetails.token : nil
          email=(auth_hash.info[:email].present?) ? auth_hash.info[:email] : nil
          name=(auth_hash.info[:name].present?) ? auth_hash.info[:name] : nil 
          uid=(auth_hash.uid.present?) ? auth_hash.uid : nil
          expiresAt=find_expires_at(authDetails.expires_at)
        if authDetails.refresh_token
            @user=User.new(name: name,email: email,token: token,uid: uid,refreshtoken: refresh_token,expiresat:expiresAt)
            @user.save
        else
           @user=User.where(email: email).update_all(token: token,uid: uid,expiresat: expiresAt)
    end
=end
client=Access_token.find_redirect_url
client.code=params["code"]
#puts "===>",request.env['omniauth.auth']
token_data=client.fetch_access_token!
@email=Access_token.get_username(token_data["access_token"])
puts "Access_token ------>#{token_data["access_token"]} \n Refresh_token--------->#{token_data["refresh_token"]}"
puts token_data 

if token_data["refresh_token"].present?
  @user=User.new(email: @email,token:token_data["access_token"],refreshtoken: token_data["refresh_token"],expiresat:find_expires_at(token_data["expires_in"]))
  @user.save!
  LoginUser.create(email: @email)
  
else
 @user=User.where(email: @email).update_all(token: token_data["access_token"],expiresat: find_expires_at(token_data["expires_in"]))
#render plain: token_data.inspect
 end

 
  redirect_to root_path
  end

  def find_expires_at(expires_at)
    @expires_at=Time.at(expires_at.to_i)
  end

=begin
  def send_email
    #render plain: params.inspect
    cnt=0
    puts "details---->#{params[:mail_details]}"
    email=params[:mail_details][:email]
    count=params[:mail_details][:count].to_i

    count.times do 
      UserMailer.testing_mail(email).deliver
      cnt=1
    end
   # flash[:notice]="Emails has been sent"
    redirect_to :back
  end
=end
  def view

    render plain: params.inspect
  end

  def gmail_redirect_uri
    client=Access_token.find_redirect_url
    #render plain: uri.inspect
    authorization = client.authorization_uri.to_s
    redirect_to authorization
  end

  def send_email
    puts "inside gmail login"
    cnt = 0
    #render plain: params.inspect
    receiver=params[:mail_details][:email]
    count=params[:mail_details][:count].to_i
    sender=LoginUser.first.email
    token=User.where(email: sender).pluck(:token).first
    gmail=Gmail.connect(:xoauth2,sender,token)
    email = gmail.compose do
      to "#{receiver}"
      subject "Testing Mail"
      body "Have a nice Day!!"
    end
    count.times do 
      email.deliver!
      puts "hhhhhh"
      cnt=1
    end
    flash[:notice]="Emails has been sent"
    #redirect_to :back
    #puts gmail.inbox.count
    redirect_to root_path
  end
end
