class Staff::CohortsController < Staff::ApplicationController
  def new
    cohort = Cohort.new
    authorize cohort
    render locals: {
      cohort: cohort
    }
  end

  def show
    return find_cohort unless params[:id]
    @cohort      = Cohort.find(params[:id]).decorate
    authorize @cohort
    students    = @cohort.students.includes(:adjustments)
    assignments = @cohort.assignments.order('due_date DESC')
    adjustments = students.flat_map(&:adjustments)
    session[:cohort_id] = @cohort.id
    render locals: {
      cohort: @cohort.decorate,
      assignments: assignments.decorate,
      adjustments: adjustments
    }
  end

  def archive
    cohort = Cohort.find(params[:cohort_id])
    if cohort.update(archived: true)
      redirect_to staff_cohorts_path, notice: "Cohort archived"
    else
      render :show
    end
  end
  def index
    @cohorts = CohortDecorator.decorate_collection(Cohort.all.order(:created_at))
  end

  def create
    cohort = Cohort.new(cohort_params)
    cohort.instructor_ids = [params[:cohort][:instructor_id]]
    authorize cohort
    if cohort.save
      redirect_to staff_cohort_path(cohort), notice: I18n.t('.created', resource: I18n.t('.cohort'))
    else
      render :new, locals: { cohort: cohort }
    end
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name, :campus_id, :start_date)
  end

  def find_cohort
    if current_user && current_user.instructor? && session[:cohort_id]
      redirect_to staff_cohort_path(session[:cohort_id])
    elsif current_user && current_user.instructor?
      redirect_to staff_cohorts_path
    end
  end
end
