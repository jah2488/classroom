class DaysController < ApplicationController

  def new
    render locals: {
      day: Day.new
    }
  end

  def create
    day = Day.new(day_params)
    day.cohort = current_instructor.current_cohort
    day.start = ActiveSupport::TimeZone[day.tz].parse(params[:day][:start])
    if day.save
      redirect_to instructor_dash_path, notice: 'A New Day has successfully been created'
    else
      render :new
    end
  end

  private

  def day_params
    params.require(:day).permit(:override_code)
  end


end
