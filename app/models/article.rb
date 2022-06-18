class Article < ApplicationRecord
  has_many_attached :article_images, dependent: :destroy
  has_one_attached :article_video, dependent: :destroy
  belongs_to :user
  belongs_to :category
  has_many :taglist, dependent: :destroy
  has_many :tags, through: :taglist
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  enum status: { public: 0, privated: 1 }, _prefix: true

  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true
  validates :text, presence: true
  validates :status, presence: true

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil? # タグが存在していれば、タグの名前を配列として全て取得
    old_tags = current_tags - sent_tags  # 現在取得したタグから送られてきたタグを除いてoldtagとする
    new_tags = sent_tags - current_tags # 送信されてきたタグから現在存在するタグを除いたタグをnewとする

    old_tags.each do |old|  # 古いタグを消す
    self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new| # 新しいタグを保存
      new_article_tag = Tag.find_or_create_by(name: new)
      self.tags << new_article_tag
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @article = Article.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @article = Article.where("title LIKE?","%#{word}%")
    else
      @article = Article.all
    end
  end

end
