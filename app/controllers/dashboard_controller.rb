class DashboardController < ApplicationController
  def index
    render locals: {
      assignments: filtered_assignments,
      current_day: Day.current_for(current_student.cohort)
    }
  end

  private
  def filtered_assignments
    case params.fetch(:filter, 'all')
    when 'incomplete' then Assignment.incomplete_for(current_student)
    when 'complete'   then Assignment.complete_for(current_student)
    when 'late'       then Assignment.late_for(current_student)
    when 'all'        then Assignment.due_soon(current_student)
    end
  end
end
