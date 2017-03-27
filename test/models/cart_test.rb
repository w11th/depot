require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @empty_cart = carts(:empty_cart)
    @not_empty_cart = carts(:not_empty_cart)
  end

  test 'should create one line item after adding new unique product' do
    line_item = @empty_cart.add_product(products(:ruby))
    assert_equal line_item.product_id, products(:ruby).id
    assert_equal line_item.price, products(:ruby).price
  end

  test 'line item quantity should be right after add unique products' do
    line_item = @not_empty_cart.add_product(products(:ruby))
    assert_equal line_item.quantity, 1
  end

  test 'line item quantity should be right after add duplicate products' do
    line_item = @not_empty_cart.add_product(products(:rails))
    assert_equal line_item.quantity, 2
  end
end
