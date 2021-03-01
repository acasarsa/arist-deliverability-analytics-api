require 'rails_helper'

RSpec.describe Report, type: :model do
  
  it "is valid with valid attributes" do
    device = Device.create!(phone_number: '+14015746041', carrier: 'ABC-Cell')
    report = Report.new(sender: '+14015746041', message: 'Hi', device_id: device.id)
    report.validate
    expect(report).to be_valid
  end

  context 'when sender has fake phone_number' do 
    it 'should not be valid' do 
      device = Device.create!(phone_number: '+14015746041', carrier: 'ABC-Cell')
      report = Report.new(sender: '555-555-5555', message: 'Hi', device_id: device.id)
      report.validate
      expect(report.valid?).to be false
    end
  end
end
