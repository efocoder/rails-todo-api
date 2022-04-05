# frozen_string_literal: true

module Api
  module V1
    class Todo < ApplicationRecord
      validates :title, presence: { message: 'Title is required' }

      belongs_to :user, class_name: 'Api::V1::User'
    end
  end
end
