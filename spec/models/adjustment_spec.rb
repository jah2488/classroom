require 'rails_helper'

RSpec.describe Adjustment, type: :model do
  let(:adjustment) { FactoryGirl.create :adjustment }
  describe 'can be created' do
    it 'defaults state to opened' do
      expect(adjustment.state).to eq('OPENED')
    end
  end
end
