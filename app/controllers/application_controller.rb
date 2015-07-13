class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone


  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found', layout: 'layouts/application', status: 404 }
      format.json { render json: { message: 'route not found' }, status: 404 }
    end
  end

  def server_error
    @error = $!
    respond_to do |format|
      format.html { render template: 'errors/internal_server_error', layout: 'layouts/error', status: 500 }
      format.json { render json: { message: 'An internal error occured' }, status: 500 }
    end
  end

  protected

  def set_time_zone
    Time.zone = 'America/Chicago'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :phone << :office_hours_start << :office_hours_end << :cohort_id
  end
end
