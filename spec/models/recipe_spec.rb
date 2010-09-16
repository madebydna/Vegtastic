require 'spec_helper'

describe Recipe do
  before(:each) do
    @recipe = Factory.build(:recipe)
  end
  
  it "saves its ingredients when it gets saved" do
    @recipe.ingredients.build(Factory.attributes_for(:ingredient))
    lambda do 
      @recipe.save!
    end.should change(Ingredient, :count)
  end
  
  it "should not be valid without at least one ingredient" do
    @recipe.should_not be_valid
    @recipe.errors[:base].should include("must have at least one ingredient")
  end
  
  it "should validate its ingredients" do
    @recipe.ingredients.build({})
    @recipe.should_not be_valid
    @recipe.errors[:ingredients].should include("is invalid")
  end
 
end
