FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'password' }
    bio { 'I am a test user.' }
    image { nil }
  end
end
