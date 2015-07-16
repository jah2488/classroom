require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do

  before(:each) do
    instructor = Instructor.create!(email: 'foo@email.com', password: 123456789)
    campus     = Campus.create!(name: 'foobar')
    cohort     = Cohort.create!(instructor_id: instructor.id, campus_id: campus.id, first_day: DateTime.now)
    student    = Student.create!(cohort_id: cohort.id, email: 'student@example.com', password: 123456789)
    sign_in student
    sign_in instructor
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      Assignment.create!
      get :show, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #current" do
    it "returns http success" do
      get :current
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
  end



  describe "GET #create" do
    it "returns http success" do
      get :create, assignment: { title: 'foo', info: 'nope', due_date: '', tag_ids: [] }
      expect(response).to have_http_status(:redirect)
    end
  end

end
