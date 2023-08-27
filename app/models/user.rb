class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :entries
  has_many :chats


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :introduction, length: {maximum: 50 }

  def name
  "#{last_name} #{first_name}"
  end

def self.ransackable_attributes(auth_object = nil)
["created_at", "email", "encrypted_password", "first_name", "first_name_kana", "id", "introduction", "is_deleted", "last_name", "last_name_kana", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
end

  # def self.ransackable_attributes(auth_object = nil)
  #   ["name", "created_at", "email", "encrypted_password", "first_name", "first_name_kana", "id", "introduction", "is_deleted", "last_name", "last_name_kana", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  # end

  def self.ransackable_associations(auth_object = nil)
    ["chats", "comments", "entries", "favorites", "followers", "followings", "image_attachment", "image_blob", "posts", "relationships", "reverse_of_relationships"]
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


  def get_image(height, width)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image.variant(resize_to_limit: [height, width]).processed
  end

  GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.last_name = "guest"
        user.first_name = "user"
        user.last_name_kana = "guest"
        user.first_name_kana = "user"
        user.phone_number = "00000000"
      end
    end

    def guest_user?
     email == GUEST_USER_EMAIL
    end

  # ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないよう制約
  def active_for_authentication?
      super && (is_deleted == false)
  end

end
