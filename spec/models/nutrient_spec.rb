require 'spec_helper'

describe Nutrient do
  
  before(:each) do
    @food = Factory(:food)
    @attr = {:value => 0.06}
  end
  
  describe "associations with food and nutrient definition" do
    before(:each) do
      @nutrient = @food.nutrients.create!(@attr)
    end
    
    it "should belong to food" do
      @nutrient.should respond_to(:food)
    end
    
    it "should have the right associated food" do
      @nutrient.food_id.should == @food.id
      @nutrient.food.should == @food
    end
    
    it "should have a name reflecting the nutrient definition" do
      @definition = @nutrient.create_nutrient_definition(Factory.attributes_for(:nutrient_definition))
      @nutrient.name.should == @definition.description
    end
    
    it "should have a unit reflecting the unit in the nutrient definition" do
      @definition = @nutrient.create_nutrient_definition(Factory.attributes_for(:nutrient_definition))
      @nutrient.unit.should == @definition.units
    end
    
  end
end
