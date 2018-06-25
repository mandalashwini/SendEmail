class User < ActiveRecord::Base
        
    def self.connect_to_gmail
        sender=LoginUser.first.email
        token=User.where(email: sender).pluck(:token).first
        @gmail=Gmail.connect(:xoauth2,sender,token)
        @gmail
    end
    
end
