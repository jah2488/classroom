require 'rails_helper'

RSpec.feature "Cohort instructor view", type: :feature do
  let!(:instructor) do
    create :instructor_user, name: 'Jane Doe'
  end

  feature 'Picking Cohort' do
    scenario 'with multiple available cohorts' do
      create :cohort, instructors_count: 0
      create :cohort
      create :cohort, name: 'Design Summer', instructors: [instructor.instructor]
      rails_cohort = create :cohort, name: 'Rails Summer', instructors: [instructor.instructor]

      sign_in(instructor)

      find(:css, "a[data-id='#{rails_cohort.id}']").click

      expect(page).to have_content('Dashboard')
      expect(page).to have_content('Reports')
      expect(page).to have_content('Assignments')
    end
  end

  scenario 'creating a cohort' do
    create :campus, name: 'Moon'
    sign_in(instructor)
    visit(new_staff_cohort_path)
  end
end
