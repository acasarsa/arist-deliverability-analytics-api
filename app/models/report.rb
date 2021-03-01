class Report < ApplicationRecord
  before_save :normalize_phone
  belongs_to :device

  validates :sender, phone: {possible: false, message: "phone number is invalid"}

  private 

  def normalize_phone 
    self.sender = Phonelib.parse(sender).e164
  end
end
