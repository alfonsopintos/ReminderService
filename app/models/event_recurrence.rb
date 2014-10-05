class EventRecurrence < ActiveRecord::Base
  after_create :send_message

  def dates(options={})
      options = {:every => every, :starts => start_date, :until => end_date, :interval => interval || 1}.merge(options)
      
      options[:on] = 
        case options[:every]
        when 'day','month'
          options[:starts].day
        when 'twice a year'
          options[:starts].day
        when 'year'
          [options[:starts].month, options[:starts].day]
        when 'week', 'every two weeks'
            options[:starts].strftime('%A').downcase.to_sym
        end

      options[:every] = 
      case options[:every]
      when 'every two weeks'
        'week'
      when 'twice a year'
        'month'
      when 'month'
        'month'
      when 'year'
        'year'
      end


      Recurrence.new(options).events
    end


    def send_message
      account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
      auth_token = "65796c1331a3c329820dd1f22033946e"

      number_to_send_to = self.cell_phone
      twilio_phone_number = "(954)-933-5130"

      @twilio_client = Twilio::REST::Client.new account_sid, auth_token

      @twilio_client.account.sms.messages.create(
      :from => twilio_phone_number,
      :to => number_to_send_to,
      :body => "Hello #{self.first_name}, You have just added your #{self.provider_name} #{self.category_name} Bill!")
    end


    # def get_twilio
    #   account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
    #   auth_token = "65796c1331a3c329820dd1f22033946e"

    #   number_to_send_to = self.cell_phone
    #   twilio_phone_number = "(954)-933-5130"

    #   client = Twilio::REST::Client.new account_sid, auth_token

    #   yield(client, twilio_phone_number, number_to_send_to)
    # end


    def send_call
      message = "Hello #{self.first_name}! This is a friendly reminder that your #{self.provider_name}, #{self.category_name} bill is due tomorrow.Goodbye!"
      url = "http://twimlets.com/voicemail?Message=#{URI::encode message}"

      account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
      auth_token = "65796c1331a3c329820dd1f22033946e"

      number_to_send_to = self.cell_phone
      twilio_phone_number = "(954)-933-5130"

      @twilio_client = Twilio::REST::Client.new account_sid, auth_token

      @twilio_client.account.calls.create(
      :from => twilio_phone_number,
      :to => number_to_send_to,
      :url => url
      )
    end


end
