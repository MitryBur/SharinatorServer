# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
socials_list = [
		['Petr', 'Ivanov', 31],
		['Valery', 'Gryaznova', 32],
		['Justin', 'Timberlake', 33],
		['Snoop', 'Dogg', 34],
		['Dirty', 'Monk', 35],
		['Andrew', 'Po', 36]
]

socials_list.each do |name, surname, vk_id|
		user = User.create
		social = Social.create name: name, surname: surname, vk_id: vk_id
		user.social = social
end