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
      render :new
    end
  end

  def edit
    render locals: {
      assignment: Assignment.find(params[:id])
    }
  end

  def update
    assignment = Assignment.find(params[:id])
    if assignment.update(assignment_params)
      redirect_to assignment, notice: 'Assignment updated'
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :info, :due_date)
  end

end
