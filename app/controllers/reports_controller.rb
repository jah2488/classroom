class ReportsController < ApplicationController
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index

  def index
    @reports = policy_scope(Report)
  end

  def new
    @report = Report.new
    authorize @report
    @students = current_user.instructor.current_cohort.students
  end

  def show
    @report = Report.find(params[:id]).decorate
    authorize @report
    @report = @report.decorate
    respond_to do |format|
      format.html
      format.pdf { render pdf: "report_#{@report.student_name}-#{@report.day}".parameterize, show_as_html: false}
    end
  end
end
