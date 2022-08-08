class Public::TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tag = Tag.all
    @categories = Category.includes(:articles).where(articles: {status: 0}).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
    @tags = Tag.includes(:articles).where(articles: {status: 0}).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.where(status: 0).page(params[:page])
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end