class Staff::AssignmentsController < Staff::ApplicationController

  def new
    cohort = Cohort.find(params[:cohort_id]).decorate
    assignment = Assignment.new(cohort: cohort)
    render locals: {
      assignment: assignment,
      cohort: cohort
    }
  end

  def show
    assignment = Assignment.find(params[:id])
    render locals: {
      assignment: assignment.decorate,
      submitted: assignment.submissions,
      unsubmitted: assignment.unsubmitted_by
    }
  end

  def index
    cohort = Cohort.find(params[:cohort_id])
    render locals: {
      cohort: cohort.decorate,
      assignments: cohort.assignments
    }
  end

  def edit
    render locals: {
      assignment: Assignment.find(params[:id]),
      cohort: Cohort.find(params[:cohort_id]).decorate
    }
  end

  def create
    cohort = Cohort.find(params[:cohort_id])
    assignment = Assignment.new(assignment_params)
    assignment.cohort   = cohort
    assignment.due_date = ActiveSupport::TimeZone[cohort.tz].parse(params[:assignment][:due_date])
    if assignment.save
      redirect_to staff_cohort_assignment_path(cohort, assignment), notice: 'Assignment successfully created'
    else
      render :new, alert: 'Assignment could not be saved', status: 422, locals: { cohort: cohort.decorate, assignment: assignment }
    end
  end

  def update
    assignment = Assignment.find(params[:id])
    params[:assignment][:due_date] = ActiveSupport::TimeZone[assignment.cohort.tz].parse(params[:assignment][:due_date])
    if assignment.update(assignment_params)
      redirect_to staff_cohort_assignment_path(assignment.cohort, assignment), notice: 'Assignment updated'
    else
      render :edit, alert: 'Assignment could not be updated', status: 422, locals: { cohort: assignment.cohort.decorate, assignment: assignment }
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :due_date, :info, tag_ids: [])
  end
end
