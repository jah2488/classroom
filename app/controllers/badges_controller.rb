class BadgesController < ApplicationController
  def new
    render locals: {
      badge: Badge.new
    }
  end

  def edit
    render template: 'badges/new', locals: {
      badge: Badge.find(params[:id])
    }
  end

  def update
    badge = Badge.find(params[:id])
    if badge.update(badge_params)
      redirect_to instructor_dash_path, notice: 'Badge updated!'
    else
      render :new
    end
  end

  def create
    badge = Badge.new(badge_params)
    if badge.save
      redirect_to instructor_dash_path, notice: 'New badge created!'
    else
      render :new
    end
  end

  private
  def badge_params
    params.require(:badge).permit(:name, :description, :icon_image)
  end
end
