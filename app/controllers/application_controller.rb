class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :record_student_activity

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    return current_student if current_student
    current_instructor
  end
  def record_student_activity
    current_student.touch(:last_active_at) if current_student
  end

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
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :phone << :office_hours_start << :office_hours_end << :cohort_id
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to :back
  end
end
