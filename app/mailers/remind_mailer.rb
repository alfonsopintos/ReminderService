class RemindMailer < ActionMailer::Base
  default from: 'fmnapp@gmail.com'
  include Sidekiq::Mailer

  def email_reminder(event_recurrence_id)
    event_recurrence = EventRecurrence.find(event_recurrence_id)

    email = event_recurrence.email

    mail to: email, subject: "Bill Reminder"  
  end

end
