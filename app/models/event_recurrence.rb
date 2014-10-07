class EventRecurrence < ActiveRecord::Base
  
  has_one :text, :dependent => :destroy
  has_one :call, :dependent => :destroy
  has_one :email, :dependent => :destroy


  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :every, presence: true
  validates :object_id, presence: true

  # validates :start_date, :must_be_before_end_date  
  # validates :end_date, :must_be_after_start_date
  
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

  def must_be_after_start_date 
    errors.add(:end_date, "End Date cannot be before start Date.") if
    start_date > end_date    
  end

  def must_be_before_end_date
    errors.add(:start_date, "Start Date cannot be after End Date.") if
    start_date > end_date 
  end

end
