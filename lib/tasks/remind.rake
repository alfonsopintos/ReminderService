desc "send off text, email, and call reminders"
  
task remind: :environment do  

############## Call Reminder #################
  tomorrow = Date.tomorrow
    Call.all.each do |call|     
      call.event_recurrence.dates.each do |duedate|     
        if (duedate == tomorrow)
          account_sid = "AC458c66afe8c3be7f362e34e212c63b84"
          auth_token = "65796c1331a3c329820dd1f22033946e"
          message = "#{call.call_reminder}"
          url = "http://twimlets.com/voicemail?Message=#{URI::encode message}"
          number_to_send_to = call.cell_phone
          twilio_phone_number = "(954)-933-5130"
          @twilio_client = Twilio::REST::Client.new account_sid, auth_token
          @twilio_client.account.calls.create(
          :from => twilio_phone_number,
          :to => number_to_send_to,
          :url => url)
        end
      end
    end
############## Text Reminder #################
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
############## Email Reminder #################
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