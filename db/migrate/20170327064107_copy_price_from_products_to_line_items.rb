class CopyPriceFromProductsToLineItems < ActiveRecord::Migration[5.0]
  def up
    line_items = LineItem.where(price: nil)
    line_items.each do |line_item|
      line_item.update(price: line_item.product.price ) unless line_item.product.nil?
      p "Line item #{line_item.id} price updated."
    end
  end

  def down
    line_items.each do |line_item|
      line_item.update(price: nil)
    end
  end
end
