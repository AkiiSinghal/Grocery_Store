class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :item
  has_many :cart_item
  has_many :order

  def thumbnail
    return self.image.variant(resize: '300x300!').processed
  end
end
