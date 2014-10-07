class Email < ActiveRecord::Base
  belongs_to :event_recurrence

  #validate email_address
  
end
