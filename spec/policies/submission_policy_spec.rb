require 'rails_helper'

RSpec.describe SubmissionPolicy do

  let(:student) { build_stubbed(:student) }
  let(:instructor) { build_stubbed(:instructor) }

  subject { described_class }

  permissions :show? do
    it "denies access if submission is owned by another student" do
      other_student = build_stubbed(:student)
      expect(subject).to_not permit(student, Submission.new(student: other_student))
    end

    it "allows student to view own" do
      expect(subject).to permit(student, Submission.new(student: student))
    end

    it "allows instructors to view all in cohort" do
      student.cohort.instructor = instructor
      expect(subject).to permit(instructor, Submission.new(student: student))
    end

    it "denies cross-cohort staff" do
      student.cohort.instructor_id = nil
      expect(subject).to_not permit(instructor, Submission.new(student: student))
    end
  end

  permissions :complete? do
    it "denies students" do
      expect(subject).to_not permit(student, Submission.new)
    end

    it "allows instructors to complete submissions" do
      student.cohort.instructor = instructor
      expect(subject).to permit(instructor, Submission.new(student: student))
    end
  end

  permissions :unfinish? do
    it "denies students" do
      expect(subject).to_not permit(student, Submission.new)
    end
    it "allows instructors to mark submissions unfinished" do
      student.cohort.instructor = instructor
      expect(subject).to permit(instructor, Submission.new(student: student))
    end
  end
end
