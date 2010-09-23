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
  
  context "with profiled ingredients" do
    before(:each) do
      # we are using foods and measurements that actually exist, so user input of ingredients will 
      # be found in the lookup table (--> should get green flag)
      # for the sake of brevity, we only set up two nutrients for each food (Fat and Carbohydrate)
      @food_1 = Factory(:food)
      @weight_1 = Factory(:weight, :food_id => @food_1.id)
      @nd1 = Factory.create(:nutrient_definition)
      @nd2 = NutrientDefinition.create({:tag => "FAT", :description => "Total Fat", :units => "g"})
      
      @n_11 = @food_1.nutrients.create({:value => 30, :nutrient_definition_id => @nd1.id})
      @n_12 = @food_1.nutrients.create({:value => 20, :nutrient_definition_id => @nd2.id})
      
      @food_2 = Factory(:other_food)
      @weight_2 = Factory(:other_weight, :food_id => @food_2.id)
      @n_21 = @food_2.nutrients.create({:value => 171, :nutrient_definition_id => @nd1.id})
      @n_22 = @food_2.nutrients.create({:value => 2, :nutrient_definition_id => @nd2.id})      
      # ------------------------------------------------------------------------------------------
      @recipe = Factory.build(:recipe)
      @ingredient1 = @recipe.ingredients.build({:name => @food_1.long_desc, :amount => @weight_1.amount, 
                                 :unit => @weight_1.measure_desc})
      @ingredient2 = @recipe.ingredients.build({:name => @food_2.long_desc, :amount => @weight_2.amount, 
                                 :unit => @weight_2.measure_desc})
                                 
     # Mocking Thinking Sphinx search calls                            
     Food.should_receive(:search).with(@ingredient1.name).and_return([@food_1]) 
     Food.should_receive(:search).with(@ingredient2.name).and_return([@food_2]) 
     Weight.should_receive(:search).with(@ingredient1.unit, :with => {:food_id => @food_1.id}).
     and_return([@weight_1])
     Weight.should_receive(:search).with(@ingredient2.unit, :with => {:food_id => @food_2.id}).
     and_return([@weight_2])                                               
    end
    
    
    it "should have two entries for nutrients in recipe profiles table" do
      @recipe.save!
      @recipe.recipe_profiles.length.should == 2
    end
    
    it "should have ingredients with two entries each in the ingedient profiles table" do
      @recipe.save!
      @ingredient1.ingredient_profiles.length.should == 2
      @ingredient2.ingredient_profiles.length.should == 2
    end
    
    it "nutrient value should be the sum of the values for its ingredients divided by number of servings" do
      @recipe.save!
      fat_content = @recipe.recipe_profiles.where(:nutrient_name => 'Total Fat').first.nutrient_value
      fat_for_first_ingredient = @ingredient1.ingredient_profiles.where(:nutrient_name => 'Total Fat').first.nutrient_amount
      fat_for_second_ingredient = @ingredient2.ingredient_profiles.where(:nutrient_name => 'Total Fat').first.nutrient_amount
      
      fat_content.should == (fat_for_first_ingredient + fat_for_second_ingredient)/@recipe.servings
    end
    
  end
 
end
