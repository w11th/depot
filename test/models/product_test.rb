require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title', description: 'yyy', image_url: 'zzz.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test 'image url' do
    ok = %w(fred.gif fred.jpg fed.png FRED.JPG FRED.jPG)
    bad = %w(fred.doc fred.gif/more fred.gif.more)

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  def new_product(image_url)
    Product.new(title: 'My Book Title',
                description: 'yyy',
                price: 1,
                image_url: image_url)
  end

  test 'product is not valid without a unique title' do
    product = Product.new(title: products(:ruby).title, description: 'yyy', image_url: 'fred.gif', price: 0.1)
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
