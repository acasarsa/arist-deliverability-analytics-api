module Api 
  module V1
    class DevicesController < ApplicationController
      def index
        devices = Device.all
        render json: devices, include: [:heartbeats, :reports]
      end

      def register
          device = Device.create(device_params)
          render json: device
      end

      def terminate 
        device = Device.find(params[:id])
        device.update(disabled_at: Time.now)
        render json: device
      end

      def alive 
        device = Device.find(params[:device_id])
        if !device.disabled_at
          heartbeat = Heartbeat.create(device_id: device.id)
          render json: heartbeat
        else 
          render json: {"error": "This divice is disabled"}, status: 500
        end
      end

      def report 
        device = Device.find(params[:device_id])
        if !device.disabled_at
          # may consider setting sender: device.phone_number unless this is supposed to be a name or whatever the user sets it to be
          # binding.pry
          report = Report.create(sender: params[:sender], message: params[:message], device_id: params[:device_id])
          render json: report
        else 
          render json: {"error": "This divice is disabled"}, status: 500
        end
      end

      private

      def device_params
        params.require(:device).permit(:phone_number, :carrier, :disabled_at)
      end

      # def report_params
      #   params.require(:report).permit(:sender, :message, :device_id)
      # end
    end
  end
end