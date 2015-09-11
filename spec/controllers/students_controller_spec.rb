require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:instructor) { create :instructor }
  let(:instructor_user) { create :instructor_user, instructor: instructor }
  let(:cohort) { create :cohort, instructors: [instructor] }
  let(:student) { create :student, cohort: cohort }
  let(:student_user) { create :user, student: student }

  describe "GET #show" do
    it "shows a student themselves" do
      sign_in student_user
      get :show, id: student_user.student.id
      expect(response).to have_http_status(:success)
    end

    it "shows instructor a student" do
      sign_in instructor_user
      get :show, id: student.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "allows instructor to see only own students" do
      create_list :student, 5
      sign_in instructor_user
      allow(controller).to receive(:render).with no_args
      expect(controller).to receive(:render).with({
        locals: { students: [student] }
      })
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
