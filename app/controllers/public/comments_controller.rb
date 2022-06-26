class Public::CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = @article.id
    @comments = @article.comments
    if @comment.save
       render "comments", notice: 'コメントしました'
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
    Comment.find(params[:id]).destroy
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    render "comments"
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :article_id)
  end
end
