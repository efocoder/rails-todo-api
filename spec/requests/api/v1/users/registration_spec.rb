# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::User, type: :request do
  let(:valid_attributes) { attributes_for(:api_v1_user) }
  let(:invalid_attributes) { attributes_for(:api_v1_user, email: nil) }


  describe 'POST /users' do
    context 'Registration' do
      it 'does not create user' do
        post user_registration_url, params: { user: invalid_attributes }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect { response }.to change(Api::V1::User, :count).by(0)
      end

      it 'does create user' do
        post user_registration_url, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect { response }.to change(Api::V1::User, :count).by_at_most(1)
      end
    end
  end
end
