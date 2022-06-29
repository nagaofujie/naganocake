class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
# def sum_price
#   item.tax_in*amount
# end

end
