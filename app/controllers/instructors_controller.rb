class InstructorsController < ApplicationController
  def show
    render locals: { instructor: Instructor.find(params[:id]) }
  end
end
