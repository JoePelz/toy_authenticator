# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    def find
      binding.pry
      response_data = {
          controller: request.controller_class.name,
          action: request.params['action']
      }
      render json: response_data, status: 200
    end

    def create
      response_data = {
          controller: request.controller_class.name,
          action: request.params['action']
      }
      render json: response_data, status: 201
    end

    private

    def authenticate_params
      @authenticate_params ||= params.require(:user)
    end
  end
end
