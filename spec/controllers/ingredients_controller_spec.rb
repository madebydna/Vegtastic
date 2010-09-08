require 'spec_helper'

describe IngredientsController do

  def mock_ingredient(stubs={})
    @mock_ingredient ||= mock_model(Ingredient, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all ingredients as @ingredients" do
      Ingredient.stub(:all) { [mock_ingredient] }
      get :index
      assigns(:ingredients).should eq([mock_ingredient])
    end
  end

  describe "GET show" do
    it "assigns the requested ingredient as @ingredient" do
      Ingredient.stub(:find).with("37") { mock_ingredient }
      get :show, :id => "37"
      assigns(:ingredient).should be(mock_ingredient)
    end
  end

  describe "GET new" do
    it "assigns a new ingredient as @ingredient" do
      Ingredient.stub(:new) { mock_ingredient }
      get :new
      assigns(:ingredient).should be(mock_ingredient)
    end
  end

  describe "GET edit" do
    it "assigns the requested ingredient as @ingredient" do
      Ingredient.stub(:find).with("37") { mock_ingredient }
      get :edit, :id => "37"
      assigns(:ingredient).should be(mock_ingredient)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created ingredient as @ingredient" do
        Ingredient.stub(:new).with({'these' => 'params'}) { mock_ingredient(:save => true) }
        post :create, :ingredient => {'these' => 'params'}
        assigns(:ingredient).should be(mock_ingredient)
      end

      it "redirects to the created ingredient" do
        Ingredient.stub(:new) { mock_ingredient(:save => true) }
        post :create, :ingredient => {}
        response.should redirect_to(ingredient_url(mock_ingredient))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ingredient as @ingredient" do
        Ingredient.stub(:new).with({'these' => 'params'}) { mock_ingredient(:save => false) }
        post :create, :ingredient => {'these' => 'params'}
        assigns(:ingredient).should be(mock_ingredient)
      end

      it "re-renders the 'new' template" do
        Ingredient.stub(:new) { mock_ingredient(:save => false) }
        post :create, :ingredient => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested ingredient" do
        Ingredient.should_receive(:find).with("37") { mock_ingredient }
        mock_ingredient.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ingredient => {'these' => 'params'}
      end

      it "assigns the requested ingredient as @ingredient" do
        Ingredient.stub(:find) { mock_ingredient(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:ingredient).should be(mock_ingredient)
      end

      it "redirects to the ingredient" do
        Ingredient.stub(:find) { mock_ingredient(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(ingredient_url(mock_ingredient))
      end
    end

    describe "with invalid params" do
      it "assigns the ingredient as @ingredient" do
        Ingredient.stub(:find) { mock_ingredient(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:ingredient).should be(mock_ingredient)
      end

      it "re-renders the 'edit' template" do
        Ingredient.stub(:find) { mock_ingredient(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested ingredient" do
      Ingredient.should_receive(:find).with("37") { mock_ingredient }
      mock_ingredient.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the ingredients list" do
      Ingredient.stub(:find) { mock_ingredient }
      delete :destroy, :id => "1"
      response.should redirect_to(ingredients_url)
    end
  end

end
