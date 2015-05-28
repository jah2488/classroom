class InstructorDashboardController < ApplicationController
  def index
    if cohort = current_instructor.current_cohort
      render_with_cohort(cohort)
    else
      render_without_cohort
    end
  end

  def render_with_cohort(cohort)
    students    = cohort.students
    assignments = cohort.assignments.order('due_date DESC')
    submissions = Submission.ungraded_for(cohort) #get submissions for current_cohort
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

  def render_without_cohort
    render locals: {
      instructor: current_instructor,
      cohort: Cohort.new(name: "no cohort"),
      current_day: nil,
      assignments: [],
      submissions: [],
      students: []
    }
  end
end
