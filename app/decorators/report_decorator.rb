class ReportDecorator < Draper::Decorator
  delegate_all
  def campus_name
    object.day.cohort.campus.name
  end

  def cohort_name
    object.cohort.name
  end

  def instructor_name
    object.day.cohort.instructor.name
  end

  def student_name
    object.student.name
  end

  def attended
    object.attended.count
  end

  def tardies
    object.tardies.count
  end

  def total_lectures
    object.lectures.count
  end

  def total_assignments
    object.assignments.count
  end

  def completed_assignments
    object.completed_assignments.count
  end
end
