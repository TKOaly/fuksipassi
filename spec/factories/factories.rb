FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    username "username"
    first_name "Jarno"
    last_name "Pekkarinen"
    irc_nick "halp"
    password "password123"
    password_confirmation "password123"
    confirmed_at Date.today
  end

  factory :participation do
    participation_type 2
    description "Test participation"
    points 5
  end

  factory :event do
    date Date.yesterday
    name 'fuksisitsit'

  end


end