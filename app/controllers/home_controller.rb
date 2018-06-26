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
  LoginUser.create(email: @email) 
else
 @user=User.where(email: @email).update_all(token: token_data["access_token"],expiresat: find_expires_at(token_data["expires_in"]))
 end
  redirect_to mail_compose_path
  end

  def find_expires_at(expires_at)
    @expires_at=Time.at(expires_at.to_i)
  end
  
  def gmail_redirect_uri
  
  #  client=Access_token.find_redirect_url
    #render plain: uri.inspect
    #authorization = client.authorization_uri.to_s
    authorization="https://accounts.google.com/signin/oauth/oauthchooseaccount?client_id=851460829618-h4upoo5b8v7qdfhpsf3n1h90u1rahpe7.apps.googleusercontent.com&as=BCJMcu5BVJlSc738g-r4wA&destination=http%3A%2F%2Flocalhost%3A3000&approval_state=!ChQzbUpwb1lrazA3ZHlXOTd4dkJSTRIfMDFkWUgzUW00SFlTOEhuU1JuY2dubW9lWHhWb1F4WQ%E2%88%99AB8iHBUAAAAAWzIWc2QeDvx8xT1UQ28R_D4XeWsQiEyw&xsrfsig=AHgIfE-dUvHehWZXWLM3ZI3fZDF-v3njNw&flowName=GeneralOAuthFlow"
    redirect_to authorization
  end

  def send_email
    puts "inside gmail login"
    cnt = 0
   # render plain: params.inspect
        receiver=params[:mail_details][:email]
        subject=params[:mail_details][:subject]
        count=params[:mail_details][:count].to_i
        if receiver.empty?
          flash[:alert]="email can't be blank"
          redirect_to :back
        elsif subject.empty?
            flash[:alert]="subject can't be blank"
            redirect_to :back
        else
     #   @gmail=User.connect_to_gmail
       
        count.times do 
          EmailSenderWorker.perform_async(receiver,subject)
=begin
            email = @gmail.compose do
              to "#{receiver}"
              subject "#{subject}"
              body "!!!!!!Have a nice Day!!"
            end
            email.deliver!
=end
                puts "ppppppppppppp"
                sleep(10)
                cnt=1
        end
       
        #flash[:notice]="Emails has been sent"
        #redirect_to :back
        #puts gmail.inbox.count
       redirect_to root_path
      end
  end
  
end
