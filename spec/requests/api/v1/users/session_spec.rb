# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::User, type: :request do
  before do
    @user = FactoryBot.create(:api_v1_user)
  end

  let(:invalid_credentials) { { email: @user.email, password: 'password' } }
  let(:valid_credentials) { { email: @user.email, password: @user.password } }

  describe 'POST /users/sign_in' do
    context 'Login' do
      it 'does not login user' do
        post user_session_url, params: { user: invalid_credentials }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does  login user' do
        post user_session_url, params: { user: valid_credentials }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
