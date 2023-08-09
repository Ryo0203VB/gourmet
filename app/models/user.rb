class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
validates :last_name, presence: true
validates :first_name, presence: true
validates :last_name_kana, presence: true
validates :first_name_kana, presence: true
validates :phone_number, presence: true
validates :email, presence: true

# ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないよう制約
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
end
