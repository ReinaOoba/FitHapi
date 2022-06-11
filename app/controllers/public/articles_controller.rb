class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :new, :create, :update, :destroy]

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

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @article = Article.new(article_params)
    tag_list = params[:article][:name].to_s.split('　')
    if @article.save
      @article.save_tag(tag_list)
      redirect_to article_path(@article.id), notice: '投稿完了しました'
    else
      @categories = Category.all
      render "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    tag_list = params[:article][:name].split('　')
     if @article.update(article_params)
       @old_relations=Taglist.where(article_id: @article.id)
        @old_relations.each do |relation|
        relation.delete
        end
       @article.save_tag(tag_list)
       redirect_to article_path(@article), notice: '更新完了しました'
     else
       @categories = Caregory.all
       render :edit
     end
  end

  def destroy
    article = Article.find(params[:id])
    article.delete
    redirect_to root_path
  end

  def  new_arrival
    @articles = Article.limit(100).order(created_at: :DESC).page(params[:page]).per(10)
  end

  def  hot
    # @articles = Article.all.per(10) 未実装やで！
  end

  private

  def article_params
    params.require(:article).permit(:article_image, :title, :text, :user_id, :category_id, :taglist_id, :status).merge(user_id: current_user.id)
  end


end