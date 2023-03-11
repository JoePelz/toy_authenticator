# frozen_string_literal: true

module Admin
  class UsersController < ::Admin::BaseController
    CREATE_PARAMS = %i[
      username
      password
      password_confirmation
    ].freeze
    FIND_PARAMS = %i[
      username
    ].freeze

    def find
      username = find_params[:username]
      user = User.find_by(username: username)

      raise Errors::NotFound.new(detail: "No user matches username #{username.inspect}") unless user

      render status: :ok, json: user, except: :password_digest
    end

    def create
      user = User.new(create_params)

      raise Errors::UnprocessableContent.new(detail: user.errors.full_messages.join('. ')) unless user.save

      render status: :created, json: user, except: :password_digest
    end

    private

    def find_params
      @find_params ||= params.permit(*FIND_PARAMS)
    end

    def create_params
      @create_params ||= params.require(:user).permit(*CREATE_PARAMS)
    end
  end
end
