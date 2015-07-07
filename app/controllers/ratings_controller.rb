class RatingsController < ApplicationController
  def create
    rating = Rating.new(rating_params)
    if rating.save!
      render json: rating
    else
      render json: rating.errors, status: :unprocessable_entity
    end
  end

  def update
    rating = Rating.find(params[:id])
    if rating.update(rating_params)
      render json: rating
    else
      render json: rating.errors, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:submission_id, :notes, :amount)
  end
end
