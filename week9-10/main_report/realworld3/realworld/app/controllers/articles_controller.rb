class ArticlesController < ApplicationController
  respond_to :json
  before_action :set_article, only: [:show, :update, :destroy]

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @article
  end

  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
  end

  private

  def set_article
    @article = Article.find_by(slug: params[:slug])
  end

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
