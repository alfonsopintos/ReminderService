class RemindMailer < ActionMailer::Base
  default from: 'fmnapp@gmail.com'
  include Sidekiq::Mailer

  def email_reminder(email_instance_id)
    @instance = Email.find(email_instance_id)

    email = @instance.email

    mail to: email, subject: "Bill Reminder"  
  end

end
