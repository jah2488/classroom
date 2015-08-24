require 'rails_helper'

RSpec.feature "Cohort views" do
  let(:instructor_user) { create :instructor_user }
  let(:cohort) { create :cohort, instructor: instructor_user.instructor }
  let(:student) { create :student, cohort: cohort }
  let(:student_user) { create :student_user, student: student }

  feature 'Viewing a cohort' do
    scenario 'as the instructor' do
      sign_in(instructor_user)
      visit cohort_path(cohort)
      expect(page).to have_content(cohort.name)
    end

    scenario 'as a student' do
      sign_in(student_user)
      visit cohort_path(cohort)
      expect(page).to have_content(cohort.name)
      expect(page).to have_content("No Checkin Today")
    end
  end
end
