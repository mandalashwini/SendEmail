class EmailSenderWorker
  include Sidekiq::Worker

  def perform(*args)
    50.times do 
      puts "ashu"
      sleep(10)
    end
  end
end
