class User < ActiveRecord::Base
        
    def self.connect_to_gmail
        sender=LoginUser.first.email
        token=User.where(email: sender).pluck(:token).first
        @gmail=Gmail.connect(:xoauth2,sender,token)
        @gmail
    end
    
    def self.email_sender(gmail,receiver,subject,body)
        @gmail=gmail
        email = @gmail.compose do
            to "#{receiver}"
            subject "#{subject}"
            body "#{body}"
          end
           email.deliver!
    end
    def self.calculate_time
        time = Time.now
        hr = time.hour
        min = time.min
        new_time = hr.to_s+":"+min.to_s
    end
end
