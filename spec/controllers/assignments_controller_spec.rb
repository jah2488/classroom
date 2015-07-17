require 'rails_helper'

describe AssignmentsController do
  before(:each) do
    instructor = FactoryGirl.create(:instructor)
    campus     = FactoryGirl.create(:campus)
    @cohort     = FactoryGirl.create(:cohort, instructor: instructor, campus: campus)
    student    = Student.create!(cohort_id: @cohort.id, email: 'student@example.com', password: 123456789)
    sign_in student
  end

  describe "GET #current" do
    it "returns http success" do
      get :current
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get :search, query: 'foo'
      expect(response).to have_http_status(:success)
    end
  end
end
