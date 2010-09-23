class IngredientParser 
  
  REDUNDANT_WORDS = ["small", "large", "medium", "big", "fresh", "dried", "raw", "organic"] # to be continued ...
  OTHER_COMMON_UNITS = ["tbsp", "tsp", "cup", "oz", "teaspoon", "tablespoon", "fruit"]
  
  
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
  
  def find_food
    #TS match mode is :all by default
    all = Food.search(@ingredient.name)
    case all.length
      when 1
        all.first
      when 0
        cleaned_phrase = clean_search_phrase
        any = Food.search cleaned_phrase, :match_mode => :any
        any.length > 1 ? reduce_result_set(any, cleaned_phrase) : any.first
      else
        cleaned_phrase = clean_search_phrase
        reduce_result_set(all, cleaned_phrase)
    end
  end
  
  private
  
  def reduce_result_set(foods, cleaned_phrase)
    # an ingredient like "margarine" or "bread" will return a large number of results
    # favor those that contain the words "regular", "plain" or "raw", or start with the name of the ingredient
    reduced = Food.search("#{cleaned_phrase} plain | #{cleaned_phrase} regular | #{cleaned_phrase} raw", 
              :conditions => {:manufacturer => ""},
              :match_mode => :boolean)
    if reduced.length > 1
      starts_with = reduced.select {|food| food.long_desc.downcase.match(/^#{cleaned_phrase}/)}
      starts_with.length > 0 ? starts_with.first : reduced.first
    elsif reduced == 1
      reduced.first
    else
      foods.first
    end
  end
  
  def clean_search_phrase
    word_array = @ingredient.name.gsub(",", "").split
    word_array.delete_if {|w| REDUNDANT_WORDS.include?(w) }
    word_array.map {|w| w.downcase }.join(" ")
  end
  
  def find_weight
    weights = Weight.search(@ingredient.unit, :with => {:food_id => @ingredient.food.id})
    if weights.length >= 1
      weights.first
    else
      # before we give up and flag the ingredient as not found we try some other common measures
      # measurements need to pass some equivalency check (e.g.: tsp is equivalent to teaspoon)
      # for some vegetables the name of the household measure is the name of the vegetable itself
      # for fruits the name "fruit" is often used in the measure description
      units_to_try = (OTHER_COMMON_UNITS - [@ingredient.unit]).push "(#{@ingredient.name})"
      weights = Weight.search(units_to_try.join(" | "), :with => {:food_id => @ingredient.food.id}, :match_mode => :boolean)
      weights.first
      # TODO: if other units were tried then we need to convert one unit to another
    end
  end
  
  def recalculate_gm_weight
    # TODO: if other units were tried then we need to convert one unit to another
  end
  
  
end