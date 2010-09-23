require 'spec_helper'

describe IngredientProfile do
  
  before(:each) do
    @food = Factory(:food)
    @weight = Factory(:weight, :food_id => @food.id)
    @n1 = @food.nutrients.create({:value => 171})
    @n1.create_nutrient_definition(Factory.attributes_for(:nutrient_definition))
    @n2 = @food.nutrients.create({:value => 2})
    @n2.create_nutrient_definition({:tag => "FAT", :description => "Total Fat", :units => "g"})
    # ------------------------------------------------------------------------------------------
    @recipe = Factory.build(:recipe)
  end
  
  it "should have the right value for nutrient amount in ingredient" do
    @ingredient = @recipe.ingredients.build({:name => @food.long_desc, :amount => 2, :unit => @weight.measure_desc})
    @recipe.save!
    
    ingredient_weight = (@weight.gm_weight/@weight.amount)*@ingredient.amount
    x = (@n1.value/100) * (ingredient_weight)

    ip = @ingredient.ingredient_profiles.where(:nutrient_id => @n1.id).first
    ip.nutrient_amount.should == x
  end
  
end