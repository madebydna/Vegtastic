# == Schema Information
# Schema version: 20100910051038
#
# Table name: foods
#
#  id                :integer(4)      not null, primary key
#  old_pk            :string(5)
#  long_desc         :string(255)
#  short_desc        :string(255)
#  common_name       :string(255)
#  manufacturer_name :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Food < ActiveRecord::Base
  
  BASE_PROFILE = {"ENERC_KCAL" => "Calories", "FAT" => "Total Fat", "CHOLE" => "Cholesterol",
    "NA" => "Sodium", "CHOCDF" => "Total Carbs", "FIBTG" => "Dietary Fiber", "PROCNT" => "Protein"}
    
  has_many :nutrients
  has_many :weights
  
  define_index do
    indexes long_desc, :as => :name
    indexes manufacturer_name, :as => :manufacturer
  end
  
  
end
