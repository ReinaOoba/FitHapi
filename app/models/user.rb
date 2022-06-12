class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image, dependent: :destroy
  has_many :articles, dependent: :destroy
  # has_many :favorites, dependent: :destroy
  has_many :my_trainings, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :account, presence: true, uniqueness: true
  validates :email, presence: true

  def to_param
    account
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/blank-profile.png')
      profile_image.attach(io: File.open(file_path), filename: 'blank-profile.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

# 退会機能
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
