require 'test_helper'

class TaskControllerTest < ActionController::TestCase
  test "should get list" do
    get :list

    assert_response :success
  end


  test "should get start" do
    aa = get :start

    assert_nil(nil)

    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
