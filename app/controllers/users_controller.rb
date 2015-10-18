class UsersController < ApplicationController
  after_action :verify_authorized, :except => :index

  def index
    users = User.search(current_user, params[:q])
    render json: users
  end
end
