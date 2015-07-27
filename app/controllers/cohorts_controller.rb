class CohortsController < ApplicationController
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  def show
    @cohort      = Cohort.find(params[:id]).decorate
    authorize @cohort
    student = current_user.student
    render locals: {
      students: @cohort.students.order(last_active_at: :DESC),
      assignments: filtered_assignments,
      adjustments: student.marked_checkins,
      current_day: student.cohort.current_day.decorate,
    }
  end

  def my
    if current_user && current_user.student?
      redirect_to cohort_path(current_user.student.cohort)
    else
      render "Not enrolled"
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
