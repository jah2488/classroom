require 'rails_helper'

RSpec.describe Cohort, type: :model do
  let(:cohort) { create :cohort }
  let(:now) { Faker::Time.between(cohort.start_time.beginning_of_day, cohort.start_time.end_of_day).in_time_zone(cohort.tz) + 1.day }

  describe "#current_day" do
    it "returns the day for today" do
      day = create :day, cohort: cohort, start: now.end_of_day - 1.second
      create :day, cohort: cohort, start: now.end_of_day + 1.second
      create :day, cohort: cohort, start: now.beginning_of_day - 1.second
      create :day, cohort: cohort, start: cohort.start_time
      Timecop.freeze(now) do
        expect(cohort.current_day).to eq day
      end
    end
  end

  describe "#create_first_day" do
    it "correctly creates a day for a new cohort" do
      today = Date.today
      cohort = create(:cohort, start_date: today)
      cohort.reload
      expect(cohort.days).to_not be_empty
      expect(cohort.days.first.start.day).to eq today.day
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
      expect(date.hour).to eq 0
      expect(date.minute).to eq 0
    end
  end
end
