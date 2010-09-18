class IngredientProfile < ActiveRecord::Base
  
  belongs_to :ingredient
  belongs_to :nutrient

  
  def self.aggregated_nutrient_values_by_recipe(ingredient_ids)
    select("ingredient_profiles.nutrient_name, ingredient_profiles.nutrient_unit, SUM(nutrient_amount) AS total").
    where("ingredient_id IN (?)", ingredient_ids).
    group("nutrient_name")
  end
    
end
