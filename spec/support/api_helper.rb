# frozen_string_literal: true

module ApiHelpers
  def json_body
    JSON.parse(response.body)
  end

  def auth_header(account)
    Devise::JWT::TestHelpers.auth_headers(valid_headers, user)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, type: :request
end
