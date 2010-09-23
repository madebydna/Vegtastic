require 'spec_helper'

describe Ingredient do
  
  context "name and measurement exist in lookup tables" do
    before(:each) do
      # ensures that we are using foods and measurements that actually exist
      @food = Factory(:food)
      @weight = Factory(:weight, :food_id => @food.id)
      @nd1 = Factory.create(:nutrient_definition)
      @n1 = @food.nutrients.create({:value => 171, :nutrient_definition_id => @nd1.id})
      @nd2 = NutrientDefinition.create({:tag => "FAT", :description => "Total Fat", :units => "g"})
      @n2 = @food.nutrients.create({:value => 2, :nutrient_definition_id => @nd2.id})
      # ------------------------------------------------------------------------------------------
      @recipe = Factory.build(:recipe)
      @ingredient = @recipe.ingredients.build({:name => @food.long_desc, :amount => @weight.amount, 
                    :unit => @weight.measure_desc})
      Food.should_receive(:search).with(@ingredient.name).and_return([@food])
      Weight.should_receive(:search).with(@ingredient.unit, :with => {:food_id => @food.id}).
      and_return([@weight])
      @recipe.save!
    end
    
    it "should get a green flag" do
      @recipe.ingredients.first.flag.should == "green" 
    end
    
    it "should have ingredient profiles for key nutrients" do
      @recipe.ingredients.first.ingredient_profiles.should_not be_empty
    end
    
    it "should have as many ingredient profiles as the food has key nutrients" do
      @recipe.ingredients.first.ingredient_profiles.length.should == @food.nutrients.length
    end
    
  end
  
  context "name, but not the measurement exists in the lookup tables" do
    
    before(:each) do
      @food = Factory(:food)
      @recipe = Factory.build(:recipe)
      @ingredient = @recipe.ingredients.build({:name => @food.long_desc, :amount => "1", :unit => "clove"})
      Food.should_receive(:search).with(@ingredient.name).and_return([@food])
      @units_to_try = (IngredientParser::OTHER_COMMON_UNITS - [@ingredient.unit]).push @ingredient.name
      
      # tests that it tries two searches to find unit in weights table
      Weight.should_receive(:search).with(@ingredient.unit, :with => {:food_id => @food.id}).
      and_return([])
      Weight.should_receive(:search).with(@units_to_try.join(" | "), 
      :with => {:food_id => @food.id}, :match_mode => :boolean).
      and_return([])
      @recipe.save!
    end
    

    it "should get a yellow flag" do
      @ingredient.flag.should == "yellow" 
    end
    
    it "should not have any ingredient profiles" do
      @ingredient.ingredient_profiles.should be_empty
    end
    
  end
  
  context "neither name nor measurement exist in the lookup tables" do
    
    before(:each) do
      @recipe = Factory.build(:recipe)
      @ingredient = @recipe.ingredients.build({:name => "smoked seitan", :amount => "1", :unit => "clove"})
      
      # tests that it tries two searches to find food
      Food.should_receive(:search).with(@ingredient.name).and_return([])
      Food.should_receive(:search).with(@ingredient.name, :match_mode => :any).and_return([])
      @recipe.save!
    end
    
    
    it "should get a red flag" do  
      @ingredient.flag.should == "red" 
    end
    
    it "should not have any ingredient profiles" do
      @ingredient.ingredient_profiles.should be_empty
    end
    
  end
  
  
end
