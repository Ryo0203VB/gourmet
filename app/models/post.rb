class Post < ApplicationRecord
  
  belongs_to :user
  belongs_to :gemre, foreign_key: 'genre_id'
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :image
  
  validates :name,presence:true
  validates :introduction,presence:true,length:{maximum:200}
  
  
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
