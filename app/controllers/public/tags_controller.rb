class Public::TagsController < ApplicationController
  def index
    @tags = Tag.all
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