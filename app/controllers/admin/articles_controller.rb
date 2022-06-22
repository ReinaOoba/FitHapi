class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @articles = Article.all.page(params[:page]).per(10)
  end

  def show
    @article = Article.find(params[:id])

  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
  end

  def destroy
    article = Article.find(params[:id])
    article.delete
    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(:article_image, :title, :text, :user_id, :category_id, :taglist_id, :status).merge(user_id: current_user.id)
  end

end
