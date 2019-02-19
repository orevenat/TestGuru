# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

10.times do
  name = Faker::Name
  User.create(first_name: name.first_name, last_name: name.last_name,
              password: Faker::Internet.password, email: Faker::Internet.email)

  Category.create(title: Faker::ProgrammingLanguage.name)
end


author_id = User.first.id

20.times do
  Test.create(author_id: author_id, title: Faker::Lorem.sentence,
              level: (0..5).to_a.sample,
              category_id: Category.pluck(:id).sample)
end

50.times do
  Question.create(body: Faker::Lorem.question, test_id: Test.pluck(:id).sample)
end

200.times do
  question_id = Question.pluck(:id).sample
  correct = Answer.find_by(question_id: question_id).nil? ? true : false
  Answer.create(body: Faker::Lorem.sentence, correct: correct,
                question_id: question_id)
end

User.pluck(:id).each do |user_id|
  r = rand(2..5)
  tests = Test.pluck(:id)
  r.times do
    TestsUser.create(user_id: user_id, test_id: tests.sample)
  end
end
