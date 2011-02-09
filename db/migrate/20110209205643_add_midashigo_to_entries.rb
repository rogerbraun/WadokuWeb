class AddMidashigoToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :midashigo, :string
  end

  def self.down
    remove_column :entries, :midashigo
  end
end
