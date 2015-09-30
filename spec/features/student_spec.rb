require 'rails_helper'

RSpec.feature 'Student views' do
  let(:instructor_user) { create :instructor_user }
  let(:cohort) { create :cohort, instructors: [instructor_user.instructor] }
  let(:student)  { create :full_student, cohort: cohort }

  feature 'Instructor can become a student' do
    scenario 'instructor has student' do
      sign_in instructor_user
      visit student_path(student)
      click_link 'Become'
      expect(page).to have_content("My Cohort")
    end
  end

  feature 'student list' do
    scenario 'instructor can see all students they have taught' do
      sign_in instructor_user
      visit students_path
      expect(page).to have_content("Email")
    end
  end
end
