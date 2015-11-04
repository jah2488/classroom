require 'rails_helper'

RSpec.feature "StaffReports", type: :feature do
  let(:instructor_user) { create :instructor_user }
  let(:cohort) { create :cohort, instructors: [instructor_user.instructor] }
  let(:student) { create :student, cohort: cohort }
  let(:student_user) { create :student_user, student: student }

  feature 'Viewing a report' do
    scenario 'as the instructor' do
      sign_in(instructor_user)
      report = create :report, student: student
      visit staff_cohort_report_path(cohort, report)
      expect(page).to have_content("Bi-Weekly Performance")
    end
  end

  feature 'Editing a report' do
    scenario 'as the instructor' do
      sign_in(instructor_user)
      report = create :report, student: student
      visit staff_cohort_report_path(cohort, report)
      click_link "Edit"
      select "2", from: "Participation"
      click_button "Update"
      expect(page).to have_content("Participation (2/3)")
    end
  end
end
