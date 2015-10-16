class Staff::ReportsController < Staff::ApplicationController
  before_action :set_cohort
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index

  def index
    @reports = policy_scope(Report).where(day_id: @cohort.days)
    @reports = ReportDecorator.decorate_collection(@reports)
  end

  def new
    @report = Report.new
    authorize @report
  end

  def edit
    @report = Report.find(params[:id])
    authorize @report
  end

  def show
    @report = Report.find(params[:id])
    authorize @report
    @report = @report.decorate
    respond_to do |format|
      format.html
    end
  end

  def create
    @report = Report.new(report_params)
    authorize @report
    if @report.save
      redirect_to staff_cohort_report_path(@cohort, @report), notice: I18n.t('.created', resource: I18n.t('.report'))
    else
      flash[:alert] = "Report couldn't be created because #{@report.errors.full_messages.join(', ')}"
      render :new
    end
  end

  private
  def set_cohort
    @cohort = Cohort.find(params[:cohort_id]).decorate
  end

  def report_params
    params.require(:report).permit(:student_id, :day_id, :participation, :participation_comments, :effort, :effort_comments, :skill, :skill_comments, :overall, :overall_comments, :status)
  end
end
