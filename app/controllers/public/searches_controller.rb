class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "Article"
      @articles_all = Article.where(status: 0).search(@word).page(params[:page])
    elsif @range == "Title"
      @articles_title = Article.where(status: 0).title_search(@word).page(params[:page])
    elsif @range == "Text"
      @articles_text = Article.where(status: 0).text_search(@word).page(params[:page])
    else
      @tags = Tag.search(@word)
    end
  end
end
