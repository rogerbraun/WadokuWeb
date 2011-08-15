class AddIndexWadokuIdOnEntries < ActiveRecord::Migration
  def self.up
    add_index :entries, :wadoku_id
  end

  def self.down
    remove_index :entries, :wadoku_id
  end
end
