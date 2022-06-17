class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :my_trainings, dependent: :destroy
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  validates :name, presence: true, length: { maximum: 20 }
  validates :account, presence: true, uniqueness: true
  validates :email, presence: true

  def to_param
    account
  end

# アイコン
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/blank-profile.png')
      profile_image.attach(io: File.open(file_path), filename: 'blank-profile.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # フォローしたときの処理
def follow(user_id)
  relationships.create(followed_id: user_id)
end

# フォローを外すときの処理
def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
end

# フォローしているか判定
def following?(user)
  followings.include?(user)
end

# 退会機能
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
