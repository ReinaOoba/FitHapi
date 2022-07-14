class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all.page(params[:page]).per(10)
    @new_category = Category.new
    @path = admin_categories_path
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.page(params[:page])
  end

  def create
    @new_category = Category.new(category_params)
    if @new_category.save
      redirect_to admin_categories_path
    else
      @categories = Category.all.page(params[:page]).per(10)
      @path = admin_categories_path
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリー編集に成功しました"
       redirect_to admin_categories_path
    else
       render :edit
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.articles.exists?
      redirect_to admin_categories_path, notice: "紐づけされている記事があるため削除できません"
    else
      category.delete
      redirect_to admin_categories_path, notice: "カテゴリーを削除しました"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
