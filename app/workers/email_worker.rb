class EmailWorker

include Sidekiq::Worker
sidekiq_options retry: false

  def perform
    tomorrow = Date.tomorrow
    EventRecurrence.all.each do |event|     
      event.dates.each do |duedate|  
        if (duedate == tomorrow) && (event.contact_method == 'email')
        RemindMailer.email_reminder(event.id).deliver!
        end
      end
    end
  end
end