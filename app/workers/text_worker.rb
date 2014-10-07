class TextWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    tomorrow = Date.tomorrow
    Text.all.each do |text|     
      text.event_recurrence.dates.each do |duedate|
        if (duedate == tomorrow)
          account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
          auth_token = "65796c1331a3c329820dd1f22033946e"
          number_to_send_to = text.cell_phone
          twilio_phone_number = "(954)-933-5130"
          @twilio_client = Twilio::REST::Client.new account_sid, auth_token
          @twilio_client.account.sms.messages.create(
          :from => twilio_phone_number,
          :to => number_to_send_to,
          :body => "#{text.text_reminder}")
        end
      end
    end
  end 
end

    
  