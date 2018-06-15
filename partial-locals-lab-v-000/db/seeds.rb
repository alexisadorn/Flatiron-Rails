# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
80.times do
  Student.create(name: Faker::Name.name, hometown: Faker::Address.city, birthday: Faker::Date.between(25.years.ago, 18.years.ago))
end
Classroom.create(course_name: 'Math', semester: "Spring #{Time.now.year}")
Classroom.create(course_name: 'English', semester: "Fall #{Time.now.year}")
Classroom.create(course_name: 'Science', semester: "Spring #{Time.now.year}")
Classroom.create(course_name: 'Chemistry', semester: "Fall #{Time.now.year}")


Classroom.all.each_with_index do |classroom, i|
  classroom.students << [Student.limit(8).offset(i*2)]
end
