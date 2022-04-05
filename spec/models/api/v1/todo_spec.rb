# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Todo, type: :model do
  before  { FactoryBot.build(:api_v1_todo) }

  context 'validations' do
    it do
      should validate_presence_of(:title).with_message('Title is required')
    end

    it do
      should validate_presence_of(:user).with_message('must exist')
    end
  end

  context 'association' do
    it { should belong_to(:user).class_name('Api::V1::User') }
  end
end
