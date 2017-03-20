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
end