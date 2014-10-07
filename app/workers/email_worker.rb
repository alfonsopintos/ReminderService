class EmailWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    tomorrow = Date.tomorrow
    Email.all.each do |email_instance|     
      email_instance.event_recurrence.dates.each do |duedate|  
        if (duedate == tomorrow)
          RemindMailer.email_reminder(email_instance.id).deliver!
        end
      end
    end
  end
end