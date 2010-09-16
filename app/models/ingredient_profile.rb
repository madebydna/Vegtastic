class IngredientProfile < ActiveRecord::Base
  
  belongs_to :ingredient
  belongs_to :nutrient

  
  def self.aggregated_nutrient_values_by_recipe(ingredient_ids)
    # TODO: remove nutrient_id from ingredient_profiles table and change nutrient_name to be in synch with Food::BASE_PROFILE
    select("ingredient_profiles.nutrient_name, ingredient_profiles.nutrient_unit, SUM(nutrient_amount) AS total").
    where("ingredient_id IN (?)", ingredient_ids).
    group("nutrient_name")
  end
    
end
