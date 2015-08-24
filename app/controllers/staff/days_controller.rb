class Staff::DaysController < Staff::ApplicationController
  def index
    render locals: {
      cohort: Cohort.find(params.fetch(:cohort_id)).decorate
    }
  end

  def new
    render locals: {
      cohort: Cohort.find(params[:cohort_id]).decorate,
      day: Day.new
    }
  end

  def create
    day = Day.new(day_params)
    day.cohort_id = params[:cohort_id]
    day.start = ActiveSupport::TimeZone[day.tz].parse(params[:day][:start])
    if day.save
      redirect_to staff_cohort_days_path(day.cohort), notice: I18n.t('.created', resource: I18n.t('.day'))
    else
      render :new, locals: {
        cohort: Cohort.find(params[:cohort_id]).decorate,
        day: day
      }
    end
  end

  private

  def day_params
    params.require(:day).permit(:override_code, :start)
  end
end
