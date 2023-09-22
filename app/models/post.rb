class Post < ApplicationRecord

  validates :name,presence:true
  validates :introduction,presence:true,length:{maximum:200}
  validates :address,presence:true
  validates :address,presence:true
  has_one_attached :image

  belongs_to :user
  belongs_to :genre, foreign_key: 'genre_id'
  has_many :comments, dependent: :destroy
  has_many :favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'

  def get_image(height, width)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image.variant(resize_to_limit: [height, width]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
