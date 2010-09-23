class FixingNutrientAndDefinitionRelationship < ActiveRecord::Migration
  def self.up
    remove_column :nutrient_definitions, :nutrient_id
    add_column :nutrient_definitions, :old_pk, :string 
    add_column :nutrients, :nutrient_definition_id, :integer
  end

  def self.down
    add_column :nutrient_definitions, :nutrient_id, :integer
    remove_column :nutrient_definitions, :old_pk
    remove_column :nutrients, :nutrient_definition_id
  end
end
