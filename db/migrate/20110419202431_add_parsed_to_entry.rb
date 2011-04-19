class AddParsedToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :parsed, :Text
  end

  def self.down
    remove_column :entries, :parsed
  end
end
