class Email < ActiveRecord::Base
  belongs_to :event_recurrence

  validates :email_reminder, presence: true
  validates :email_address, presence: true
  validates_format_of :email_address, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

end
