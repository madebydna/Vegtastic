class AddTagToNutrientDefinitions < ActiveRecord::Migration
  def self.up
    add_column :nutrient_definitions, :tag, :string
  end

  def self.down
    remove_column :nutrient_definitions, :tag
  end
end
