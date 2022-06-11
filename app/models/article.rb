class Article < ApplicationRecord
  has_many_attached :article_image, dependent: :destroy
  belongs_to :user
  belongs_to :category
  has_many :taglist, dependent: :destroy
  has_many :tags, through: :taglist
  has_many :comments, dependent: :destroy

  enum status: { opened: 0, closed: 1 }

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
end