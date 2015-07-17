require 'spec_helper'

describe DayDecorator do
  describe "#starts_at" do
    it "uses timezone" do
      day = instance_double("Day", start:  DateTime.new(2015, 5,11,8,0,0,"-06:00"), tz: "Central Time (US & Canada)")
      expect(DayDecorator.decorate(day).starts_at).to eq " 9:00am CDT"
    end
  end

  describe "#late_at" do
    it "uses timezone" do
      day = instance_double("Day", late_time:  DateTime.new(2015, 5,11,8,15,0,"-06:00"), tz: "Central Time (US & Canada)")
      decor = DayDecorator.decorate(day)
      expect(decor.late_at).to eq " 9:15am CDT"
    end
  end
end
