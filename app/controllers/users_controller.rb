class UsersController < ApplicationController
  after_action :verify_authorized, except: [:index, :me]

  def index
    users = User.search(current_user, params[:q])
    render json: users
  end

  def me
    render json: current_user
  end
end
