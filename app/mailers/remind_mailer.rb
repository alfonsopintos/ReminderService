class RemindMailer < ActionMailer::Base
  default :from => 'fmnapp@gmail.com'

  def email_reminder(email)
    @event_recurrence.email = email
    mail( :to => email,
    :subject => 'Bill Reminder' )
  end

end
