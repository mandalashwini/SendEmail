class HomeController < ApplicationController
  def index
  end
  def create  
puts "===>",request.env['omniauth.auth']
client=Access_token.find_redirect_url
client.code=params["code"]
token_data=client.fetch_access_token!
@email=Access_token.get_username(token_data["access_token"])
puts "Access_token ------>#{token_data["access_token"]} \n Refresh_token--------->#{token_data["refresh_token"]}"
puts token_data 
if token_data["refresh_token"].present?
  @user=User.new(email: @email,token:token_data["access_token"],refreshtoken: token_data["refresh_token"],expiresat:find_expires_at(token_data["expires_in"]))
  @user.save!
else
 @user=User.where(email: @email).update_all(token: token_data["access_token"],expiresat: find_expires_at(token_data["expires_in"]))
end
LoginUser.create(email: @email) 
  redirect_to mail_compose_path
  end

  def find_expires_at(expires_at)
    @expires_at=Time.at(expires_at.to_i)
  end
  
  def gmail_redirect_uri
  
   # client=Access_token.find_redirect_url
    #render plain: uri.inspect
    #authorization = client.authorization_uri.to_s
    authorization="https://accounts.google.com/signin/oauth/oauthchooseaccount?client_id=851460829618-h4upoo5b8v7qdfhpsf3n1h90u1rahpe7.apps.googleusercontent.com&as=0VPoMyY5v51UVZ-o4rZM4w&destination=http%3A%2F%2Flocalhost%3A3000&approval_state=!ChRWNHktVmJrS193Slpvd1VxcE1iNxIfRXlyZFlQUDk5UXNZOEhuU1JuY2dubW9lUXBxLVF4WQ%E2%88%99AB8iHBUAAAAAWzN41eWLNuC3OIvNrrhFJal4UGsuFdM8&xsrfsig=AHgIfE_ZVyvpaa9m8SJa18JsLri8gMrOiA&flowName=GeneralOAuthFlow"
    redirect_to authorization
  end

  def send_email
    puts "inside gmail login"
   #render plain: params.inspect
        receiver=params[:mail_details][:email]
        subject=params[:mail_details][:subject]
        body=params[:mail_details][:body]
        count=params[:mail_details][:count].to_i
        if receiver.empty?
          flash[:alert]="email can't be blank"
          redirect_to :back
        elsif subject.empty?
            flash[:alert]="subject can't be blank"
            redirect_to :back
        elsif count == 0
            flash[:alert]="count can't be blank"
            redirect_to :back
        else
        EmailSenderWorker.perform_async(receiver,subject,body,count)
       redirect_to :back
      end
  end
  def logout
    LoginUser.destroy_all
    flash[:notice]="successfully logout!!"
    redirect_to root_path
  end
end
