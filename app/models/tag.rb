class Tag < ApplicationRecord
  has_many :taglists, dependent: :destroy, foreign_key: 'tag_id'
  has_many :articles, through: :taglists

  validates :name, presence: true, uniqueness: true

  def self.looks(search, word)
    if search == "perfect_match"
      @tag = Tag.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @tag = Tag.where("name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
  end
end
