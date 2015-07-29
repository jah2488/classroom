require 'rails_helper'

describe ReportPolicy do
  let(:student) { build_stubbed :student }
  let(:student_user) { build_stubbed :user, student: student }
  let(:instructor) { build_stubbed :instructor }
  let(:instructor_user) { build_stubbed :user, instructor: instructor }

  subject { described_class }

  permissions ".scope" do
    it "it shows a student their own reports" do
      report = create(:report, student: student)
      create(:report)
      expect(ReportPolicy::Scope.new(student_user, Report.all).resolve).to eq [report]
    end
    it "it shows instructors all of their reports" do
      allow(instructor).to receive(:students) {[student]}
      one = create(:report, student: student)
      two = create(:report, student: student)
      expect(ReportPolicy::Scope.new(instructor_user, Report.all).resolve).to eq [one, two]
    end
  end

  permissions :show? do
    it "allows students to view own reports" do
      expect(subject).to permit(student_user, Report.new(student: student))
    end

    it "allows instructors to see own reports" do
      student.cohort.instructor_id = instructor.id
      expect(subject).to permit(instructor_user, Report.new(student: student))
    end

    it "denies instructors from seeing other reports" do
      expect(subject).to_not permit(instructor_user, Report.new(student: student))
    end
  end

  permissions :create? do
    it "allows instructors to create reports on own students" do
      student.cohort.instructor_id = instructor.id
      expect(subject).to permit(instructor_user, Report.new(student: student))
    end
  end
end
