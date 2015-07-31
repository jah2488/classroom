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
    it "allows instructor to see only own students" do
      create_list :student, 5
      student.cohort.instructor_id = instructor_user.instructor.id
      student.cohort.save
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
