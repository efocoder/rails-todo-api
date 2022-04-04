# frozen_string_literal: true
class ApplicationController < ActionController::API
  # include ActionController::MimeResponds
  respond_to :json
  wrap_parameters format: [:json]

  include Shared

  before_action :authenticate_user!
end
