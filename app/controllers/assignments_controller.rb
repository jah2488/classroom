class AssignmentsController < ApplicationController
  def new
    render locals: {
      assignment: Assignment.new
    }
  end

  def show
    render locals: {
      assignment: Assignment.find(params[:id])
    }
  end

  def create
    assignment = Assignment.new(assignment_params)
    assignment.cohort = current_instructor.current_cohort
    if assignment.save
      redirect_to instructor_dash_path, notice: 'Assignment successfully created'
    else
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :info, :due_date)
  end

end
