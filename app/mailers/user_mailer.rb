class UserMailer < ApplicationMailer
  default from: "ashwini.mandal@cuelogic.com"
  def testing_mail(receiver)
    @receiver=receiver
    mail to: receiver , subject: "Testing mail"
  end
end
