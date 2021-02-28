require 'rails_helper'

RSpec.describe "Heartbeats", type: :request do
  context "when POST request sent to /alive endpoint" do 
    context "when device is not disabled" do 
      it "should create a heartbeat" do 
        device = Device.create!(phone_number: "+14015746041", carrier: "XCL")
        post '/api/v1/alive', params: {device_id: device.id}
        post '/api/v1/alive', params: {device_id: device.id}
        expect(Heartbeat.count).to eq(2)
        expect(response).to have_http_status(200)
      end
    end

    context "when device is disabled" do 
      it "endpoint cannot be reached" do 
        device = Device.create(phone_number: "+14015746041", carrier: "XCL", disabled_at: Time.now)
        post '/api/v1/alive', params: {device_id: device.id}
        expect(response).to have_http_status(500)
      end
    end
  end
end
