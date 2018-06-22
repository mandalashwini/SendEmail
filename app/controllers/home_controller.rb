class HomeController < ApplicationController
  def index
  end
  def create
  #  render plain: request.env['omniauth.auth'].inspect
    
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
 end
  redirect_to root_path
  end

  def find_expires_at(expires_at)
    @expires_at=Time.at(expires_at.to_i)
  end

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

  def view

    render plain: params.inspect
  end
end
