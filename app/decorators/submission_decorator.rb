class SubmissionDecorator < Draper::Decorator
  decorates_association :student
  delegate_all

  def one_line
    "#{(student.name || student.email)} - #{link[0..45]}"
  end
end
