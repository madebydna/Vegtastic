class FixDataTypesInRecipeProfile < ActiveRecord::Migration
  def self.up
    change_table :recipe_profiles do |t|
      t.change :nutrient_name, :string
      t.change :nutrient_unit, :string
    end
    
  end

  def self.down
    change_table :recipe_profiles do |t|
      t.change :nutrient_name, :integer
      t.change :nutrient_unit, :float
    end
  end
end
