class AddIndexToEntriesIndices < ActiveRecord::Migration
  def self.up
    add_index :entries_indices, :entry_id
    add_index :entries_indices, :index_id
  end

  def self.down
    remove_index :entries_indices, :entry_id
    remove_index :entries_indices, :index_id
  end
end
