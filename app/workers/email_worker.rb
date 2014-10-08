class EmailWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    tomorrow = Date.tomorrow
    Email.all.each do |email|     
      email.event_recurrence.dates.each do |duedate|  
        if (duedate == tomorrow)
          #RemindMailer calls on our ActionMailer class 
          #'send_email' is the name of the method in our RemindMailer class. 
          #('email.id') is the id that corresponds to the email instance. 
          # Its being passed as an arguement so the worker can identify who to send the email to.
          #.deliver! is used to send right away.
          RemindMailer.send_email(email.id).deliver!
        end
      end
    end
  end
end