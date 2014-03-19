require 'test_helper'

class TaskControllerTest < ActionController::TestCase
  test "should get list" do
    get :list

    assert_response :success
  end


  test "should get start" do
    aa = get :start
    p aa
    assert_equal aa,"test","相等"

    assert_response :success
  end

  test "should get delete" do
    #get :delete
    #assert_response :success
  end

end
