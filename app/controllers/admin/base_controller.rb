# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    include InternalAuthenticatable

    before_action :require_internal_api_key!
  end
end
