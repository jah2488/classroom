class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone

  protected

  def set_time_zone
    Time.zone = 'America/Chicago'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :phone << :office_hours_start << :office_hours_end << :cohort_id
  end
end
