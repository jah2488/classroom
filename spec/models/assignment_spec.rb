require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'by_week' do
    it 'lumps assignments by the week they are due in' do
      records = [
        am_one   = Assignment.new(title: 'foo', due_date: DateTime.now.beginning_of_week + 1.day),
        am_two   = Assignment.new(title: 'foo', due_date: DateTime.now.beginning_of_week + 2.days),
        am_three = Assignment.new(title: 'foo', due_date: DateTime.now.beginning_of_week + 1.week),
        am_four  = Assignment.new(title: 'foo', due_date: DateTime.now.beginning_of_week + 2.week)
      ]
      result = {
        am_one.due_date.beginning_of_week.to_date   => [ am_one, am_two ],
        am_three.due_date.beginning_of_week.to_date => [ am_three ],
        am_four.due_date.beginning_of_week.to_date  => [ am_four ]
      }
      expect(Assignment.by_week(records)).to include(result)
    end
  end

  describe 'search' do
    it 'retuns all assignments with title matching query' do
      foo  = Assignment.create!(title: 'foobar')
      fizz = Assignment.create!(title: 'fizzbuzz')

      expect(Assignment.search('f')).to  eq([foo, fizz])
      expect(Assignment.search('fo')).to eq([foo])
      expect(Assignment.search('fi')).to eq([fizz])
    end
  end

  context 'students with assignments' do
    before(:each) do
      c = Campus.create!(name: 'iron yard')
      co1 = Cohort.create!(campus_id: c.id, first_day: DateTime.now)
      co2 = Cohort.create!(campus_id: c.id, first_day: DateTime.now)
      @foo = Assignment.create!(cohort_id: co1.id, title: 'foo', due_date: DateTime.now + 2.days)
      @bar = Assignment.create!(cohort_id: co1.id, title: 'bar', due_date: DateTime.now + 2.weeks)
      Assignment.create!(cohort_id: co2.id, title: 'fizz')
    end

    let!(:student) {
      Student.create!(email: 'f@g.com', password: 123445890, cohort_id: Cohort.first.id)
    }

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
