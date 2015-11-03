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
      assignments = Assignment.search(current_user, params[:q])
    else
      assignments = policy_scope(Assignment)
    end
    assignments = assignments.order(:due_date)
    respond_to do |format|
      format.json { render json: assignments }
      format.html { render locals: { assignments: assignments } }
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
