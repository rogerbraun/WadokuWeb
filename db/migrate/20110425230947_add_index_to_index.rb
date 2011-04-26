class AddIndexToIndex < ActiveRecord::Migration
  def self.up
    add_index :indices, :query
  end

  def self.down
    remove_index :indices, :query
  end
end
