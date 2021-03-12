class Report < ApplicationRecord
  before_save :normalize_phone
  belongs_to :device

  validates :sender, phone: {possible: false, message: "phone number is invalid"}
  # only validated for things that were asked for in the deliverables to save time. 
  # If this was a ticket and didn't specify I would ask for clarifaction. 

  private 

  def normalize_phone 
    self.sender = Phonelib.parse(sender).e164
  end
end
