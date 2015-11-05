class CheckinsController < ApplicationController
  after_action :verify_authorized, :except => :index
  def create
    authorize Checkin.new
    provided_code   = params.fetch(:override_code, 'none')
    distance        = params.fetch(:distance, 0)
    status = Checkin.perform(current_user.student, distance, provided_code)
    render json: status[1], status: status[0]
  end
end
