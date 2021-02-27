module Api 
  module V1
    class DevicesController < ApplicationController
      def index
        devices = Device.all
        render json: devices, include: [:heartbeats, :reports]
      end

      def register
        if params['disabled_at'] == nil #maybe don't need that is there any way to hit the post request if you already have it?
          device = Device.create(device_params)
          render json: device
        else 
          render json: {"error": "This divice is disabled"}, status: 500
        end
      end

      private

      def device_params
        params.require(:device).permit(:phone_number, :carrier, :disabled_at)
      end
    end
  end
end