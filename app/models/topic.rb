class Topic < ApplicationRecord
  validates :title, presence: true
  validates :thumbnail, presence: true
  validates :contents, presence: true
  validates :user_id, presence: true
  
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  
  mount_uploader :image, ImageUploader
end
