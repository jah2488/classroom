class Staff::DaysController < Staff::ApplicationController
  def index
    render locals: {
      cohort: Cohort.find(params.fetch(:cohort_id)).decorate
    }
  end

  def new
    @cohort = Cohort.find(params[:cohort_id]).decorate
    render locals: {
      day: Day.new
    }
  end

  def create
    day = Day.new(day_params)
    day.cohort_id = params[:cohort_id]
    day.start = ActiveSupport::TimeZone[day.tz].parse(params[:day][:start])
    if day.save
      redirect_to staff_cohort_days_path(day.cohort), notice: 'A New Day has successfully been created'
    else
      render :new
    end
  end

  private

  def day_params
    params.require(:day).permit(:override_code)
  end
end
