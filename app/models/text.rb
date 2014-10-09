class Text < ActiveRecord::Base
  belongs_to :event_recurrence

  validates :cell_phone, presence: true
  validates :cell_phone, length: { is: 10 }
  validates :cell_phone, :numericality => {:only_integer => true}
  validates :text_reminder, presence: true
  validates :text_reminder, :length => {maximum: 160}

  
end
