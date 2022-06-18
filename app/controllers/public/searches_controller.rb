class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @articles = Article.looks(params[:search], params[:word])
    elsif
      @categories = Category.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end
  end
end
