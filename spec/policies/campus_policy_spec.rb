require 'rails_helper'

describe CampusPolicy do

  let(:instructor_user) { build_stubbed :instructor_user }
  let(:student_user) { build_stubbed :student_user }
  let(:campus) { build_stubbed :campus }

  subject { described_class }

  permissions ".scope" do
  end

  permissions :show? do
    it 'allows everyone' do
      expect(subject).to permit(User.new, campus)
    end
  end

  permissions :create? do
    it "allows instructors to create" do
      expect(subject).to permit(instructor_user, campus)
      expect(subject).to_not permit(student_user, campus)
    end
  end

  permissions :update? do
    it "allows instructors to update" do
      expect(subject).to permit(instructor_user, campus)
      expect(subject).to_not permit(student_user, campus)
    end
  end

  permissions :destroy? do
  end
end
