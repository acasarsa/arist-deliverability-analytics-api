class Report < ApplicationRecord
  before_save :normalize_phone
  belongs_to :device

  def normalize_phone 
    self.sender = Phonelib.parse(sender).e164
  end
end
