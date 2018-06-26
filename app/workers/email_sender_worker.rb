class EmailSenderWorker
  include Sidekiq::Worker
  def perform(receiver,subject,body,count)
    @gmail=User.connect_to_gmail
    cnt=1
    count.times do
        day=Date.today.strftime("%A")
        time=User.calculate_time
        new_subject=subject+"_"+cnt.to_s+" "+day+" "+time
        User.email_sender(@gmail,receiver,new_subject,body)
        puts "123"
        cnt = cnt + 1
        sleep(10)
    end
    @gmail.logout
    
  end
end
