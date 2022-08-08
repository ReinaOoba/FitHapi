class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @category = Category.all
    @categories = Category.includes(:articles).where(articles: {status: 0}).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
    @tags = Tag.includes(:articles).where(articles: {status: 0}).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
  end

  def show
    @category = Category.find(params[:id])
    @articles =@category.articles.where(status: 0).page(params[:page])
  end

end
