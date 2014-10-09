class EventRecurrence < ActiveRecord::Base
  
  has_one :text, dependent: :destroy
  has_one :call, dependent: :destroy
  has_one :email, dependent: :destroy


  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :every, presence: true
  validates :object_id, presence: true

  validate :end_date_is_after_start_date, 
    :start_date_is_before_end_date

  before_save :correct_every_and_interval
  


  def correct_every_and_interval
    self.interval = 
      case self.every
      when 'every two weeks'
         2 #weeks
      when 'twice a year'
         6 #months 
      end
    self.every = 
      case self.every
      # when 'day'
      #   'day'
      # when 'week'
      #   'week'
      when 'every two weeks'
        'week'
      when 'twice a year'
        'month'
      when 'month'
        'month'
      when 'year'
        'year'
      end
  end
  
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
    Recurrence.new(options).events
  end

  def end_date_is_after_start_date 
    errors.add(:end_date, "Check your Dates. End Date cannot be before start Date. An event must have a start date, previous to its end date") if
    start_date > end_date    
  end

  def start_date_is_before_end_date
    errors.add(:start_date, "You must start your event before its own end date. An event cannot start after its end date") if
    start_date > end_date 
  end

end
