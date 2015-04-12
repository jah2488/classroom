class CohortsController < ApplicationController
  def new
    render locals: {
      cohort: Cohort.new
    }
  end

  def show
    render locals: {
      cohort: Cohort.find(params.fetch(:id))
    }
  end

  def create
    cohort = Cohort.new(cohort_params)
    cohort.instructor = current_instructor
    if cohort.save
      redirect_to instructor_dash_path, notice: I18n.t('.created', resource: I18n.t('.cohort'))
    else
    end
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name, :location)
  end
end
