class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :day

  enum status: { "Satisfactory" => 0,
                 "Unsatisfactory"           => 1,
                 "Probation"   => 2
  }

  def campus_name
    day.cohort.location
  end

  def course_name
    day.cohort.name
  end

  def cohort_name
    day.cohort.name
  end

  def instructor_name
    day.cohort.instructor.name
  end

  def student_name
    student.name
  end

  def completed_assignments
    Assignment.complete_for(student).count
  end

  def total_assignments
    Assignment.for(student).count
  end

  def absences
    student.absences
  end

  def attended
    total_lectures - absences
  end

  def tardies
    student.tardies
  end

  def total_lectures
    Day.where(cohort_id: day.cohort_id).count
  end
end
