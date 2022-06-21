class Public::CategoriesController < ApplicationController
  def index
    @category = Category.all
    @categories = Category.includes(:articles).where(articles: {status: 0}).limit(4)
    @tags = Tag.includes(:articles).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
  end

  def show
    @category = Category.find(params[:id])
    @articles =@category.articles.where(status: 0).page(params[:page])
  end

end
