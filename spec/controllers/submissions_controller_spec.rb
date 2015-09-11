require 'rails_helper'

RSpec.describe SubmissionsController do
  let(:instructor) { create :instructor }
  let(:instructor_user) { create :user, instructor: instructor }
  let(:cohort) { create :cohort, instructors: [instructor] }
  let(:student) { create :student, cohort: cohort }
  let(:student_user) { create :user, student: student }
  let(:submission) { create :submission, student: student }

  context "student" do
    before do
      sign_in student_user
    end
    describe "GET #new" do
      it "returns http success" do
        get :new
      end
    end
    describe "GET #show" do
      it "succeeds on own" do
        get :show, id: submission.id
        expect(response).to have_http_status(:success)
      end
    end

  end

  context "instructor" do
    before do
      sign_in instructor_user
    end

    describe "PATCH #mark" do
      it "marks complete" do
        patch :complete, submission_id: submission.id
        expect(response).to have_http_status(:success)
        submission.reload
        expect(submission).to be_complete
      end

      it "marks unfinished" do
        patch :unfinish, submission_id: submission.id
        expect(response).to have_http_status(:success)
        submission.reload
        expect(submission).to be_unfinished
      end
    end

  end
end
