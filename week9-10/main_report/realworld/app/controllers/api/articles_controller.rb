module Api
  class ArticlesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!, except: [:index, :show]

    def create
      article = current_user.articles.build(article_params)

      if article.save
        render json: article, status: :created
      else
        render json: article.errors, status: :unprocessable_entity
      end
    end

    private

    def article_params
      params.require(:article).permit(:title, :description, :body)
    end
  end
end
