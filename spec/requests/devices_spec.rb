require 'rails_helper'

RSpec.describe "Devices", type: :request do
  describe "POST /api/v1/register" do 
    it "creates device with status 200 and responds to JSON by default" do 
      post "/api/v1/register", params: { device: { phone_number: "1231231234", carrier: "Cell-ONE"}}
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "PATCH /api/v1/terminate" do 
    it "updates disabled_at to current timestamp" do
      device = Device.create(phone_number: "+1231231234", carrier: "XCL", disabled_at: nil)
      patch '/api/v1/terminate', params: { id: device.id, disabled_at: Time.now }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/alive" do 
    it "creates a heartbeat with status 200 when device is not disabled" do 
      device = Device.create(phone_number: "+12231231234", carrier: "XCL", disabled_at: nil)
      post '/api/v1/alive', params: {device_id: device.id}
      expect(response).to have_http_status(200)
    end

    it "throws an error and returns status 500 if device is disabled" do 
      device = Device.create(phone_number: "+12231231234", carrier: "XCL", disabled_at: Time.now)
      post '/api/v1/alive', params: {device_id: device.id}
      expect(response).to have_http_status(500)
    end

    describe "POST /api/v1/report" do
      it "creates a report with status 200 when device is not disabled and allows for utf-8 text" do 
        device = Device.create(phone_number: "+12231231234", carrier: "XCL", disabled_at: nil)
        post '/api/v1/alive', params: {device_id: device.id, sender: '+12231231234', message: 'send dog pics 🐕🐕🐕'}
        expect(response).to have_http_status(200)
      end

      it "throws an error and returns status 500 if device is disabled" do 
        device = Device.create(phone_number: "+12231231234", carrier: "XCL", disabled_at: Time.now)
        post '/api/v1/alive', params: {device_id: device.id, sender: '+12231231234', message: 'send dog pics'}
        expect(response).to have_http_status(500)
      end
    end

    # make test for the correct phone number format 
    # see about fixing the test for device creation
    # make the first tests neater like these ones
  end


end
