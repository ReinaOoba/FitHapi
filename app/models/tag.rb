class Tag < ApplicationRecord
  has_many :taglists, dependent: :destroy, foreign_key: 'tag_id'
  has_many :articles, through: :taglists

  validates :name, presence: true, uniqueness: true

  def self.search(word)
    @tags = Tag.where("name LIKE?","%#{word}%")
  end

end
