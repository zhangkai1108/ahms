require 'test_helper'

class Product2sControllerTest < ActionController::TestCase
  setup do
    @product2 = product2s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product2s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product2" do
    assert_difference('Product2.count') do
      post :create, product2: { name: @product2.name }
    end

    assert_redirected_to product2_path(assigns(:product2))
  end

  test "should show product2" do
    get :show, id: @product2
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product2
    assert_response :success
  end

  test "should update product2" do
    patch :update, id: @product2, product2: { name: @product2.name }
    assert_redirected_to product2_path(assigns(:product2))
  end

  test "should destroy product2" do
    assert_difference('Product2.count', -1) do
      delete :destroy, id: @product2
    end

    assert_redirected_to product2s_path
  end
end
