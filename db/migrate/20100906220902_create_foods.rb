class CreateFoods < ActiveRecord::Migration
  def self.up
    create_table :foods do |t|
      t.string :old_pk, :limit => 5
      t.string :long_desc
      t.string :short_desc
      t.string :common_name
      t.string :manufacturer_name
      t.timestamps
    end
  end

  def self.down
    drop_table :foods
  end
end
