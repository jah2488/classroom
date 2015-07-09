class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    render locals: {
      student: Student.find(params[:id])
    }
  end

  def edit
    render locals: {
      student: Student.find(params[:id])
    }
  end

  def update
    student = Student.find(params[:id])
    if student.update(student_params)
      redirect_to profile_path(student), notice: 'Profile successfully updated'
    end
  end

  def reports
    render locals: {
      students: current_instructor.current_cohort.students
    }
  end

  def report
    debug = true if params[:debug].present? || params[:report][:debug] == 'true'
    report = params.fetch(:report)
    if (report.fetch('student', 1).to_i).zero?
      student = Student.new
      student.name = report[:student]
    else
      student = Student.find(report[:student])
    end
    render pdf: 'assessment', show_as_html: debug, locals: {
                 debug: debug,
                 campus:                 report.fetch(:campus, current_instructor.current_cohort.location),
                 course:                 report.fetch(:course, current_instructor.current_cohort.name),
                 cohort:                 report.fetch(:cohort, current_instructor.current_cohort.name),
                 instructor:             report.fetch(:instructor, current_instructor.name),
                 student:                student.name,
                 participation:          report.fetch(:participation, 3),
                 participation_comments: report.fetch(:participation_comments, ''),
                 effort:                 report.fetch(:effort, 3),
                 effort_comments:        report.fetch(:effort_comments, ''),
                 skill:                  report.fetch(:skill, 3),
                 skill_comments:         report.fetch(:skill_comments, ''),
                 overall:                report.fetch(:overall, 3),
                 overall_comments:       report.fetch(:overall_comments, ''),
                 status:                 report.fetch(:status, 'Satisfactory'),
                 completed_assignments:  report.fetch(:completed_assignments, Assignment.complete_for(student).count),
                 total_assignments:      report.fetch(:total_assignments, Assignment.for(student).count).to_i,
                 absences:               report.fetch(:absences, student.absences).to_i,
                 tardies:                report.fetch(:tardies, student.tardies).to_i,
                 total_lectures:         report.fetch(:total_lectures, Day.for(current_instructor.current_cohort).count).to_i,
    }
  end

  private

  def student_params
    params.require(:student).permit(:name, :github, :phone, :blog, :bio)
  end
end
