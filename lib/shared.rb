# frozen_string_literal: true

module Shared
  def create_response(status_code, message, data = [])
    resp = {}
    resp['status_code'] = status_code
    resp['message'] = message

    (resp['data'] = data) unless data.empty?

    resp.to_json
  end

  def serialize_data(serializer, data)
    logger.info "DATA #{data.inspect}"
    resp = []
    if data.is_a?(Array)
      serializer.new(collection).serializable_hash[:data].each { |d| resp << d[:attributes] }
    else
      resp << serializer.new(data).serializable_hash[:data][:attributes]
    end

    resp
  end
end
