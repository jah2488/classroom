# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

instructor = Instructor.create!({
  name: 'test instructor',
  phone: '555 555 5555',
  office_hours_start: "March 22, 2015 12:00PM",
  office_hours_end: "March 22, 2015 5:00PM",
  email: 'instructor@example.com',
  password: 'password'
})

campus = Campus.create!({
  name: "Nashville, TN",
  latitude: 36.1316327,
  longitude: -86.7495919
})

cohort = Cohort.create!({
  name: 'ruby on rails',
  instructor_id: instructor.id,
  campus_id: campus.id
})

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
  students << Student.create({
    name: "student-#{n}",
    github: "ghstudent-#{n}",
    phone: "555-555-555#{n}",
    blog: "http://blogger.com/",
    bio: "blah blah blah",
    cohort_id: cohort.id,
    email: "student-#{n}@example.com",
    password: "password"
  })
end

15.times do |n|
  Submission.create({
    link: 'http://github.com/',
    notes: 'This was hard',
    student_id: students.sample.id,
    assignment_id: assignments.sample.id
  })
end

