require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stores_index_url
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  # test "should get access times increasement after visit index" do
  #   5.times do
  #     get stores_index_url
  #     assert_response :success
  #     assert_select 'h1', 'Your Pragmatic Catalog'
  #   end
  #   get stores_index_url
  #   assert_response :success
  #   assert_select 'h1', 'Your Pragmatic Catalog 6 times'
  # end
end
