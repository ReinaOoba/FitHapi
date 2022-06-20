class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "Article"
      @articles_all = Article.search(@word).page(params[:page])
    elsif @range == "Title"
      @articles_title = Article.title_search(@word).page(params[:page])
    elsif @range == "Text"
      @articles_text = Article.text_search(@word).page(params[:page])
    else @range == "Tag"
      @tags = Tag.search(@word)
    end
  end
end
