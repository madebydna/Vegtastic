# == Schema Information
# Schema version: 20100910051038
#
# Table name: ingredients
#
#  id           :integer(4)      not null, primary key
#  recipe_id    :integer(4)
#  order_of     :integer(4)
#  amount       :float
#  unit         :string(255)
#  name         :string(255)
#  instructions :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Ingredient < ActiveRecord::Base
  
  UNITS = ["tbsp", "tsp", "cup", "oz", "lb", "gm", "can", "piece", "clove", "package", "stick", "stalk", "head"]
  
  # Temp vars to avoid looking up the food/weight twice
  attr_accessor :food, :weight
  
  belongs_to :recipe
  has_many :ingredient_profiles, :dependent => :destroy
  has_many :nutrients, :through => :ingredient_profiles
  
  validates_numericality_of :amount
  validates_presence_of :amount, :name
  
  before_save :set_flag
  after_save :create_profiles, :if => Proc.new { |i| i.flag == 'green' } 
  
  #ingredients not included in the recipe
  class << self
    def not_included
      where("flag != 'green'")
    end
  end
  
  private
  
  def set_flag
    if changed_significantly?
      #IngredientParser attempts to find foods and measurements. The flag attribute gets set depending on outcome
      parser = IngredientParser.new(self)
      parser.set_flag
    end
  end
  
  def create_profiles
    if changed_significantly?
      food.nutrients.each do |nutrient|
        if Food::BASE_PROFILE.keys.include?(nutrient.nutrient_definition.tag)
          x = calculate_nutrient_amount(nutrient)
          i_attrs = {:nutrient => nutrient, :nutrient_amount => x, 
          :nutrient_name => nutrient.name, :nutrient_unit => nutrient.unit}
          if ip = ingredient_profiles.find_by_nutrient_id(nutrient.id)
            ip.update_attributes(i_attrs)
          else
            ingredient_profiles.create(i_attrs)
          end
        end
      end
    end
  end
  
  def calculate_nutrient_amount(nutrient)
    ingredient_weight = (weight.gm_weight/weight.amount)*amount
    (nutrient.value/100) * (ingredient_weight) 
  end
  
  def changed_significantly?
    # only if changes to these three attributes have occurred, will we have to go through the profiling steps again
    # since this check is also triggered when a recipe & ingredients are fist created, the "changed" array would 
    # be empty, thefore I check for the condition that the ingredient has just been saved 
    !(["name", "unit", "amount"] & changed).empty? || !((self.created_at - Time.now.utc) > 1)
  end
  
end
