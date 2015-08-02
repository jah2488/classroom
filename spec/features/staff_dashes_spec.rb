require 'rails_helper'

RSpec.feature "StaffDashes", type: :feature do
  feature 'The Cohort Dashboard' do
    let!(:instructor) do
      create :instructor_user, email: 'instructor@theironyard.com', password: 'password', name: 'Jane Doe'
    end

    scenario 'has assignments, students, submissions, and adjustments' do
      cohort  = create :cohort, name: 'Rails Summer', instructor: instructor.instructor
      day     = create :day, cohort: cohort
      checkin = create :checkin, day: day
      assignment = create :assignment_w_submissions, cohort: cohort
      user = create :student_user
      user.email = Faker::Internet.email
      user.student.cohort = cohort
      user.save!
      create :adjustment, checkin: checkin

      sign_in(:instructor)

      visit staff_cohort_path(cohort)

      expect(page).to have_content(day.decorate.starts_at)
      expect(page).to have_content(assignment.title)
      expect(page).to have_content(assignment.submissions.first.link)
      expect(page).to have_content(user.name)
    end

    scenario 'viewing assignments' do
    end
    scenario 'creating assignments' do
    end

    scenario 'viewing submissions' do
    end
    scenario 'viewing assignments' do
    end

  end
end
