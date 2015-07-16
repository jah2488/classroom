class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :day

  enum status: { "Satisfactory" => 0,
                 "Unsatisfactory"           => 1,
                 "Probation"   => 2
  }

  def cohort
    day.cohort
  end

  def campus_name
    day.cohort.campus.name
  end

  def cohort_name
    cohort.name
  end

  def instructor_name
    day.cohort.instructor.name
  end

  def student_name
    student.name
  end

  def end_of_day
    day.start.end_of_day
  end

  def completed_assignments
    Assignment.complete_for(student).where("due_date <= ?", end_of_day).count
  end

  def total_assignments
    Assignment.for(student).where("due_date <= ?", end_of_day).count
  end

  def attended
    student.checkins.where("created_at <= ?", end_of_day).count
  end

  def tardies
    student.checkins.where("created_at <= ?", end_of_day).select{|c| c.late?}.count
  end

  def total_lectures
    cohort.days.where("start <= ?", end_of_day).count
  end
end
