require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:instructor_user) { create :instructor_user }
  let(:student) { create :student }
  let(:student_user) { create :user, student: student }

  describe "GET #show" do
    it "shows a student themselves" do
      sign_in student_user
      get :show, id: student_user.student.id
      expect(response).to have_http_status(:success)
    end

    it "shows instructor a student" do
      student.cohort.instructor_id = instructor_user.instructor.id
      student.cohort.save
      sign_in instructor_user
      get :show, id: student.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      sign_in instructor_user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
