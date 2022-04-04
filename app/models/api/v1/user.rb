# frozen_string_literal: true

module Api
  module V1
    class User < ApplicationRecord
      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
      devise :database_authenticatable, :registerable, :validatable, :jwt_authenticatable, 
             jwt_revocation_strategy: Api::V1::JwtDenylist
    end
  end
end
