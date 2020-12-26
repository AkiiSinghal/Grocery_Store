class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :item
  has_many :cart_item
  has_many :order
  validate :image_type

  def thumbnail
    return self.image.variant(resize: '300x300!').processed
  end

  def self.search(search)
    if search
      shop_type =User.find_by(shop:search)
        if shop_type
        self.where(id: shop_type)
        else
        @shops=User.all
        end
    else
      @shops=User.all
    end
  end

  def image_type
    if user_type == "Vendor" && image.attached? == false
        errors.add(:image, "are missing")
    end
  end
end
