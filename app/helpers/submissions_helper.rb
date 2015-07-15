require 'open-uri'

module SubmissionsHelper

  def next_submission_url_for_student(submission)
    next_submission_url_for(submission, :student)
  end

  def next_submission_url_for_assignment(submission)
    next_submission_url_for(submission, :assignment)
  end

  private

  def next_submission_url_for(submission, association)
    url_for(submission.public_send(association)
      .submissions
      .where(state: Submission::PENDING)
      .where.not(id: submission.id).first)
  end

end
