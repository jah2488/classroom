require 'rails_helper'

RSpec.describe Student do
  let(:student)  { create :full_student }
  describe "#past_due_count" do
    it "calculates" do
      create :assignment, cohort: student.cohort, due_date: (Time.now - 1.day)
      late_assignment = create :assignment, cohort: student.cohort, due_date: (Time.now - 1.day)
      on_time_assignment = create :assignment, cohort: student.cohort, due_date: (Time.now - 1.day)
      create :submission, student: student, assignment: on_time_assignment, created_at: (on_time_assignment.due_date - 1.hour)
      create :submission, student: student, assignment: late_assignment, created_at: (late_assignment.due_date + 1.hour)
      expect(student.past_due_count).to eq 2
    end
  end
end
