class ReportsController < ApplicationController
  def index
  end

  def new
    @report = Report.new
    @students = current_instructor.current_cohort.students
  end

  def create
    report = Report.new(report_params)
    report.day = Day.current_for(current_instructor.current_cohort)
    if report.save
      redirect_to report_path(report), notice: I18n.t('.created', resource: I18n.t('.report'))
    else
      render error: "something went wrong"
    end
  end

  def show
    @report = Report.find(params[:id])
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
