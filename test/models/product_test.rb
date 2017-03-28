require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  def valid_params
    { title: 'My Book Title', description: 'My Book Description', image_url: 'foobar.jpg', price: 0.01 }
  end

  test 'title should be present' do
    product = Product.new(valid_params)
    product.title = nil
    assert product.invalid?
  end

  test 'title length should less than 20' do
    product = Product.new(valid_params)
    product.title = 'a' * 41
    assert product.invalid?
    assert_equal ['is too long'], product.errors[:title]
  end

  test 'title should be unique' do
    product = Product.new(valid_params)
    product.title = products(:ruby).title
    assert product.invalid?
    assert_equal ['should be unique'], product.errors[:title]
  end

  test 'description should be present' do
    product = Product.new(valid_params)
    product.description = nil
    assert product.invalid?
  end

  test 'price should be present' do
    product = Product.new(valid_params)
    product.price = nil
    assert product.invalid?
  end

  test 'price must be >= 0.01' do
    product = Product.new(valid_params)

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test 'image_url should be present' do
    product = Product.new(valid_params)
    product.image_url = nil
    assert product.invalid?
  end

  test 'image_url should be valid format' do
    ok = %w(fred.gif fred.jpg fed.png FRED.JPG FRED.jPG)
    bad = %w(fred.doc fred.gif/more fred.gif.more)

    product = Product.new(valid_params)

    ok.each do |name|
      product.image_url = name
      assert product.valid?, "#{product.image_url} shouldn't be invalid"
    end

    bad.each do |name|
      product.image_url = name
      assert product.invalid?, "#{product.image_url} shouldn't be valid"
    end
  end
end
