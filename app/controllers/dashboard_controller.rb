class DashboardController < ApplicationController
  def index
    render locals: {
      assignments: filtered_assignments,
      current_day: Day.current_for(current_student.cohort)
    }
  end

  def cohort
    render locals: {
      students: current_student.cohort.students.order('last_active_at')
    }
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
