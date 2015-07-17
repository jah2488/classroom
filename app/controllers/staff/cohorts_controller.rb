class Staff::CohortsController < Staff::ApplicationController
  def new
    render locals: {
      cohort: Cohort.new
    }
  end

  def show
    cohort      = Cohort.find(params[:id])
    students    = cohort.students.includes(:adjustments)
    assignments = cohort.assignments.order('due_date DESC')
    submissions = Submission.ungraded_for(cohort)
    adjustments = students.flat_map(&:adjustments)
    render locals: {
      instructor: current_instructor,
      cohort: cohort,
      current_day: Day.current_for(cohort),
      assignments: assignments,
      submissions: submissions,
      students: students,
      adjustments: adjustments
    }
  end

  def index
    @cohorts = Cohort.all
  end

  def create
    cohort = Cohort.new(cohort_params)
    cohort.instructor = current_instructor
    cohort.first_day = cohort.first_day.beginning_of_day
    if cohort.save
      redirect_to staff_cohort_path(cohort), notice: I18n.t('.created', resource: I18n.t('.cohort'))
    end
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name, :campus_id, :first_day)
  end
end
