class Call < ActiveRecord::Base
  belongs_to :event_recurrence

  validates :cell_phone, presence: true
  validates :cell_phone, length: { is: 10 }
  validates :cell_phone, :numericality => {:only_integer => true}
  validates :call_reminder, presence: true
end
