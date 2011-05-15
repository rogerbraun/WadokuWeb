class RemoveIndexModel < ActiveRecord::Migration
  def self.up
    drop_table :indices
    drop_table :entries_indices
  end

  def self.down
  end
end
