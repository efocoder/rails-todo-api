FactoryBot.define do
  factory :api_v1_todo, class: 'Api::V1::Todo' do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    status { 'NEW' }
    user { FactoryBot.create(:api_v1_user) }
  end
end
