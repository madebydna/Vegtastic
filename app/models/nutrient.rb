class Nutrient < ActiveRecord::Base
  
  # Get the abbreviated versions (e.g. ENERC_KCAL, FAT, CHOLE, ...)
  BASE_PROFILE = ['Protein', 'Total lipid (fat)', 'Carbohydrate, by difference', 'Energy', 'Fiber, total dietary', 'Sodium, Na']
  
  has_one :nutrient_definition


end
