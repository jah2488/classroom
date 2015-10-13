require 'rails_helper'

RSpec.describe Cohort, type: :model do
  let(:cohort) { create :cohort, start_date: Date.today - 1.month }
  let(:now) { Faker::Time.between(cohort.start_time, cohort.start_time + 3.months) }

  describe "#current_day" do
    it "returns the day for today" do
      tznow = now.in_time_zone(cohort.tz)
      day = create :day, cohort: cohort, start: tznow.end_of_day - 1.second
      create :day, cohort: cohort, start: tznow.end_of_day + 1.second
      create :day, cohort: cohort, start: tznow.beginning_of_day - 1.second
      create :day, cohort: cohort, start: cohort.start_time
      Timecop.freeze(now) do
        expect(cohort.current_day).to eq day
      end
    end
  end

  describe "#start_date=" do
    it "takes in a date and sets a full time" do
      today = Date.today
      cohort = Cohort.new
      cohort.campus = build_stubbed :campus
      cohort.start_date = today
      #the date is assumed to be in the TZ of the campus
      date = cohort.start_time.in_time_zone(cohort.tz)
      expect(date.day).to eq today.day
      expect(date.month).to eq today.month
      expect(date.hour).to be_between(0, 1) # dst messes with this
      expect(date.minute).to eq 0
    end
  end
end
