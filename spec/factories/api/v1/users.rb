FactoryBot.define do
  factory :api_v1_user, class: 'Api::V1::User' do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'pas123' }
  end
end
