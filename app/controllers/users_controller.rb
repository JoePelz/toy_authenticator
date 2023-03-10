class UsersController < ApplicationController
  def index
    render json: {status: "success"}, status: 200
  end
end