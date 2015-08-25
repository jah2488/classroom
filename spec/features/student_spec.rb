require 'rails_helper'

RSpec.feature 'Student views' do
  let(:instructor_user) { create :instructor_user }
  let(:cohort) { create :cohort, instructor: instructor_user.instructor }
  let(:student)  { create :full_student, cohort: cohort }

  feature 'Instructor can become a student' do
    scenario 'instructor has student' do
      sign_in instructor_user
      visit student_path(student)
      click_link 'Become'
      expect(page).to have_content("My Cohort")
    end
  end
end
