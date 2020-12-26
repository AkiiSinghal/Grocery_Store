class Item < ApplicationRecord
    belongs_to :user
    has_many :cart_item
    has_many :order
    #has_one_attached: image
    has_many_attached :images
    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :quantity, presence: true
    validate :image_type

    def thumbnail input
        return self.images[input].variant(resize: '300x300!').processed
    end

    private
    def image_type
        if images.attached? == false
            errors.add(:images, "are missing")
        end
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png))
                errors.add(:images, "need to be a JPEG or PNG")
            end
        end
    end

    
end
