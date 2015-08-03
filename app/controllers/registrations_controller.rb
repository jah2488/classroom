class RegistrationsController < Devise::RegistrationsController
  def new
    @cohort = Cohort.find(params[:cohort_id]) if params[:cohort_id]
    super
  end

  def create
    super do |resource|
      resource.student = Student.new(cohort_id: params[:cohort_id])
      resource.save
    end
  end

  def update
    super
  end
end

