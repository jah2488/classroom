require 'rails_helper'

RSpec.feature "Cohort views", js: true do
  let(:instructor_user) { create :instructor_user }
  let(:cohort) { create :cohort, instructor: instructor_user.instructor }
  let(:student) { create :student, cohort: cohort }
  let(:student_user) { create :student_user, student: student }

  feature 'Viewing a cohort' do
    scenario 'as the instructor' do
      sign_in(instructor_user)
      visit cohort_path(cohort)
      expect(page).to have_content(cohort.name.titleize)
      expect(page).to match_expectation ignore: [0, 0, 10, 10]
    end

    scenario 'as a student' do
      sign_in(student_user)
      visit cohort_path(cohort)
      expect(page).to have_content(cohort.name.titleize)
      expect(page).to have_content("No Checkin Today")
      expect(page).to match_expectation ignore: [[0, 110, 220, 200], [700, 635, 755, 690]]
    end
  end
end
