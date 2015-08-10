class Staff::AssignmentsController < Staff::ApplicationController

  def new
    render locals: {
      assignment: Assignment.new,
      cohort: Cohort.find(params[:cohort_id]).decorate
    }
  end

  def create
    cohort = Cohort.find(params[:cohort_id])
    assignment = Assignment.new(assignment_params)
    assignment.cohort = cohort
    assignment.due_date = ActiveSupport::TimeZone[cohort.tz].parse(params[:assignment][:due_date])
    if assignment.save
      redirect_to staff_cohort_assignment_path(cohort, assignment), notice: 'Assignment successfully created'
    else
      render :new, alert: 'Assignment could not be saved', status: 422
    end
  end

  def show
    render locals: {
      assignment: Assignment.find(params[:id]).decorate
    }
  end

  def update
    assignment = Assignment.find(params[:id])
    if assignment.update(assignment_params)
      redirect_to staff_cohort_assignment_path(assignment.cohort, assignment), notice: 'Assignment updated'
    else
      render :edit, alert: 'Assignment could not be updated', status: 422
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :info, tag_ids: [])
  end
end
