class AdjustmentsController < ApplicationController
  def create
    adjustment = Adjustment.new(adjustment_params)
    if adjustment.save
      render json: adjustment
    else
      render json: adjustment.errors, status: :unprocessable_entity
    end
  end

  def adjust
    adjustment = Adjustment.find(params[:id])
    checkin    = adjustment.checkin

    checkin.correct
    adjustment.state = Adjustment::ADJUSTED

    checkin.save
    adjustment.save
    render json: adjustment
  end

  def close
    adjustment = Adjustment.find(params[:id])
    adjustment.state = Adjustment::CLOSED
    adjustment.save
    render json: adjustment
  end

  private
  def adjustment_params
    params.require(:adjustment).permit(:checkin_id, :state)
  end
end
