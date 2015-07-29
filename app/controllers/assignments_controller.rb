class AssignmentsController < ApplicationController

  def show
    render locals: {
      assignment: Assignment.find(params[:id])
    }
  end

  def current
    assignment = Assignment.current_for(current_user.student)
    if assignment
      redirect_to assignment_path(assignment)
    else
      redirect_to root_path, notice: 'All assignments are past due or completed.'
    end
  end

  def search
    render json: Assignment.search(params[:query])
  end

  def edit
    render locals: {
      assignment: Assignment.find(params[:id])
    }
  end
end
