# frozen_string_literal: true

module Api
  module V1
    class TodoSerializer
      include JSONAPI::Serializer
      attributes :id, :title, :description, :status

      attribute :created_at do |user|
        user.created_at.strftime('%Y-%m-%d')
      end
    end
  end
end
