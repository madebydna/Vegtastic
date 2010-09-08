class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.integer :recipe_id
      t.integer :order_of
      t.float :amount
      t.string :unit
      t.string :name
      t.string :instructions

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
