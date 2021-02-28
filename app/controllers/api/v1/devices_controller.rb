module Api 
  module V1
    class DevicesController < ApplicationController
      def index # remove
        devices = Device.all
        render json: devices, include: [:heartbeats, :reports]
      end

      def register
          device = Device.create!(device_params)
          render json: device, status: 200
      end

      def terminate 
        device = Device.find(params[:id])
        device.update(disabled_at: Time.now)
        render json: device
      end

      def alive 
        device = Device.find(params[:device_id])
        if !device.disabled_at
          heartbeat = Heartbeat.create(alive_params)
          render json: heartbeat, status: 200
        else 
          render json: {"error": "This divice is disabled"}, status: 500
        end
      end

      def report 
        device = Device.find(params[:device_id])
        if !device.disabled_at
          report = Report.create(report_params)
          render json: report, status: 200
        else 
          render json: {"error": "This divice is disabled"}, status: 500
        end
      end

      private

      def device_params
        params.require(:device).permit(:phone_number, :carrier, :disabled_at)
      end

      def report_params
        params.permit(:sender, :message, :device_id)
      end

      def alive_params
        params.permit(:device_id)
      end

    end
  end
end