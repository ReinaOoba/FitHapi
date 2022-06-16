class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all.page(params[:page]).per(10)
    @new_tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.page(params[:page])
  end

  def create
    @new_tag = Tag.new(tag_params)
    if @new_tag.save
      redirect_to admin_tags_path
    else
      @tags = Tag.all
      render :index
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:notice] = "タグ編集に成功しました"
       redirect_to admin_tags_path
    else
       render :edit
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.delete
    flash[:notice] = "タグを削除しました"
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end

