class InstructorDashboardController < ApplicationController
  def index
    cohort      = current_instructor.current_cohort
    students    = cohort.students
    assignments = cohort.assignments
    submissions = Submission.ungraded_for(cohort)
    #get submissions for current_cohort
    # only return ungraded submissions sorted by assignment due date
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
