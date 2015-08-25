class Staff::CampusesController < Staff::ApplicationController
  def index
    render locals: {
      campuses: Campus.all
    }
  end

  def new
    render locals: {
      campus: Campus.new
    }
  end
end
