# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pizzas = [
	{ name: 'Hawaiian Chicken', price: 25.00 },
	{ name: 'Indian Tandoori', price: 28.50 },
	{ name: 'Vege Delight', price: 20.00 },
	{ name: 'Seafood Surprise', price: 25.50 }
]

pizzas.each do |pizza|
	Menu.create(name: pizza[:name], price: pizza[:price])
end