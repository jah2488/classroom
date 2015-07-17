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
      Assignment.create!(title: 'example assignment')
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
      get :search, query: 'foo'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create, assignment: { title: 'foo', info: 'nope', due_date: '', tag_ids: [] }
      expect(response).to have_http_status(:redirect)
    end
    it "returns new page on errors" do
      get :create, assignment: { info: 'none' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      assignment = Assignment.create!(title: 'example assignment')
      get :edit, id: assignment.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    let(:assignment) {
      Assignment.create!(title: 'example assignment')
    }

    it "returns http success" do
      get :update, id: assignment.id, assignment: { title: 'foo', info: 'nope', due_date: '', tag_ids: [] }
      expect(response).to have_http_status(:redirect)
    end

    it "returns new page on errors" do
      get :update, id: assignment.id, assignment: { title: nil, info: 'none' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

