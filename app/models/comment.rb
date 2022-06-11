class Comment < ApplicationRecord
  belongs_to article
  
  validates :user_id, presence: true
  validates :article_id, presence: true
  validates :text, presence: true
end
