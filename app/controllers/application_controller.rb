class ApplicationController < ActionController::API
  rescue_from(Errors::APIError) do |exception|
    response_data = {
      "errors": [
        {
          "status": exception.status,
          "title":  exception.title,
          "detail": exception.detail,
        }.compact
      ]
    }

    render(
        json: response_data,
        status: exception.status
    )
  end
end
