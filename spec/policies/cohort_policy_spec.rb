require 'rails_helper'

describe CohortPolicy do

  let(:instructor_user) { build_stubbed :instructor_user }
  let(:student_user) { build_stubbed :student_user }
  let(:cohort) { build_stubbed :cohort }

  subject { described_class }

  permissions ".scope" do
  end

  permissions :show? do
    it 'denies unenrolled students' do
      expect(subject).to_not permit(student_user, cohort)
    end

    it "allows enrolled students to see cohorts" do
      expect(student_user).to receive(:in_cohort?).with(cohort).and_return(true)
      expect(subject).to permit(student_user, cohort)
    end

    it 'allows instructors to view' do
      expect(subject).to permit(instructor_user, cohort)
    end
  end

  permissions :create? do
    it "allows instructors to create" do
      expect(subject).to permit(instructor_user, cohort)
      expect(subject).to_not permit(student_user, cohort)
    end
  end

  permissions :update? do
    it "allows instructors to update their own" do
      expect(instructor_user).to receive(:in_cohort?).with(cohort).and_return(true)
      expect(subject).to permit(instructor_user, cohort)
      expect(subject).to_not permit(student_user, cohort)
    end
  end

  permissions :destroy? do
    it "allows instructors to destroy their own" do
      expect(instructor_user).to receive(:in_cohort?).with(cohort).and_return(true)
      expect(subject).to permit(instructor_user, cohort)
      expect(subject).to_not permit(student_user, cohort)
    end
  end
end
