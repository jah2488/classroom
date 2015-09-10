class Instructor < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :cohorts
  validates :user_id, presence: true

  def current_cohort
    cohorts.last
  end

  def name
    if user
      user.name || user.email
    else
      "Instructor ##{id}"
    end
  end

  def has_office_hours?
    office_hours_start && office_hours_end
  end

  def office_hours_start_at
    office_hours_start.strftime("%H:%M")
  end

  def office_hours_end_at
    office_hours_end.strftime("%H:%M")
  end

  def has_student?(student)
    self.id == student.cohort.instructor_id
  end

  def students
    cohorts.map(&:students).flatten
  end
end
