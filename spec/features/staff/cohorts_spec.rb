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
    create_cohort
    expect_cohort_to_be_created
  end

  #Notes about this particular test/scenario:
  #  - Thought I'd play with the idea of making the scenario as readable as possible
  #    so when it does break, you're changing the method its using, not the scenario itself.
  #    Could help isolate especially brittle areas of the test or the code.
  #  - I realize that this tests is taking the big assumption that you will be redirected to the staff_cohorts_index after sign_in

  def create_cohort
    fill_in 'Name', with: 'Rails'
    select 'Moon', from: 'Campus'
    select instructor.name, from: 'Instructor'

    click_button 'Create Cohort'
  end

  def expect_cohort_to_be_created
    expect(page).to have_content('New Cohort successfully created!')
  end
end
