module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ error: e.message }, :not_found)
    end
  end

  private

  def unauthorized_request(e)
    json_response({ error: e.message }, :unauthorized)
  end

  def unprocessable_entity(e)
    json_response({ error: e.message }, :unprocessable_entity)
  end

  def json_response(message, status)
    render json: message, status: status
  end
 class MissingToken < StandardError
 end

  
end
