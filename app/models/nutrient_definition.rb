class NutrientDefinition < ActiveRecord::Base
  
  belongs_to :nutrient
  
  def friendly_name
    # code to retrieve friendly description from a hash
  end
end
