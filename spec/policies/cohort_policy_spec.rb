require 'rails_helper'

describe CohortPolicy do

  let(:instructor_user) { build_stubbed :instructor_user }
  let(:student_user) { build_stubbed :student_user }
  let(:cohort) { build_stubbed :cohort }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it "allows anyone to see cohorts" do
      expect(subject).to permit(student_user, cohort)
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
      cohort.instructor_id = instructor_user.instructor.id
      expect(subject).to permit(instructor_user, cohort)
      expect(subject).to_not permit(student_user, cohort)
    end
  end

  permissions :destroy? do
    it "allows instructors to destroy their own" do
      cohort.instructor_id = instructor_user.instructor.id
      expect(subject).to permit(instructor_user, cohort)
      expect(subject).to_not permit(student_user, cohort)
    end
  end
end
