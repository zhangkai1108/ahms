require 'test_helper'

class TaskControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get stop" do
    get :stop
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
