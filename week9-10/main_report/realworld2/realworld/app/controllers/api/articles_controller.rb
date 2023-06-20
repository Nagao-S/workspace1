require_relative '../../../lib/json_web_token'
module Api
  class ArticlesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_article, only: [:show, :update, :destroy]
    before_action :authenticate_request, only: [:create, :update, :destroy]

    def create
      @article = @current_user.articles.new(article_params)

      if @article.save
        render_article(@current_user)
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    def show
      render json: { article: article_json(@article) }
    end

    def update
      if @article.update(article_params)
        render json: { article: article_json(@article) }
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      head :no_content
    end

    private

    def set_article
      @article = Article.find_by(slug: params[:slug])
      render_not_found if @article.nil?
    end

    def authenticate_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header

      begin
        decoded_token = JsonWebToken.decode(token)
        @current_user = User.find(decoded_token[:user_id])
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :unauthorized
      end
    end

    def article_params
      params.require(:article).permit(:title, :description, :body)
    end

    def article_json(article)
      {
        slug: article.slug,
        title: article.title,
        description: article.description,
        body: article.body,
        createdAt: article.created_at,
        updatedAt: article.updated_at,
        favorited: false,
        favoritesCount: 0,
        author: {
          username: article.user.username,
          bio: article.user.bio,
          image: article.user.image,
          following: false
        }
      }
    end

    def render_not_found
      render json: { error: 'Article not found' }, status: :not_found
    end
  end
end
