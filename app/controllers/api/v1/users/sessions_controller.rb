# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        wrap_parameters :user, format: [:json]
        # before_action :configure_sign_in_params, only: [:create]
        respond_to :json
        include Shared

        # GET /resource/sign_in
        # def new
        #   super
        # end

        # POST /resource/sign_in
        # def create
        #   super
        # end

        # DELETE /resource/sign_out
        # def destroy
        #   super
        # end

        protected

        def respond_with(resource, _opts = {})
          if user_signed_in?
            data = serialize_data(Api::V1::UserSerializer, resource)
            data.first['token'] = request.env['warden-jwt_auth.token']
            render json: create_response(200, 'Signed in successfully', data), status: :ok
          end
        end

        def respond_to_on_destroy
          current_user ? log_out_success : log_out_failure
        end

        def log_out_success
          render json: { message: 'You are Logged out.' }, status: :ok
        end

        def log_out_failure
          render json: { message: 'Logged out failure.' }, status: :unauthorized
        end

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_sign_in_params
        #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
        # end
      end
    end
  end
end
