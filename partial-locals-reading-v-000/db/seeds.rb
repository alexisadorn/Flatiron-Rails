# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bob = Author.create(name: 'Bob', hometown: 'Philly')
billy = Author.create(name: 'Billy', hometown: 'Detroit')
fred = Author.create(name: 'Fred', hometown: 'Baltimore')

authors = [bob, billy, fred]

authors.each do |author|
  5.times do
    Post.create(title: Faker::Book.title, content: Faker::Hipster.paragraph, author: author)
  end
end
