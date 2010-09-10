class Food < ActiveRecord::Base
  
  BASE_PROFILE = {"ENERC_KCAL" => "Calories", "FAT" => "Total Fat", "CHOLE" => "Cholesterol",
    "NA" => "Sodium", "CHOCDF" => "Total Carbs", "FIBTG" => "Dietary Fiber", "PROCNT" => "Protein"}
    
  has_many :nutrients
  has_many :weights
  
  def get_nutrient_info(nutrient_name)
    n = nutrients.joins(:nutrient_definition).
    where("nutrient_definitions.description = ?", nutrient_name).first
    puts "#{long_desc} has #{n.value} #{n.unit} of #{n.name} per 100g"
    return n
  end
  
  #amount is the quantity and measure is the household unit, e.g. 1 cup or 12 oz
  def get_weight_for_household_measure(amount, measure)
    weights.where(:amount => amount, :measure_desc => measure).first
  end
  
  def get_nutrient_amount(nutrient_name, amount, measure)
    #n.value will represent the amount of the nutrient in 100g of food
    n = get_nutrient_info(nutrient_name)
    # if measure is already in gm, then this step can be skipped
    # TODO: implement this
    unless measure == "g"
      w = get_weight_for_household_measure(amount, measure)
    end
    x = (n.value/100) * w.gm_weight 
    "#{w.amount} #{w.measure_desc} of #{long_desc} (#{w.gm_weight}g) has #{x} #{n.unit} of #{n.name}"
  end
  
  
end
