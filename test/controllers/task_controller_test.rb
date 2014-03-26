require 'test_helper'

class TaskControllerTest < ActionController::TestCase
  test "should get list" do
    get :list

    assert_response :success
  end


  test "should get start" do
    Market.delete_all
    DealTask.delete_all
    aa = get :start
    p aa
    assert_response :success
  end

  test "should get delete" do
    #get :delete
    #assert_response :success
  end

end
