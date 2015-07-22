class CohortsController < ApplicationController
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  def show
    @cohort = Cohort.find(params[:id])
    authorize @cohort
  end
end
