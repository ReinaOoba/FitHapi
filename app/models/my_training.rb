class MyTraining < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :menu, presence: true, length { in: 2..30 }
  validates :set, presence: true, length { in: 2..50 }
  validates :note, length { maximum: 150 }
end
