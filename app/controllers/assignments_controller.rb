class AssignmentsController < ApplicationController
  after_action :verify_authorized, except: [:index, :current]

  def show
    assignment = Assignment.find(params[:id])
    authorize assignment
    respond_to do |format|
      format.html { render locals: { assignment: assignment } }
      format.json { render json: assignment, include: 'submissions' }
    end
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
    if params[:q]
      render json: Assignment.search(current_user, params[:q])
    else
      render json: policy_scope(Assignment).order(:due_date)
    end
  end

  def edit
    assignment = Assignment.find(params[:id])
    authorize assignment
    render locals: {
      assignment: assignment
    }
  end
end
