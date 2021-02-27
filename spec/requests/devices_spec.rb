require 'rails_helper'

RSpec.describe "Devices", type: :request do
  # describe "GET /api/v1/devices" do
  #   it "works! (now write some real specs)" do
  #     get api_v1_devices_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe "POST /api/v1/devices" do 
    it "creates device with status 200" do 
      post "/api/v1/register", :params => { 
        "device":  { 
          "phone_number": "1231231234", 
          "carrier": "Cell-ONE"
        }}
        expect(response).to have_http_status(200)
        # expect(response.content_type).to eq("application/json; charset=utf-8")
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
end
