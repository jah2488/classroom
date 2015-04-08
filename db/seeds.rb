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

cohort = Cohort.create!({
  name: 'ruby on rails',
  location: 'Building A Room 2001',
  instructor_id: instructor.id
})

assignments = []
students    = []

5.times do |n|
  assignments << Assignment.create({
    cohort_id: cohort.id,
    title: 'work on making',
    info: 'do the thing blah blah blah',
    due_date: Date.today + Array(1..5).sample
  })
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

