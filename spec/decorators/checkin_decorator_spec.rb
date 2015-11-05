require 'spec_helper'

describe CheckinDecorator do
  subject{CheckinDecorator.new(build_stubbed :checkin)}

  it "has stats" do
    expect(subject.stats).to be_a Hash
  end
end
