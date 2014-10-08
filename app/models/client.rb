class Client < ActiveRecord::Base
  has_one :api_key

  after_create :generate_key

  def generate_key
    ApiKey.create!(client_id: self.id)
  end
end
