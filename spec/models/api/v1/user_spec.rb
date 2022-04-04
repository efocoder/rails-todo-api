# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::User, type: :model do
  before { FactoryBot.build(:api_v1_user) }

  context 'validation' do
    it do
      should validate_presence_of(:email).with_message("can't be blank")
    end

    it do
      should validate_uniqueness_of(:email).with_message('has already been taken').case_insensitive
    end

    it do
      should validate_presence_of(:password).with_message("can't be blank")
    end

    it do
      should validate_length_of(:password).is_at_least(6).with_message('is too short (minimum is 6 characters)')
    end

    it do
      should validate_presence_of(:first_name).with_message('First Name required')
    end

    it do
      should validate_presence_of(:last_name).with_message('Last Name required')
    end

  end
end
