require 'rails_helper'

RSpec.describe AdjustmentsController do
  let(:adjustment) { create :adjustment }
  let(:instructor_user) { create :instructor_user }
  it "adjusts" do
    sign_in instructor_user
    put :adjust, adjustment_id: adjustment.id
    expect(response).to have_http_status(:success)
  end
  it "closes" do
    sign_in instructor_user
    put :close, adjustment_id: adjustment.id
    expect(response).to have_http_status(:success)
  end
end
