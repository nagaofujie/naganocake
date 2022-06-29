class OrderItem < ApplicationRecord
 belongs_to :item
 belongs_to :order

 enum making_status:{impossible: 0, wait: 1, production: 2, complete: 3}
end
