class SubmissionsController < ApplicationController
  after_action :verify_authorized, except: :index
  def new
    submission = Submission.new
    authorize submission
    render locals: {
      submission: submission
    }
  end

  def show
    submission = Submission.find(params[:id])
    authorize submission
    render locals: {
      submission: submission
    }
  end

  def create
    assignment = Assignment.find(submission_params.fetch(:assignment_id))
    submission = Submission.new(submission_params)
    submission.student    = current_student
    submission.assignment = assignment
    submission.late       = true if assignment.due_date.past?

    authorize submission
    if submission.save
      redirect_to dashboard_path, notice: "Submission for '#{assignment.title.titleize}' submitted for review."
    else
      render :new, alert: 'Submission was unable to be submitted.'
    end
  end

  def update
    submission = Submission.find(params[:id])
    authorize submission
    if submission.update(submission_params)
      render json: submission
    else
      render json: submission.errors, status: :unprocessable_entity
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
    authorize submission
    submission.completed = completed
    submission.state = Submission::GRADED
    badge_ids  = params.fetch(:badge_ids, []).reject { |_, v| v == 'false' }.map { |(k, _)| k.split('-').last }
    submission.badge_ids = badge_ids
    submission.save!

    rating = Rating.new
    rating.submission = submission
    rating.notes = params.fetch('notes', '')
    rating.save!

    render json: {}, status: 200
  end

  def submission_params
    params.require(:submission).permit(:assignment_id, :link, :notes, :badge_ids)
  end

end
