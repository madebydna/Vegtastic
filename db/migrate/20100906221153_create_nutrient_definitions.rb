class CreateNutrientDefinitions < ActiveRecord::Migration
  def self.up
    create_table :nutrient_definitions do |t|
      t.integer :nutrient_id
      t.string :units
      t.string :description

      t.timestamps
    end
    
    add_index :nutrient_definitions, :nutrient_id, :name => "index_nutrient_definitions_on_nutrient_id"
  end

  def self.down
    drop_table :nutrient_definitions
  end
end
