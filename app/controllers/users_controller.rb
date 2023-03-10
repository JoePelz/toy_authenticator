class UsersController < ApplicationController
  def authenticate
    response_data = {
        controller: request.controller_class.name,
        action: request.params['action']
    }
    render json: response_data, status: 200
  end
end
