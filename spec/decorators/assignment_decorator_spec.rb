require 'spec_helper'

describe AssignmentDecorator do
  subject { AssignmentDecorator.decorate(assignment) }
  let(:assignment) { build_stubbed :assignment }
  it{ expect(subject.title).to_not eq nil}

  context "time is frozen" do
    before do
      now = Time.new(2015, 11, 5, 10, 1, 0, "-06:00")
      Timecop.freeze(now)
    end

    after do
      Timecop.return
    end

    describe "#due_date_in_words" do
      let(:assignment) { instance_double('Assignment', due_date: @due_date) }

      it "converts upcoming due date" do
        @due_date = Time.new(2015, 11, 5, 17, 0, 0, "-06:00")
        expect(subject.due_date_in_words).to eq "Due in about 7 hours"
      end

      it "converts a past due date" do
        @due_date = Time.new(2015, 11, 5, 9, 0, 0, "-06:00")
        expect(subject.due_date_in_words).to eq "Due about 1 hour ago"
      end

      it "handles no due date" do
        @due_date = nil
        expect(subject.due_date_in_words).to be_blank
      end
    end

    describe "#start_in_words" do
      let(:assignment) { instance_double('Assignment', start_at: @start_at) }

      it "converts upcoming start" do
        @start_at = Time.new(2015, 11, 5, 17, 0, 0, "-06:00")
        expect(subject.start_in_words).to eq "Starts in about 7 hours"
      end

      it "converts past start" do
        @start_at = Time.new(2015, 11, 5, 9, 0, 0, "-06:00")
        expect(subject.start_in_words).to eq "Started about 1 hour ago"
      end
    end
  end
end
