require 'rails_helper'

RSpec.describe Report, type: :model do
  
  context 'when sender has fake phone_number' do 
    it 'should not be valid' do 
      report = Report.new(sender: '555-555-5555', message: 'Hi')
      report.validate
      expect(report.valid?).to be false
    end
  end
end
