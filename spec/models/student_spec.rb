require 'rails_helper'

RSpec.describe Student do
  let(:student)  { create :full_student }
  describe "#late_assignments" do
    it "calculates" do
      incomplete_assignment = create :assignment, cohort: student.cohort, due_date: (Time.now - 1.day)
      late_assignment = create :assignment, cohort: student.cohort, due_date: (Time.now - 1.day)
      on_time_assignment = create :assignment, cohort: student.cohort, due_date: (Time.now - 1.day)
      create :submission, student: student, assignment: on_time_assignment, late: false
      create :submission, student: student, assignment: late_assignment, late: true
      expect(student.late_assignments).to include(late_assignment)
      expect(student.late_assignments).to_not include(on_time_assignment, incomplete_assignment)
    end
  end
end
