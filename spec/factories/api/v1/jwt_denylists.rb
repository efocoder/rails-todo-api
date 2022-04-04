FactoryBot.define do
  factory :api_v1_jwt_denylist, class: 'Api::V1::JwtDenylist' do
    jti { "MyString" }
    exp { "2022-04-03 15:48:08" }
  end
end
