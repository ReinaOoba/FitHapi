class Category < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.looks(search, word)
    if search == "perfect_match"
      @category = Category.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @category = Category.where("name LIKE?","%#{word}%")
    else
      @category = Category.all
    end
  end

end
