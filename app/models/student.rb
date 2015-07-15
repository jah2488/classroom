class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :cohort
  has_many :submissions
  has_many :assignments, -> { uniq }, through: :submissions
  has_many :complete_assignments, -> { where(submissions: { completed: true }).uniq }, through: :submissions, source: :assignment
  has_many :badges, through: :submissions
  has_many :checkins
  has_many :adjustments, through: :checkins

  validates_presence_of :cohort

  def marked_checkins
    c = Checkin.arel_table
    checkins.includes(:adjustment)
            .where(c[:late].eq(true).or(
                   c[:absent].eq(true)))
  end

  def badge_list
    @badges ||= badges
    [@badges, Badge.all - @badges]
  end

  def tardies
    checkins.where(late: true).count
  end

  def absences
    checkins.where(absent: true).count
  end

  def completed_assignments
    submissions.where(completed: true)
  end

  def complete_percentage
    (complete_assignments.count.to_f / cohort.assignments.count.to_f).round(2)
  end

  def past_due_count
    Assignment.late_for(self).count
  end

  def to_s
    "#{(name || email)} | tardies: #{tardies} | absences: #{absences} | submissions: #{submissions.count}"
  end
end
