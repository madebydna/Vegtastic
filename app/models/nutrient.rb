class Nutrient < ActiveRecord::Base
    
  belongs_to :food
  has_one :nutrient_definition

  def name
    nutrient_definition.description
  end
  
  def unit
    nutrient_definition.units
  end
  
  
end
