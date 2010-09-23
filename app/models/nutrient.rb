# == Schema Information
# Schema version: 20100910051038
#
# Table name: nutrients
#
#  id         :integer(4)      not null, primary key
#  food_id    :integer(4)
#  old_pk     :string(3)
#  value      :float
#  created_at :datetime
#  updated_at :datetime
#

class Nutrient < ActiveRecord::Base
    
  belongs_to :food
  belongs_to :nutrient_definition

  def name
    nutrient_definition.description
  end
  
  def unit
    nutrient_definition.units
  end
  
  
end
