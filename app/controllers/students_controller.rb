class StudentsController < ApplicationController
  def show
    render locals: {
      student: Student.find(params[:id])
    }
  end

  def edit
    render locals: {
      student: Student.find(params[:id])
    }
  end

  def update
    student = Student.find(params[:id])
    if student.update(student_params)
      redirect_to profile_path(student), notice: 'Profile successfully updated'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :github, :phone, :blog, :bio)
  end
end
