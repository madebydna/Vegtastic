class CreateRecipeProfiles < ActiveRecord::Migration
  def self.up
    create_table :recipe_profiles do |t|
      t.integer :recipe_id
      t.integer :nutrient_name
      t.float :nutrient_value
      t.float :nutrient_unit
      t.timestamps
    end
    
    add_column :ingredient_profiles, :nutrient_name, :string
    add_column :ingredient_profiles, :nutrient_unit, :string
  end

  def self.down
    drop_table :recipe_profiles
    remove_column :ingredient_profiles, :nutrient_name
    remove_column :ingredient_profiles, :nutrient_unit
  end
end
