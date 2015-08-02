require 'rails_helper'

RSpec.feature "StaffCohorts", type: :feature do
  let!(:instructor) do
    create :instructor_user, email: 'instructor@theironyard.com', password: 'password', name: 'Jane Doe'
  end

  feature 'Picking Cohort' do
    scenario 'with multiple available cohorts' do
      create :cohort, name: 'Design Summer', instructor: instructor.instructor
      rails_cohort = create :cohort, name: 'Rails Summer', instructor: instructor.instructor

      sign_in(:instructor)

      find(:css, "a[data-id='#{rails_cohort.id}']").click

      expect(page).to have_content('Dashboard')
      expect(page).to have_content('Reports')
      expect(page).to have_content('New Assignment')
      expect(page).to have_content('New Badge')
    end

    scenario 'creating a cohort' do
      create :campus, name: 'Moon'

      sign_in(:instructor)
      click_new_cohort_link
      create_cohort
      expect_cohort_to_be_created
    end
    #Notes about this particular test/scenario:
    #  - Thought I'd play with the idea of making the scenario as readable as possible
    #    so when it does break, you're changing the method its using, not the scenario itself.
    #    Could help isolate especially brittle areas of the test or the code.
    #  - I realize that this tests is taking the big assumption that you will be redirected to the staff_cohorts_index after sign_in

    def click_new_cohort_link
      find(:css, "a[href='#{new_staff_cohort_path}']").click
    end

    def create_cohort
      fill_in 'Name', with: 'Rails'
      select 'Moon', from: 'Campus'
      select 'Jane Doe', from: 'Instructor'

      click_button 'Create Cohort'
    end

    def expect_cohort_to_be_created
      expect(page).to have_content('New Cohort successfully created!')
    end
  end
end
