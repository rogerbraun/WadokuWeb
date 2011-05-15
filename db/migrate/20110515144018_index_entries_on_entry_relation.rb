class IndexEntriesOnEntryRelation < ActiveRecord::Migration
  def self.up
    change_table :entries do |t|
      t.index :entry_relation
    end
  end

  def self.down
    change_table :entries do |t|
      t.remove_index :entry_relation
    end
  end
end
