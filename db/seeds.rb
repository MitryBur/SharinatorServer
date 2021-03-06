# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
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
		social = SocialProfile.create name: name, surname: surname, vk_id: vk_id
		user.social = social
end

events_list = [
		['Party','Awesome party', 1],
		['Hawaii','Crap party', 2]
]

events_list.each do |title, description, owner_id|
		Event.create title: title, description: description, owner_id: owner_id
end
=end