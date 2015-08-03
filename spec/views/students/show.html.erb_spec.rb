require 'rails_helper'

RSpec.describe "students/show", type: :view do
  let(:student) { build_stubbed :student }
  before do
    render template: subject, locals: {
      student: student.decorate
    }
  end
  it "shows the student" do
    expect(rendered).to match(/Stats/)
  end
end
