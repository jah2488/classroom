class CheckinsController < ApplicationController
  def create
    # Hardcoded business rules :(
    # -- In a controller of all places too. Ugh.
    #

    day = Day.current_for(current_student.cohort)

    if day.has_checkin_for?(current_student)
      render json: '', status: :unauthorized
    else
      checkin         = Checkin.new
      checkin.student = current_student
      checkin.day     = day
      checkin.late    = true if Time.zone.now > day.start_time
      provided_code   = params.fetch(:override_code)
      distance        = params.fetch(:distance)
      if distance.to_i > 1.0 && provided_code != day.override_code
        render json: 'Code Invalid', status: :unauthorized
      elsif checkin.save
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
end
