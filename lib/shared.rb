# frozen_string_literal: true

module Shared
  TODO_STATUS = { new: 'NEW', in_progress: 'IN_PROGRESS', completed: 'COMPLETED', deleted: 'DELETED' }.freeze

  def create_response(status_code, message, data = [], src = nil)
    resp = {}
    resp['status_code'] = status_code
    resp['message'] = message
    # resp['data'] = data

    (resp['data'] = data) unless src

    resp.to_json
  end

  def serialize_data(serializer, data)
    # logger.info "DATA #{data.inspect}"
    resp = []
    if data.is_a?(ActiveRecord::Relation)
      serializer.new(data).serializable_hash[:data].each { |d| resp << d[:attributes] }
    else
      resp << serializer.new(data).serializable_hash[:data][:attributes]
    end

    resp
  end
end
