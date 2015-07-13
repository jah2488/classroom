class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :cohort
  has_many :submissions
  has_many :checkins
  has_many :adjustments, through: :checkins

  validates_presence_of :cohort

  def marked_checkins
    c = Checkin.arel_table
    checkins.where(c[:late].eq(true).or(
                   c[:absent].eq(true)))
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
    completed_assignments.group_by(&:assignment).count.to_f / cohort.assignments.count.to_f
  end

  def past_due_count
    Assignment.late_for(self).count
  end

  def to_s
    "#{(name || email)} | tardies: #{tardies} | absences: #{absences} | submissions: #{submissions.count}"
  end
end
