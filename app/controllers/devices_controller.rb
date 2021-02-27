class DevicesController < ApplicationController
  def index
    devices = Device.all
    render json: devices, include: [:heartbeats]
  end

end
