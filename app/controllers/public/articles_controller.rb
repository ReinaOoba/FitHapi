class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.where(status: 0).page(params[:page])
  end

  def show
    @article = Article.find(params[:id])
    @article_tags = @article.tags
    @comments = @article.comments
    @comment = Comment.new
    if @article.status == "privated" && @article.user != current_user
      redirect_to root_path, notice: '非公開設定の記事は投稿者本人しか閲覧できません'
    end
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

      if params[:article][:article_image_ids]
        params[:article][:article_image_ids].each do |image_id|
          article_image = @article.article_images.find(image_id)
          article_image.purge # deleteと同じ意味だが画像はpurge
        end
      end
       redirect_to article_path(@article), notice: '更新完了しました'
     else
       @categories = Caregory.all
       render :edit
     end
  end

  def destroy
    article = Article.find(params[:id])
      if article.id == 1
        redirect_to root_path, notice: 'この記事は削除できません'
        return
      end
    article.delete
    redirect_to root_path
  end

  def new_arrival
    @articles = Article.limit(100).where(status: 0).order(created_at: :DESC).page(params[:page]).per(10)
    @categories = Category.includes(:articles).where(articles: {status: 0}).limit(4)
    @tags = Tag.includes(:articles).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
  end

  def hot
    @articles = Article.left_joins(:favorites).where(status: 0).group(:id).order('count(favorites.article_id) desc').page(params[:page]).per(10)
    @categories = Category.includes(:articles).where(articles: {status: 0}).limit(4)
    @tags = Tag.includes(:articles).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :category_id, :taglist_id, :status, :article_video, article_images: [] ).merge(user_id: current_user.id)
  end
end