# frozen_string_literal: true
class ApplicationController < ActionController::API
  # include ActionController::MimeResponds
  respond_to :json
  wrap_parameters format: [:json]

  include Shared

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  before_action :authenticate_user!

  private

  def not_found
    render json: create_response(404, 'Record not found', [], 404), status: :not_found
  end

  def bad_request
    render json: create_response(400, 'Bad Request. POST, PUT and PATCH requests need body',
                                 [], 400), status: :bad_request
  end
end
