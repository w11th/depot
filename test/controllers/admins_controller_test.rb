require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_url
    assert_response :success
  end

  test "should redirect to login page after logging out" do
    delete logout_url
    get admins_url
    assert_redirected_to login_url
  end

end
