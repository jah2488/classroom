require 'rails_helper'

RSpec.describe Instructor do
  let(:instructor) { create :instructor }

  describe "#has_student?" do
    it "is true if they have the student in a cohort" do
      student = student_in_cohort create :cohort, instructors: [instructor]
      expect(instructor).to have_student(student)
    end

    it "allows TAs to have a student" do
      instructor2 = create :instructor
      student = student_in_cohort create :cohort, instructors: [instructor, instructor2]
      expect(instructor2).to have_student(student)
    end

    it "disallows random instructor" do
      student = student_in_cohort create :cohort, instructors_count: 0
      expect(instructor).to_not have_student(student)
    end
  end

  def student_in_cohort c
    create :student, cohort: c
  end
end
