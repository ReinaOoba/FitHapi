class Taglist < ApplicationRecord
  belongs_to :tag
  belongs_to :article, dependent: :destroy

  validates :article_id, presence: true
  validates :tag_id, uniqueness: { scope: :article_id }
end
