class AddEntryRelationToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :entry_relation, :string
  end

  def self.down
    remove_column :entries, :entry_relation
  end
end
