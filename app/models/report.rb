class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :day

  enum status: {
    "Satisfactory"    => 0,
    "Unsatisfactory"  => 1,
    "Probation"       => 2
  }

  def cohort
    day.cohort
  end

  def end_of_day
    day.start.end_of_day
  end

  def completed_assignments
    Assignment.complete_for(student).where("due_date <= ?", end_of_day)
  end

  def assignments
    Assignment.for(student).where("due_date <= ?", end_of_day)
  end

  def attended
    student.checkins.where("created_at <= ?", end_of_day)
  end

  def tardies
    student.checkins.where("created_at <= ?", end_of_day).select{|c| c.late?}
  end

  def lectures
    cohort.days.where("start <= ?", end_of_day)
  end
end
