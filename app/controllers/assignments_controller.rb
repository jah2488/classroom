class AssignmentsController < ApplicationController
  after_action :verify_authorized, except: [:index, :current]

  def show
    assignment = Assignment.find(params[:id])
    authorize assignment
    render locals: {
      assignment: assignment
    }
  end

  def current
    assignment = Assignment.current_for(current_user.student)
    if assignment
      authorize assignment
      redirect_to assignment_path(assignment)
    else
      redirect_to root_path, notice: 'All assignments are past due or completed.'
    end
  end

  def index
    render json: Assignment.search(params[:q])
  end

  def edit
    assignment = Assignment.find(params[:id])
    authorize assignment
    render locals: {
      assignment: assignment
    }
  end
end
