require "spec_helper"

describe IngredientsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ingredients" }.should route_to(:controller => "ingredients", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ingredients/new" }.should route_to(:controller => "ingredients", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ingredients/1" }.should route_to(:controller => "ingredients", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ingredients/1/edit" }.should route_to(:controller => "ingredients", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ingredients" }.should route_to(:controller => "ingredients", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ingredients/1" }.should route_to(:controller => "ingredients", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ingredients/1" }.should route_to(:controller => "ingredients", :action => "destroy", :id => "1")
    end

  end
end
