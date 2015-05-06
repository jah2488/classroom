class SubmissionsController < ApplicationController
  def new
    render locals: {
      submission: Submission.new
    }
  end

  def show
    render locals: {
      submission: Submission.find(params[:id])
    }
  end

  def mark_complete
    submission = Submission.find(params[:id])
    submission.completed = true
    submission.state = Submission::GRADED
    submission.save!
    redirect_to :back
  end

  def mark_unfinished
    submission = Submission.find(params[:id])
    submission.completed = false
    submission.state = Submission::GRADED
    submission.save!
    redirect_to :back
  end

  def create
    assignment = Assignment.find(submission_params.fetch(:assignment_id))
    submission = Submission.new(submission_params)
    submission.student    = current_student
    submission.assignment = assignment
    submission.late       = true if assignment.due_date < Time.zone.now

    if submission.save
      redirect_to dashboard_path, notice: "Submission for '#{assignment.title.titleize}' submitted for review."
    else
      render :new, alert: 'Submission was unable to be submitted.'
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:assignment_id, :link, :notes)
  end

end
