class CreateWeights < ActiveRecord::Migration
  def self.up
    create_table :weights do |t|
      t.integer :food_id
      t.float :amount
      t.string :measure_desc
      t.float :gm_weight

      t.timestamps
    end
    
    add_index :weights, :food_id, :name => "index_weights_on_food_id"
  end

  def self.down
    drop_table :weights
  end
end
