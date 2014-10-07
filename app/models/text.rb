class Text < ActiveRecord::Base
  belongs_to :event_recurrence

  validates :cell_phone, length: { is: 10 }
  validates :cell_phone, :numericality => {:only_integer => true}

  #validate message is no longer than 160 characters

end
