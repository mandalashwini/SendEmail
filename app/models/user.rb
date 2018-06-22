class User < ActiveRecord::Base
    
    def self.connet_to_gmail
        require 'gmail'
        user=User.first
        gmail=Gmail.connect(:xoauth2,user.email,user.token)
        if gmail.logged_in?
            puts "success"
        else
            puts "fail"
        end

    end
end
