module Errors
  class UnprocessableContent < Errors::APIError
    TITLE = 'Unprocessable Content'
    STATUS = 422
  end
end
