class Public::HomesController < ApplicationController
  def top
    articles= Article.where(status: 0)
    @new_arrival_articles = articles.order(created_at: :DESC).limit(4)
    @hot_articles = articles.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}.take(4)
    @categories = Category.includes(:articles).where(articles: {status: 0}).limit(4)
    @tags = Tag.includes(:articles).sort {|a,b| b.articles.size <=> a.articles.size}.take(4)

  end

  def about
  end

  def policy_agreement
  end
end
