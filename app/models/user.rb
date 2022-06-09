class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile_image
  # has_many :articles, dependent: :destroy
  # has_many :favorites, dependent: :destroy
  # has_many :mytrainings, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :account, presence: true, uniqueness: true
  validates :email, presence: true

# ゲスト機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲスト'
      user.account = 'guest'
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def to_param
    account
  end

# 退会機能
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
