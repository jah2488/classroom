class DashboardController < ApplicationController
  def index
    render locals: {
      assignments: Assignment.for(current_student),
      current_day: Day.current_for(current_student.cohort)
    }
  end
end
