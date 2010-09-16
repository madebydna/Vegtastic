class IngredientParser  
  
  def initialize(ingredient)
    @ingredient = ingredient
  end
  
  def set_flag
    if @ingredient.food = find_food
      @ingredient.weight = find_weight
      @ingredient.flag = @ingredient.weight ? "green" : "yellow"
    else
      @ingredient.flag = "red"
    end
  end
  
  def find_weight
    #TODO: measurements need to pass some equivalency check (e.g.: tsp is equivalent to teaspoon)
    @ingredient.food.get_weight_for_household_measure(@ingredient.unit)
  end
  
  def find_food
    #TODO: logic to perform multiple searches if ingredient name has multiple words
    #TODO: logic to pick best match if multiple foods found
    Food.where("long_desc LIKE ?", "%#{@ingredient.name}%").first
  end
  
end