require 'rails_helper'

RSpec.describe AdjustmentsController do
  let(:adjustment) { FactoryGirl.create :adjustment }
  let(:instructor) { FactoryGirl.create :instructor }
  it "adjusts" do
    sign_in instructor
    patch :adjust, id: adjustment.id
    expect(response).to be_success
  end
end
