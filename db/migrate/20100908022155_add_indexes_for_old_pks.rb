class AddIndexesForOldPks < ActiveRecord::Migration
  def self.up
    add_index :foods, :old_pk, :name => "index_foods_on_old_pk"
    add_index :nutrients, :old_pk, :name => "index_nutrients_on_old_pk"
  end

  def self.down
  end
end
