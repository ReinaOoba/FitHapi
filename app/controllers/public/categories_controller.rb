class Public::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @articles =@category.articles.where(status: 0).page(params[:page])
  end

end
