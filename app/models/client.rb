class Client < ActiveRecord::Base
  has_one :api_key, dependent: :destroy


  after_create :generate_key

  def generate_key
    ApiKey.create!(client_id: self.id)
  end

  def email_counter
    self.email_count += 1
    self.save
  end

  def call_counter
    self.call_count += 1
    self.save
  end

  def text_counter
    self.text_count += 1
    self.save
  end

end
