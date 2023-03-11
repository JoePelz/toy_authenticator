# frozen_string_literal: true

module Errors
  class UnprocessableContent < Errors::APIError
    TITLE = 'Unprocessable Content'
    STATUS = 422
  end
end
