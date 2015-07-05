class InstructorDashboardController < ApplicationController
  def index
    if current_instructor.current_cohort.nil?
      redirect_to new_cohort_path
    else
      render_with_cohort
    end
  end

  private
  def render_with_cohort
    cohort      = current_instructor.current_cohort
    students    = cohort.students
    assignments = cohort.assignments.order('due_date DESC')
    submissions = Submission.ungraded_for(cohort)
    render locals: {
      instructor: current_instructor,
      cohort: cohort,
      current_day: Day.current_for(cohort),
      assignments: assignments,
      submissions: submissions,
      students: students
    }
  end

end
