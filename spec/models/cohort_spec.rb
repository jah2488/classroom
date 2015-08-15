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
end
