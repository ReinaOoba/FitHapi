class Public::CommentsController < ApplicationController
  def create
    @article = Article.find_by(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = @article.id
    @comment.save
    render "articles/show"
  end

  def destroy
    Comment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    @article = Article.find_by(params[:article_id])
    render "articles/show"
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
