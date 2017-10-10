# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  recipe = Recipe.create(name: Faker::Lorem.word, description: Faker::Lorem.sentence, time: Random.rand(100))
  recipe.ingredients.create(name: Faker::Lorem.word, amount: Random.rand(10))

  # todo = Todo.create(title: Faker::Lorem.word, created_by: User.first.id)
  # todo.items.create(name: Faker::Lorem.word, done: false)
end
