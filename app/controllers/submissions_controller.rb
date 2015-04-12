class SubmissionsController < ApplicationController
  def new
    render locals: {
      submission: Submission.new
    }
  end

  def show
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
