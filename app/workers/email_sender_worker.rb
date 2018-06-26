class EmailSenderWorker
  include Sidekiq::Worker
  def perform(receiver,subject)
    @gmail=User.connect_to_gmail
  #  User.email_sender(@gmail,receiver,subject)
    email = @gmail.compose do
      to "#{receiver}"
      subject "#{subject}"
      body "@@@Have a nice Day!!"
    end
     email.deliver!
     @gmail.logout
  end
end
