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
        json = JSON.parse(response.body)
        expect(json[0]).to_not be_blank
        expect(json[1]).to_not be_blank
        expect(json[2]["tardies"]).to eq 0
        expect(json[2]["absences"]).to eq 0
      end
    end

    it "fails if student is already checked in" do
      time = cohort.start_time
      Timecop.freeze(time.to_datetime) do
        sign_in student_user
        create :day, cohort: cohort, start: time
        post :create, distance: 0
      end
      post :create, distance: 0
      expect(response).to have_http_status(:bad_request)
    end

    it "rejects off-campus checkin without override code" do
      time = cohort.start_time
      Timecop.freeze(time.to_datetime) do
        sign_in student_user
        create :day, cohort: cohort, start: time
        post :create, distance: 5
      end
      expect(response).to have_http_status(:forbidden)
    end
  end
end
