# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: 'julkku', first_name: 'Julius', last_name: 'Uusinarkaus', irc_nick: 'julkku', email: 'julius@uusinarkaus.com', password: ENV['PASS'], password_confirmation: ENV['PASS'], confirmed_at: Date.today)
User.create(username: 'Harrowed', first_name: 'Eetu', last_name: 'Mattila', irc_nick: 'Harrowed', email: 'eetu.mattila@cs.helsinki.fi', password: ENV['PASS'], password_confirmation: ENV['PASS'], confirmed_at: Date.today)
User.first.add_role 'admin'
User.second.add_role 'admin'
Language.create(name: 'English', en_name: 'English', code: 'en')
Language.create(name: 'Suomi', en_name: 'Finnish', code: 'fi')
