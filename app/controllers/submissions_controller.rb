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

  def mark_complete
    grade_submission(true)
  end

  def mark_unfinished
    grade_submission(false)
  end

  private

  def grade_submission(completed)
    submission = Submission.find(params[:id])
    submission.completed = completed
    submission.state = Submission::GRADED
    submission.save!

    rating = Rating.new
    rating.submission = submission
    rating.notes = params.fetch('notes', '')
    rating.save!

    render json: {}, status: 200
  end

  def submission_params
    params.require(:submission).permit(:assignment_id, :link, :notes)
  end

end
