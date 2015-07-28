class StudentsController < ApplicationController
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index

  def index
    students = policy_scope(Student)
    render locals: {
      students: students
    }
  end

  def show
    student = Student.find(params[:id])
    authorize student
    render locals: {
      student: student
    }
  end

  def edit
    student = Student.find(params[:id])
    authorize student
    render locals: {
      student: student
    }
  end

  def update
    student = Student.find(params[:id])
    authorize student
    if student.update(student_params)
      redirect_to student_path(student), notice: 'Profile successfully updated'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :github, :phone, :blog, :bio, :twitter)
  end
end
