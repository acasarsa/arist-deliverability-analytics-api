class Device < ApplicationRecord
  before_save :normalize_phone
  has_many :heartbeats
  has_many :reports

  validates :phone_number, phone: true
  validates_presence_of :carrier

  private 
  
  def normalize_phone 
    self.phone_number = Phonelib.parse(phone_number).e164
  end
end
