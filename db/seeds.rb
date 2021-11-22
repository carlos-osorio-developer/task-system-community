# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['yo', 'andrea', 'leon', 'andres', 'natalia', 'camilo', 'rusbel', 'johan'].each do |name|
  user = User.new(email: "#{name}@a.a", password: 'sumadre')
  user.save
end

puts 'Users created'

['Personal', 'Work', 'Gardening', 'Learning', 'Projects'].each do |categ|
  category = Category.new(name: name, description: "These are tasks about #{categ.lowercase} stuff")
  category.save
end

puts 'Categories has been created'
