class AdjustmentsController < ApplicationController
  def show
    adjustment = Adjustment.find(params[:id])
    authorize adjustment
    render json: adjustment, include: 'checkin.student,checkin.day'
  end

  def create
    adjustment = Adjustment.new(adjustment_params)
    authorize adjustment
    if adjustment.save
      render json: adjustment
    else
      render json: adjustment.errors, status: :unprocessable_entity
    end
  end

  def adjust
    adjustment = Adjustment.find(params[:adjustment_id])
    authorize adjustment
    checkin    = adjustment.checkin

    checkin.correct
    adjustment.state = Adjustment::ADJUSTED

    checkin.save
    adjustment.save
    render json: adjustment, include: 'checkin'
  end

  def close
    adjustment = Adjustment.find(params[:adjustment_id])
    authorize adjustment
    adjustment.state = Adjustment::CLOSED
    adjustment.save
    render json: adjustment, include: 'checkin'
  end

  private
  def adjustment_params
    params.require(:adjustment).permit(:checkin_id, :state)
  end
end
