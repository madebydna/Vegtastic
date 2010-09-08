class CreateNutrients < ActiveRecord::Migration
  def self.up
    create_table :nutrients do |t|
      t.integer :food_id
      t.string :old_pk, :limit => 3
      t.float :value
      t.timestamps
    end
    
    add_index :nutrients, :food_id, :name => "index_nutrients_on_food_id"
  end

  def self.down
    drop_table :nutrients
  end
end
