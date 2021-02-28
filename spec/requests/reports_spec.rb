require 'rails_helper'

RSpec.describe "Reports", type: :request do
  context "When POST request sent to /report endpoint" do
    context "when device is not disabled" do 
      it "should create a new heartbeat and accept UTF-8 formatting" do 
        device = Device.create!(phone_number: "+14015746041", carrier: "Verizon")
        post '/api/v1/report', params: {device_id: device.id, sender: '+14015746041', message: 'send dog pics 🐕🐕🐕'}
        post '/api/v1/report', params: {device_id: device.id, sender: '+14015746041', message: 'send cat pics 🐈🐈🐈'}
        expect(Report.count).to eq(2)
        expect(response.body.encoding.name).to eq('UTF-8')
        expect(response).to have_http_status(200)
      end
    end

    context "when device is disabled" do 
      it "endpoint cannot be reached" do 
        device = Device.create!(phone_number: "+14015746041", carrier: "XCL", disabled_at: Time.now)
        post '/api/v1/report', params: {device_id: device.id, sender: '+14015746041', message: 'i have dog pics!'}
        expect(response).to have_http_status(500)
      end
    end
  end
end
