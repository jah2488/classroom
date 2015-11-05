require 'spec_helper'

describe AssignmentDecorator do
  subject { AssignmentDecorator.decorate(assignment) }
  let(:assignment) { instance_double('Assignment', due_date: @due_date) }
  let(:now) { Time.new(2015, 11, 5, 10, 1, 0, "-06:00") }

  it "converts upcoming due date" do
    @due_date = Time.new(2015, 11, 5, 17, 0, 0, "-06:00")
    Timecop.freeze(now) do
      expect(subject.due_date_in_words).to eq "Due in about 7 hours"
    end
  end

  it "converts a past due date" do
    @due_date = Time.new(2015, 11, 5, 9, 0, 0, "-06:00")
    Timecop.freeze(now) do
      expect(subject.due_date_in_words).to eq "Due about 1 hour ago"
    end
  end
end
