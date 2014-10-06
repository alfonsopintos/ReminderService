class FirstWorker
  include Sidekiq::Worker

  def perform(event_recurrence_id)
    event_recurrence = EventRecurrence.find(event_recurrence_id)
    account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
    auth_token = "65796c1331a3c329820dd1f22033946e"

    number_to_send_to = event_recurrence.cell_phone
    twilio_phone_number = "(954)-933-5130"

    @twilio_client = Twilio::REST::Client.new account_sid, auth_token

    @twilio_client.account.sms.messages.create(
    :from => twilio_phone_number,
    :to => number_to_send_to,
    :body => "#{event_recurrence.initial}")
  end
  
end