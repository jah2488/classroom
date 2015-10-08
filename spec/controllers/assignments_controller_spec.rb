require 'rails_helper'

describe AssignmentsController do
  before(:each) do
    instructor = FactoryGirl.create(:instructor)
    campus     = FactoryGirl.create(:campus)
    @cohort     = FactoryGirl.create(:cohort, instructors: [instructor], campus: campus)
    student    = create(:student, cohort_id: @cohort.id)
    student_user = create(:user, student: student)
    sign_in student_user
  end

  describe "GET #current" do
    it "returns http success" do
      get :current
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, query: 'foo'
      expect(response).to have_http_status(:success)
    end
  end
end
