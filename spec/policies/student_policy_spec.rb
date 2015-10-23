require 'rails_helper'

describe StudentPolicy do

  let(:student) { build_stubbed :student }
  let(:student2) { build_stubbed :student }
  let(:student_user) { build_stubbed :user, student: student }
  let(:instructor) { build_stubbed(:instructor) }
  let(:instructor_user) { build_stubbed(:user, instructor: instructor) }

  subject { described_class }

  permissions :show? do
    it "allows instructor to view own students" do
      expect(instructor).to receive(:has_student?).with(student).and_return true
      expect(subject).to permit(instructor_user, student)
    end

    it "allows students to view other students in same cohort" do
      student2.cohort_id = student.cohort_id
      expect(subject).to permit(student_user, student2)
    end

    it 'allows student to view self' do
      expect(subject).to permit(student_user, student)
    end

    it 'does not allow student to view student in different cohort' do
      expect(subject).to_not permit(student_user, student2)
    end
  end

  permissions :create?, :new? do
    it "allows instructors to create students" do
      expect(subject).to permit(instructor_user, Student.new)
    end
  end

  permissions :destroy? do
    it 'allows instructors to delete own student' do
      expect(instructor).to receive(:has_student?).with(student).and_return true
      expect(subject).to permit(instructor_user, student)
    end
  end

  permissions :update?, :edit?, :grades? do
    it "allows instructor of student" do
      expect(instructor).to receive(:has_student?).with(student).and_return(true).thrice
      expect(subject).to permit(instructor_user, student)
    end
    it "allows self" do
      expect(subject).to permit(student_user, student)
    end
  end
end
