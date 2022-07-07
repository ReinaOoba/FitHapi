class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_tag_info, only: [:index, :create]
  before_action :ensure_correct_tag, only: [:edit, :update]


  def index
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
      render :index
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:notice] = "タグ編集に成功しました"
       redirect_to admin_tags_path
    else
       render :edit
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    if tag.articles.exists?
      redirect_to admin_tags_path, notice: "紐づけされている記事があるため削除できません"
    else
      tag.delete
      redirect_to admin_tags_path, notice: "タグを削除しました"
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def ensure_tag_info
    @tags = Tag.all.page(params[:page]).per(10)
    @path = admin_tags_path
  end

  def ensure_correct_tag
    @tag = Tag.find(params[:id])
  end

end

