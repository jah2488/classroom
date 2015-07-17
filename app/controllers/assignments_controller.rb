class AssignmentsController < ApplicationController

  def show
    render locals: {
      assignment: Assignment.find(params[:id])
    }
  end

  def current
    assignment = Assignment.current_for(current_student)
    if assignment
      redirect_to student_assignment_path(assignment)
    else
      redirect_to dashboard_path, alert: 'All assignments are past due or completed.'
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
