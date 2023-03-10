class TokensController < ApplicationController
  def authenticate
    response_data = {
        access_token: "secret access token",
        access_token_expires_at: 30.minutes.from_now
    }
    render json: response_data, status: 200
  end
end
