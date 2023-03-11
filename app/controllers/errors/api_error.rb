# frozen_string_literal: true

module Errors
  class APIError < StandardError
    TITLE = 'Something went wrong'
    STATUS = 500
    DETAIL = nil

    def initialize(title: nil, status: nil, detail: nil)
      super
      @title = title
      @status = status
      @detail = detail
    end

    def status
      @status || self.class::STATUS
    end

    def title
      @title || self.class::TITLE
    end

    def detail
      @detail || self.class::DETAIL
    end
  end
end
