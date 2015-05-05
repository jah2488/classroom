class DaysController < ApplicationController

  def new
    render locals: {
      day: Day.new
    }
  end

  def create
    current_day = Day.current_for(current_instructor.current_cohort)
    day = Day.new(day_params)
    day.cohort = current_instructor.current_cohort
    if day.save
      current_day.unaccounted_for_students.each do |student|
        Checkin.create(student_id: student.id,
                       late: false,
                       absent: true,
                       day_id: current_day.id)
      end
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
