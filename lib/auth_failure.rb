# frozen_string_literal: true

class AuthFailure < Devise::FailureApp
  include Shared

  def respond
    http_auth
  end

  def http_auth
    self.status = 401
    headers['WWW-Authenticate'] = %(Bearer realm=#{Devise.http_authentication_realm.inspect}) if http_auth_header?
    self.content_type = 'json'
    self.response_body = http_auth_body
  end

  def http_auth_body
    create_response(401, i18n_message)
  end

  def request_format
    :json
  end
end
