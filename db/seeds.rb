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
  name: "Great Instructor"
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

Instructor.create!({
  phone: '555 555 5555',
  office_hours_start: "March 22, 2015 12:00PM",
  office_hours_end: "March 22, 2015 5:00PM",
  title: "Assistant Instructor",
  user: new_instructor = User.create!({
    email: 'new-instructor@example.com',
    password: 'password',
    name: "Okay Instructor"
  })
})
new_instructor.confirm
new_instructor.save!

user2 = User.create!({
  email: 'student@example.com',
  password: 'password'
})
user2.confirm

campus = Campus.create!({
  name: "Nashville, TN",
  latitude: 36.1316327,
  longitude: -86.7495919
})

cohort = Cohort.create!({
  name: 'Ruby on Rails',
  campus_id: campus.id,
  start_time: DateTime.now,
  instructors: [instructor]
})

user2.create_student!(cohort: cohort)

FactoryGirl.create(:cohort, name: "Mobile")
FactoryGirl.create(:cohort, name: "Front End JS")

assignments = []
students    = []

10.times.each_slice(4).with_index do |nums, index|
  nums.each_with_index do |n, i|
    assignments << Assignment.create({
      cohort_id: cohort.id,
      title: "Week #{i}, Day #{n}",
      info: 'do the thing blah blah blah',
      due_date: Date.today + (i + 2) + n
    })
  end
end

15.times do |n|
  user = FactoryGirl.create(:full_user)
  students << FactoryGirl.create(:full_student, cohort_id: cohort.id, user: user)
end

15.times do |n|
  Submission.create({
    link: 'http://github.com/',
    notes: 'This was hard',
    late: [true, false].sample,
    student_id: students.sample.id,
    assignment_id: assignments.sample.id
  })
end
