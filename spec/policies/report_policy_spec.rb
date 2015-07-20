require 'rails_helper'

describe ReportPolicy do
  let(:student) { build_stubbed :student }
  let(:instructor) { build_stubbed :instructor }

  subject { described_class }

  permissions ".scope" do
    pending "it shows a student their own reports"
    pending "it shows instructors all of their reports"
  end

  permissions :show? do
    it "allows students to view own reports" do
      expect(subject).to permit(student, Report.new(student: student))
    end

    it "allows instructors to see own reports" do
      student.cohort.instructor_id = instructor.id
      expect(subject).to permit(instructor, Report.new(student: student))
    end

    it "denies instructors from seeing other reports" do
      expect(subject).to_not permit(instructor, Report.new(student: student))
    end
  end

  permissions :create? do
    it "allows instructors to create reports on own students" do
      student.cohort.instructor_id = instructor.id
      expect(subject).to permit(instructor, Report.new(student: student))
    end
  end
end
