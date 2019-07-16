# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError, with: :handle_general_exception

  def handle_general_exception(exc)
    render json: { success: false, error: exc.message }
  end

  def success_response(body)
    { success: true }.merge(body)
  end
end
