class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    # Comment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    article = Article.find_by(id: params[:article_id])
    comment.delete
    redirect_to admin_article_path(article), notice: '削除完了しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
