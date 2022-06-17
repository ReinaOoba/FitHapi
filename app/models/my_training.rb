class MyTraining < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :menu, presence: true
  validates :set, presence: true
end
