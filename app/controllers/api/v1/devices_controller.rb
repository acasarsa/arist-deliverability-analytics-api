module Api 
  module V1
    class DevicesController < ApplicationController
######################################################################
########### I added the index action and associated endpoint 
########### to test my endpoints via Postman
######################################################################

      def index 
        devices = Device.all
        render json: devices, include: [:heartbeats, :reports]
      end

######################################################################
########### expected controller actions for challenge ################
######################################################################

      def register
          device = Device.create(device_params)
          if device.valid? 
            render json: device, status: 200
          else 
            render json: {"error": device.errors.full_messages}, status: 500
          end
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
          render json: {"error": "This device is disabled"}, status: 500
        end
      end

      def report 
        device = Device.find(params[:device_id])
        if !device.disabled_at
          report = Report.create(report_params)
          if report.valid? 
            render json: report, status: 200
          else 
            render json: {"error": report.errors.full_messages[0]}, status: 500 # only 1 validation so rendering the only error
          end
        else 
          render json: {"error": "This device is disabled"}, status: 500
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