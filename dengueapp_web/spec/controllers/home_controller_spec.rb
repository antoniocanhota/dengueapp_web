require 'spec_helper'

describe HomeController do

  describe "GET 'administrador'" do
    it "returns http success" do
      get 'administrador'
      response.should be_success
    end
  end

  describe "GET 'moderador'" do
    it "returns http success" do
      get 'moderador'
      response.should be_success
    end
  end

  describe "GET 'denunciante'" do
    it "returns http success" do
      get 'denunciante'
      response.should be_success
    end
  end

end
