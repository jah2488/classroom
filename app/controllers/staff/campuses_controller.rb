class Staff::CampusesController < Staff::ApplicationController
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index

  def index
    render locals: {
      campuses: policy_scope(Campus.all)
    }
  end

  def new
    campus = Campus.new
    authorize campus
    render locals: {
      campus: campus
    }
  end

  def create
    campus = Campus.new(campus_params)
    authorize campus
    if campus.save
      redirect_to staff_campuses_path, notice: I18n.t('.created', resource: I18n.t('.campus'))
    else
      render :new, locals: {campus: campus}
    end
  end

  private

  def campus_params
    params.require(:campus).permit(:name, :latitude, :longitude, :time_zone)
  end
end
