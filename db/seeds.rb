# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pizzas = [
	{ name: 'Hawaiian Pizza', price: 25.00 },
	{ name: 'Tandoori Pizza', price: 28.50 },
	{ name: 'Vegetarian Pizza', price: 20.00 },
	{ name: 'Seafood Pizza', price: 25.50 },
	{ name: 'Chicken Pepperoni Pizza', price: 15.50 },
	{ name: 'Beef Pepperoni Pizza', price: 23.30 },
	{ name: 'Salmon Pizza', price: 18.50 },
	{ name: 'Vegan Pizza', price: 17.00 },
	{ name: 'Supreme Chicken Pizza', price: 33.50 },
	{ name: 'Lamb Galore Pizza', price: 22.70 },
	{ name: 'Tuna Tango Pizza', price: 19.00 },
	{ name: 'Spicy Vegetarian Pizza', price: 20.00 },
	{ name: 'Kids Pizza', price: 14.50 }
]

Menu.destroy_all

pizzas.each do |pizza|
	Menu.create(name: pizza[:name], price: pizza[:price])
end