class IngredientParser 
  
  REDUNDANT_WORDS = ["small", "large", "medium", "big", "tiny", "fresh", "dried", "raw", "organic"] # to be continued ...
  
  def initialize(ingredient)
    @ingredient = ingredient
  end
  
  def set_flag
    if @ingredient.food = find_food
      #raise @ingredient.food.inspect if @ingredient.name =~ /^Basil/
      @ingredient.weight = find_weight
      @ingredient.flag = @ingredient.weight ? "green" : "yellow"
    else
      @ingredient.flag = "red"
    end
  end
  
  def find_weight
    #TODO: measurements need to pass some equivalency check (e.g.: tsp is equivalent to teaspoon)
    Weight.search(@ingredient.unit, :with => {:food_id => @ingredient.food.id}).first
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
    # favor those that contain the words "regular", "plain" or "raw", or start with the word
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
  
end