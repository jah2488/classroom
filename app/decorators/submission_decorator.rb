class SubmissionDecorator < Draper::Decorator
  delegate_all

  def one_line
    "#{(student.name || student.email)} - #{link[0..45]}"
  end
end
