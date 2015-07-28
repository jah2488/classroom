require 'rails_helper'

RSpec.describe SubmissionsController do
  let(:student) { FactoryGirl.create :student }
  let(:instructor) { FactoryGirl.create :instructor }
  let(:submission) { FactoryGirl.create :submission, student: student }

  context "student" do
    before do
      sign_in student
    end
    describe "GET #new" do
      it "returns http success" do
        get :new
      end
    end
    describe "GET #show" do
      it "succeeds on own" do
        get :show, id: submission.id
        expect(response).to be_success
      end
    end

  end

  context "instructor" do
    before do
      sign_in instructor
    end
    describe "PATCH #mark" do
      ## I really don't like these tests
      it "marks complete" do
        student.cohort.instructor = instructor
        student.cohort.save
        patch :complete, submission_id: submission.id
        expect(response).to be_success
        submission.reload
        expect(submission).to be_complete
      end
      it "marks unfinished" do
        student.cohort.instructor = instructor
        student.cohort.save
        patch :unfinish, submission_id: submission.id
        expect(response).to be_success
        submission.reload
        expect(submission).to be_unfinished
      end
    end

  end
end
