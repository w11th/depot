class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    price * quantity
  end

  def increase_quantity
    update(quantity: quantity + 1)
  end

  def decrease_quantity
    if quantity > 1
      update(quantity: quantity - 1)
    else
      false
    end
  end
end
