class StudentsController < ApplicationController
  def show
    render locals: {
      student: Student.find(params[:id])
    }
  end

  def edit
  end

  def update
  end
end
