class CheckinsController < ApplicationController
  def create
    # Hardcoded business rules :(
    # -- In a controller of all places too. Ugh.
    #
    # Probably need a Day model that is created on the instructor's side for each 'day of class'.
    # Then each checkin belongs to a particular day, which belongs to a particular cohort.
    # Will make the schedule a lot more flexible and avoid some nasty logic and the need for cron jobs.
    checkin = Checkin.new
    checkin.student = current_student
    day             = Day.current_for(current_student.cohort)
    checkin.day     = day
    checkin.late    = true if Time.zone.now > day.start_time
    if checkin.save
      render json: [
        checkin.created_at.strftime("%I:%M%p"),
        checkin,
        { tardies: current_student.tardies, absences: current_student.absences }
      ].to_json, status: 200
    else
      render json: checkin.errors, status: :unprocessable_entity
    end
  end
end
