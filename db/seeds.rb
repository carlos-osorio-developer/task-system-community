# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['yo', 'andrea', 'leon', 'andres', 'natalia', 'camilo', 'rusbel', 'johan'].each do |name|
  user = User.new(email: "#{name}@a.a", password: '123456')
  user.save
end

puts 'Users created'

['Personal', 'Work', 'Gardening', 'Learning', 'Projects'].each do |categ|
  category = Category.new(name: categ, description: "These are tasks about #{categ.downcase} stuff")
  category.save
end

puts 'Categories has been created'

owner = User.find_by(email: 'yo@a.a')

base = [
  [
    'Projects',
    'Start developing of UX/UI project',
    ['johan:1', 'leon:2', 'andrea:random']
  ],

  [
    'Personal',
    'Start working out ',
    ['johan:1', 'leon:2', 'andrea:random']
  ],

  [
    'Learning',
    'Keep learning RoR',
    ['johan:1', 'leon:2', 'andrea:random']
  ],

  [
    'Gardening',
    'Take care of chiles',
    ['johan:1', 'leon:2', 'andrea:random']
  ],
]

base.each do |category, description, participant_set|
  participants = participant_set.map do |participant|
    user_name, raw_role = participant.split(':')
    role = raw_role == 'random' ? [1, 2].sample : raw_role
    
    Participant.new(
      user: User.find_by(email: "#{user_name}@a.a"),
      role: role.to_i
    )
  end

  Task.create!(
    category: Category.find_by(name: category),
    name: "Task ##{Task.count + 1}",
    description: description,
    due_date: Date.today + 15.days,
    owner: owner,
    participants: participants
  )
end

puts 'Tasks has been created'

