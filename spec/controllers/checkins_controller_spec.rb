require 'rails_helper'

RSpec.describe CheckinsController do
  let(:instructor) { create :instructor }
  let(:instructor_user) { create :instructor_user, instructor: instructor }
  let(:cohort) { create :cohort, instructors: [instructor] }
  let(:student) { create :student, cohort: cohort }
  let(:student_user) { create :user, student: student }

  describe "POST #create" do
    it "denies instructors" do
      sign_in instructor_user
      post :create
      expect(response).to_not have_http_status(:success)
    end

    it "succeeds for unchecked student" do
      time = cohort.start_time
      Timecop.freeze(time.to_datetime) do
        sign_in student_user
        create :day, cohort: cohort, start: time
        post :create, distance: 0
        expect(response).to have_http_status(:success)
      end
    end
  end
end
