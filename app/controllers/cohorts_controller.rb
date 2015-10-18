class CohortsController < ApplicationController
  after_action :verify_authorized, :except => [:index, :my]

  def index
    cohorts = Cohort.search(current_user, params[:q])
    render json: cohorts
  end

  def show
    @cohort      = Cohort.find(params[:id]).decorate
    authorize @cohort
    return redirect_to staff_cohort_path(@cohort) if current_user.instructor?
    student = current_user.student
    render locals: {
      students: @cohort.students.order(last_active_at: :DESC).map(&:decorate),
      assignments: filtered_assignments,
      adjustments: student.marked_checkins,
      cohort: student.cohort.decorate,
    }
  end

  def my
    if current_user && current_user.student?
      redirect_to cohort_path(current_user.student.cohort)
    elsif current_user && current_user.instructor? && session[:cohort_id]
      redirect_to staff_cohort_path(session[:cohort_id])
    elsif current_user && current_user.instructor?
      redirect_to staff_cohorts_path
    else
      render layout: "application", html: "Not enrolled in a cohort. Contact your instructor."
    end
  end

  private
  def filtered_assignments
    current_student = current_user.student
    case params.fetch(:filter, 'all')
    when 'incomplete' then Assignment.incomplete_for(current_student)
    when 'complete'   then Assignment.complete_for(current_student)
    when 'late'       then Assignment.late_for(current_student)
    when 'all'        then Assignment.for(current_student)
    end
  end
end
