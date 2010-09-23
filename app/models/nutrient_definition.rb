# == Schema Information
# Schema version: 20100910051038
#
# Table name: nutrient_definitions
#
#  id          :integer(4)      not null, primary key
#  nutrient_id :integer(4)
#  units       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  tag         :string(255)
#

class NutrientDefinition < ActiveRecord::Base
  
  has_many :nutrients
  
end
