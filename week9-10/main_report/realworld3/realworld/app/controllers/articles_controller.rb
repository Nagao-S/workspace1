class ArticlesController < ApplicationController
  respond_to :json
  before_action :set_article, only: [:show, :update, :destroy]

  # Articleオブジェクトの生成
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # JSONにレンダリング
  def show
    render json: @article
  end

  # 更新
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # 削除
  def destroy
    @article.destroy
  end

  # オブジェクトを@articleにセット
  def set_article
    @article = Article.find_by(slug: params[:slug])
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
