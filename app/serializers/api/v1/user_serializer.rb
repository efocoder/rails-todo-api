# frozen_string_literal: true

module Api
  module V1
    class UserSerializer
      include JSONAPI::Serializer
      attributes :id, :email, :first_name, :last_name

      attribute :created_at do |user|
        user.created_at.strftime('%Y-%m-%d')
      end

    end
  end
end
