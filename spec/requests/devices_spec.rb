require 'rails_helper'

RSpec.describe "Devices", type: :request do 
  context "when POST request made to /register endpoint" do 
    context "when params are valid" do
      it "is should create new device with content type of json" do 
        post "/api/v1/register", params: { device: { phone_number: "+14015746041", carrier: "Cell-ONE"}}
        post "/api/v1/register", params: { device: { phone_number: "+14015746041", carrier: "Vodafone"}}
          expect(Device.count).to eq(2)
          expect(response).to have_http_status(200)
          expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "when params are invalid" do 
      it "should have status code 500 and render an error message" do 
        post "/api/v1/register", params: { device: { phone_number: "555-555-5555", carrier: "Cell-ONE"}}
        expect(response.body).to include("error")
        expect(response).to have_http_status(500)
      end
    end
  end

  context "when PATCH request sent to /terminate endpoint" do 
    context "updates disabled_at to current timestamp" do
      it "should not be nil after success" do 
        device = Device.create!(phone_number: "+14015746041", carrier: "XCL", disabled_at: nil)
        patch '/api/v1/terminate', params: { id: device.id }
        updated_device = Device.find_by_id(device.id)
        actual = updated_device.disabled_at != nil
        expect(actual).to_not be nil
        expect(response).to have_http_status(200)
      end
    end
  end
end
