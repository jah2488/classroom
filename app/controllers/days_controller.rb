class DaysController < ApplicationController

  def new
    render locals: {
      day: Day.new
    }
  end

  def create
    day = Day.new(day_params)
    day.cohort = current_instructor.current_cohort
    if day.save
      redirect_to instructor_dash_path, notice: 'A New Day has successfully been created. It has been set as the current day for this cohort.'
    else
      render :new
    end
  end

  private

  def day_params
    params.require(:day).permit(:start_time, :override_code)
  end


end
