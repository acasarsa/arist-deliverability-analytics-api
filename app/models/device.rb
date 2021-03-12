class Device < ApplicationRecord
  before_save :normalize_phone
  has_many :heartbeats
  has_many :reports

  validates :phone_number, phone: {possible: false, message: "is invalid"}
  validates_presence_of :carrier, message: "is required"

  private 
  
  def normalize_phone 
    self.phone_number = Phonelib.parse(phone_number).e164
    # went with .e164 instead of .full_e164 because the directions didn't specifcally mention needing an extension & since the app is for text message based communication, I made the judgement call that it wasn't needed. However, this is somehthing I'd ask my senior about in practice. 
  end
end
