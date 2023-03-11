# frozen_string_literal: true

class UsersController < ApplicationController
  def authenticate
    user = User.find_by(username: authenticate_params[:username])
    unless user&.authenticate(authenticate_params[:password])
      raise Errors::Unauthorized.new(detail: "Credentials are not valid")
    end

    render status: 200, json: user, except: :password_digest
  end

  private

  def authenticate_params
    @authenticate_params ||= params.require(:user).permit(:username, :password)
  end

end
