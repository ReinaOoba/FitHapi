class Public::HomesController < ApplicationController
  def top
    @categories = Category.all
    @tags = Tag.includes(:articles).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)
  end

  def about
  end

  def policy_agreement
  end
end
