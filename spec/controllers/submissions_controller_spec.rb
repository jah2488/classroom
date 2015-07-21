require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do
  let(:student) { FactoryGirl.create :student }

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
        submission = FactoryGirl.create(:submission, student: student)
        get :show, id: submission.id
        expect(response).to be_success
      end
    end
  end
end
