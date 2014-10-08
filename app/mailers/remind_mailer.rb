class RemindMailer < ActionMailer::Base
  default from: 'fmnapp@gmail.com'
  include Sidekiq::Mailer

  #send_email takes the id of the email instance it has to send as an arguement
  def send_email(email_id)
    #variable 'send' represents the instance of the email to send. Obtains it through the (email_id) parameter
    send = Email.find(email_id) 
    #tells Mailer to send email to the email_address of that instance. being represented here by send
    mail to: send.email_address, subject: "Bill Reminder"  
  end

end
