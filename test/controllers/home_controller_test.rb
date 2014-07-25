require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "this should be a model tests" do
    assert_equal(User.new.name == "unknown")
  end

end
