require 'rails_helper'

RSpec.describe Device, type: :model do

  it "is valid with valid attributes" do
    device = Device.create!(phone_number: '+14015746041', carrier: 'ABC-Cell')
    expect(device).to be_valid
  end

  context 'with fake phone_number' do 
    it 'should not be valid' do 
      device = Device.new(phone_number: '555-555-5555', carrier: 'Verizon')
      device.validate 
      expect(device.valid?).to be false
    end
  end

  context 'with non-e164 formatting' do
    context 'without country code' do
      it 'should parse into e164 format with default country code "US"' do 
        device = Device.create!(phone_number: '(401) 574-6041', carrier: 'Verizon')
        actual = device.phone_number
        expected = '+14015746041'
        expect(actual).to eq(expected)
      end
    end
  end

  context 'with non-e164 formatting' do 
    it 'parses international numbers into e164 format' do 
      device = Device.create!(phone_number: '+49 30 901820', carrier: 'Vodafone')
      actual = device.phone_number
      expected = '+4930901820'
      expect(actual).to eq(expected)
    end
  end

  context 'with blank phone_number' do 
    it 'should not be valid' do 
      device = Device.new(phone_number: '', carrier: 'Verizon')
      device.validate 
      expect(device.valid?).to be false
    end
  end

  context 'with blank carrier' do 
    it 'should not be valid' do 
      device = Device.new(phone_number: '+14015746041', carrier: '')
      device.validate 
      expect(device.valid?).to be false
    end
  end
end
