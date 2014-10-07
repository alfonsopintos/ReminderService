class CallWorker

include Sidekiq::Worker
sidekiq_options retry: false

  def perform
    tomorrow = Date.tomorrow
    EventRecurrence.all.each do |event|     
      event.dates.each do |duedate|     
        if (duedate == tomorrow) && (event.contact_method == 'phone call')
        account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
        auth_token = "65796c1331a3c329820dd1f22033946e"
        message = "#{event.call_reminder}"
        url = "http://twimlets.com/voicemail?Message=#{URI::encode message}"
        number_to_send_to = event.cell_phone
        twilio_phone_number = "(954)-933-5130"
        @twilio_client = Twilio::REST::Client.new account_sid, auth_token
        @twilio_client.account.calls.create(
        :from => twilio_phone_number,
        :to => number_to_send_to,
        :url => url)
        end
      end
    end
  end
end