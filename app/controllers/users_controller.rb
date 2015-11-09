class UsersController < ApplicationController
  after_action :verify_authorized, except: [:index, :me]
  before_filter :doorkeeper_authorize!, only: :me

  def index
    users = User.search(current_user, params[:q])
    render json: users
  end

  def me
    render json: current_resource_owner
  end
end
