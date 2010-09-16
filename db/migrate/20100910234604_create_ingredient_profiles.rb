class CreateIngredientProfiles < ActiveRecord::Migration
  def self.up
    create_table :ingredient_profiles do |t|
      t.integer :ingredient_id
      t.integer :nutrient_id
      t.float :gm_weight
      t.float :nutrient_amount
      t.timestamps
    end
    
    add_column :ingredients, :flag, :string
  end

  def self.down
    drop_table :ingredient_profiles
    remove_column :ingredients, :flag
  end
end
