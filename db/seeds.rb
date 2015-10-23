# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do |i|
  User.create!(email: "user#{i}@email.com", password: "password#{i}")
end

5.times do |i|
  Sub.create!(title: "Sub #{i+1}", description: "best sub ever about #{i + 1}",
              user_id: i + 1)
end

Sub.all.each do |sub|
  3.times do |i|
    Post.create!(title: "Post #{i+1} in #{sub.title}", content: "Hello!",
                  url: "google.com/", user_id: 20-i, sub_ids: [sub.id, i + 1])
  end
end
