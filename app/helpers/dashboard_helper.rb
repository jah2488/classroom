module DashboardHelper

  def week_number(total, index)
    ((index + 1) - total).abs + 1
  end

  def status_for(assignment, student)
    assignment.decorate.state(student)
  end

end
