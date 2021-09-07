class User < ApplicationRecord
  attr_accessor :skip_validations
  before_validation { email.downcase! }
  has_secure_password
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, unless: :skip_validations
  has_many :posts
  
  mount_uploader :image, AvatarUploader
end
