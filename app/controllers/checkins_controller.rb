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
      now  = Time.zone.now
      late = day.late_time
      late_time = DateTime.new(now.year, now.month, now.day, late.hour, late.min, late.sec, now.zone)
      checkin.late    = true if now > late_time
      provided_code   = params.fetch(:override_code, 'none')
      distance        = params.fetch(:distance, 0)
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
