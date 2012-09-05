require 'test_helper'

class DenunciasControllerTest < ActionController::TestCase
  setup do
    @denuncia = denuncias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:denuncias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create denuncia" do
    assert_difference('Denuncia.count') do
      post :create, :denuncia => @denuncia.attributes
    end

    assert_redirected_to denuncia_path(assigns(:denuncia))
  end

  test "should show denuncia" do
    get :show, :id => @denuncia.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @denuncia.to_param
    assert_response :success
  end

  test "should update denuncia" do
    put :update, :id => @denuncia.to_param, :denuncia => @denuncia.attributes
    assert_redirected_to denuncia_path(assigns(:denuncia))
  end

  test "should destroy denuncia" do
    assert_difference('Denuncia.count', -1) do
      delete :destroy, :id => @denuncia.to_param
    end

    assert_redirected_to denuncias_path
  end
end
