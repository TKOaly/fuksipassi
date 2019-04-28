# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: ENV['USERNAME'], first_name: ENV['FIRSTNAME'], last_name: ENV['LASTNAME'], irc_nick: ENV['IRCNICK'], email: ENV['EMAIL'], password: ENV['PASS'], password_confirmation: ENV['PASS'], confirmed_at: Date.today, privacy_policy_consent: true)
User.first.add_role 'admin'
Language.create(name: 'English', en_name: 'English', code: 'en')
Language.create(name: 'Suomi', en_name: 'Finnish', code: 'fi')
