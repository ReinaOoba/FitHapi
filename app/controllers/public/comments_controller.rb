class Public::CommentsController < ApplicationController
  def create
    @article = Article.find_by(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = @article.id
    if @comment.save
       render "comments", notice: 'コメントしました'
      # redirect_to article_path(@article), notice: 'コメントしました'
    else
      redirect_to article_path(@article), notice: 'コメント欄に何も入ってません'
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    @article = @comment.article
  end

  def update
    @comment = Comment.find(params[:id])
    article = @comment.article
    if @comment.update(comment_params)
      redirect_to article_path(article), notice: 'コメントをしました'
    else
      render :edit
    end
  end

  def destroy
    Comment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    @article = Article.find_by(params[:article_id])
    render "comments"
    # redirect_to article_path(article), notice: '削除完了しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
