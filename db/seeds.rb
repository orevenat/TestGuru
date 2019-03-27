require 'faker'

admin = Admin.find_or_create_by(first_name: 'Ruslan',
                                last_name: 'Knyazev',
                                email: 'agrry@yandex.ru')
admin.password = 'admin01'
admin.save

author_id = User.first.id

%w[Backend Frontend DevOps].each do |w|
  Category.create(title: w)

  (0..3).each do |num|
    category_id = Category.last.id
    Test.create(author_id: author_id, title: "#{w} lvl #{num}",
                level: num,
                category_id: category_id)

    test_id = Test.last.id
    (1..4).each do |q|
      Question.create(body: "#{w} question ##{q}", test_id: test_id)
      question_id = Question.last.id

      (1..4).each do |a|
        correct = a == 1
        Answer.create(body: "#{q} answer ##{a}", correct: correct,
                      question_id: question_id)
      end
    end
  end
end

Rule.create(rule_type: 'category', value: Category.first.title)
rule_one = Rule.last.id
Rule.create(rule_type: 'attempt', value: '1')
rule_two = Rule.last.id
Rule.create(rule_type: 'level', value: '0')
rule_three = Rule.last.id

Badge.create(name: 'Backend Finish',
             picture: 'https://image.flaticon.com/icons/png/128/1579/1579490.png',
             rule_id: rule_one)

Badge.create(name: 'Attempt Finish',
             picture: 'https://image.flaticon.com/icons/png/128/1579/1579491.png',
             rule_id: rule_two)

Badge.create(name: 'Level finish',
             picture: 'https://image.flaticon.com/icons/png/128/1579/1579492.png',
             rule_id: rule_three)
