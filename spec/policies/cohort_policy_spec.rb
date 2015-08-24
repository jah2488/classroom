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
    it 'denies unenrolled students' do
      expect(subject).to_not permit(student_user, cohort)
    end

    it "allows enrolled students to see cohorts" do
      student_user.student.cohort_id = cohort.id
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
