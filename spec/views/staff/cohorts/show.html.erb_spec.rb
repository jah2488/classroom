require 'rails_helper'

RSpec.describe "staff/cohorts/show", type: :view do
  let(:cohort) { create :cohort_w_stuff }
  before do
    # these locals are smelly
    render template: subject, locals: {
      cohort: cohort.decorate,
      assignments: cohort.assignments,
      adjustments: cohort.students.flat_map(&:adjustments)
    }
  end

  it "shows the assignments" do
    cohort.assignments.each do |a|
      expect(rendered).to match assignment_path(a)
    end
  end

  it "shows the submissions" do
    expect(rendered).to match submission_path(cohort.assignments.first.submissions.first)
  end
end
