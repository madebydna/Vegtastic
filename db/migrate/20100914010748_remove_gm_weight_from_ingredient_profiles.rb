class RemoveGmWeightFromIngredientProfiles < ActiveRecord::Migration
  def self.up
    remove_column :ingredient_profiles, :gm_weight
  end

  def self.down
    add_column :ingredient_profiles, :gm_weight, :float
  end
end
