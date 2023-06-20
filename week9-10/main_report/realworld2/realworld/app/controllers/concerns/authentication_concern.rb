module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
    skip_before_action :verify_authenticity_token
  end

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      decoded = JsonWebToken.decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  def render_unauthorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

  def current_user
    @current_user
  end
end
