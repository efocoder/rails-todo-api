# frozen_string_literal: true

module Api
  module V1
    class User < ApplicationRecord
      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
      devise :database_authenticatable, :registerable, :validatable, :jwt_authenticatable, 
             jwt_revocation_strategy: Api::V1::JwtDenylist


      validates :first_name, presence: {message: 'First Name required'}
      validates :last_name, presence: {message: 'Last Name required'}

      has_many :todos, class_name: 'Api::V1::Todo'
    end
  end
end
