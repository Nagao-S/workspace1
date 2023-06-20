module Api
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      @user = User.new(user_params)

      if @user.save
        token = JsonWebToken.encode(user_id: @user.id)
        render json: { user: user_response(@user, token) }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def user_response(user, token)
      {
        email: user.email,
        token: token,
        username: user.username,
        bio: user.bio,
        image: user.image
      }
    end
  end
end