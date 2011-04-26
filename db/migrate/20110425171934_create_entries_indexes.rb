class CreateEntriesIndexes < ActiveRecord::Migration
  def self.up
    create_table :entries_indices, :id => false do |t|
      t.integer :entry_id
      t.integer :index_id
    end
  end

  def self.down
    drop_table :entries_indices
  end
end
