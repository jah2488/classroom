class Submission < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment
  has_many :ratings, dependent: :destroy
  has_many :submission_badges, dependent: :destroy
  has_many :badges, through: :submission_badges
  validates :student, presence: true
  validates :link, presence: true
  validate :link_must_be_uri

  PENDING = 1
  # wat ^ aren't these the same?
  IN_PROGRESS = 2
  # wat ^ aren't these the same?
  GRADED = 3

  def self.ungraded_for(cohort)
      Submission.includes(:assignment)
        .where(state: Submission::PENDING)
        .where(completed: false).where("assignments.cohort_id = ?", cohort.id)
        .references(:assignment)
        .order('assignments.due_date DESC')
  end

  def graded?
    state == GRADED
  end

  def complete?
    completed && graded?
  end

  def unfinished?
    !completed && graded?
  end

  def has_feedback?
    @has_feedback ||= ratings.any? {|r| r.has_feedback?}
  end

  def label
    if graded?
      completed ? 'Completed' : 'Incomplete'
    else
      'Ungraded'
    end
  end

  def on_time
    late ? 'Late' : 'On Time'
  end

  def status
    "#{label} #{on_time}"
  end

  def tz
    assignment.cohort.tz
  end

  def link_must_be_uri
    begin
      URI.parse(link)
    rescue URI::InvalidURIError
      errors.add(:link, "Link is not a valid URL")
    end
  end
end
