require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'by_week' do
    xit 'lumps assignments by the week they are due in' do
      records = [
        am_one   = Assignment.new(title: 'foo-1', due_date: DateTime.now.beginning_of_week + 1.day),
        am_two   = Assignment.new(title: 'foo-2', due_date: DateTime.now.beginning_of_week + 2.days),
        am_three = Assignment.new(title: 'foo-3', due_date: DateTime.now.beginning_of_week + 1.week),
        am_four  = Assignment.new(title: 'foo-4', due_date: DateTime.now.beginning_of_week + 2.week)
      ]
      result = {
        am_one.due_date.beginning_of_week.to_date   => [ am_one, am_two ],
        am_three.due_date.beginning_of_week.to_date => [ am_three ],
        am_four.due_date.beginning_of_week.to_date  => [ am_four ]
      }
      expect(Assignment.by_week(records)).to eq result
    end
  end

  describe 'search' do
    context "instructor" do
      let(:user) { build_stubbed(:instructor_user) }
    it 'retuns all assignments with title matching query' do
      foo  = create :assignment, title: "foobar"
      fizz = create :assignment, title: 'fizzbuzz'

      expect(Assignment.search(user, 'f')).to  eq([foo, fizz])
      expect(Assignment.search(user, 'fo')).to eq([foo])
      expect(Assignment.search(user, 'fi')).to eq([fizz])
    end
    end
  end

  context 'students with assignments' do
    before(:each) do
      c = create :campus, name: 'iron yard'
      @co1 = create :cohort, campus: c
      co2 = create :cohort, campus: c
      @foo = create :assignment, cohort: @co1, title: 'foo', due_date: DateTime.now + 2.days
      @bar = create :assignment, cohort: @co1, title: 'bar', due_date: DateTime.now + 2.weeks
      create :assignment, cohort: co2, title: 'fizz'
    end

    let(:student) { create :student, cohort: @co1 }

    describe 'for' do
      it 'returns all assignments for that student by cohort' do
        expect(Assignment.for(student)).to include(@foo, @bar)
      end

      it 'sorts all assignments by their due_date' do
        expect(Assignment.for(student)).to eq([@bar, @foo])
      end
    end

    describe 'current_for' do
      it 'returns the assignment that is the closest to being due without being late' do
        expect(Assignment.current_for(student)).to eq(@bar)
      end
    end
  end
end
