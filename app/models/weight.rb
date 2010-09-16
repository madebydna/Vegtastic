# == Schema Information
# Schema version: 20100910051038
#
# Table name: weights
#
#  id           :integer(4)      not null, primary key
#  food_id      :integer(4)
#  amount       :float
#  measure_desc :string(255)
#  gm_weight    :float
#  created_at   :datetime
#  updated_at   :datetime
#

class Weight < ActiveRecord::Base
  
  belongs_to :food
end
