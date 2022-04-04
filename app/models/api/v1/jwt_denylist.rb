# frozen_string_literal: true

class Api::V1::JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = 'api_v1_jwt_denylist'
end
