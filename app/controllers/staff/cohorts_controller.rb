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
    students    = @cohort.students
    assignments = @cohort.assignments.order('due_date DESC')
    session[:cohort_id] = @cohort.id
    render locals: {
      cohort: @cohort.decorate,
      assignments: assignments.decorate,
      adjustments: students.flat_map(&:adjustments).select{|a| a.state == "OPENED"}
    }
  end

  def staff
    cohort = Cohort.find(params[:cohort_id])
    render locals: {
      cohort: cohort.decorate,
      instructors: cohort.instructors.decorate,
      operations: cohort.operators.decorate
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
    @cohorts = CohortDecorator.decorate_collection(Cohort.unarchived.order(:created_at))
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
    if current_user && current_user.staff? && session[:cohort_id]
      redirect_to staff_cohort_path(session[:cohort_id])
    elsif current_user && current_user.staff?
      redirect_to staff_cohorts_path
    end
  end
end
