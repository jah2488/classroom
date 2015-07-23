class ReportsController < ApplicationController
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  def index
    @reports = policy_scope(Report)
  end

  def new
    @report = Report.new
    authorize @report
    @students = current_instructor.current_cohort.students
  end

  def create
    report = Report.new(report_params)
    authorize report
    report.day = current_instructor.current_cohort.current_day
    if report.save
      redirect_to report_path(report), notice: I18n.t('.created', resource: I18n.t('.report'))
    else
      render error: "something went wrong"
    end
  end

  def show
    @report = Report.find(params[:id]).decorate
    authorize @report
    respond_to do |format|
      format.html
      format.pdf { render pdf: "#{@report.student.name} Report", show_as_html: false}
    end
  end

  private

  def report_params
    params.require(:report).permit(:student_id, :participation, :participation_comments, :effort, :effort_comments, :skill, :skill_comments, :overall, :overall_comments, :status)
  end
end
