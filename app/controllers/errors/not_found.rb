module Errors
  class NotFound < Errors::APIError
    TITLE = 'Record Not Found'
    STATUS = 404
  end
end
