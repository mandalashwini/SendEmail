class EmailSenderWorker
  include Sidekiq::Worker
  def perform(gmail,receiver,subject)
      @gmail=gmail
    binding.pry
    email = @gmail.compose do
      to "#{receiver}"
      subject "#{subject}"
      body "!!!!!!Have a nice Day!!"
    end
     email.deliver!
     puts "111111111111"
  end
end
