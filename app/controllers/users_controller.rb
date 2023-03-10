class UsersController < ApplicationController
  def index
    client = ::RedisInstance.instance
    old_value = client.get("test")
    new_value = Time.current.as_json
    client.set('test', new_value, ex: 10)
    response_data = {
        status: 'success',
        old_value: old_value,
        new_value: new_value
    }
    render json: response_data, status: 200
  end
end
