require "spec_helper"

describe RecipesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/recipes" }.should route_to(:controller => "recipes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/recipes/new" }.should route_to(:controller => "recipes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/recipes/1" }.should route_to(:controller => "recipes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/recipes/1/edit" }.should route_to(:controller => "recipes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/recipes" }.should route_to(:controller => "recipes", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/recipes/1" }.should route_to(:controller => "recipes", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/recipes/1" }.should route_to(:controller => "recipes", :action => "destroy", :id => "1")
    end

  end
end
