module Errors
  class Unauthorized < Errors::APIError
    TITLE = 'Unauthorized'
    STATUS = 401
  end
end
