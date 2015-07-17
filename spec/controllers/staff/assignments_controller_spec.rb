require 'rails_helper'

describe Staff::AssignmentsController do

  before(:each) do
    instructor = FactoryGirl.create(:instructor)
    campus     = FactoryGirl.create(:campus)
    @cohort     = FactoryGirl.create(:cohort, instructor: instructor, campus: campus)
    sign_in instructor
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, cohort_id: @cohort.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      Assignment.create!(title: 'example assignment')
      get :show, id: 1, cohort_id: @cohort.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, assignment: { title: 'foo', info: 'nope', due_date: '01/01/2015 09:00 AM', tag_ids: [] }, cohort_id: @cohort.id
      expect(response).to have_http_status(:redirect)
    end
    it "returns new page on errors" do
      post :create, assignment: { info: 'none', due_date: '' }, cohort_id: @cohort.id
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      assignment = Assignment.create!(title: 'example assignment')
      get :edit, id: assignment.id, cohort_id: @cohort.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #update" do
    let(:assignment) { FactoryGirl.create(:assignment, cohort: @cohort) }

    it "returns http success" do
      post :update, id: assignment.id, assignment: { title: 'foo', info: 'nope', due_date: '', tag_ids: [] }, cohort_id: @cohort.id
      expect(response).to have_http_status(:redirect)
    end

    it "returns new page on errors" do
      post :update, id: assignment.id, assignment: { title: nil, info: 'none' }, cohort_id: @cohort.id
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

