class DashboardController < ApplicationController
  def index
    render locals: {
      assignments: filtered_assignments,
      adjustments: current_student.marked_checkins,
      current_day: current_student.cohort.current_day.decorate
    }
  end

  def cohort
    redirect_to cohort_path(current_student.cohort)
  end

  private
  def filtered_assignments
    case params.fetch(:filter, 'all')
    when 'incomplete' then Assignment.by_week(Assignment.incomplete_for(current_student))
    when 'complete'   then Assignment.by_week(Assignment.complete_for(current_student))
    when 'late'       then Assignment.by_week(Assignment.late_for(current_student))
    when 'all'        then Assignment.by_week(Assignment.for(current_student))
    end
  end
end
