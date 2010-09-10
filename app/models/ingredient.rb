class Ingredient < ActiveRecord::Base
  
  belongs_to :recipe
  
  def find_food
    Food.where("long_desc LIKE ? OR short_desc LIKE ?", "'%name%'", "'%name%'")
  end
end
