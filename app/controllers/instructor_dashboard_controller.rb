class InstructorDashboardController < ApplicationController
  def index
    cohort      = current_instructor.current_cohort
    students    = cohort.students
    assignments = cohort.assignments
    render locals: {
      instructor: current_instructor,
      cohort: cohort,
      current_day: Day.current_for(cohort),
      assignments: assignments,
      students: students
    }
  end
end
