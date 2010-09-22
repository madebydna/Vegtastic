# == Schema Information
# Schema version: 20100910051038
#
# Table name: recipes
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  servings    :integer(4)
#  description :text
#  directions  :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Recipe < ActiveRecord::Base
    
  after_save :update_or_create_recipe_profile
  
  has_many :ingredients, :dependent => :destroy
  validates_associated :ingredients
  has_many :recipe_profiles, :dependent => :destroy
  
  accepts_nested_attributes_for :ingredients, :allow_destroy => true, 
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  validate :needs_at_least_one_ingredient
  
  
  def needs_at_least_one_ingredient
    errors.add(:base, "must have at least one ingredient") if ingredients.size == 0
  end 
  
  
  private
  
  def update_or_create_recipe_profile
    i_profiles = IngredientProfile.aggregated_nutrient_values_by_recipe(ingredients.collect(&:id))
    # create or update nutrient entry
    i_profiles.each do |ip|
      ip_attr = {:nutrient_name => ip.nutrient_name, :nutrient_value => (ip.total/self.servings), :nutrient_unit => ip.nutrient_unit}  
      if rp = recipe_profiles.find_by_nutrient_name(ip.nutrient_name)
        rp.update_attributes(ip_attr)
      else
        recipe_profiles.create!(ip_attr)
      end
    end
  end
  
end
