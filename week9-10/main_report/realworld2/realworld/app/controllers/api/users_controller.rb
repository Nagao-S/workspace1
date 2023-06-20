module Api
class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    

    def create
      @user = User.new(user_params)
      if @user.save
        token = JWT.encode({ user_id: @user.id }, 'your_secret_key')
        render json: { user: { username: @user.username, email: @user.email, token: token, bio: @user.bio, image: @user.image } }
      else
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end
    end

    def login
      user = User.find_by(email: params[:user][:email].to_s.downcase)
  
      if user && user.authenticate(params[:user][:password])
        render json: user.to_json(only: [:username, :email, :bio, :image], methods: [:token])
      else
        render json: {errors: { 'email or password' => ['is invalid'] }}, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password, :bio, :image)
    end
  end
end
