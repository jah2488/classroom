require 'rails_helper'

describe CohortPolicy do

  let(:instructor) { build_stubbed :instructor }
  let(:student) { build_stubbed :student }
  let(:cohort) { build_stubbed :cohort }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it "allows anyone to see cohorts" do
      expect(subject).to permit(student, cohort)
      expect(subject).to permit(instructor, cohort)
    end
  end

  permissions :create? do
    it "allows instructors to create" do
      expect(subject).to permit(instructor, cohort)
      expect(subject).to_not permit(student, cohort)
    end
  end

  permissions :update? do
    it "allows instructors to update their own" do
      cohort.instructor_id = instructor.id
      expect(subject).to permit(instructor, cohort)
      expect(subject).to_not permit(student, cohort)
    end
  end

  permissions :destroy? do
    it "allows instructors to destroy their own" do
      cohort.instructor_id = instructor.id
      expect(subject).to permit(instructor, cohort)
      expect(subject).to_not permit(student, cohort)
    end
  end
end
