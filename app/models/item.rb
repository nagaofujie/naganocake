class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre
  has_many :oder_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy


  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/cake-1284548__480.1.jpeg")
      image.attach(io: File.open(file_path),filename:"default-image.jpg",content_type: "image/jpg")
    end
    image.variant(resize_to_limit:[width, height]).processed
  end

  def tax_in
    (price * 1.1).round
  end

  def amount
    order_item.amount
  end

end
