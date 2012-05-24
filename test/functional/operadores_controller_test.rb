require 'test_helper'

class OperadoresControllerTest < ActionController::TestCase
  setup do
    @operador = operadores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operadores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operador" do
    assert_difference('Operador.count') do
      post :create, :operador => @operador.attributes
    end

    assert_redirected_to operador_path(assigns(:operador))
  end

  test "should show operador" do
    get :show, :id => @operador.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @operador.to_param
    assert_response :success
  end

  test "should update operador" do
    put :update, :id => @operador.to_param, :operador => @operador.attributes
    assert_redirected_to operador_path(assigns(:operador))
  end

  test "should destroy operador" do
    assert_difference('Operador.count', -1) do
      delete :destroy, :id => @operador.to_param
    end

    assert_redirected_to operadores_path
  end
end
