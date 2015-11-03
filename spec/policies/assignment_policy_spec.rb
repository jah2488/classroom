require 'rails_helper'

describe AssignmentPolicy do
  let(:instructor_user) { build_stubbed :instructor_user }
  let(:student_user) { build_stubbed :student_user }
  let(:assignment) { build_stubbed :assignment }

  subject { described_class }

  permissions ".scope" do

  end

  permissions :destroy? do
    it "allows instructor on own cohort" do
      allow(instructor_user.instructor).to receive(:cohort_ids).and_return([assignment.cohort_id])
      expect(subject).to permit(instructor_user, assignment)
    end
    it "denies all students" do
      expect(subject).to_not permit(student_user, assignment)
    end
    it "denies instructors on other cohorts" do
      expect(subject).to_not permit(instructor_user, assignment)
    end
  end
end
