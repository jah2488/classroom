class CohortsController < ApplicationController
  after_action :verify_authorized, :except => [:index, :my]
  after_action :verify_policy_scoped, :only => :index

  def show
    @cohort      = Cohort.find(params[:id]).decorate
    authorize @cohort
    student = current_user.student
    render locals: {
      students: @cohort.students.order(last_active_at: :DESC).map(&:decorate),
      assignments: filtered_assignments,
      adjustments: student.marked_checkins,
      cohort: student.cohort,
    }
  end

  def my
    if current_user && current_user.student?
      redirect_to cohort_path(current_user.student.cohort)
    elsif current_user && current_user.instructor?
      redirect_to staff_cohorts_path if current_user.instructor?
    else
      render layout: "application", html: "Not enrolled in a cohort. Contact your instructor."
    end
  end

  private
  def filtered_assignments
    current_student = current_user.student
    case params.fetch(:filter, 'all')
    when 'incomplete' then Assignment.by_week(Assignment.incomplete_for(current_student))
    when 'complete'   then Assignment.by_week(Assignment.complete_for(current_student))
    when 'late'       then Assignment.by_week(Assignment.late_for(current_student))
    when 'all'        then Assignment.by_week(Assignment.for(current_student))
    end
  end
end
