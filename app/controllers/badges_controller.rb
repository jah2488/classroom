class BadgesController < ApplicationController
  after_action :verify_authorized, :except => [:index, :my]
  after_action :verify_policy_scoped, :only => :index
  def new
    badge = Badge.new
    authorize badge
    render locals: {
      badge: badge
    }
  end

  def edit
    badge = Badge.find(params[:id])
    authorize badge
    render template: 'badges/new', locals: {
      badge: badge
    }
  end

  def show
    badge = Badge.find(params[:id])
    authorize badge
    render locals: {
      badge: badge
    }
  end

  def index
    badges = policy_scope(Badge).decorate
    render locals: {
      badges: badges
    }
  end

  def update
    badge = Badge.find(params[:id])
    authorize badge
    if badge.update(badge_params)
      redirect_to badges_path, notice: 'Badge updated!'
    else
      render :new
    end
  end

  def destroy
    badge = Badge.find(params[:id])
    authorize badge
    if badge.destroy
      redirect_to badges_path, notice: "Badge deleted"
    else
      render :index
    end
  end

  def create
    badge = Badge.new(badge_params)
    authorize badge
    if badge.save
      redirect_to badges_path, notice: 'New badge created!'
    else
      render :new
    end
  end

  private
  def badge_params
    params.require(:badge).permit(:name, :description, :icon_image)
  end
end
