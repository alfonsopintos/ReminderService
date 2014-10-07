class Email < ActiveRecord::Base
  belongs_to :event_recurrence
end
