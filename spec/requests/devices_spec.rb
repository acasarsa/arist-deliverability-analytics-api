require 'rails_helper'

RSpec.describe "Devices", type: :request do
  describe "POST /api/v1/register" do 
    it "creates device with status 200" do 
      post "/api/v1/register", :params => { 
        "device":  { 
          "phone_number": "1231231234", 
          "carrier": "Cell-ONE"
        }}
        expect(response).to have_http_status(200)
    end

    it "responds to JSON by default" do 
      post "/api/v1/register", :params => { 
        "device":  { 
          "phone_number": "1231231234", 
          "carrier": "Cell-ONE"
        }}
        expect(response.content_type).to eq("application/json; charset=utf-8")
    end
    # it "returns status 500 error if device is disabled" do 
    #   post "/api/v1/register", :params => { 
    #     "device":  { 
    #       "phone_number": "1231231234", 
    #       "carrier": "Cell-TWO",
    #       "disabled_at": "2021-02-27T00:22:29.781Z"
    #     }}
    #     expect(response).to have_http_status(500)
    # end
  end

  describe "PATCH /api/v1/terminate" do 
    it "updates disabled_at to current timestamp" do
      device = Device.create(phone_number:  "1231231234", carrier: "XCL", disabled_at: nil)
      patch '/api/v1/terminate', params: { id: device.id, disabled_at: Time.now }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/alive" do 
    it "creates a heartbeat with status 200 when device is not disabled" do 
      device = Device.create(phone_number:  "1231231234", carrier: "XCL", disabled_at: nil)
      post '/api/v1/alive', params: {device_id: device.id}
      expect(response).to have_http_status(200)
    end

    it "throws an error and returns status 500 if device is disabled" do 
      device = Device.create(phone_number:  "1231231234", carrier: "XCL", disabled_at: nil)
      patch '/api/v1/terminate', params: { id: device.id, disabled_at: Time.now }
      post '/api/v1/alive', params: {device_id: device.id}
      expect(response).to have_http_status(500)
    end

  end


end
