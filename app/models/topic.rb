class Topic < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  
  validates :title, presence: true
  validates :contents, presence: true
  validates :user_id, presence: true
  
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  
  mount_uploaders :image, ImageUploader
  
  def self.search(search)
      return Topic.all unless search
      Topic.where(['title LIKE ?', "%#{search}%"])
  end
end
