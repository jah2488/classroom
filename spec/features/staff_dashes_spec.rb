require 'rails_helper'

RSpec.feature "StaffDashes", type: :feature do
  feature 'The Cohort Dashboard' do
    let!(:instructor) do
      create :instructor_user, email: 'instructor@theironyard.com', password: 'password', name: 'Jane Doe'
    end

    scenario 'has assignments, students, submissions, and adjustments' do
      cohort, day, _, assignment, user, _ = create_full_dash

      sign_in(:instructor)

      Timecop.travel(cohort.start_time) do
        visit staff_cohort_path(cohort)
        expect(page).to have_content(day.decorate.starts_at)
        expect(page).to have_content(assignment.title.titleize)
        expect(page).to have_content(assignment.submissions.first.decorate.link_domain)
        expect(page).to have_content(/#{user.name}/i)
      end
    end

    scenario 'viewing assignments' do
      cohort, _, _, assignment, _, _ = create_full_dash

      sign_in(:instructor)

      visit staff_cohort_path(cohort)

      click_link_to(staff_cohort_assignment_path(cohort, assignment))

      expect(page).to have_content(assignment.title)
      expect(page).to have_content(/submit homework/i)
    end

    scenario 'creating assignments' do
    end

    scenario 'viewing submissions' do
      cohort, _, _, assignment, _, _ = create_full_dash

      sign_in(:instructor)

      visit staff_cohort_path(cohort)

      click_link_to(submission_path(assignment.submissions.first))

      expect(page).to have_content(/#{assignment.submissions.first.student.decorate.name}'s Submission for #{assignment.title}/i)
    end

    scenario 'viewing students' do
      cohort, _, _, assignment, _, _ = create_full_dash

      sign_in(:instructor)

      visit staff_cohort_path(cohort)

      click_link_to(student_path(assignment.submissions.first.student))

      expect(page).to have_content(assignment.submissions.first.student)
      expect(page).to have_content(/stats/i)
      expect(page).to have_content(/badges/i)
      expect(page).to have_content(/blog/i)
    end

    def click_link_to(path)
      result = find_link_to(path)
      if result.respond_to?(:each)
        result.first.click
      else
        result.click
      end
    end

    def find_link_to(path)
      find(:css, "a[href='#{path}']")
    rescue Capybara::Ambiguous
      all(:css, "a[href='#{path}']")
    end

    def create_full_dash
      cohort  = create :cohort, name: 'Rails Summer', instructor: instructor.instructor
      day = cohort.first_day
      checkin = create :checkin, day: day
      assignment = create :assignment_w_submissions, cohort: cohort
      adjustment = create :adjustment, checkin: checkin

      student = assignment.submissions.first.student
      student.cohort = cohort
      student.user = create :user, name: 'Jane Student Smith'
      student.save!

      user = create :student_user
      user.email = Faker::Internet.email
      user.student.cohort = cohort
      user.save!

      [cohort, day, checkin, assignment, user, adjustment]
    end

  end
end
