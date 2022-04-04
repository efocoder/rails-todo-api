# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        wrap_parameters :user, format: [:json]
        include Shared

        # before_action :configure_sign_up_params
        before_action :configure_sign_up_params, only: [:create]
        # before_action :configure_account_update_params, only: [:update]

        # GET /resource/sign_up
        # def new
        #   super
        # end

        # POST /resource
        # def create
        #   super
        # end

        # GET /resource/edit
        # def edit
        #   super
        # end

        # PUT /resource
        # def update
        #   super
        # end

        # DELETE /resource
        # def destroy
        #   super
        # end

        # GET /resource/cancel
        # Forces the session data which is usually expired after sign
        # in to be expired now. This is useful if the user wants to
        # cancel oauth signing in/up in the middle of the process,
        # removing all OAuth session data.
        # def cancel
        #   super
        # end

        protected

        def respond_with(resource, _opts = {})
          resource.persisted? ? register_success : register_failed(resource)
        end

        def register_success
          render json: create_response(200, 'Signed up successfully', serialize_data(Api::V1::UserSerializer, resource)),
                 status: :ok
        end

        def register_failed(resource)
          logger.info "Register #{resource.errors.full_messages}"
          render json: resource.errors, status: :unprocessable_entity
        end

        # If you have extra params to permit, append them to the sanitizer.
        def configure_sign_up_params
          devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password first_name last_name])
        end

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_account_update_params
        #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
        # end

        # The path used after sign up.
        # def after_sign_up_path_for(resource)
        #   super(resource)
        # end

        # The path used after sign up for inactive accounts.
        # def after_inactive_sign_up_path_for(resource)
        #   super(resource)
        # end
      end
    end
  end
end
