# frozen_string_literal: true

module InternalAuthenticatable
  extend ActiveSupport::Concern

  API_KEY_HEADER = 'X-API-KEY'

  def require_internal_api_key!
    api_key_header = request.headers[API_KEY_HEADER]
    raise Errors::Unauthorized.new(detail: "API key header is missing") unless api_key_header.present?

    api_key = InternalAPIKey.find_by(value: api_key_header)
    unless api_key&.active?
      raise Errors::Unauthorized.new(detail: "API key is invalid")
    end
  end
end
