require 'rails_helper'

RSpec.describe AdjustmentsController do
  let(:adjustment) { create :adjustment }
  let(:instructor_user) { create :instructor_user }
  it "adjusts" do
    sign_in instructor_user
    patch :adjust, id: adjustment.id
    expect(response).to have_http_status(:success)
  end
end
