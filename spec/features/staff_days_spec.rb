require 'rails_helper'

RSpec.feature "Staff days panel" do
  let(:instructor) do
    create :instructor_user, email: 'instructor@theironyard.com', password: 'password', name: 'Jane Doe'
  end
  let(:cohort) { create :cohort, instructor: instructor.instructor }
  before do
    create_list :student, 2, cohort: cohort
    sign_in instructor
  end

  feature 'Viewing days' do
    scenario 'with new cohort' do
      visit staff_cohort_days_path(cohort)
      expect(page).to have_content(cohort.name)
      expect(page).to_not have_content("Started")
      expect(page).to_not have_content("Absent")
    end

    scenario 'with in-progress cohort' do
      create_list :day, 5, cohort: cohort
      visit staff_cohort_days_path(cohort)
      expect(page).to have_content("Started")
      expect(page).to have_content("Absent")
    end
  end

  feature 'Creating days' do
    scenario 'creating a day' do
      visit new_staff_cohort_day_path(cohort)
      fill_in 'Start', with: cohort.start_time.to_s
      click_button 'Create Day'
      expect(page).to have_content("Started")
    end

    scenario 'creating a duplicate day' do
      create :day, cohort: cohort, start: cohort.start_time
      visit new_staff_cohort_day_path(cohort)
      fill_in 'Start', with: cohort.start_time.to_s
      click_button 'Create Day'
      expect(page).to have_content("already has this")
    end
  end
end
