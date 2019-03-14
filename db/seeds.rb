# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

admin = Admin.new(first_name: 'Ruslan', last_name: 'Knyazev', email: 'agrry@yandex.ru')
admin.password = 'admin01'
admin.save

10.times do
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

  question_id = Question.last.id
  4.times do
    correct = Answer.find_by(question_id: question_id).nil? ? true : false
    Answer.create(body: Faker::Lorem.sentence, correct: correct,
                  question_id: question_id)
  end
end

