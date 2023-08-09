class Genre < ApplicationRecord
  # postsとジャンルidでのアソシエーション
  has_many :posts, foreign_key: "genre_id"

  validates :name, presence: true
end
