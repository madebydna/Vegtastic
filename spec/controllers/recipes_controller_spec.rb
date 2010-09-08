require 'spec_helper'

describe RecipesController do

  def mock_recipe(stubs={})
    @mock_recipe ||= mock_model(Recipe, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all recipes as @recipes" do
      Recipe.stub(:all) { [mock_recipe] }
      get :index
      assigns(:recipes).should eq([mock_recipe])
    end
  end

  describe "GET show" do
    it "assigns the requested recipe as @recipe" do
      Recipe.stub(:find).with("37") { mock_recipe }
      get :show, :id => "37"
      assigns(:recipe).should be(mock_recipe)
    end
  end

  describe "GET new" do
    it "assigns a new recipe as @recipe" do
      Recipe.stub(:new) { mock_recipe }
      get :new
      assigns(:recipe).should be(mock_recipe)
    end
  end

  describe "GET edit" do
    it "assigns the requested recipe as @recipe" do
      Recipe.stub(:find).with("37") { mock_recipe }
      get :edit, :id => "37"
      assigns(:recipe).should be(mock_recipe)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created recipe as @recipe" do
        Recipe.stub(:new).with({'these' => 'params'}) { mock_recipe(:save => true) }
        post :create, :recipe => {'these' => 'params'}
        assigns(:recipe).should be(mock_recipe)
      end

      it "redirects to the created recipe" do
        Recipe.stub(:new) { mock_recipe(:save => true) }
        post :create, :recipe => {}
        response.should redirect_to(recipe_url(mock_recipe))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recipe as @recipe" do
        Recipe.stub(:new).with({'these' => 'params'}) { mock_recipe(:save => false) }
        post :create, :recipe => {'these' => 'params'}
        assigns(:recipe).should be(mock_recipe)
      end

      it "re-renders the 'new' template" do
        Recipe.stub(:new) { mock_recipe(:save => false) }
        post :create, :recipe => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested recipe" do
        Recipe.should_receive(:find).with("37") { mock_recipe }
        mock_recipe.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :recipe => {'these' => 'params'}
      end

      it "assigns the requested recipe as @recipe" do
        Recipe.stub(:find) { mock_recipe(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:recipe).should be(mock_recipe)
      end

      it "redirects to the recipe" do
        Recipe.stub(:find) { mock_recipe(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(recipe_url(mock_recipe))
      end
    end

    describe "with invalid params" do
      it "assigns the recipe as @recipe" do
        Recipe.stub(:find) { mock_recipe(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:recipe).should be(mock_recipe)
      end

      it "re-renders the 'edit' template" do
        Recipe.stub(:find) { mock_recipe(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested recipe" do
      Recipe.should_receive(:find).with("37") { mock_recipe }
      mock_recipe.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the recipes list" do
      Recipe.stub(:find) { mock_recipe }
      delete :destroy, :id => "1"
      response.should redirect_to(recipes_url)
    end
  end

end
