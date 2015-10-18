require 'rails_helper'

describe Staff::CohortsController do
  let(:cohort) { create :cohort_w_stuff }
  let(:instructor_user) { create :instructor_user }
  describe "GET #show" do
    it "allows cohort to be viewed" do
      sign_in instructor_user
      get :show, id: cohort.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #archive" do
    it "archives a cohort" do
      sign_in instructor_user
      expect{put :archive, cohort_id: cohort.id; cohort.reload}.to change(cohort, :archived).to true
    end
  end
end
