# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create!({
  email: 'instructor@example.com',
  password: 'password',
  name: "Will"
})
user.confirm
user.save!

instructor = Instructor.create!({
  phone: '555 555 5555',
  office_hours_start: "March 22, 2015 12:00PM",
  office_hours_end: "March 22, 2015 5:00PM",
  title: "Instructor",
  user: user
})

assist = Instructor.create!({
  phone: '555 555 5555',
  office_hours_start: "March 22, 2015 12:00PM",
  office_hours_end: "March 22, 2015 5:00PM",
  title: "Assistant Instructor",
  user: assist_user = User.create!({
    email: 'new-instructor@example.com',
    password: 'password',
    name: "Jess"
  })
})
assist_user.confirm
assist_user.save!

user2 = User.create!({
  email: 'student@example.com',
  password: 'password'
})
user2.confirm

josh = Operator.create!({
  title: "Lead Campus Director",
  user: cd_user = User.create!({
    email: "cd@example.com",
    password: 'password',
    name: "Josh"
  })
})
cd_user.confirm
cd_user.save!

bethany = Operator.create!({
  title: "Campus Operations Manager"
})

campus = Campus.create!({
  name: "Nashville, TN",
  latitude: 36.1316327,
  longitude: -86.7495919,
  operators: [josh, bethany]
})

cohort = Cohort.create!({
  name: 'Frontend Fall 2015',
  campus_id: campus.id,
  start_time: DateTime.now - 1.month,
  instructors: [instructor, assist]
})


FactoryGirl.create(:cohort, name: "Mobile")
FactoryGirl.create(:cohort, name: "Backend Fall 2015")

assignments = []
students = [user2.create_student!(cohort: cohort)]

10.times.each_slice(4).with_index do |nums, index|
  nums.each_with_index do |n, i|
    assignments << Assignment.create({
      cohort_id: cohort.id,
      title: "Week #{i}, Day #{n}",
      info: Faker::Lorem.paragraph,
      due_date: cohort.start_time + (i + 2) + n
    })
  end
end

15.times do |n|
  user = FactoryGirl.create(:full_user)
  students << FactoryGirl.create(:full_student, cohort_id: cohort.id, user: user)
end

15.times do |n|
  Submission.create!({
    link: 'http://github.com/',
    notes: 'This was hard',
    late: [true, false].sample,
    student_id: students.sample.id,
    assignment_id: assignments.sample.id
  })
end

10.times.each.with_index do |i|
  day = Day.create!({
    cohort: cohort,
    start: cohort.start_time + i.days
  })
  students.each do |s|
    if [true, true, false].sample
      checkin = Checkin.create!({
        student_id: s.id,
        day: day,
        created_at: day.start + (0..30).to_a.sample.minutes
      })
      if checkin.late? && [true, false].sample
        Adjustment.create!({
          checkin: checkin
        })
      end
    end
  end
end
